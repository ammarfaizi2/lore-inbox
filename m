Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSEZNvG>; Sun, 26 May 2002 09:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSEZNvE>; Sun, 26 May 2002 09:51:04 -0400
Received: from waste.org ([209.173.204.2]:56737 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316088AbSEZNvE>;
	Sun, 26 May 2002 09:51:04 -0400
Date: Sun, 26 May 2002 08:50:55 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Robert Schwebel <robert@schwebel.de>, <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205252116240.1028-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0205260053000.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2002, Linus Torvalds wrote:

> On Sat, 25 May 2002, Oliver Xymoron wrote:
> >
> > I'm sure you know this route is not very useful - there's practically
> > nothing that we can push across the hard RT divide anyway. We can't do
> > meaningful filesystem I/O, memory allocation, networking, or VM fiddling -
> > what's left?
>
> Atomic memory allocation, for one. Potentially very useful.

Dunno. That implies reservations on the Linux side - generally RT apps
are going to be sensitive to memory exhaustion. Given that, it's easier
just to budget for them all up front and carve that memory out at boot.

Not that I'm against a reservation scheme.  I've been arguing for one for
a while to avoid deadlocks with network storage.

> > Cleaning up soft RT latencies will make the vast majority of people who
> > think they want hard RT happy anyway.
>
> I certainly personally agree with you, but the hard-liners don't.

Making subsystems of the kernel RT-safe won't buy much for them and won't
help latencies. The people who would want you to do that are from the
buzzword camp.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

