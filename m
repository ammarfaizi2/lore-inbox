Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261604AbSJMVEL>; Sun, 13 Oct 2002 17:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbSJMVEL>; Sun, 13 Oct 2002 17:04:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36356 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261604AbSJMVEK>; Sun, 13 Oct 2002 17:04:10 -0400
Date: Sun, 13 Oct 2002 17:02:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re:Benchmark results from resp1 trivial response time test
In-Reply-To: <20021013164731.10615.qmail@linuxmail.org>
Message-ID: <Pine.LNX.3.96.1021013165711.2243A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Paolo Ciarrocchi wrote:

> From: Bill Davidsen <davidsen@tmr.com>
> [...]
> > run this version I'd like to see the result. I believe I had to use the
> > "-l" patch option to ignore blank mismatches to get this to work, and I've
> > cleaned up another mailing funny as well. 
> 
> Hi Bill,
> here the results agains 2.5.41-mm2C (2.5.41-mm2 + Con patch "vmscan.c")
> 
> Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
>  
>                        _____________ delay ms. ____________                  
>            Test        low       high    median     average     S.D.    ratio
>          noload    113.648    114.508    113.707    113.861    0.000    1.000
>      smallwrite    116.054    180.420    117.924    130.525    0.028    1.146
>      largewrite    114.019    179.770    120.451    134.021    0.028    1.177
>         cpuload    106.590    162.893    107.075    118.080    0.025    1.037
>       spawnload    106.574    164.898    107.490    118.671    0.026    1.042
>        8ctx-mem   7767.843  16917.625   8994.265  10906.788    3.844   95.790
>        2ctx-mem   6515.450  18273.101  10344.575  11217.755    4.822   98.521
> 
> 8ctx-mem and 2ctx-mem show "bad" performance.
> Do you think is it possible to apply the patch on the top of 2.5.42-mm2 ?

I haven't tried it yet, but I'm interested in your result, since my
2.5.41-mm2v result was actually better then plain -mm2. I am just building
some new test stuff on an SMP machine so I can compare uni and SMP
performance under load, and I'll look at 2.5.42 tonight or tomorrow.

My reference machine was a 96MB machine, if you're really curious about
this you could boot with mem=96m (or 128m) and rerun the test. In any case
I have the kids tonight, if I get some time I'll try it, otherwise
tomorrow.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

