Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269791AbUJGKwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269791AbUJGKwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269790AbUJGKwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:52:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28101 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269791AbUJGKvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:51:05 -0400
Date: Thu, 7 Oct 2004 12:52:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041007105230.GA17411@elte.hu>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005134707.GA32033@elte.hu>
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


i've released the -T3 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3

Changes since -T1 (-T2 was not announced):

 - rebased to -rc3-mm3. This should fix the build problems and further 
   shrinks the -VP patch. Also, people who had USB problems please
   re-test -T3 as -mm3 is supposed to have much of those problems fixed.
   Also, the dvb-bt8xx.c build problem should be fixed in -mm3 too, plus
   a number of smp_processor_id() warnings were debugged and fixed as
   well.

 - fixed SWSUSPEND compilation. Could someone who uses swsuspend check
   whether sw-suspension works fine?

 - improved CONFIG_DEBUG_PREEMPT - this could help debug any potentially
   remaining unbalanced preemption counts that were reported. (but
   the fixes in -mm3 could fix them as well.)

to build a -T3 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc3.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/2.6.9-rc3-mm3.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3

	Ingo
