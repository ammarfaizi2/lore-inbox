Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVAVVXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVAVVXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVAVVXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 16:23:09 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:18872 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262734AbVAVVW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 16:22:29 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None, usuallly detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-00
Date: Sat, 22 Jan 2005 16:22:24 -0500
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20050115133454.GA8748@elte.hu> <20050122122915.GA7098@elte.hu>
In-Reply-To: <20050122122915.GA7098@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501221622.24273.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.47.137] at Sat, 22 Jan 2005 15:22:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 January 2005 07:29, Ingo Molnar wrote:
>i have released the -V0.7.36-00 Real-Time Preemption patch, which
> can be downloaded from the usual place:
>
>  http://redhat.com/~mingo/realtime-preempt/
>
>this is mainly a merge to 2.6.11-rc2.

Humm, by the time I went after the patch it was up to -02.

And I'm getting a couple of error exits:
-------------------
net/sched/sch_generic.c: In function `qdisc_restart':
net/sched/sch_generic.c:128: error: label `requeue' used but not 
defined
  CC      drivers/pci/setup-bus.o
make[2]: *** [net/sched/sch_generic.o] Error 1
make[1]: *** [net/sched] Error 2
make[1]: *** Waiting for unfinished jobs....
-------------------

And
-------------------
  LD      net/sunrpc/built-in.o
make: *** [net] Error 2
make: *** Waiting for unfinished jobs....
-------------------
So obviously I'm not running it. :-)

One other item I don't think is related, in the last version (35-01) I 
had svn'd a new ieee1396 sub-directory from that ieee1394.org site 
into the drivers tree, and since it was less than a week old and 
worked right well, I just copied it over into the new kernel tree & 
reran the configs after renameing the existing ieee1394 to 
ieee1394-orig.

>There was alot of merging to be done due to Thomas Gleixner's
>spinlock/rwlock cleanups making it into upstream and due to the
> upstream spinlock changes, and there were some networking related
> conflicts as well, so these areas might introduce new regressions.
>
>the patch includes a fix that should resolve the microcode-update
>related boot-time crash reported by K.R. Foley. It also includes a
>verify_mm_writelocked() fix from Daniel Walker.
>
>to create a -V0.7.36-00 tree from scratch, the patching order is:
>
>  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
> 
> http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc2.bz
>2
> http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-r
>c2-V0.7.36-00
>
> Ingo

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.32% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
