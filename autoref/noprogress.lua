--[[***********************************************************************
*   Copyright 2018 Andreas Wendler                                        *
*   Robotics Erlangen e.V.                                                *
*   http://www.robotics-erlangen.de/                                      *
*   info@robotics-erlangen.de                                             *
*                                                                         *
*   This program is free software: you can redistribute it and/or modify  *
*   it under the terms of the GNU General Public License as published by  *
*   the Free Software Foundation, either version 3 of the License, or     *
*   any later version.                                                    *
*                                                                         *
*   This program is distributed in the hope that it will be useful,       *
*   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
*   GNU General Public License for more details.                          *
*                                                                         *
*   You should have received a copy of the GNU General Public License     *
*   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
*************************************************************************]]

local NoProgress = {}

local World = require "../base/world"
local Event = require "event"

NoProgress.possibleRefStates = {
    Game = true,
}

local NO_PROGRESS_TIME = 10
local NO_PROGRESS_RADIUS = 0.07

local startPos = World.Ball.pos
local startTime = World.Time
function NoProgress.occuring()
    if startPos:distanceTo(World.Ball.pos) > NO_PROGRESS_RADIUS then
        startPos = World.Ball.pos
        startTime = World.Time
    end
    if World.Time -  startTime > NO_PROGRESS_TIME then
        NoProgress.consequence = "FORCE_START"
        NoProgress.freekickPosition = World.Ball.pos
        NoProgress.executingTeam = math.random(2) == 1 and "YellowColorStr" or "BlueColorStr"
        NoProgress.message = "No progress for more than 10 seconds"
        NoProgress.event = Event("NoProgress")
        return true
    end
    return false
end

function NoProgress.reset()
    startPos = World.Ball.pos
    startTime = World.Time
end

return NoProgress
