Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRHSR3R>; Sun, 19 Aug 2001 13:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266662AbRHSR3H>; Sun, 19 Aug 2001 13:29:07 -0400
Received: from Expansa.sns.it ([192.167.206.189]:57354 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S266464AbRHSR27>;
	Sun, 19 Aug 2001 13:28:59 -0400
Date: Sun, 19 Aug 2001 19:29:14 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>, <gars@lanm-pc.com>
Subject: Re: Swap size for a machine with 2GB of memory
In-Reply-To: <20010819024233.A26916@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0108191916350.5840-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Aug 2001, Eric S. Raymond wrote:

> The Red Hat installation manual claims that the size of the swap partition
> should be twice the size of physical memory, but no more than 128MB.
???
with old 2.0 kernels there was a limit to swap partition of 128MB each
one, and then you could use a lot of them if you have need of a lot of
swap.
 >
> The screaming hotrod machine Gary Sandine and I built around the Tyan S2464
> has 2GB of physical memory.  Should I believe the above formula?  If not,
> is there a more correct one for calculating needed swap on machines with
> very large memory?
Depends of what is your need. in general kernel 2.4 needs of more swap
space in front of 2.2. To explain why whould be long,
it's due to VM change and a different page aging. You can check in
a kml archive to find an explanetion in a better english than mine.

with early 2.4 kernel Linus suggested to have a swap area double in front
of the physical ram. That was expecially true for pc having big amount of
ram that are going to have long uptimes.

On my ultrasparc linux with 4 GByte of RAM running 2.4.X kernels,
I needed to add a 8 GB disk just for
swap (16 partitions of 512 MB each one).
But that is because i needed all that swap for what my users where running
on this server at the times. (now this sun 3500 has been sended to other
use, SOB!)

On the other side, if you are going to run some applications that do not
require a lot
of memory, it could happen that you will never touch the swap for more
that some Mbyte.

In generel it is a good thing to have an amount of swap bigger than your
physical ram, but not too mutch.
if you need a swap 4 times bigger than your physical ram that means you
should buy more ram.

bests
Luigi
>
> (No further hangs, BTW.)
> --
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
>
> .. a government and its agents are under no general duty to
> provide public services, such as police protection, to any
> particular individual citizen...
>         -- Warren v. District of Columbia, 444 A.2d 1 (D.C. App.181)
> -

