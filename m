Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135545AbRAHV6D>; Mon, 8 Jan 2001 16:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135383AbRAHV5p>; Mon, 8 Jan 2001 16:57:45 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:45559 "EHLO
	mf2.private") by vger.kernel.org with ESMTP id <S135539AbRAHV50>;
	Mon, 8 Jan 2001 16:57:26 -0500
Date: Mon, 8 Jan 2001 14:00:19 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.30.0101082207290.3435-100000@fs129-124.f-secure.com>
Message-ID: <Pine.LNX.4.30.0101081357130.966-100000@mf2.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Szabolcs Szakacsits wrote:

> AFAIK newer glibc = CVS glibc but the malloc() tune parameters work
> via environment variables for the current stable ones as well, e.g. to
> overcome the above "out of memory" one could do,
>
> % export MALLOC_MMAP_MAX_=1000000
> % export MALLOC_MMAP_THRESHOLD_=0
> % magma

As I just mentioned, I haven't been able to test this yet due to my
current binary being linked against an older libc with doesn't seem to
have these parameters.  But here's one other data point, I just thought
I'd ask if this jives with your theory:  if I configure the linux kernel
to be able to use 2GB of RAM, then the 870MB limit becomes much lower, to
230MB.

Cheers, Wayne



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
