Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUKIWT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUKIWT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUKIWT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:19:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:39402 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261730AbUKIWS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:18:56 -0500
Date: Wed, 10 Nov 2004 00:20:02 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041109232002.GA14503@elte.hu>
References: <OFC1C59379.C97F0CF1-ON86256F47.00720C09@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFC1C59379.C97F0CF1-ON86256F47.00720C09@raytheon.com>
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

> [3] I am not so sure that the latency tracing works. I do not get any
> trace output, even if I set preempt_max_latency to zero.

What is the value of preempt_thresh? If it's set then it overrides the
preempt_max_latency value. (previously the bogus timing values probably
triggered even a relatively high preempt-threshold, but now with a
correct tracer it's not possible anymore.)

> [...] I also noticed that /proc/sys/kernel/preempt_wakeup_timing was
> removed at .20 but not sure if that was deliberate. [...]

yeah, this was deliberate - it's a side-effect of separating it from the
other timing options.

	Ingo
