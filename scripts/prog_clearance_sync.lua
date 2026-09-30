-- Synchronize separate toggle items with the progressive clearance item
local function clearanceSync(code, value)
	local prog = Tracker:FindObjectForCode("progressiveclearancelevel")
	if not prog then return end

	-- find the normal clearance items
	local vis = {
		Tracker:FindObjectForCode("clearancelevel1"),
		Tracker:FindObjectForCode("clearancelevel2"),
		Tracker:FindObjectForCode("clearancelevel3"),
		Tracker:FindObjectForCode("clearancelevel4"),
		Tracker:FindObjectForCode("clearancelevel5"),
		Tracker:FindObjectForCode("clearancelevel6"),
	}

	-- if any missing, abort
	for i=1,6 do
		if not vis[i] then return end
	end

	local active = prog.Active
	local stage = tonumber(prog.CurrentStage) or 0

	if not active or stage <= 0 then
		for i=1,6 do vis[i].Active = false end
		return
	end

	if stage > 6 then stage = 6 end
	for i=1,6 do
		vis[i].Active = (i <= stage)
	end
end

ScriptHost:AddWatchForCode("prog clearance sync", "progressiveclearancelevel", clearanceSync)