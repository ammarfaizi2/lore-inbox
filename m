Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267676AbUHPO56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267676AbUHPO56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUHPO56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:57:58 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28088 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267681AbUHPO5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:57:47 -0400
Date: Mon, 16 Aug 2004 16:58:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
Message-ID: <20040816145831.GA14195@elte.hu>
References: <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092662814.5082.2.camel@localhost> <1092665577.5362.12.camel@localhost> <1092667804.5362.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092667804.5362.21.camel@localhost>
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

>  0.000ms (+0.000ms): do_IRQ (default_idle)
>  0.000ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
>  0.459ms (+0.459ms): generic_redirect_hardirq (do_IRQ)
>  0.459ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
>  0.459ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)

> It definitely looks like the kernel is interrupted by some interrupt
> source not covered by the patch.

the only possibility is SMM, which is not handled by Linux. (but by the
BIOS.) Otherwise we track everything - including NMIs.

can you reproduce this using an UP kernel too?

	Ingo
