Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbULGOLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbULGOLg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 09:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbULGOLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 09:11:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18650 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261630AbULGOLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 09:11:33 -0500
Date: Tue, 7 Dec 2004 15:11:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041207141123.GA12025@elte.hu>
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041207132927.GA4846@elte.hu>
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


i have released the -V0.7.32-6 Real-Time Preemption patch, which can be
downloaded from the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this too is a fixes-only release.

Changes since -V0.7.32-4:

 - fixed a lock_kernel()-re-enables-interrupts bug reported by Daniel 
   Walker. The fix is to allow down() from irqs-off sections (and 
   save/restore irq flags) as long as there's no real contention on the
   semaphore.

 - fixed a /proc/latency_trace formatting bug reported by Mark H. 
   Johnson.

to create a -V0.7.32-6 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/2.6.10-rc2-mm3.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm3-V0.7.32-6

	Ingo
