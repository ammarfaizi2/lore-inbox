Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUHVAQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUHVAQw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 20:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUHVAQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 20:16:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5760 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262406AbUHVAQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 20:16:50 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <4127E386.5000701@cybsft.com>
References: <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <20040820195540.GA31798@elte.hu>  <20040821140501.GA4189@elte.hu>
	 <1093125390.817.22.camel@krustophenia.net>  <4127E386.5000701@cybsft.com>
Content-Type: text/plain
Message-Id: <1093133810.817.26.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 20:16:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 20:06, K.R. Foley wrote:
> I just posted a similar trace of ~4141 usec from P6 here:
> 
> http://www.cybsft.com/testresults/2.6.8.1-P6/latency-trace1.txt
> 

This looks wrong:

00000003 0.008ms (+0.001ms): dummy_socket_sock_rcv_skb (tcp_v4_rcv)
00000004 0.008ms (+0.000ms): tcp_v4_do_rcv (tcp_v4_rcv)
00000004 0.009ms (+0.000ms): tcp_rcv_established (tcp_v4_do_rcv)
00010004 3.998ms (+3.989ms): do_IRQ (tcp_rcv_established)
00010005 3.999ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
00010005 4.001ms (+0.002ms): generic_redirect_hardirq (do_IRQ)
00010004 4.002ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)

Probably a false positive, Ingo would know better.  What kind of stress
testing were you doing?

Lee

