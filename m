Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbULAJD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbULAJD1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 04:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbULAJD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 04:03:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17371 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261336AbULAJDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 04:03:23 -0500
Date: Wed, 1 Dec 2004 10:02:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041201090220.GE15928@elte.hu>
References: <OFF4F89D90.B89E0767-ON86256F5C.004C735C@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF4F89D90.B89E0767-ON86256F5C.004C735C@raytheon.com>
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


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> I have results from two builds of -V0.7.31-9. The first build is
> CONFIG_RT (RT) and the second is CONFIG_DESKTOP (PK or as described in
> .config help - Preempt Kernel).

interesting numbers. The slowdown in networking could easily be due to
IRQ and softirq threading, so it would make sense to also add a "PNT"
test (preempt, non-threaded), just to have something functionally
comparable to 2.4 lowlat+preempt.

	Ingo
