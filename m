Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbTBJWAZ>; Mon, 10 Feb 2003 17:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbTBJWAZ>; Mon, 10 Feb 2003 17:00:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53263 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265242AbTBJWAY>; Mon, 10 Feb 2003 17:00:24 -0500
Date: Mon, 10 Feb 2003 17:06:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andi Kleen <ak@suse.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
In-Reply-To: <20030208022908.GA29776@wotan.suse.de>
Message-ID: <Pine.LNX.3.96.1030210170411.29699B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Feb 2003, Andi Kleen wrote:

> Regarding the watchdog: what it basically wants is a POSIX
> CLOCK_MONOTONIC clock. This isn't currently implemented by Linux, 
> but I expect it will be eventually because it's really useful for a lot
> of applications who just need an increasing time stamp in user space,
> and who do not want to fight ntpd for this. One example for such 
> an application is the X server who needs this for its internal 
> event sequencing.
> 
> Implementing it based on the current time infrastructure is very easy -
> you just do not add xtime and wall jiffies in, but only jiffies.
> 
> I don't think doing any special hacks and complicating get_cycles()
> for it is the right way. Just implement a new monotonic clock primitive
> (and eventually export it to user space too) 

That seems to be the right way to go, rather than slow get_cycles() have a
separate functionality which does what you need. Didn't know about
CLOCK_MONOTONIC by that name, but I agree it's useful in various places.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

