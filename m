Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSGKUWb>; Thu, 11 Jul 2002 16:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSGKUWa>; Thu, 11 Jul 2002 16:22:30 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17157 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313687AbSGKUW3>; Thu, 11 Jul 2002 16:22:29 -0400
Date: Thu, 11 Jul 2002 16:20:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: rwhron@earthlink.net
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
In-Reply-To: <20020709005901.GA9616@rushmore>
Message-ID: <Pine.LNX.3.96.1020711161225.5732A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 rwhron@earthlink.net wrote:

> Sometimes small differences in LMbench between -jam and -aa are 
> just CPU bounces on SMP.  The difference for pipe and af/unix latency
> only appears on SMP too, but it is very consistent.  (My k6/2
> has small differences between -aa and -jam for pipe and af/unix
> latency).
> 
> You will know better what could make the difference:
> 
> This is the averages:
> 
> *Local* Communication latencies in microseconds - smaller is better
> -------------------------------------------------------------------
> kernel              Pipe    AF/Unix
> -----------------  -------  -------
> 2.4.19-pre10-aa4    33.941   70.216
> 2.4.19-pre10-jam2    7.877   16.699

Small differences? The only thing I would call small is the latency of the
jam kernel!

If (a) this is a real value which results in ~5x latency reduction in
non-benchmark applications, and (b) doesn't have some resulting penalty
(there are some free lunches in Linux), then it would be desirable.

I have an IPC test which measures time for a datum to move form process A
to process B and back, using various methods, I'll try to build these
kernels and test it in my next free day. I'd love to test latency of SysV
message queues as well, since these turn out to be good solutions to some
types of N:M client-server problems.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

