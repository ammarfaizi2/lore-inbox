Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbULMW4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbULMW4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbULMWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:54:46 -0500
Received: from mx1.elte.hu ([157.181.1.137]:10477 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261209AbULMWe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:34:29 -0500
Date: Mon, 13 Dec 2004 23:33:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Message-ID: <20041213223357.GA6944@elte.hu>
References: <OFA329B47C.3EDA9672-ON86256F69.005967F1@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA329B47C.3EDA9672-ON86256F69.005967F1@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> A comparison of PREEMPT_RT (no tracing) to PREEMPT_DESKTOP
> (with tracing) to help answer previous requests.
> 
> Comparison of .32-20RT and .32-18PK results
> 20RT has PREEMPT_RT (all tracing disabled)
> 18PK has PREEMPT_DESKTOP and no threaded IRQ's (tracing enabled)
> 2.4 has lowlat + preempt patches applied
> 
>       within 100 usec
>        CPU loop (%)   Elapsed Time (sec)    2.4
> Test   RT     PK        RT      PK   |   CPU  Elapsed
> X     99.87 100.00&     65 *    64+  |  97.20   70
> top   99.35 100.00&     31 *    31+  |  97.48   29
> neto  96.94 100.00&    113 *   184+  |  96.23   36
> neti  97.05 100.00&    119 *   170+  |  95.86   41

interesting - the PK kernel with tracing enabled performs better than
the PK kernel with tracing disabled? Sounds counter-intuitive.

	Ingo
