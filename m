Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267787AbUHPP4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267787AbUHPP4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUHPPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:55:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40146 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267796AbUHPPgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:36:33 -0400
Date: Mon, 16 Aug 2004 17:37:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
Message-ID: <20040816153751.GA15573@elte.hu>
References: <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092662814.5082.2.camel@localhost> <1092665577.5362.12.camel@localhost> <1092667804.5362.21.camel@localhost> <20040816145831.GA14195@elte.hu> <1092669057.5362.31.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092669057.5362.31.camel@localhost>
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


* Thomas Charbonnel <thomas@undata.org> wrote:

> > >  0.000ms (+0.000ms): do_IRQ (default_idle)
> > >  0.000ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
> > >  0.459ms (+0.459ms): generic_redirect_hardirq (do_IRQ)
> > >  0.459ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
> > >  0.459ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
> > 
> > > It definitely looks like the kernel is interrupted by some interrupt
> > > source not covered by the patch.
> > 
> > the only possibility is SMM, which is not handled by Linux. (but by the
> > BIOS.) Otherwise we track everything - including NMIs.

> This would confirm the hypothesis of a buggy BIOS, I'm afraid.

there are still other (and more likely) possible reasons like a bug in
the latency tracer. (Or a broken TSC - albeit this is less likely.)

can you reproduce this phenomenon at will? Does it go away if you turn 
ACPI/APM off (both in the kernel and in the BIOS). Does it go away if 
you use idle=poll?

	Ingo
