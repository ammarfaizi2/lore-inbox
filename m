Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUH1UKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUH1UKs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUH1UJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:09:44 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:23472 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267777AbUH1UIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:08:16 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q2
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040828200412.GA29263@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu> <20040828120309.GA17121@elte.hu>
	 <200408281818.28159.lkml@felipe-alfaro.com> <4130B7BD.5070801@cybsft.com>
	 <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu>
	 <1093723276.8611.60.camel@krustophenia.net>
	 <20040828200412.GA29263@elte.hu>
Content-Type: text/plain
Message-Id: <1093723702.8611.62.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 16:08:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 16:04, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Sat, 2004-08-28 at 15:44, Ingo Molnar wrote:
> > 
> > > there's a Kconfig chunk missing from the Q0/Q1 patches, i've uploaded Q2
> > 
> > Still not quite right:
> > 
> >   HOSTLD  scripts/mod/modpost
> >   CC      arch/i386/kernel/asm-offsets.s
> > In file included from arch/i386/kernel/asm-offsets.c:7:
> > include/linux/sched.h: In function `lock_need_resched':
> > include/linux/sched.h:983: error: structure has no member named `break_lock'
> > make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
> > make: *** [arch/i386/kernel/asm-offsets.s] Error 2
> 
> you probably have CONFIG_PREEMPT_VOLUNTARY disabled in the .config?
> 

Nope:

# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
# CONFIG_X86_UP_APIC is not set

Lee

