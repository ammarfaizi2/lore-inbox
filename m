Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbUKRI4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUKRI4G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 03:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbUKRI4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 03:56:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53431 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262683AbUKRI4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 03:56:04 -0500
Date: Thu, 18 Nov 2004 10:57:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
Message-ID: <20041118095742.GB16054@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <419C0B26.9070607@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419C0B26.9070607@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> I know I am late reporting this but I didn't figure it out until late
> this afternoon. I had trouble booting this one on my SMP workstation
> at the office. It would hang after it had almost finished booting.
> Anyway the solution was to disable tracing in /etc/rc.local and then
> re-enable it after it has finished booting. I know this happens late
> in the boot but it works for me.
> 
> echo 0 > /proc/sys/kernel/trace_enabled
> #echo 0 > /proc/sys/kernel/preempt_wakeup_timing
> #echo 50 > /proc/sys/kernel/preempt_max_latency
> 
> To be honest I am not sure which of the above fixes the late boot hang
> and I didn't have time to figure it out either. This doesn't happen on
> my SMP system here.

there's a generic bug i'm chasing right now that seems to get worse with
tracing enabled. The symptom of the bug is typically a system hang.

	Ingo
