Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbUKJOEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbUKJOEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUKJODM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:03:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53971 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261906AbUKJOAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:00:21 -0500
Date: Wed, 10 Nov 2004 16:01:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041110150136.GA8668@elte.hu>
References: <20041021132717.GA29153@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <200411101452.36007.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411101452.36007.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Hi
> 
> On SMP/HT/P4 I get:
>  BUG: lock held at task exit time!

> sh/5429: BUG in __up_mutex at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:1064
> BUG: sleeping function called from invalid context sh(5429) at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:1314
> in_atomic():1 [00000003], irqs_disabled():0

hm, apparently something leaked a BKL count. Unfortunately we dont know
precisely what did it, only that it happened. Did this happen during
bootup, or during normal use. Can you trigger it arbitrarily?

	Ingo
