Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbUKOSwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbUKOSwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 13:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUKOSwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 13:52:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:4744 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261663AbUKOSwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 13:52:02 -0500
Date: Mon, 15 Nov 2004 20:52:03 +0100
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
Message-ID: <20041115195203.GA12321@elte.hu>
References: <OFCFA96E95.192AA15E-ON86256F4D.00668D28-86256F4D.00668D43@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFCFA96E95.192AA15E-ON86256F4D.00668D28-86256F4D.00668D43@raytheon.com>
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

* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

>  1209 80000000 0.005ms (+0.000ms): do_nmi (mcount)
>  1209 80000000 0.005ms (+0.000ms): do_nmi (<00200286>)
>  1209 80000000 0.006ms (+0.000ms): profile_hook (profile_tick)
>  1209 80000000 0.006ms (+0.000ms): _raw_read_lock (profile_hook)
>  1209 80000000 0.007ms (+0.196ms): _raw_read_unlock (profile_tick)
>  1209 80000000 0.204ms (+0.001ms): set_new_owner (__down_mutex)

i've seen NMIs causing such problems before. Could you try a testrun
with all debug options disabled in the .config (and REGPARM enabled,
etc.) plus nmi_watchdog=0? Just to see how many of the artifacts are
related to debugging overhead.

	Ingo
