Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUHVGeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUHVGeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 02:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUHVGeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 02:34:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38038 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266263AbUHVGem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 02:34:42 -0400
Date: Sun, 22 Aug 2004 08:35:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
Message-ID: <20040822063500.GA20828@elte.hu>
References: <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu> <1093125390.817.22.camel@krustophenia.net> <4127E386.5000701@cybsft.com> <1093133810.817.26.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093133810.817.26.camel@krustophenia.net>
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

> On Sat, 2004-08-21 at 20:06, K.R. Foley wrote:
> > I just posted a similar trace of ~4141 usec from P6 here:
> > 
> > http://www.cybsft.com/testresults/2.6.8.1-P6/latency-trace1.txt
> > 
> 
> This looks wrong:
> 
> 00000003 0.008ms (+0.001ms): dummy_socket_sock_rcv_skb (tcp_v4_rcv)
> 00000004 0.008ms (+0.000ms): tcp_v4_do_rcv (tcp_v4_rcv)
> 00000004 0.009ms (+0.000ms): tcp_rcv_established (tcp_v4_do_rcv)
> 00010004 3.998ms (+3.989ms): do_IRQ (tcp_rcv_established)
> 00010005 3.999ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
> 00010005 4.001ms (+0.002ms): generic_redirect_hardirq (do_IRQ)
> 00010004 4.002ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
> 
> Probably a false positive, Ingo would know better.  What kind of
> stress testing were you doing?

indeed this looks suspect. Is this an SMP system?

	Ingo
