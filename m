Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSJOBZ1>; Mon, 14 Oct 2002 21:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSJOBZ1>; Mon, 14 Oct 2002 21:25:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3844 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262250AbSJOBZ0>; Mon, 14 Oct 2002 21:25:26 -0400
Date: Mon, 14 Oct 2002 21:31:08 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re:Benchmark results from resp1 trivial response time test
In-Reply-To: <20021014213054.1637.qmail@linuxmail.org>
Message-ID: <Pine.LNX.3.96.1021014212113.882B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Paolo Ciarrocchi wrote:

> Hi Bill,
> I'm back with the results of others tests, here all my results:

Thanks, I'll cip them in the response, but this test sure does make some
kernels unhappy, doesn't it? And the sad truth is that this isn't
artifact, if you get a similar "real load" on the machine the response
will be really unusable in real life.



> I post the script I use to get this summary as well,
> do you think it is usefull ?

Sure, it's very like the one I used to generate the results on the web
site, other than I used "version=${filename%.out}" to avoid a cut or sed
process, and I put my redirect after the "done" as "done >>summary.txt" so
I didn't have to put it on every line. Matter of style, and I'm really
lazy about typing anything I don't need to ;-) 
 
> #!/bin/bash
> out=(`ls *.out|sort`)
> total=`echo ${out[@]}|wc -w`
> # echo $total 
> > summary.txt
> for i in `seq 0 1 $[total-1]`
> do
> kernel_version=`echo ${out[i]}|cut -d "." --fields=1-3`
> 	echo -e "\t\tKernel version: $kernel_version" >> summary.txt
> 	grep  '^ ' ${out[i]} >> summary.txt
> 	echo >> summary.txt
> done;

I'm going to replace S.D. with the ratio of the median values in the near
future, I find that more useful, since one really bad response can skew
the ratio of average. Of course the other values are there to avoid
confusion, but t makes a nicer number for the "look at one value" folks.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

