Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265087AbSKETVK>; Tue, 5 Nov 2002 14:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265089AbSKETVK>; Tue, 5 Nov 2002 14:21:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11529 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265087AbSKETVI>; Tue, 5 Nov 2002 14:21:08 -0500
Date: Tue, 5 Nov 2002 14:26:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_TINY
In-Reply-To: <20021104195144.GC27298@opus.bloom.county>
Message-ID: <Pine.LNX.3.96.1021105141149.17410L-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002, Tom Rini wrote:

> On Mon, Nov 04, 2002 at 02:13:48AM +0000, Rob Landley wrote:

> > I've used -Os.  I've compiled dozens and dozens of packages with -Os.  It has 
> > always saved at least a few bytes, I have yet to see it make something 
> > larger.  And in the benchmarks I've done, the smaller code actually runs 
> > slightly faster.  More of it fits in cache, you know.
> 
> Then we don't we always use -Os?

1 - I'm not sure all versions of gcc support it, as in "it generates
correct code."

2 - I'm not sure how (if) it works on non-Intel systems.

3 - The performance gain is related to cache size and performance. The
obvious case is unrolling loops, you win if they fit in cache. If you have
a Celeron, P-III with 256k, P-4 with HT on, all have different cache
behaviour. And SMP or memory speed changes the penalty for a cache miss to
main memory.

4 - inertia, minimal gain and experience. Maybe no one sees enough gain to
justify the chance that some version of gcc is really broken.

5 - placebo effect. People just think it's faster because it's different.

6 - quantum effects, like Schroedinger's (sp?) cat it's only faster or
slower if you measure it.

Pick one or more of these as pleases you. My mind say 4, my heart says 
5+6.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

