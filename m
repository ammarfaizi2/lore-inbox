Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289214AbSBDWZZ>; Mon, 4 Feb 2002 17:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289216AbSBDWZQ>; Mon, 4 Feb 2002 17:25:16 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18948 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289214AbSBDWZC>; Mon, 4 Feb 2002 17:25:02 -0500
Date: Mon, 4 Feb 2002 17:24:05 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ed Tomlinson <tomlins@cam.org>
cc: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <20020204044055.EF0579251@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.3.96.1020204171710.31056C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2002, Ed Tomlinson wrote:

> I really think giving the linux schedule more information (not necessarily
> using a shared mm) about which groups of tasks comprise an application would
> help things. 
> 
> What I coded was an attempt to give the scheduler a way to cope under load.
> If it knows groups of processes belong together then it can control them 
> when required.  With my current code it place running my freenet node at
> nice +10 still leaves me with a very responsive system.

I don't much like the vm as a way to determine association, but between
process groups and thread groups I would think that if there isn't useful
information perhaps something isn't working as desired.

I firmly believe that nice should be used to get uncommon behaviour, and
that the scheduler should do a decent job with most common loads, which
includes threads.

I hope to try K2 this weekend, I want to get get O1, rmap, and low
latency. If the latest O1 doesn't have child run first I want to add that
as well, barring someone providing a reason not to. I suspect I'll go
head down for some hours doing that, which is why I only evaluate multiple
features every few weeks :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

