Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWCJOoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWCJOoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWCJOoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:44:16 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5820 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751434AbWCJOoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:44:16 -0500
Date: Fri, 10 Mar 2006 15:44:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tomasz Chmielewski <mangoo@wpkg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
In-Reply-To: <441180DD.3020206@wpkg.org>
Message-ID: <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
References: <441180DD.3020206@wpkg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: can I bring Linux down by running "renice -20 cpu_intensive_process"?
>
Depends on what the cpu_intensive_process does. If it tries to allocate 
lots of memory, maybe. If it's _just_ CPU (as in `perl -e '1 while 1'`), 
you get a chance that you can input some commands on a terminal to kill it.
SCHED_FIFO'ing or SCHED_RR'ing such a process is sudden death of course.

> I have a Linux server (kernel 2.6.8.1 + Linux RAID1) which is a "backup"
> machine: it gets the files from other servers, compresses it, writes to the
> tape, checks md5sums etc.
>
> It's been running for quite a bit, no problems with stability so far.
>
Why would you need it to run at -20 anyway?

> As I restarted the machine, I saw that the logging ends few minutes after I
> changed the priority of md5sum to -20.
>
> So here is my question: is it possible to bring down the machine by simply
> doing "renice -20 cpu_intensive_process"?
>
In case of md5sum: it should not be. At least you should have been able to 
unblank the console pressing any key, or have sysrq available.

> As I said, this machine does heavy compression and md5sum calculations of big
> files every day, and was stable all the time - but stopped responding after I
> changed the priority of a CPU-intensive process to -20.
>
> Coincidence and a hardware failure?
>
Sysrq+T (and/or +P) will tell you where the CPU is running.


Jan Engelhardt
-- 
