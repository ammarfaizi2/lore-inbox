Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbUKKIvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUKKIvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 03:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbUKKIvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 03:51:00 -0500
Received: from mx1.elte.hu ([157.181.1.137]:6285 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261336AbUKKIuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 03:50:55 -0500
Date: Thu, 11 Nov 2004 10:52:44 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041111095244.GA16299@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <4192F244.7020103@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4192F244.7020103@cybsft.com>
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

> Ingo Molnar wrote:
> >i have released the -V0.7.23 Real-Time Preemption patch, which can be
> >downloaded from the usual place:
> >
> 
> Here is the updated rtc-debug patch. This version unlike previous
> versions doesn't change the way the rtc driver works. The output of
> /dev/rtc is preserved also so it doesn't break the existing
> functionality of rtc. By the same token it won't produce output usable
> by amlat, but it works for measuring the latency from interrupt to
> read. 

looks good - i've added this to my tree. (with minor portability fixes:
rdtscll -> get_cycles(), long long -> cycles_t)

	Ingo
