Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314386AbSDRQHW>; Thu, 18 Apr 2002 12:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314387AbSDRQHV>; Thu, 18 Apr 2002 12:07:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49929 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314386AbSDRQHV>; Thu, 18 Apr 2002 12:07:21 -0400
Date: Thu, 18 Apr 2002 12:04:35 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: James Bourne <jbourne@MtRoyal.AB.CA>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.44.0204170808160.17511-100000@skuld.mtroyal.ab.ca>
Message-ID: <Pine.LNX.3.96.1020418115423.5375B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, James Bourne wrote:

> After Ingo forwarded me his original patch (I found his patch via a web
> based medium, which had converted all of the left shifts to compares, and
> now I'm very glad it didn't boot...) and the system is booted and is
> balancing most of the interrupts at least.  Here's the current output
> of /proc/interrupts

  Is this positive or negative on performance? If you have a system
getting so many interrupts that one CPU can't handle them, obviously there
is a gain. However, by thrashing the cache of all CPUs instead of just one
you have some memory performance cost.

  I first looked at this for a mainframe vendor who decided that putting
all the interrupts in one CPU was better. That was then, this is now, but
I am curious about metrics, like real and system time doing a kernel
compile, etc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

