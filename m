Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWAKRwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWAKRwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWAKRwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:52:10 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:61314 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932352AbWAKRwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:52:09 -0500
Date: Wed, 11 Jan 2006 12:51:52 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <simlo@phys.au.dk>
cc: Ingo Molnar <mingo@elte.hu>, david singleton <dsingleton@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RT Mutex patch and tester [PREEMPT_RT]
In-Reply-To: <Pine.LNX.4.44L0.0601111816360.16743-201000@lifa03.phys.au.dk>
Message-ID: <Pine.LNX.4.58.0601111240020.31180@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.0601111816360.16743-201000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2006, Esben Nielsen wrote:

> I have done 2 things which might be of interrest:
>
> I) A rt_mutex unittest suite. It might also be usefull against the generic
> mutexes.
>
> II) I changed the priority inheritance mechanism in rt.c,
> optaining the following goals:
>

Interesting.  I'll take a look more at this after I finish dealing with
some deadlocks that I found in posix-timers.

[snip]
>
> What am I missing:
> Testing on SMP. I have no SMP machine. The unittest can mimic the SMP
> somewhat
> but no unittest can catch _all_ errors.

I have a SMP machine that just freed up.  It would be interesting to see
how this works on a 8x machine.  I'll test it first on my 2x, and when
Ingo gets some time he can test it on his big boxes.

>
> Testing with futexes.
>
> ALL_PI_TASKS are always switched on now. This is for making the code
> simpler.
>
> My machine fails to run with CONFIG_DEBUG_DEADLOCKS and CONFIG_DEBUG_PREEMPT
> on at the same time. I need a serial cabel and on consol over serial to
> debug it. My screen is too small to see enough there.
>
> Figure out more tests to run in my unittester.
>
> So why aren't I doing those things before sending the patch? 1) Well my
> girlfriend comes back tomorrow with our child. I know I will have no time to code anything substential
> then. 2) I want to make sure Ingo sees this approach before he starts
> merging preempt_rt and rt_mutex with his now mainstream mutex.

If I get time, I might be able to finish this up, if the changes look
decent, and don't cause too much overhead.

-- Steve

