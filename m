Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSLQTUy>; Tue, 17 Dec 2002 14:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSLQTUy>; Tue, 17 Dec 2002 14:20:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29452 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265683AbSLQTUu>; Tue, 17 Dec 2002 14:20:50 -0500
Date: Tue, 17 Dec 2002 14:27:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT Benchmarks (was: /proc/cpuinfo and hyperthreading)
In-Reply-To: <20021216223848.GA2994@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1021217141920.20007A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2002, J.A. Magallon wrote:

> Number of threads	Elapsed time   User Time   System Time
> 1                   53:216           53:220    00:000
> 2                   29:272           58:180    00:320
> 3                   27:162         1:21:450    00:540
> 4                   25:094         1:41:080    01:250
> 
> Elapsed is measured by the parent thread, that is not doing anything
> but wait on a pthread_join. User and system times are the sum of
> times for all the children threads, that do real work.
> 
> The jump from 1->2 threads is fine, the one from 2->4 is ridiculous...
> I have my cpus doubled but each one has half the pipelining for floating
> point...see the user cpu time increased due to 'worst' processors and
> cache pollution on each package.
> 
> So, IMHO and for my apps, HyperThreading is just a bad joke.

I must be misreading this, it looks to me as though having threads running
HT is reducing the clock time, and frankly that's what I want. It may not
be as good as having more processors, but it certainly is better for
nothing, even for your application. I read that as about 10% faster, and I
know people who spend more on fans to o/c their CPU than the premium for a
Xeon.

More to the point, since you have no choice if you want to go fast or have
>2 CPUs, you get HT included. Clearly if you want good latency you don't
run SMP at all due to the extra locking, that's a kernel issue, not HT.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

