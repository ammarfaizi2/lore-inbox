Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbUKKUv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUKKUv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUKKUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:51:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15761 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262355AbUKKUvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:51:55 -0500
Date: Thu, 11 Nov 2004 22:51:22 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041111215122.GA5885@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111144414.GA8881@elte.hu>
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


i have released the -V0.7.25-1 Real-Time Preemption patch, which can be
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release that resolves a couple of bugs that slipped
into -V0.7.25-0:

 - lockup/deadlock fix: make debug_direct_keyboard default to 0. It is
   only a debug helper to be used for development, it was never intended
   to be enabled. This fix should resolve the bugs reported by Gunther
   Persoons and Mark H. Johnson.

 - fix symbol export problems in rtc.ko, reported by Remi Colinet, based
   on the patch from K.R. Foley.

 - make preempt_wakeup_timing default to 1 if enabled in the .config, as 
   originally intended.

to create a -V0.7.25-1 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.25-1

	Ingo
