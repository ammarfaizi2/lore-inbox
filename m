Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129821AbQKUWKc>; Tue, 21 Nov 2000 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbQKUWKW>; Tue, 21 Nov 2000 17:10:22 -0500
Received: from spike2.i405.net ([63.229.23.90]:44293 "EHLO spike2.i405.net")
	by vger.kernel.org with ESMTP id <S130771AbQKUWKH>;
	Tue, 21 Nov 2000 17:10:07 -0500
Message-ID: <0066CB04D783714B88D83397CCBCA0CD49AF@spike2.i405.net>
From: "Stephen Gutknecht (linux-kernel)" <linux-kernel@i405.com>
To: "'David Lang'" <david.lang@digitalinsight.com>,
        David Riley <oscar@the-rileys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Better testing of hardware (was: Defective Read Hat)
Date: Tue, 21 Nov 2000 13:39:17 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part of the issue is that there exists no "easy to use" standardized test
software.  Full 32-bit concurrent use of many devices can reveal problems
that users do not often see in normal applications.

One major hardware review site found stability problems with the Intel
Pentium 3 1130Mhz processor that ultimately lead to Intel delaying the
release -- it passed all tests but not a compile of the Linux Kernel!  This
was on more than 3 different processors.
http://www.tomshardware.com/cpu/00q3/0008281/pentiumiii-04.html

A Linux Kernel compile test does a really good job of testing the hard disk,
RAM, and CPU... as it executes all types of instructions and the final
output depends on all prior steps completing correctly.  On a really fast
system (> 900Mhz) might make sense to run it twice, once to "warm up" the
CPU and other components.  Most "benchmarks" just test speed, not the actual
stability or data integrity (they write results to a device but don't check
for data corruption, or they test only one device at a time, not all at
once).

What a Linux kernel compile DOESN'T test is the network interfaces and video
cards.

Yes, there are "stand alone" test programs -- but something that uses the
actual OS interfaces and drivers (like a kernel compile) is the best way!

I think the Linux Community could really jump over Microsoft who suffers
from the same problem.  Many OS-reported problems stem from hardware that is
marginal (especially CPU, RAM, and PCI/AGP bus)... works at most level, but
thrown in some heavy tasks... and odd software faults show up.  A very
simple but well designed test program run for 15 minutes would detect such
problems.  It is just foolish that Microsoft hasn't delivered this... as it
has to cost them 100x more to deal with it as a support problem!

You will find that most Overlockers run their favorite game in a loop for 10
or 20 minutes as the best test they have found.  This often does
Video+Ram+CPU+Sound board (PCI) at full tilt. What is needed is a
_standardized test_ that really goes after everything (including network).

What "system test" programs exist for Linux today?  Any active projects?
Just image a good "consumer distro" that has this as part of the setup!

I come from an OS/2, WinNT, Win2K background... believe me, the problem has
been here in the "PC platform" all along... and every OS vendor (and even
application vendor) pays for this oversight.  Linux really could take the
lead!  Before every kernel problem report, require "supertest" to be run for
10 minutes.

  Stephen Gutknecht


-----Original Message-----
From: David Lang [mailto:david.lang@digitalinsight.com]
Sent: Tuesday, November 21, 2000 2:05 PM
To: David Riley
Cc: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux


David, usually when it turns out that Linux finds hardware problems the
underlying cause is that linux makes more effective use of the component,
and as such something that was marginal under windows fails under linux as
the correct timing is used.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
