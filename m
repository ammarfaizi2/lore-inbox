Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVJXT34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVJXT34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 15:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVJXT34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 15:29:56 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:1190 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S1751133AbVJXT3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 15:29:55 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark Knecht <markknecht@gmail.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>,
       nando@ccrma.Stanford.EDU
In-Reply-To: <20051022035851.GC12751@elte.hu>
References: <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 12:28:41 -0700
Message-Id: <1130182121.4983.7.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-22 at 05:58 +0200, Ingo Molnar wrote: 
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > Here's one with rc5-rt3:

rc5-rt5, _without_ HIGH_RES_TIMERS. No messages after this but the
Gnome/X session got really confused and unusable after starting fine
(ie: windows would not redraw, apparently everything suddenly slowed
down to a crawl):

Oct 24 12:10:43 host kernel: Using specific hotkey driver
Oct 24 12:10:43 host kernel: ACPI: CPU0 (power states: C1[C1])
Oct 24 12:10:43 host kernel: ACPI: CPU1 (power states: C1[C1])
Oct 24 12:10:43 host kernel: Time: tsc clocksource has been installed.
Oct 24 12:10:43 host kernel: WARNING: non-monotonic time!
Oct 24 12:10:43 host kernel: ... time warped from 578911413 to
539189615.
Oct 24 12:10:43 host kernel: softirq-timer/1/13[CPU#1]: BUG in ktime_get
at kernel/ktimers.c:103
Oct 24 12:10:43 host kernel:  [<c0128157>] __WARN_ON+0x67/0x90 (8)
Oct 24 12:10:43 host kernel:  [<c01408d2>] ktime_get+0xf2/0x170 (48)
Oct 24 12:10:43 host kernel:  [<c014151f>] ktimer_run_queues+0x2f/0x130
(68)
Oct 24 12:10:43 host kernel:  [<c013162e>] run_timer_softirq+0xde/0x380
(48)
Oct 24 12:10:43 host kernel:  [<c0374435>] schedule+0x85/0x100 (24)
Oct 24 12:10:43 host kernel:  [<c012d3c8>] ksoftirqd+0x118/0x1e0 (28)
Oct 24 12:10:43 host kernel:  [<c012d2b0>] ksoftirqd+0x0/0x1e0 (44)
Oct 24 12:10:43 host kernel:  [<c013d15c>] kthread+0xac/0xb0 (4)
Oct 24 12:10:43 host kernel:  [<c013d0b0>] kthread+0x0/0xb0 (12)
Oct 24 12:10:43 host kernel:  [<c0101545>] kernel_thread_helper+0x5/0x10
(16)
Oct 24 12:10:43 host kernel: WARNING: non-monotonic time!
Oct 24 12:10:43 host kernel: ... time warped from 579911260 to
539914810.
Oct 24 12:10:43 host kernel: softirq-timer/0/4[CPU#0]: BUG in ktime_get
at kernel/ktimers.c:103
Oct 24 12:10:43 host kernel:  [<c0128157>] __WARN_ON+0x67/0x90 (8)
Oct 24 12:10:43 host kernel:  [<c01408d2>] ktime_get+0xf2/0x170 (48)
Oct 24 12:10:43 host kernel:  [<c014151f>] ktimer_run_queues+0x2f/0x130
(68)
Oct 24 12:10:43 host kernel:  [<c013162e>] run_timer_softirq+0xde/0x380
(48)
Oct 24 12:10:43 host kernel:  [<c0374435>] schedule+0x85/0x100 (24)
Oct 24 12:10:43 host kernel:  [<c012d3c8>] ksoftirqd+0x118/0x1e0 (28)
Oct 24 12:10:43 host kernel:  [<c012d2b0>] ksoftirqd+0x0/0x1e0 (44)
Oct 24 12:10:43 host kernel:  [<c013d15c>] kthread+0xac/0xb0 (4)
Oct 24 12:10:43 host kernel:  [<c013d0b0>] kthread+0x0/0xb0 (12)
Oct 24 12:10:43 host kernel:  [<c0101545>] kernel_thread_helper+0x5/0x10
(16)
Oct 24 12:10:43 host kernel: WARNING: non-monotonic time!
Oct 24 12:10:44 host kernel: ... time warped from 578911413 to
540188071.
Oct 24 12:10:44 host kernel: softirq-timer/1/13[CPU#1]: BUG in ktime_get
at kernel/ktimers.c:103
Oct 24 12:10:44 host kernel:  [<c0128157>] __WARN_ON+0x67/0x90 (8)
Oct 24 12:10:44 host kernel:  [<c01408d2>] ktime_get+0xf2/0x170 (48)
Oct 24 12:10:44 host kernel:  [<c014151f>] ktimer_run_queues+0x2f/0x130
(68)
Oct 24 12:10:44 host kernel:  [<c013162e>] run_timer_softirq+0xde/0x380
(48)
Oct 24 12:10:44 host kernel:  [<c0374435>] schedule+0x85/0x100 (24)
Oct 24 12:10:44 host kernel:  [<c012d3c8>] ksoftirqd+0x118/0x1e0 (28)
Oct 24 12:10:44 host kernel:  [<c012d2b0>] ksoftirqd+0x0/0x1e0 (44)
Oct 24 12:10:44 host kernel:  [<c013d15c>] kthread+0xac/0xb0 (4)
Oct 24 12:10:44 host kernel:  [<c013d0b0>] kthread+0x0/0xb0 (12)
Oct 24 12:10:44 host kernel:  [<c0101545>] kernel_thread_helper+0x5/0x10
(16)
Oct 24 12:10:44 host kernel: isapnp: Scanning for PnP cards...
Oct 24 12:10:44 host kernel: isapnp: No Plug & Play device found
Oct 24 12:10:44 host kernel: Real Time Clock Driver v1.12
Oct 24 12:10:44 host kernel: Linux agpgart interface v0.101 (c) Dave
Jones

-- Fernando


