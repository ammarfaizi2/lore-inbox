Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbUKDLjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUKDLjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUKDLhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:37:06 -0500
Received: from sartre.ispvip.biz ([209.118.182.154]:64691 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S262155AbUKDLRv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:17:51 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
From: "Michael J. Cohen" <mjc@unre.st>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, sboyce@blueyonder.co.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <1099563805.30372.2.camel@localhost>
References: <4189108C.2050804@blueyonder.co.uk>
	 <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk>
	 <418988A6.4090902@cybsft.com>  <20041104100634.GA29785@elte.hu>
	 <1099563805.30372.2.camel@localhost>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 06:17:41 -0500
Message-Id: <1099567061.7911.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > i applied your earlier patch but many more changes were needed to port
> > PREEMPT_REALTIME (and in particular, PREEMPT_HARDIRQS) to x64. You can
> > check out the x64 bits in -V0.7.8 which can be downloaded from the usual
> > place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > Sid, does this one build/work for you? (i had to disable CPUFREQ in the
> > .config to get it to build - an -mm bug i suspect.)
> > 
> > 	Ingo
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x1e57c): In function `___trace':
> : undefined reference to `irqs_disabled_flags'
> kernel/built-in.o(.text+0x1e797): In function `add_preempt_count':
> : undefined reference to `irqs_disabled_flags'
> make: *** [.tmp_vmlinux1] Error 1
> 
> ------
> Michael Cohen

Turned off the debugging stuff to fix this one :/

might_sleep issue at swap_on and firefox causes oopsen.

dmesg is 120k+ so here:

http://325i.org/software/2.6.10-rc1-mm2-RT-V0.7.8.dmesg

------
Michael Cohen

