Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVDARfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVDARfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVDAReD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:34:03 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:14520 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S262829AbVDARcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:32:00 -0500
Date: Fri, 01 Apr 2005 12:31:55 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-reply-to: <20050401104724.GA31971@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>
Message-id: <200504011231.55717.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
 <20050401104724.GA31971@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 April 2005 05:47, Ingo Molnar wrote:
>i have released the -V0.7.43-00 Real-Time Preemption patch, which
> can be downloaded from the usual place:
>
>  http://redhat.com/~mingo/realtime-preempt/
>
>this release too is a step towards more robustness. I found a bug
> that caused an infinite recursion and subsequent spontaneous
> reboot. The bug was once again related to lock->debug locks, so i
> decided to get rid of them altogether: from now on every lock in
> the -RT domain is debugged.
>
>To be able to use code that relies on incompatible properties of
> stock Linux semaphores (and rwsems), i've added a new compile-time
> semaphore-type mechanism that enables the easy switching from RT
> semaphores to stock semaphores. I've done this conversion for all
> subsystems that needed it - e.g. XFS, firewire, USB and SCSI. XFS
> seems to be working much better with this approach - BYMMV.
>
>but an unavoidable side-effect is that the whole codebase got turned
>upside down once again, so be careful and expect a few rough edges. 
> In particular keep an eye on new compile-time warnings related to
> semaphores - code that gives a warning might build but it will
> almost certainly not work.
>
>to create a -V0.7.43-00 tree from scratch, the patching order is:
>
>  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2

I use the .gz, more reliable unpacks

> http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc1.bz
>2

Again I use the .gz

> http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-r
>c1-V0.7.43-00
>
> Ingo

It was up to 43-04 by the time I got there.

This one didn't go in cleanly Ingo.  From my build-src scripts output:
-------------------
Applying patch realtime-preempt-2.6.12-rc1-V0.7.43-04
[...]
patching file lib/rwsem-spinlock.c
Hunk #5 FAILED at 133.
Hunk #6 FAILED at 160.
Hunk #7 FAILED at 179.
Hunk #8 FAILED at 194.
Hunk #9 FAILED at 204.
Hunk #10 FAILED at 231.
Hunk #11 FAILED at 250.
Hunk #12 FAILED at 265.
Hunk #13 FAILED at 274.
Hunk #14 FAILED at 293.
Hunk #15 FAILED at 314.
11 out of 15 hunks FAILED -- saving rejects to file 
lib/rwsem-spinlock.c.rej
-----------
I doubt it would run, so I haven't built it.  Should I?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
