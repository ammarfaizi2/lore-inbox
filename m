Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUIBLJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUIBLJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268284AbUIBLJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:09:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50669 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268228AbUIBLIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:08:50 -0400
Date: Thu, 2 Sep 2004 13:10:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Message-ID: <20040902111003.GA4256@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902065549.GA18860@elte.hu>
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


i've released the -Q9 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q9

ontop of:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

Changes:

 - fixed the cond_resched_softirq() bug noticed by Mika Penttila.

 - updated the preemption-friendly network-RX code but 8193too.c still
   produces delayed packets so netdev_backlog_granularity now defaults
   to 2, which seems to be working fine on my testbox.

 - the latency_trace output now includes the kernel and patch version,
   for easier sorting of reports.

	Ingo
