Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUKVVO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUKVVO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUKVVNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:13:25 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23978 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262427AbUKVVKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:10:52 -0500
Date: Mon, 22 Nov 2004 23:12:24 +0100
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122221224.GA13799@elte.hu>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com>
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

>  - echo 0 > /proc/sys/kernel/preempt_wakeup_timing [entered, but
> display was frozen at this point and did not see newline nor any
> further output]

managed to reproduce this on an SMP box but not on an UP box, so i think
this is SMP related. It definitely happens almost immediately after
preempt_wakeup_timing is reset - or after preempt_max_timing is reset. 
(Perhaps a dump_stack() from the wrong place, or something like that.)

	Ingo
