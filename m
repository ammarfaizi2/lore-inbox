Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbULFNRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbULFNRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbULFNRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:17:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64436 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261199AbULFNRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:17:35 -0500
Date: Mon, 6 Dec 2004 14:14:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
Message-ID: <20041206131458.GA20247@elte.hu>
References: <20041203205807.GA25578@elte.hu> <Pine.OSF.4.05.10412052342380.12234-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10412052342380.12234-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> On Fri, 3 Dec 2004, Ingo Molnar wrote:
> 
> > 
> > [...] 
> > on low RT load (the common case) 
> 
> In the system I deal with on my day job, 50% of the CPU load is from
> RT tasks!

i'm not sure what point you are trying to make, but 'low RT load' in
this context means up to a load of 1.0. (i.e. one or less tasks running
on average)

also, this only applies to SMP systems.

thirdly, even if the new balancing code kicks in, the overhead is not
that bad, and it's for a purpose: we rather want an RT task to run on a
free CPU.

	Ingo
