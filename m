Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUHTINR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUHTINR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUHTIM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:12:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13024 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264538AbUHTILu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:11:50 -0400
Date: Fri, 20 Aug 2004 10:13:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
Message-ID: <20040820081319.GA4321@elte.hu>
References: <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <1092972918.10063.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092972918.10063.11.camel@krustophenia.net>
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

> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4
> 
> I think I am seeing those weird ~1 ms latencies still (actually I am not
> sure I saw before now):
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8.1-P4#/var/www/2.6.8.1-P4/kswapd_latency_trace.txt

this is a 9 msec latency in fact. I know what's going on - it's the
get_swap_page() locking - i looked at it once already but there's no
immediate silver arrow. As we allocate more and more swap entries the
longer the scan gets.

	Ingo
