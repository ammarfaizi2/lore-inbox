Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269484AbUJSQE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269484AbUJSQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269488AbUJSQDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:03:42 -0400
Received: from mail3.utc.com ([192.249.46.192]:49658 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S269484AbUJSQCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:02:07 -0400
Message-ID: <41753A58.2020906@cybsft.com>
Date: Tue, 19 Oct 2004 11:01:28 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019144642.GA6512@elte.hu> <28172.195.245.190.93.1098199429.squirrel@195.245.190.93> <20041019155008.GA9116@elte.hu>
In-Reply-To: <20041019155008.GA9116@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
> 
> 
>>OK. After some incremental configurations, I've isolated that those
>>oops(es) only occurs if PREEMPT_TIMING and/or LATENCY_TRACE areset
>>(Y). My first suspect was that newest RWSEM_DEADLOCK_DETECT, but it
>>wasn't the case.
>>
>>So something has broken on that non-preemptible critical section
>>timing stuff since U4.
>>
>>Hasn't anybody else stumbled on this?
> 
> 
> i'm using it myself and havent seen the problem yet. Could you send me
> the latest .configs, the working and the broken one too? I'll try to
> reprodue it (or maybe someone else with a serial console sees it too).
> 
> 	Ingo
> 

I am seeing something similar here with both U5 and U6 on both of my SMP 
systems (actually I haven't gotten to try U6 on my SMP system at home 
yet.) On my SMP system here (dual Xeon) I get a handful of traces during 
the boot and then the last thing I see is a trace that has something to 
do with parport, but the key MIGHT be that it always seems to crap out 
when I get traces for 3-level deep critical section nesting. I will try 
to capture the trace the old-fashioned way when I get a chance shortly.

I do have U5 booted on my UP system at home though.

kr
