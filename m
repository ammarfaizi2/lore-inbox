Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVFMCLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFMCLY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 22:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFMCLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 22:11:23 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:20671 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261315AbVFMCLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 22:11:19 -0400
Date: Sun, 12 Jun 2005 22:11:03 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050612134907.GA17467@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506122211.04152.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu>
 <200506120940.11698.gene.heskett@verizon.net> <20050612134907.GA17467@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Humm, I think I hijacked a thread.  Anyway, for exercise I just built 48-17,
but had to interrupt the boot & go back to 48-13 as I was drowning in 
a near DOS caused by:

Jun 12 21:54:16 coyote kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LMAC] -> GSI 11 (level, low) -> IRQ 11
Jun 12 21:54:16 coyote kernel: BUG: scheduling while atomic: softirq-timer/0/0x10000100/3
Jun 12 21:54:16 coyote kernel: caller is __cond_resched+0x3d/0x50
Jun 12 21:54:16 coyote kernel:  [<c036fb7f>] __schedule+0x67f/0x6d0 (8)
Jun 12 21:54:16 coyote kernel:  [<c0113c3d>] __cond_resched+0x3d/0x50 (8)
Jun 12 21:54:16 coyote kernel:  [<c0120c40>] process_timeout+0x0/0x10 (32)
Jun 12 21:54:16 coyote kernel:  [<c0120999>] run_timer_softirq+0x259/0x400 (4)
Jun 12 21:54:16 coyote kernel:  [<c0113c3d>] __cond_resched+0x3d/0x50 (32)
Jun 12 21:54:16 coyote kernel:  [<c03704ac>] cond_resched+0x1c/0x30 (12)
Jun 12 21:54:16 coyote kernel:  [<c011c74c>] ksoftirqd+0xec/0x150 (8)
Jun 12 21:54:16 coyote kernel:  [<c011c660>] ksoftirqd+0x0/0x150 (24)
Jun 12 21:54:16 coyote kernel:  [<c012c825>] kthread+0xa5/0xb0 (4)
Jun 12 21:54:16 coyote kernel:  [<c012c780>] kthread+0x0/0xb0 (28)
Jun 12 21:54:16 coyote kernel:  [<c0100e41>] kernel_thread_helper+0x5/0x14 (16)
Jun 12 21:54:16 coyote random: Initializing random number generator:  succeeded

That was the first of several hundred that went by by the time I 3 fingered it.
Virtually all were carbon copies of each other.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
