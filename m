Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282009AbRKVC7U>; Wed, 21 Nov 2001 21:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282025AbRKVC7L>; Wed, 21 Nov 2001 21:59:11 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:6411 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S282009AbRKVC6z>; Wed, 21 Nov 2001 21:58:55 -0500
Date: Wed, 21 Nov 2001 21:58:53 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: war <war@starband.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net>
Message-ID: <Pine.LNX.4.10.10111212148150.29736-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can having swap speed ANYTHING up?

simple: under memory load, it's more efficient to scavenge 
idle pages so they can be used for some "hotter" purpose.
there usually are *some* pages in any process which are 
only used at startup, or very rarely used.  if there's no 
memory pressure, sure, leave them there.  if there is some 
other use for the memory, even caching files, then it's more
efficient to swap those pages (assuming they're dirty).

swap is a sound way of making more efficient use of limited ram.

> RAM = 1000MB/s.
> DISK = 10MB/s

well, modern disks are 40 MB/s, and a typical non-rambus PC
has only around 600 MB/s dram bandwidth, depending on how you
measure it, etc.

> Ram is generally 1000x faster than a hard disk.

no, more like 20x; it can be up to around 80x (1.6 GB/s pc800
and a fairly pathetic 20 MB/s disk).  the *latency* ratio can 
be much higher (10 ms vs 200 ns).

> No swap = fastest possible solution.

false in general.  the only case where this is true is where
you either have just the right amount of ram (unlikely, unless
you can tune your apps rather carefully), or you have too much (your case).

