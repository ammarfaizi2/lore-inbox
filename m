Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUHTJPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUHTJPD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUHTJPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 05:15:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62092 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267827AbUHTJOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 05:14:04 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040820081319.GA4321@elte.hu>
References: <20040816034618.GA13063@elte.hu>
	 <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <1092972918.10063.11.camel@krustophenia.net>
	 <20040820081319.GA4321@elte.hu>
Content-Type: text/plain
Message-Id: <1092993242.10063.66.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 05:14:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 04:13, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4
> > 
> > I think I am seeing those weird ~1 ms latencies still (actually I am not
> > sure I saw before now):
> > 
> > http://krustophenia.net/testresults.php?dataset=2.6.8.1-P4#/var/www/2.6.8.1-P4/kswapd_latency_trace.txt
> 
> this is a 9 msec latency in fact. I know what's going on - it's the
> get_swap_page() locking - i looked at it once already but there's no
> immediate silver arrow. As we allocate more and more swap entries the
> longer the scan gets.
> 

This is an extreme load situation, so I don't think it will be a
real-world problem.  I have not seen it under any normal workload.

What about this one:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P4#/var/www/2.6.8.1-P4/netif_receive_skb_latency_trace.txt

This appears during normal use.

Lee


