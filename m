Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbULBNUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbULBNUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbULBNUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:20:43 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:62096 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261608AbULBNUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:20:32 -0500
Message-ID: <46166.195.245.190.94.1101993536.squirrel@195.245.190.94>
In-Reply-To: <20041202140612.4c07bca8@mango.fruits.de>
References: <20041201160632.GA3018@elte.hu> <20041201162034.GA8098@elte.hu>
    <33059.192.168.1.5.1101927565.squirrel@192.168.1.5>
    <20041201212925.GA23410@elte.hu> <20041201213023.GA23470@elte.hu>
    <32788.192.168.1.8.1101938057.squirrel@192.168.1.8>
    <20041201220916.GA24992@elte.hu>
    <20041201234355.0dac74cf@mango.fruits.de>
    <20041202084040.GC7585@elte.hu>
    <20041202132218.02ea2c48@mango.fruits.de>
    <20041202122931.GA25357@elte.hu>
    <20041202140612.4c07bca8@mango.fruits.de>
Date: Thu, 2 Dec 2004 13:18:56 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Florian Schmidt" <mista.tapas@gmx.net>
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Adam Heath" <doogie@debian.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "Gunther Persoons" <gunther_persoons@spymac.com>, emann@mrv.com,
       "Shane Shrybman" <shrybman@aei.ca>, "Amit Shah" <amit.shah@codito.com>,
       "Esben Nielsen" <simlo@phys.au.dk>, "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 02 Dec 2004 13:20:31.0281 (UTC) FILETIME=[B29DDA10:01C4D871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:
>
> Ingo Molnar wrote:
>
>> it's very likely not the simple jack_test client. I've attached the
>> trace in question. Here are the tasks that were running:
>>
>>  gkrellm
>>    IRQ 0
>>   IRQ 14
>>    IRQ 5
>>    jackd
>>  kblockd
>>   korgac
>> ksoftirq
>> qjackctl
>>   qsynth
>>        X
>>     xmms
>>
>> the trace doesnt show what task jackd was waiting on, and it would be
>> hard to establish it, the tracepoint would have to 'discover' all other
>> holders of the pipe fd, which is quite complex.
>
> I'm not knowledgable enough to read the trace, but what was for example
> the last thing qsynth was doing? Did it go to sleep? I suppose this was
> Rui's 9 qsynth's test, right?
>

No, it wasn't my old 8 fluidsynths test. It was just one normal desktop
work session. At the time, IIRC, the only jack clients that were running
were:

    qjackctl (obviously :)
    qsynth   (3 fluidsynth engines, many soundfonts loaded).
    xmms     (via xmms-jack output plugin)

By just taking xmms out from the graph, I can run my desktop environment
(KDE 3.2) for hours without a single XRUN or noticeable delay. And just
before RT-V0.9.31-19 had arrived, that was just a dream ;)

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


