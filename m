Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSEZF4P>; Sun, 26 May 2002 01:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315725AbSEZF4O>; Sun, 26 May 2002 01:56:14 -0400
Received: from bs1.dnx.de ([213.252.143.130]:60075 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315734AbSEZF4M>;
	Sun, 26 May 2002 01:56:12 -0400
Date: Sun, 26 May 2002 07:31:36 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Erik Andersen <andersen@codepoet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526073136.H598@schwebel.de>
In-Reply-To: <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0205251015350.6515-100000@home.transmeta.com> <20020526005827.B598@schwebel.de> <20020526004853.GA18679@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 06:48:53PM -0600, Erik Andersen wrote:
> Indeed.  For example -- suppose I have an application that is driving a
> robot.  My application needs to calculate the target values for
> each joint position in such that I can plot out the jerk,
> acceleration, velocity, and position in cartesian space of a tool
> moving in joint space (i.e. lots of 4x4 matrix multiplications,
> often involving a full 3D model of the workcell) And I need to
> send each new set of target values to the controller at the servo
> rate or the robot will stutter.  
> 
> But if only it were that easy...  Since the target values we are
> talking about is actually just the amount of current being sent
> to the servo motors.  So also at the servo rate, I must read the
> encoders for each joint to get its actual position (as opposed to
> nominal postition) and feed that into a control routine
> (typically using a PID routine using PID gains that vary
> non-linearly per arm position, intertial loading, phase of the
> moon, etc) which then varies the actual per-axis servo motor
> current  to make the cartesian-space path of the tool match the
> nominal path.
> 
> So now we have a full 3D model of the robot, the non-liner model
> of the robot PID-gain space, the entire (application specific)
> workcell model, the robot specific forward and inverse kinematics
> routines, and the entire trajectory planning subsystem.  And of
> course we now need the real-time IO subsystem to handle are the
> thousands of this-and-that sensors (think PLC-type behavior).
> etc, etc, etc.  All this in the kernel?  Nah...

People are doing this (or at least something similar) in reality these
days... :-) 

Hopefully, your post shows clearly why there are users out there who don't
want to make such complex algorithms open source, and I must say I can
understand them. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
