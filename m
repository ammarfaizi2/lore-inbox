Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTA0Vmo>; Mon, 27 Jan 2003 16:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbTA0Vmo>; Mon, 27 Jan 2003 16:42:44 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19209 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262824AbTA0Vmn>; Mon, 27 Jan 2003 16:42:43 -0500
Date: Mon, 27 Jan 2003 16:48:52 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Terje Eggestad <terje.eggestad@scali.com>
cc: Lee Chin <leechin@mail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-newbie@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
In-Reply-To: <1043660902.21075.11.camel@pc-16.office.scali.no>
Message-ID: <Pine.LNX.3.96.1030127163538.27928G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jan 2003, Terje Eggestad wrote:

> Apart from the argument already given on other replies, you should
> keep in mind that you probably need to give priority to doing receive.
> THat include your clients, but if you don't you run into the risk of
> significantly limiting your bandwidth since the send queues around your
> system fill up. 
> 
> Try doing that with threads.

Okay, I'm running my usenet exchange machines on Linux with Earthquake,
one thread per socket, 300-500 sockets, 700-800GB/day with incoming rate
spikes to 130Mbit on two 100Mbit NICs. What is it I'm supposed to try
doing with threads?

And if this is a webserver or anything like it, the incoming bandwidth is
probably orders of magnitude below the outgoing... Hum, like a usenet
reader server. Below, from a Linux box running Twister, also threaded per
feed in and per reader socket out.

 load free buffs swap pgin pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx   usr  sys idl  i_netK  o_netK
 2.98  5.0  1807  0.0  544 2220  71  66  21   0 6173 3390 9600 17983     3  17  80  7170.8   941.9
 4.77  4.5  1805  0.0 1117 6267  39 134 134   0 5403 3212 8780 20663     8  34  58  6645.4   978.9
 2.35  4.3  1802  0.0 1529 6900  37 176 189   0 6134 3648 10007 18492    9  25  66  7470.4  1087.9
 1.10  4.8  1800  0.0 1428 5609  33 149 150   0 5871 3447 9505 18028     9  25  66  7235.2   961.0
 1.38  6.7  1798  0.0  970 6671  34 139 134   0 6250 3685 10051 20210    9  26  65  7503.4  1088.8
 6.57  5.0  1797  0.0 1589 7673  89 184 188   0 5912 3571 9732 20165     8  33  59  7003.7  1169.3
 2.30  4.6  1799  0.0 1648 5900  44 154 146   0 6539 3998 10660 17975    9  27  64  7631.0  1382.6

Forgive the formatting, it kind of break with larger numbers...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

