Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262793AbSI3Rw2>; Mon, 30 Sep 2002 13:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262801AbSI3Rw1>; Mon, 30 Sep 2002 13:52:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49679 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262793AbSI3Rw0>; Mon, 30 Sep 2002 13:52:26 -0400
Date: Mon, 30 Sep 2002 13:36:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Roberto Nibali <ratz@drugphish.ch>
cc: "David S. Miller" <davem@redhat.com>, ak@suse.de, niv@us.ibm.com,
       linux-kernel@vger.kernel.org, jamal <hadi@cyberus.ca>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
In-Reply-To: <3D92CCC5.5000206@drugphish.ch>
Message-ID: <Pine.LNX.3.96.1020930133306.20863A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Roberto Nibali wrote:

> I've done extensive testing in this field trying to achive fast packet 
> filtering with a huge set of not ordered rules loaded into the kernel.
> 
> According to my findings I had reason to believe that after around 1000 
> rules for ipchains and around 4800 rules for iptables the L2 cache was 
> the limiting factor (of course given the slowish iptables/conntrack 
> table lookup).
> 
> Those are rule thresholds I achieved with a PIII Tualatin and 512KB L2 
> cache. With a sluggish Celeron with I think 128KB L2 cache I achieved 
> about 1/8 of the above treshold. That's why I thought the L2 cache plays 
> a bigger role in this than the CPU FSB clock.
> 
> I concluded that if the ruleset to be matched would exceed the treshold 
> of what can be loaded into the L2 cache we see cache trashing and that's 
> why performance goes right to hell. I wanted to test this using oprofile 
> but haven't found the correct cpu performance counter yet :).
> 
> > Also not necessary, only the top level cache really needs to be
> > top performance.
> 
> I will do a new round of testing this weekend for a speech I'll be 
> giving. This time I will include ipchains, iptables (of course I am 
> willing to apply every interesting patch regarding hash table 
> optimisation and whatnot you want me to test), nf-hipac, the OpenBSD pf 
> and of course the work done by Jamal.

Look forward to any info you can provide.

I particularly like that nf-hipac can be put in and tried in one-to-one
comparison, that leaves an easy route to testing and getting confidence in
the code.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

