Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUIBGzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUIBGzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267512AbUIBGzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:55:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:20682 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266845AbUIBGzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 02:55:01 -0400
Date: Thu, 2 Sep 2004 08:55:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       alsa-devel@lists.sourceforge.net
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
Message-ID: <20040902065549.GA18860@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902063335.GA17657@elte.hu>
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


i've released the -Q8 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q8

ontop of:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

this release fixes an artificial 0-1msec delay between hardirq arrival
and softirq invocation. This should solve some of the ALSA artifacts
reported by Mark H Johnson. It should also solve the rtl8139 problems -
i've put such a card into a testbox and with -Q7 i had similar packet
latency problems while with -Q8 it works just fine.

So netdev_backlog_granularity is still a value of 1 in -Q8, please check
whether the networking problems (bootup and service startup and latency)
problems are resolved. (and increase this value in case there are still
problems.)

	Ingo
