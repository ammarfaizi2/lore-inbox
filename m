Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbUKTMBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUKTMBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbUKTL7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 06:59:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20117 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262805AbUKTL5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 06:57:04 -0500
Date: Sat, 20 Nov 2004 13:59:23 +0100
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
Message-ID: <20041120125923.GD8091@elte.hu>
References: <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net> <20041120125057.03b3d8c4@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120125057.03b3d8c4@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> here are the different layers of preemption:
> 
>  - !PREEMPT
>  - PREEMPT_VOLUNTARY
>  - PREEMPT
>  - PREEMPT_RT
> 
> each step forward decreases latencies, at the cost of more runtime
> overhead.

yes, and here is how they show up in the config:

               ( ) No Forced Preemption (Server)
               ( ) Voluntary Kernel Preemption (Desktop)
               ( ) Preemptible Kernel (Low-Latency Desktop)
               (X) Complete Preemption (Real-Time)

measurements are needed to find out how latencies and runtime overhead
vary between these levels.

	Ingo
