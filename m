Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVK0T5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVK0T5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVK0T5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:57:32 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:4522 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751030AbVK0T5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:57:31 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051127123052.GA22807@elte.hu>
References: <1132987928.4896.1.camel@mindpipe>
	 <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu>
Content-Type: text/plain
Date: Sun, 27 Nov 2005 14:57:22 -0500
Message-Id: <1133121442.19202.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 13:30 +0100, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Sat, 2005-11-26 at 14:05 -0500, Lee Revell wrote:
> > 
> > > -rt19 seems to work except that asm/io_apic.h fails to include 
> > > asm/apicdef.h so MAX_IO_APICS is undefined.
> > 
> > The patch below fixes the Makefile x86_64 clutter and the io_apic 
> > compile problem
> 
> thanks, applied.

-rt19 still does not boot for me with PREEMPT_DESKTOP and the latency
debugging options enabled (same .config I sent previously).  I get
endless screenfuls of "=============" on boot.  grep shows that these
most likely come from kernel/rt.c.

rlrevell@mindpipe:~$ grep -rI "=====================" linux-2.6.14-rt19/kernel/
linux-2.6.14-rt19/kernel/rt.c:    printk("=============================================\n\n");
linux-2.6.14-rt19/kernel/rt.c:            printk("\n==========================================\n");
linux-2.6.14-rt19/kernel/rt.c:            printk("\n===========================================\n");
linux-2.6.14-rt19/kernel/rt.c:            printk("\n============================================\n");

Lee

