Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbUKRCie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbUKRCie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUKRCie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 21:38:34 -0500
Received: from relay02.pair.com ([209.68.5.16]:3847 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262369AbUKRCic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 21:38:32 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <419C0B26.9070607@cybsft.com>
Date: Wed, 17 Nov 2004 20:38:30 -0600
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
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
References: <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu>
In-Reply-To: <20041117124234.GA25956@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.28-0 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
> 	http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes & latency-reduction release.
> 

I know I am late reporting this but I didn't figure it out until late
this afternoon. I had trouble booting this one on my SMP workstation at
the office. It would hang after it had almost finished booting. Anyway
the solution was to disable tracing in /etc/rc.local and then re-enable
it after it has finished booting. I know this happens late in the boot
but it works for me.

echo 0 > /proc/sys/kernel/trace_enabled
#echo 0 > /proc/sys/kernel/preempt_wakeup_timing
#echo 50 > /proc/sys/kernel/preempt_max_latency

To be honest I am not sure which of the above fixes the late boot hang 
and I didn't have time to figure it out either. This doesn't happen on 
my SMP system here.

kr

