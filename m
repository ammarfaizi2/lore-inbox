Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbUKKM1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUKKM1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 07:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUKKM1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 07:27:31 -0500
Received: from relay03.pair.com ([209.68.5.17]:15879 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S262224AbUKKM11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 07:27:27 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41935AAA.6030804@cybsft.com>
Date: Thu, 11 Nov 2004 06:27:22 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
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
References: <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <4192F244.7020103@cybsft.com> <20041111102057.GA18801@elte.hu> <20041111130543.GA28641@elte.hu>
In-Reply-To: <20041111130543.GA28641@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>i've done some further cleanups: made it .config configurable
>>(CONFIG_RTC_HISTOGRAM), moved the latency-histogram construction code
>>into separate functions to make it more apparent that there is no
>>impact to the normal codepaths. Patch attached.
> 
> 
> i've attached another update with a few more smaller details fixed:
> 
>  - only print the histogram if a /dev/rtc using application indeed used 
>    it to get interrupts. This removes bogus printouts triggered by 
>    hwclock.
> 
>  - skip the first RTC interrupt from the histogram - most of the
>    /dev/rtc applications do not handle the first event very well,
>    skewing the histogram.
> 
> 	Ingo

Very nicely done. Also much less of a hack now the way you took all of 
the code out of the normal codepaths and made it into inlines that 
pretty much compile out if not being used.

kr
