Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbUAVTg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUAVTg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:36:58 -0500
Received: from saturn.opentools.org ([66.250.40.202]:50668 "EHLO
	www.princetongames.org") by vger.kernel.org with ESMTP
	id S264558AbUAVTgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:36:53 -0500
Date: Thu, 22 Jan 2004 14:36:44 -0500 (EST)
From: Aaron Mulder <ammulder@alumni.princeton.edu>
X-X-Sender: ammulder@www.princetongames.org
To: Brandon Ehle <azverkan@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange pauses in 2.6.2-rc1 / AMD64
In-Reply-To: <40108A2B.3080605@yahoo.com>
Message-ID: <Pine.LNX.4.44.0401221428200.29180-100000@www.princetongames.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Thanks for the tip.  Unfortunately, disabling Legacy USB Support
didn't stop the pauses for me.  It's weird -- if I lay off the mouse, the
CPU goes to 99.7-100% idle, the load goes to 0, and top shows only 1
running task (presumably top itself).  Every little while, Java will wake
up and do some more work, then go to sleep again.  It seems to happen
during the "jarsigner" phase of the Java build (there are about 20
invocations of that), and it may be launching a new process to sign each
JAR, I'm not sure.  This last time, I noticed that Java woke up briefly
when Mozilla hit the top list.  It just seems to need some kind of
external stimulus.  Keyboard doesn't do it.  FYI, I have no USB devices
connected at the moment.

Thanks,
	Aaron

On Thu, 22 Jan 2004, Brandon Ehle wrote:
> Aaron Mulder wrote:
> 
> >	I tried out 2.6.2-rc1 today, and saw some very strange behavior
> >with Java.  I run a 30s build process (Java/Ant), and it would basically
> >stop in the middle.  If I run a "top" next to it (this was all in X),
> >during the pauses, the CPUs would go down to nearly 100% idle, and all the
> >Java processes disappeared from the top of the list.  If I moved my mouse
> >at all, the Java build would wake up for a bit, then stop again 10 or 15
> >seconds later.  The build would easily take several minutes if I didn't
> >move my mouse much (or hang indefinitely if I didn't move my mouse at
> >all).  If I consistently jiggled my mouse through the entire build, the
> >performance was approximately what I would expect (35-40s).
> >
> >  
> >
> 
> I was running into the same thing last night.  In order to get the 
> kernel to boot on my machine, I had also been passing idle=poll on the 
> commandline.  According to an earlier message, I turned off "Legacy USB 
> Support" in the BIOS and the kernel booted fine without passing the 
> idle=poll parameter and the pauses no longer happen for me.
> 
> This is on a Athlon 64 3000+ on a K8V Deluxe, 1GB RAM, Gentoo for x86_64.
> 
> >	I tried the same thing under my normal kernel (SuSE
> >2.4.21-178-smp) and the build ran continuously with no pauses (35s).
> >
> >	The pauses on 2.6.2-rc1 occured with both 32-bit (Sun) and 64-bit
> >(Blackdown) Java implementations.
> >
> >	I can't explain it, but if there's any pertinent info I can
> >provide, I'll be happy to.
> >
> >Thanks,
> >	Aaron
> >
> >2x Opteron 248, Tyan Thunder K8W, 4GB RAM, SuSE 9.0 for AMD64
> >  
> >
> 

