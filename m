Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268155AbUJCVHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268155AbUJCVHw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 17:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUJCVHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 17:07:52 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:1253 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268155AbUJCVHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 17:07:51 -0400
Date: Sun, 3 Oct 2004 23:09:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: [patch] voluntary-preempt-2.6.9-rc3-mm1-S8
Message-ID: <20041003210926.GA1267@elte.hu>
References: <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928000516.GA3096@elte.hu>
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


i've released the -S8 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm1-S8

this iteration is mainly a merge to -rc3-mm1. The -rc3-mm1 tree now
includes the generic-irq-subsystem patch which is a prerequisite of the
threaded-irqs feature in the -VP patch. As a result of this the -VP
patch got significantly smaller, down from 224K to 89K.

also part of the patch are further refinements of the preempt-bkl
feature and a couple of bugfixes, reported for the -mm tree but not
included in -rc3-mm1 yet. (All of these were sent to Andrew too so they
should show up in -mm2.)

to build an -S8 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc3.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm1/2.6.9-rc3-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm1-S8

	Ingo
