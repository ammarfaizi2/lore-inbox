Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267846AbUH1UMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267846AbUH1UMY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUH1ULB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:11:01 -0400
Received: from astro.futurequest.net ([69.5.28.104]:62189 "HELO
	astro.futurequest.net") by vger.kernel.org with SMTP
	id S267807AbUH1UKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:10:05 -0400
From: Daniel Schmitt <pnambic@unu.nu>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q2
Date: Sat, 28 Aug 2004 22:10:03 +0200
User-Agent: KMail/1.7
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
References: <20040823221816.GA31671@yoda.timesys> <1093715573.8611.38.camel@krustophenia.net> <20040828194449.GA25732@elte.hu>
In-Reply-To: <20040828194449.GA25732@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408282210.03568.pnambic@unu.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 August 2004 21:44, Ingo Molnar wrote:
>
> there's a Kconfig chunk missing from the Q0/Q1 patches, i've uploaded Q2
> that fixes this:
>
This breaks here unless CONFIG_SMP is defined, with the following error:

  CC      arch/i386/kernel/asm-offsets.s
In file included from arch/i386/kernel/asm-offsets.c:7:
include/linux/sched.h: In function `lock_need_resched':
include/linux/sched.h:983: error: structure has no member named `break_lock'

Probably missing a check for CONFIG_SMP around the need_lockbreak defines in 
sched.h, and maybe also in cond_resched_lock().

Daniel.

