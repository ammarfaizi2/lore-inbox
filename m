Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSEZDMN>; Sat, 25 May 2002 23:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSEZDMM>; Sat, 25 May 2002 23:12:12 -0400
Received: from waste.org ([209.173.204.2]:20625 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315595AbSEZDMM>;
	Sat, 25 May 2002 23:12:12 -0400
Date: Sat, 25 May 2002 22:12:05 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Robert Schwebel <robert@schwebel.de>, <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205251729490.4355-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0205252159380.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2002, Linus Torvalds wrote:

>
>
> On Sat, 25 May 2002, Linus Torvalds wrote:
> >
> > Can we make the whole kernel truly hard-RT? Sure, possible in theory. In
> > practice? No way, José. It's just not mainline enough.
>
> Side note: we could, of course, mark some spinlocks (and thus some
> code-paths) as being RT-safe, and then make sure that those spinlocks -
> when they disable interrupts - actually disable the _hw_ interrupts even
> with the RT patches.
>
> That would make those sequences usable even from within a RT subset, but
> would obviously mean that those spinlocks have to be checked for latency
> issues - because any user (also non-RT ones) would obviously be truly
> uninterruptible within these spinlocks.

I'm sure you know this route is not very useful - there's practically
nothing that we can push across the hard RT divide anyway. We can't do
meaningful filesystem I/O, memory allocation, networking, or VM fiddling -
what's left?

Cleaning up soft RT latencies will make the vast majority of people who
think they want hard RT happy anyway.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

