Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269464AbUJSPZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269464AbUJSPZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269458AbUJSPZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:25:56 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:14473 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269464AbUJSPZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:25:48 -0400
Message-ID: <28172.195.245.190.93.1098199429.squirrel@195.245.190.93>
In-Reply-To: <20041019144642.GA6512@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
    <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
    <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
    <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
    <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
    <20041019144642.GA6512@elte.hu>
Date: Tue, 19 Oct 2004 16:23:49 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 19 Oct 2004 15:25:41.0720 (UTC) FILETIME=[E502E580:01C4B5EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>> i have released the -U6 Real-Time Preemption patch:
>>
>>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U6
>

I'm experiencing terrible kernel panics at a very early bootstrap stage
while testing the U5 and U6 latest patch(es) on my laptop (P4/UP) --
(Ingo: this is about the very same trouble I've reported while pre-testing
U6).

Sorry that I can't show any trace dumps; only a hard-screenshot (with
digital camera?) would be possible but rather incomplete. The serial
console hack is not an option--these "modern" laptops doesn't come with
serial ports anymore, and netconsole is a no-op at a so early point of the
boot process. Or so I believe.

OK. After some incremental configurations, I've isolated that those
oops(es) only occurs if PREEMPT_TIMING and/or LATENCY_TRACE areset (Y). My
first suspect was that newest RWSEM_DEADLOCK_DETECT, but it wasn't the
case.

So something has broken on that non-preemptible critical section timing
stuff since U4.

Hasn't anybody else stumbled on this?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


