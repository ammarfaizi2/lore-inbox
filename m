Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUH1UcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUH1UcE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbUH1Ub6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:31:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13983 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265973AbUH1U3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:29:42 -0400
Date: Sat, 28 Aug 2004 22:31:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Schmitt <pnambic@unu.nu>
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q3
Message-ID: <20040828203116.GA29686@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <1093715573.8611.38.camel@krustophenia.net> <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408282210.03568.pnambic@unu.nu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Schmitt <pnambic@unu.nu> wrote:

> > there's a Kconfig chunk missing from the Q0/Q1 patches, i've uploaded Q2
> > that fixes this:
> >
> This breaks here unless CONFIG_SMP is defined, with the following error:
> 
>   CC      arch/i386/kernel/asm-offsets.s
> In file included from arch/i386/kernel/asm-offsets.c:7:
> include/linux/sched.h: In function `lock_need_resched':
> include/linux/sched.h:983: error: structure has no member named `break_lock'
> 
> Probably missing a check for CONFIG_SMP around the need_lockbreak
> defines in sched.h, and maybe also in cond_resched_lock().

doh - right indeed. -Q3 has this fixed, it is at:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q3

ontop of the usual:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

        Ingo

