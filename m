Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267230AbUHaTcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267230AbUHaTcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUHaTbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:31:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47066 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269031AbUHaT2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:28:51 -0400
Date: Tue, 31 Aug 2004 21:30:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Daniel Schmitt <pnambic@unu.nu>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Message-ID: <20040831193029.GA29912@elte.hu>
References: <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <20040830090608.GA25443@elte.hu> <1093875939.5534.9.camel@localhost> <20040830180011.GA7419@elte.hu> <1093980227.8005.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093980227.8005.14.camel@localhost>
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

> As you can see ~1ms was probably an accident, and the latency does not
> always come from do_timer. The constant is do_IRQ interrupting the
> idle thread.

(do you have any sort of powersaving mode (ACPI/APM) enabled? If yes,
could you try to tune it down as much as possible - disable any
powersaving option in the BIOS and in the .config - kill apmd, etc.)

but i dont think it's powersaving - why would such an overhead show up
in those functions. The only common thing seems to be that both
mark_offset_tsc() and mask_and_ack_8259A() does port IO, which is slow -
but still it shouldnt take ~0.5 msecs!

	Ingo
