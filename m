Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbSKUSU0>; Thu, 21 Nov 2002 13:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSKUSUZ>; Thu, 21 Nov 2002 13:20:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62482 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266952AbSKUSUZ>; Thu, 21 Nov 2002 13:20:25 -0500
Date: Thu, 21 Nov 2002 13:25:09 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@digeo.com>
cc: Dave Jones <davej@codemonkey.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Aaron Lehmann <aaronl@vitelus.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
In-Reply-To: <3DDD162B.BAC88F94@digeo.com>
Message-ID: <Pine.LNX.3.96.1021121132217.9986A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Andrew Morton wrote:

> Dave Jones wrote:

> We'd buy a bit by arranging for the in-kernel copy of the fp state
> to have the same layout as the hardware.  That way it can be done in
> a single big, fast, well-aligned slurp.  But for some reason that code has
> to convert into and out of a different representation.
> 
> But the real low-hanging fruit here is the observation that the
> test application doesn't use floating point!!!
> 
> Maybe we need to take an fp trap now and then to "poll" the application
> to see if it is still using float.

I thought we used to do that and someone (Linus??) thought the complexity
didn't justify the saving. Always seemed like a good idea to me, but with
the various types of processor we have today, it's harder to say what wins
until benchmarks are done.

Hopefully someone has a better memory than I about this.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

