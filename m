Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUHUJMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUHUJMr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 05:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268937AbUHUJMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 05:12:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22680 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268928AbUHUJMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 05:12:35 -0400
Date: Sat, 21 Aug 2004 11:13:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
Message-ID: <20040821091338.GA25931@elte.hu>
References: <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <1093058602.854.5.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093058602.854.5.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, 2004-08-20 at 09:30, Ingo Molnar wrote:
> 
> >  - reduce ZAP_BLOCK_SIZE to 16 when vp != 0. This pushes the exit
> >    latency down to below 100 usecs on Lee Revell's box.
> > 
> 
> Almost:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6#/var/www/2.6.8.1-P6/trace8.txt

i suspect if you turn off tracing (or disable it in the kernel
completely) then you'd see below-100 usec latencies here. A trace entry
costs ~0.3 usecs on your box, so this 50-entry trace has roughly 15
usecs of tracing overhead :-)

	Ingo
