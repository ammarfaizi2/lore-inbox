Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUHTDeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUHTDeD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 23:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUHTDeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 23:34:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24012 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266240AbUHTDeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 23:34:00 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040819073247.GA1798@elte.hu>
References: <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu>
Content-Type: text/plain
Message-Id: <1092972918.10063.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 23:35:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 03:32, Ingo Molnar wrote:
> i've uploaded the -P4 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4

I think I am seeing those weird ~1 ms latencies still (actually I am not
sure I saw before now):

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P4#/var/www/2.6.8.1-P4/kswapd_latency_trace.txt

This was the result of doing `make -j12' with a large C++ program (I
know, I wanted to see what would happen).  This gradually slowed the
machine to a crawl - for a while I could watch the /proc/latency_trace
fiels and see the latency gradually climbing.  Eventually tha machine
ground almost to a halt, with lots of disk activity., and trying to
switch from X to a console window resulted in a blank screen for 2-3
minutes.  I did eventually get a text console and was able to kill all
the cc1plus processes, and the machine went back to normal.

The link above is the highest latency recorded during this episode.

Lee

