Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbULMW4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbULMW4x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbULMWyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:54:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:27868 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261338AbULMWkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:40:43 -0500
Date: Mon, 13 Dec 2004 23:39:47 +0100
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
Message-ID: <20041213223947.GB6944@elte.hu>
References: <OF400780A2.F355C2F4-ON86256F69.006AD194@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF400780A2.F355C2F4-ON86256F69.006AD194@raytheon.com>
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

> The maximum duration of the CPU loop (as measured by the application)
> is in the range of 1.42 msec to 2.57 compared to the nominal 1.16 msec
> duration for -20RT.  The equivalent numbers for -20PK are 1.28 to 1.93
> msec. [...]

so -20RT has resolved all the CPU-loop-max-delay issues of the -RT
kernel regarding the RT-priority CPU loop and in essence adds only a
small amount of delay (100 usecs?) to the nominal (==minimum possible)
delay?

i suspect the 100 usecs comparison is an effect of the cutoff value
being a single value. Also, 100 usecs is so close to the DMA related
delay which makes it hard to compare it - other than stating that -RT
has higher CPU overhead.

are the ping times still considered anomalous? Could be a side-effect of
the different flow of control between hardirq/softirq contexts. (There
have been a (low but nonzero) number of assumptions about the flow in
pieces of softirq code, and there could be more.)

	Ingo
