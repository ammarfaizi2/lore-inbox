Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266507AbUH1UDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUH1UDD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUH1UDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:03:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43976 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266507AbUH1UCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:02:50 -0400
Date: Sat, 28 Aug 2004 22:04:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q2
Message-ID: <20040828200412.GA29263@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <20040828120309.GA17121@elte.hu> <200408281818.28159.lkml@felipe-alfaro.com> <4130B7BD.5070801@cybsft.com> <1093715573.8611.38.camel@krustophenia.net> <20040828194449.GA25732@elte.hu> <1093723276.8611.60.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093723276.8611.60.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Sat, 2004-08-28 at 15:44, Ingo Molnar wrote:
> 
> > there's a Kconfig chunk missing from the Q0/Q1 patches, i've uploaded Q2
> 
> Still not quite right:
> 
>   HOSTLD  scripts/mod/modpost
>   CC      arch/i386/kernel/asm-offsets.s
> In file included from arch/i386/kernel/asm-offsets.c:7:
> include/linux/sched.h: In function `lock_need_resched':
> include/linux/sched.h:983: error: structure has no member named `break_lock'
> make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
> make: *** [arch/i386/kernel/asm-offsets.s] Error 2

you probably have CONFIG_PREEMPT_VOLUNTARY disabled in the .config?

	Ingo
