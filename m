Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbUKOQsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUKOQsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 11:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUKOQsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 11:48:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3028 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261637AbUKOQsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 11:48:30 -0500
Date: Mon, 15 Nov 2004 18:50:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041115175000.GA7559@elte.hu>
References: <OF201B61B1.F0A7806E-ON86256F4A.005D427B-86256F4A.005D4299@raytheon.com> <20041115164604.GA1456@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115164604.GA1456@elte.hu>
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

> >  [8] Some samples of /proc/loadavg during my big test showed some
> > extremely large numbers. For example:
> > 5.07 402.44 0.58 5/120 4448
> 
> i'm currently trying to track down this one. The
> rq->nr_uninterruptible count got out of sync during one of the
> scheduler changes - and this causes large negative task counts,
> messing up the load-average.

ok, found it - it's an upstream bug in fact. I've uploaded -V0.7.26-5
with the fix.

	Ingo
