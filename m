Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSCRTho>; Mon, 18 Mar 2002 14:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292395AbSCRThe>; Mon, 18 Mar 2002 14:37:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51467 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292231AbSCRTh2>; Mon, 18 Mar 2002 14:37:28 -0500
Date: Mon, 18 Mar 2002 14:35:06 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Peter Zaitsev <pz@spylog.ru>
cc: mysql@lists.mysql.com, linux-kernel@vger.kernel.org
Subject: Re: MYSQL,Linux & large threads number
In-Reply-To: <551905871007.20020315163038@spylog.ru>
Message-ID: <Pine.LNX.3.96.1020318143129.29698A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002, Peter Zaitsev wrote:

> Hello mysql,
> 
>   Some time ago I wrote about slow down of mysql with large number of
>   threads, which is quite common in Linux-Apache-Mysql-PHP enviroment.
> 
>   The test was simulating the worst case of concurrency - all the
>   threads are modified global variable in a loop 5000000 times in
>   total, using standard mutex for synchronization. The yeild is used
>   in a loop to force even more fair distribution of lock usage by
>   threads and increase context switches, therefore it did not change
>   much with large number of threads. I.e with 64 threads time without
>   yeild is 1:33.5


> For Next test I'll try to use Ingo's scheduler to see if it helps to
> solve the problem, also I'll try to test real mysql server to see
> which slowdown it will have.

I think it would be instructive to try using NGPT and either a patched
kernel or 2.4.19-pre3 which has the extra system calls included. I make no
predictions, but large improvements have been noted with a large number of
threads.

> 
> 
> 
> 
> CODE: (Dumb one just for test)
> 
>   
> #include <stdio.h>
> #include <pthread.h>
> #include <time.h>
> #define NUM_TH 1000

You might want to read this from the command line as an option and malloc
the vecors. Just a thought, I'm bad at guessing how lare a test I may want
to run.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

