Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268713AbUJPMco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268713AbUJPMco (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 08:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268714AbUJPMco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 08:32:44 -0400
Received: from relay.pair.com ([209.68.1.20]:46094 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268713AbUJPMcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 08:32:42 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <417114E6.9090700@cybsft.com>
Date: Sat, 16 Oct 2004 07:32:38 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <20041016064205.GA30371@elte.hu> <1097917325.1424.13.camel@krustophenia.net> <20041016103608.GA3548@elte.hu>
In-Reply-To: <20041016103608.GA3548@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> 
>>>i regularly test it on UP. Do you have SPINLOCK_DEBUG enabled perhaps? 
>>>That doesnt work right now. You can enable DEBUG_SPINLOCK_SLEEP and
>>>DEBUG_PREEMPT.
>>
>>Sorry, I did have that enabled.  This caused a build failure with a UP
>>build and a boot failure with CONFIG_SMP.
> 
> 
> not your fault at all - i cleaned this up in my tree so that only valid
> combinations can be selected, these fixes will show up in -U4.
> 
> it seems that SMP + PREEMPT_TIMING is not stable though, somehow the
> latency printk's cause a crash sooner or later. I'm still debugging this
> problem. Without PREEMPT_TIMING the SMP kernel is stable.
> 
> 	Ingo
> 

On my SMP system here at home I have not seen this instability. It's 
been rock solid since yesterday morning and I already posted the worst 
latencies that have been generated. My SMP system at work was up and 
doing fine until I shut it down when I left last night. And posted the 
high latencies from that yesterday as well. All in all it doesn't look 
too bad to me.

kr

Home SMP system:
[root@porky latencies]# uptime
  07:23:55 up 19:42,  3 users,  load average: 67.22, 83.69, 57.23

Current time: Sat Oct 16 06:37:08 CDT 2004
Exiting test run..
Displaying report...
Total test time: 18h46m6s
Tests passed:
TTCP ran 1024 times in 8h32m50s, failed on 0 attempts.
FS ran 64 times in 18h46m3s, failed on 0 attempts.
CRASHME ran 256 times in 2h31m42s, failed on 0 attempts.
FIFOS_MMAP ran 256 times in 11h23m41s, failed on 0 attempts.
P3-FPU ran 256 times in 6h41m44s, failed on 0 attempts.
SAVE-STATE ran 1 times in 1m2s, failed on 0 attempts.
**** Test run completed successfully ****


