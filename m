Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbUKUNaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUKUNaH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 08:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUKUNaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 08:30:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:61063 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261153AbUKUNaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 08:30:03 -0500
Date: Sun, 21 Nov 2004 15:32:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041121143234.GA23773@elte.hu>
References: <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net> <20041120125536.GC8091@elte.hu> <1100971141.6879.18.camel@krustophenia.net> <20041120191403.GA16262@elte.hu> <1100975745.6879.35.camel@krustophenia.net> <20041120201155.6dc43c39@mango.fruits.de> <20041120214035.2deceaeb@mango.fruits.de> <20041121124555.GA7972@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121124555.GA7972@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> > So i don't really know how to go about this. I suppose i just run
> > PREEMPT kernels instead of PREEMPT_REALTIME. Maybe it's the overhead
> > which is killing jackd performance with PREEMPT_REALTIME, but i don't
> > believe so (50ms? nah!).
> 
> agreed, no way can 50msec be related to overhead.

there's one exception: if the RT workload is _just_ below 100% CPU
utilization, then PREEMPT_RT's overhead could push it above 100% and
trigger CPU overload, with big delays. What is the maximum CPU usage
during the test, while the system is otherwise idle?

	Ingo
