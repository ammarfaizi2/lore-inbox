Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282771AbRLGRu6>; Fri, 7 Dec 2001 12:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282877AbRLGRup>; Fri, 7 Dec 2001 12:50:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45584 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282771AbRLGRul>; Fri, 7 Dec 2001 12:50:41 -0500
Date: Fri, 7 Dec 2001 09:45:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>
Message-ID: <Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Dec 2001, Andi Kleen wrote:
> torvalds@transmeta.com (Linus Torvalds) writes:
> >
> > "putc()" is a standard function.  If it sucks, let's get it fixed.  And
> > instead of changing bonnie, how about pinging the _real_ people who
> > write sucky code?
>
> It is easy to fix. Just do #define putc putc_unlocked

Sure. And why don't you also do

	#define sin(x) (1)
	#define sqrt(x) (1)
	#define strlen(x) (1)
	...

to make other benchmarks happier?

bonnie is a _benchmark_. It's meant for finding bad performance. Changing
it to make it work better when performance is bad is _pointless_. You've
now made the whole point of bonnie go away.

> There is just a slight problem: it'll fail if your application is threaded
> and wants to use the same FILE from multiple threads.
>
> It is a common problem on all OS that eventually got threadsafe stdio.

It's a common problem with bad programming.

You can be thread-safe without sucking dead baby donkeys through a straw.
I already mentioned two possible ways to fix it so that you have locking
when you need to, and no locking when you don't.

		Linus

