Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUJVW0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUJVW0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJVW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:26:26 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:24466 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S268031AbUJVVth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:49:37 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Date: Fri, 22 Oct 2004 17:49:35 -0400
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
References: <20041014234202.GA26207@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
In-Reply-To: <20041022175633.GA1864@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410221749.35306.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.58.180] at Fri, 22 Oct 2004 16:49:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 13:56, Ingo Molnar wrote:
>i have released the -U10.2 Real-Time Preemption patch, which can be
>downloaded from:
>
>  http://redhat.com/~mingo/realtime-preempt/
>
>this is a fixes-only release.
>
>Changes since -U10:
>
> - fixed a big bug present ever since: the BKL got dropped when a
>   spinlock-mutex was acquired and it scheduled away. This reduced
> the locking efficiency of the BKL. A number of outstanding problems
> could be affected, in particular this should fix the tty locking
> breakage reported by Alexander Batyrshin and Adam Heath. UP and SMP
> systems are affected too, with SMP systems having a higher chance
> to trigger this condition.
>
> - tulip.c breakage fix from Thomas Gleixner
>
> - tg3 and 3c59x fixes.
>
> - made the hardirq threads SCHED_FIFO by default. They get
> priorities between 25 and 50, depending on the irq #. (this is
> pretty random but i found no better scheme.) Made the softirq
> thread SCHED_FIFO by default as well, albeit this probably will
> have to change. These changes should make it easier to debug a hung
> system.
>
>to create a -U10.2 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
> +
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.
>6.9-mm1/2.6.9-mm1.bz2 +
> http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm
>1-U10.2

Mmm, I get a 404 page not found. when I click on  on thsi link.

> Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
