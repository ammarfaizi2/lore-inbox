Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUIOKiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUIOKiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUIOKiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:38:18 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:3482 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S264503AbUIOKiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:38:15 -0400
Message-ID: <58696.195.245.190.93.1095244531.squirrel@195.245.190.93>
In-Reply-To: <20040915100048.GA2676@elte.hu>
References: <1094597710.16954.207.camel@krustophenia.net>
    <1094598822.16954.219.camel@krustophenia.net>
    <32930.192.168.1.5.1094601493.squirrel@192.168.1.5>
    <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu>
    <37312.195.245.190.93.1094728166.squirrel@195.245.190.93>
    <1095210962.2406.79.camel@krustophenia.net>
    <19084.195.245.190.94.1095240596.squirrel@195.245.190.94>
    <20040915093859.GA1629@elte.hu>
    <58425.195.245.190.93.1095242005.squirrel@195.245.190.93>
    <20040915100048.GA2676@elte.hu>
Date: Wed, 15 Sep 2004 11:35:31 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Florian Schmidt" <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 15 Sep 2004 10:38:14.0345 (UTC) FILETIME=[1ABAD390:01C49B10]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>Rui Nuno Capela wrote:
>
>> Yes, I didn't mentioned that, but I do have provided it and assumed on
>> all my reported trials:
>>
>>     echo 0 > "/proc/irq/8/rtc/threaded"
>>     echo 0 > "/proc/irq/17/Intel ICH5/threaded"
>>
>> Thanks.
>
> weird. You shouldnt get any xruns - unless jackd for whatever reason
> doesnt truly run under RT priorities. (there was some NPTL related
> buglet that caused such a symptom in earlier jackd versions.)
>

I thought it has been ironed out here.

Note that the difference arises only whether softirq-preempt and
hardirq-preempt are enabled or not.

- with softirq-preempt=0 and hardirq-preempt=0, jackd realtime runs
perfectly, as advertised (jackd -R -p 128 -n 2), and sounds good too ;)

- with softirq-preempt=1 and hardirq-preempt=1, the XRUN storm is terribly
annoying. And sound is obviously a crackling festival.

Remember, that all this is on same hardware, same smp kernel configuration
(CONFIG_SCHED_SMT is not set), same everything else (SuSE 9.1, NPTL 0.61,
jack-0.98.11cvs).

I hope the latency-traces show something useful. Til then...

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

