Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269096AbUJENpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269096AbUJENpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUJENpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:45:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40105 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269113AbUJENpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:45:33 -0400
Date: Tue, 5 Oct 2004 15:47:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
Message-ID: <20041005134707.GA32033@elte.hu>
References: <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004215315.GA17707@elte.hu>
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


i've released the -T1 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-T1

Changes since -T0:

 - added the read-lock fix from Hugh that affects SMP systems. This 
   could fix Rui's problem - i've checked -T1 on a P4/HT box and saw no 
   problems, BYMMV.

 - compilation fixes (for those who downloaded T0 early)

 - small tracer improvement

to build a -T1 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc3.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/2.6.9-rc3-mm2.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-T1

	Ingo
