Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129345AbQK3Pnx>; Thu, 30 Nov 2000 10:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129423AbQK3Pnd>; Thu, 30 Nov 2000 10:43:33 -0500
Received: from www.14850.com ([209.150.235.34]:2814 "EHLO mail.14850.com")
        by vger.kernel.org with ESMTP id <S129345AbQK3PnY>;
        Thu, 30 Nov 2000 10:43:24 -0500
Message-Id: <5.0.0.25.0.20001130095146.00c3aae0@armstrong.cse.buffalo.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Thu, 30 Nov 2000 10:12:34 -0500
To: linux-kernel@vger.kernel.org
From: Buddha Buck <bmbuck@14850.com>
Subject: HOW-DO-I: Diagnosing hardware problems
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having troubles with my system, which has been having erratic lockups 
(usually 1-2 a day, or more).  While the problem may be kernel-related, it 
is starting to look like a hardware problem.

The lockups happen at seemingly random times, not related to system load, 
particular usages, etc.  The lockups disable interrupts, as near as I can 
tell.  Among other things, it stops responding to the keyboard (numlock and 
capslock no longer toggle the keyboard lights, Ctrl-Alt-Del ineffective, 
and the console does not unblank.  In lockups past, all these would still 
work, even after a kernel panic).

When this first started (under 2.4.0pre10), I was getting oopses, showing 
the system was dying in wake_up, while trying to schedule during an 
interrupt (I think that's what the oops said).  Some oopses would be 
logged, and not kill the system, others would kill the system, and not be 
logged.  When I downgraded to 2.2.17+ide, I stopped getting oopses, and the 
lockups stopped, for a while.  Now the system (under both 2.2.18 and 
2.4.0pre11) lockups but doesn't oops, not even to the console.

I also sometimes experience disk freezes, where the system blocks on 
reading the disk, preventing new programs to load or files to be 
read/written, but not freezing memory-resident applications or halting 
interrupts.  I have -once- been able to wait-out a freeze, and got a 
message that the system was disabling DMA on the IDE drive.  The system 
usually gets unstable after that, and locks up soon afterwards.  However, 
not all lockups are predicated by freezes.

I have run memtest overnight with no reported errors. I replaced the 
network card (a Linksys NE2k-PCI card with a Linksys tulip card) because it 
was giving me errors.  I have manually checked the processor temperature 
and it is cool to the touch.  This problem cropped up within the last few 
months, and seems to be getting worse.

When running 2.4.0pre10-11, I tend to get some disk corruption detected 
when I fsck during a reboot.  I haven't noticed this as much with the 2.2.x 
kernels.

I don't know where to proceed from here in eliminating hardware as an issue 
before I report a kernel problem.  Any suggestions?

later,
   Buddha

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
