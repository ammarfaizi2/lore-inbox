Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267722AbUHPPYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267722AbUHPPYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHPPQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:16:53 -0400
Received: from pD9517D3C.dip.t-dialin.net ([217.81.125.60]:13953 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S267684AbUHPPMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:12:41 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816145831.GA14195@elte.hu>
References: <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092662814.5082.2.camel@localhost> <1092665577.5362.12.camel@localhost>
	 <1092667804.5362.21.camel@localhost>  <20040816145831.GA14195@elte.hu>
Content-Type: text/plain
Message-Id: <1092669057.5362.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 17:10:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> * Thomas Charbonnel <thomas@undata.org> wrote:
> 
> >  0.000ms (+0.000ms): do_IRQ (default_idle)
> >  0.000ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
> >  0.459ms (+0.459ms): generic_redirect_hardirq (do_IRQ)
> >  0.459ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
> >  0.459ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
> 
> > It definitely looks like the kernel is interrupted by some interrupt
> > source not covered by the patch.
> 
> the only possibility is SMM, which is not handled by Linux. (but by the
> BIOS.) Otherwise we track everything - including NMIs.
> 
> can you reproduce this using an UP kernel too?
> 
> 	Ingo

I'm currently not using SMP :

root@satellite linux # grep SMP .config
CONFIG_BROKEN_ON_SMP=y
# CONFIG_X86_BIGSMP is not set
# CONFIG_SMP is not set

Whole .config here:
http://www.undata.org/~thomas/config-2.6.8-P2

This would confirm the hypothesis of a buggy BIOS, I'm afraid.

Thomas


