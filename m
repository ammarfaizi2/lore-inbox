Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269069AbUHaTqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269069AbUHaTqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUHaTqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:46:11 -0400
Received: from pD9E0ED8C.dip.t-dialin.net ([217.224.237.140]:36996 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S269062AbUHaTpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:45:33 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Daniel Schmitt <pnambic@unu.nu>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040831193029.GA29912@elte.hu>
References: <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093875939.5534.9.camel@localhost>
	 <20040830180011.GA7419@elte.hu> <1093980227.8005.14.camel@localhost>
	 <20040831193029.GA29912@elte.hu>
Content-Type: text/plain
Message-Id: <1093981507.8005.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 21:45:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> * Thomas Charbonnel <thomas@undata.org> wrote:
> 
> > As you can see ~1ms was probably an accident, and the latency does not
> > always come from do_timer. The constant is do_IRQ interrupting the
> > idle thread.
> 
> (do you have any sort of powersaving mode (ACPI/APM) enabled? If yes,
> could you try to tune it down as much as possible - disable any
> powersaving option in the BIOS and in the .config - kill apmd, etc.)
> 
> but i dont think it's powersaving - why would such an overhead show up
> in those functions. The only common thing seems to be that both
> mark_offset_tsc() and mask_and_ack_8259A() does port IO, which is slow -
> but still it shouldnt take ~0.5 msecs!
> 
> 	Ingo

Indeed, I just checked and my xrun every ~8 seconds problem is back. I
have acpi compiled in but acpi=off, but it doesn't seem to be honoured
(it was with 2.6.8.1, IIRC).

Thomas




