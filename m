Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbULAVVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbULAVVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbULAVVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:21:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51426 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261452AbULAVVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:21:03 -0500
Date: Wed, 1 Dec 2004 22:20:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041201212051.GD22671@elte.hu>
References: <OFD409C8B3.8F810860-ON86256F5D.004D6614@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD409C8B3.8F810860-ON86256F5D.004D6614@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70, UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Unless I am mistaken, my "PK" config is the closest to 2.4 lowlat+preempt.

indeed, you are right.

> For the relevant differences in .config:
>   PK                                  RT
>   CONFIG_PREEMPT_DESKTOP=y            CONFIG_PREEMPT_DESKTOP is not set
>   CONFIG_PREEMPT_RT is not set        CONFIG_PREEMPT_RT=y
>   CONFIG_PREEMPT=y                    CONFIG_PREEMPT=y
>   CONFIG_PREEMPT_SOFTIRQS is not set  CONFIG_PREEMPT_SOFTIRQS=y
>   CONFIG_PREEMPT_HARDIRQS is not set  CONFIG_PREEMPT_HARDIRQS=y
> (though the system still creates ksoftirqd/0 and /1 on both...)
>   CONFIG_SPINLOCK_BKL is not set      [not present]
>   CONFIG_PREEMPT_BKL=y                CONFIG_PREEMPT_BKL=y
>   CONFIG_ASM_SEMAPHORES=y             [not present]
>   CONFIG_RWSEM_XCHGADD_ALGORITHM=y    [not present]
>   ...
>   [not present]                       CONFIG_RT_DEADLOCK_DETECT=y
>   ...

the only thing i'd suggest to change is to also generate an RT (and 
perhaps PK) result with all debugging options disabled - i.e. both 
RT_DEADLOCK_DETECT and all LATENCY_TRACING/timing related options 
disabled.

but your tests did trigger asserts not so long ago so it might not be
wise to run without debugging. But it's definitely a thing to try in the
future.

> Unless you are saying that I should back off to one of the other
> preempt settings (to replicate the 2.4 config on 2.6).

no, i think the PK kernel is supposed to be quite close to what
2.4+lowlat offers.

	Ingo
