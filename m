Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbULJVNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbULJVNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbULJVNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:13:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17625 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261212AbULJVM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:12:59 -0500
Date: Fri, 10 Dec 2004 22:12:35 +0100
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
Message-ID: <20041210211235.GB5864@elte.hu>
References: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF8AB2B6D9.572374AA-ON86256F66.0061EFA8-86256F66.0061F00A@raytheon.com>
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

> [3] Some traces show information on both CPU's and then a long period
> with no traces from the other. Here is an example...

> <unknown-2847  1d.h.    4탎 : rebalance_tick (scheduler_tick)
> <unknown-2847  1d.h.    5탎 : irq_exit (apic_timer_interrupt)
> <unknown-2847  1d...    5탎 < (0)

> ... no more traces from CPU 1 ...

PID 2847 returned to userspace at timestamp 5탎. Userspace then can take
an arbitrary amount of time until it calls the kernel again.

	Ingo
