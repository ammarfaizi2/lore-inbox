Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbULIUF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbULIUF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbULIUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:05:59 -0500
Received: from mx1.elte.hu ([157.181.1.137]:48875 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261598AbULIUFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:05:54 -0500
Date: Thu, 9 Dec 2004 21:04:35 +0100
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209200435.GA14194@elte.hu>
References: <OF5058AABF.606A2CFD-ON86256F65.0067A0C9@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5058AABF.606A2CFD-ON86256F65.0067A0C9@raytheon.com>
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

> I don't expect turning the debugging off will make that much of a
> difference but I can try it tomorrow. [...]

so basically this is your setup:

 - prio 99: all IRQ threads and ksoftirqd threads

 - prio 30: 'CPU loop' from latencytest, generating ~80% CPU load

 - SCHED_OTHER: workload generators

and the metric is "delays in the prio 30 CPU loop", correct?

	Ingo
