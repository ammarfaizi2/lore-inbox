Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUHSHcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUHSHcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUHSHcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:32:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33665 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262932AbUHSHcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:32:05 -0400
Date: Thu, 19 Aug 2004 09:32:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: [patch] voluntary-preempt-2.6.8.1-P4
Message-ID: <20040819073247.GA1798@elte.hu>
References: <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817080512.GA1649@elte.hu>
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


i've uploaded the -P4 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4

the main change is a more robust latency tracer - the previous one was
not 100% correct for interrupts. People who have exprienced those weird
~1msec latencies in the idle task please re-check and re-post latency
traces.

Changes since -P3:

 - changed SHA_CODE_SIZE from 0 to 3 to reduce RNG overhead

 - fixed the copy_page_range latency

 - improved the latency tracer

	Ingo
