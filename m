Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131976AbRCYDZn>; Sat, 24 Mar 2001 22:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRCYDZd>; Sat, 24 Mar 2001 22:25:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:778 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131976AbRCYDZ3>; Sat, 24 Mar 2001 22:25:29 -0500
Date: Sat, 24 Mar 2001 19:24:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: <alan@lxorguk.ukuu.org.uk>, <hpa@transmeta.com>, <tytso@MIT.EDU>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Larger dev_t
In-Reply-To: <UTC200103241425.PAA08694.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.31.0103241920580.6710-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Mar 2001 Andries.Brouwer@cwi.nl wrote:
>
> We need a size, and I am strongly in favor of sizeof(dev_t) = 8;
> this is already true in glibc.

The fact that glibc is a quivering mass of bloat, and total and utter crap
makes you suggest that the Linux kernel should try to be as similar as
possible?

Not a very strong argument.

There is no way in HELL I will ever accept a 64-bit dev_t.

I _will_ accept a 32-bit dev_t, with 12 bits for major numbers, and 20
bits for minor numbers.

If people cannot fit their data in that size, they have some serious
problems. And for people who think that you should have meaningful minor
numbers where the bit patterns get split up some way, I can only say "get
a frigging clue". That's what you have filesystem namespaces for. Don't
try to make binary name-spaces.

And I don't care one _whit_ about the fact that Ulrich Drepper thinks that
it's a good idea to make things too large.

		Linus

