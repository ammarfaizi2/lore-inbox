Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbULGOIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbULGOIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 09:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbULGOIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 09:08:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59608 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261600AbULGOH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 09:07:57 -0500
Date: Tue, 7 Dec 2004 15:07:33 +0100
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
Message-ID: <20041207140733.GA10072@elte.hu>
References: <OF17EC3728.49FC8C3C-ON86256F62.00576C16@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF17EC3728.49FC8C3C-ON86256F62.00576C16@raytheon.com>
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

> > It is easy to hack the scheduler to fix some RT issue but break the 
> > generic scheduler - this solution is not meant to be such a hack.
>
> I agree but I see the big delay of running the RT task to be a symptom
> that the current non RT scheduler is somehow broken. I've reported the
> non RT starvation condition several times. Yes, the second CPU is
> busy, but I really do want to bump cpu_burn (which is non RT & nice)
> to run my (non RT and not nice) stress script / commands instead.

well ... doing global balancing on SMP gets really expensive, really
quick. It's simply not an option for 4 way or higher, and even on 2-way
it's measurable. In the RT case arguably latency is more important than
throughput, but i dont think the same case could be made for nice vs. 
non-nice.

	Ingo
