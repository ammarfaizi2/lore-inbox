Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268825AbUHUCvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268825AbUHUCvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 22:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268826AbUHUCvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 22:51:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12739 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268825AbUHUCvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 22:51:35 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040820133031.GA13105@elte.hu>
References: <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu>  <20040820133031.GA13105@elte.hu>
Content-Type: text/plain
Message-Id: <1093056694.854.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 22:51:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 09:30, Ingo Molnar wrote:
> i've uploaded the -P5 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P5

>  - added a preempt_count field to /proc/latency_trace. This makes it
>    easier to spot IRQ contexts and generally it gives a nice overview of
>    how the preemption depth changes. It should also help us debug
>    those 900usec weirdnesses related to cpu_idle. (if they still occur)
> 

Ok, disregard my question about what this field was.

>  - made the tcp packet-queue collapsing dependent on VOLUNTARY_PREEMPT.
> 

I am seeing ~180usec latencies related to netif_receive_skb:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6/trace5.txt

Lee

