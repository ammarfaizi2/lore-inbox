Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbTAAP7c>; Wed, 1 Jan 2003 10:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTAAP7c>; Wed, 1 Jan 2003 10:59:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23301 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267252AbTAAP7a>; Wed, 1 Jan 2003 10:59:30 -0500
Date: Wed, 1 Jan 2003 11:05:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: scott thomason <scott@thomasons.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Impact of scheduler tunables on interactive response (was Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio)
In-Reply-To: <200212311831.29124.scott@thomasons.org>
Message-ID: <Pine.LNX.3.96.1030101105838.14470C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, scott thomason wrote:

> I wrote a program that emulates a varying but constant set of loads 
> with a fixed amount of sleep() time in the hopes that it would appear 
> "interactive" to the estimator. The program measures the time it 
> takes to process each iteration (minus the time it spends sleeping). 
> Then I tried seven different configurations of the tunables while the 
> system was under load. The kernel was 2.5.53-mm2. The load was a 
> continuously looping kernel make -j4 clean/make -j4 bzImage, and a 
> continuously looping copy of a 100MB file. My system is a dual AMD 
> MP2000 with 1GB RAM.

This sounds very like my resp2 (www.unyuug.org/benchmarks/) program I
announced on this list some months ago, but resp2 generates loads of a
specific type so that you can determine of changes affect i/o load,
swapping load, CPU load, etc.

> 
> *IF* the test program is valid--something I would like feedback 
> on!--the results show that you can attack the background load with 
> aggressive tunable settings to achieve low interactive response 
> times, contrary to the direction Andrew had suggested taking for 
> tunable settings.
> 
> The seven tunable configurations, a graph of the results, and the raw 
> data are here:
> 
>     http://www.thomasons.org/int_res.html
> 
> Tab-delimited text and OpenOffice spreadsheets of the data are here:
> 
>     http://www.thomasons.org/int_res.txt
>     http://www.thomasons.org/int_res.sxc
> 
> I would like to assemble a small suite of tools that can be used to 
> measure the impact of kernel changes on interactive performance, 
> starting with Mark Hahn's/Andrew's "realfeel" microbenchmark and 
> moving up thru whatever else may be necessary to gauge real-life 
> impact. Your comments and direction are very welcome.

Note: the context switching benchmark is at the same URL. I have posted
some output recently, haven't had a of feedback other than some folks
mailing results to me without copying the list. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

