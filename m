Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUIUHn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUIUHn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUIUHn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 03:43:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3984 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267509AbUIUHn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 03:43:27 -0400
Date: Tue, 21 Sep 2004 09:44:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: [patch] voluntary-preempt-2.6.9-rc2-mm1-S2
Message-ID: <20040921074426.GA10477@elte.hu>
References: <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921071854.GA7604@elte.hu>
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


i've released the -S2 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S2

Changes since -S1:

 - added the swapspace-layout patch to fix the get_swap_page()
   latencies. (sw-suspend wont compile but everything else should work
   fine.)

 - fixed the random.c BKL non-preemptability assumption

 - export smp_processor_id() to fix modules

 - module init smp_processor_id()-debug false positive fix

To get a 2.6.9-rc2-mm1-VP-S2 kernel, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc2.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/2.6.9-rc2-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S2

	Ingo
