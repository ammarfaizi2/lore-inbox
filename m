Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUHVCWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUHVCWe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUHVCWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:22:33 -0400
Received: from relay.pair.com ([209.68.1.20]:40465 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S265487AbUHVCWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:22:18 -0400
X-pair-Authenticated: 66.190.51.173
Message-ID: <41280355.8040109@cybsft.com>
Date: Sat, 21 Aug 2004 21:22:13 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
References: <1092628493.810.3.camel@krustophenia.net>	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>	 <20040820195540.GA31798@elte.hu>  <20040821140501.GA4189@elte.hu>	 <1093125390.817.22.camel@krustophenia.net>  <4127E386.5000701@cybsft.com> <1093133810.817.26.camel@krustophenia.net>
In-Reply-To: <1093133810.817.26.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
 > On Sat, 2004-08-21 at 20:06, K.R. Foley wrote:
 >
 >>I just posted a similar trace of ~4141 usec from P6 here:
 >>
 >>http://www.cybsft.com/testresults/2.6.8.1-P6/latency-trace1.txt
 >>
 >
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
 > Probably a false positive, Ingo would know better.  What kind of stress
 > testing were you doing?
 >
 > Lee
 >

This is while running the stress-kernel suite. I don't know about it
being a false possitive, it very well may be. Looking back through the
logs though I am not sure this is a valid latency anyway. This trace was
from 06:37 this morning. About 19:54 last night I got an oops in kswapd
and this morning around 10:30ish I had stuff getting killed right and
left by oom. So, I am thinking that this probably is not a very reliable
test.

kr

