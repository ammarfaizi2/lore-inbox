Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRDEWbE>; Thu, 5 Apr 2001 18:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRDEWay>; Thu, 5 Apr 2001 18:30:54 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:11536 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129134AbRDEWas>; Thu, 5 Apr 2001 18:30:48 -0400
Date: Thu, 5 Apr 2001 15:29:54 -0700
Message-Id: <200104052229.f35MTse22138@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to let all others run
In-Reply-To: <Pine.LNX.3.95.1010405124737.15946A-100000@chaos.analogic.com>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2001 12:52:28 -0400 (EDT), Richard B. Johnson <root@chaos.analogic.com> wrote:

> Only an observation:
> 
> 
> main()
> {
>    nice(19);
>    for(;;)
>        sched_yield(); 
> }
> 
> does...
> 
[...]
> 
> It consumes 99.1 percent CPU, just spinning.

And, umm, what *exactly* would you expect it to do? It's the only process
consuming cpu, and sched_yield() certainly doesn't yield to the idle
task. So it's basically the same as a "for(;;);" program, except it
spends more time in kernel space and schedules faster when something
else needs the cpu.

It's 100% expected behavior.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
