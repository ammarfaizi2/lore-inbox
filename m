Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131370AbQLOAW6>; Thu, 14 Dec 2000 19:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132937AbQLOAWs>; Thu, 14 Dec 2000 19:22:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:3080 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131370AbQLOAWb>; Thu, 14 Dec 2000 19:22:31 -0500
Date: Thu, 14 Dec 2000 15:51:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jakub Jelinek <jakub@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <20001214183559.M760@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.10.10012141543130.12695-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Jakub Jelinek wrote:

> On Thu, Dec 14, 2000 at 11:11:28AM -0800, Linus Torvalds wrote:
> > user applications and (b) gcc-2.96 is so broken that it requires special
> > libraries for C++ vtable chunks handling that is different, so the
> > _working_ gcc can only be used with programs that do not need such
> > library support.
> 
> Every major g++ release had incompatible libstdc++, even g++ 2.95.2 if
> bootstrapped under glibc 2.1.x is binary incompatible with g++ 2.95.2
> bootstrapped under glibc 2.2.x (libstdc++ uses different soname then;
> even if we used g++ 2.95.2 we would not have C++ binary compatible with
> other distributions).

Yes. 

And I realize that somebody inside RedHat really wanted to use a snapshot
in order to get some C++ code to compile right.

But it at the same time threw C stability out the window, by using a
not-very-widely-tested snapshot for a major new release. 

Are you seriously saying that you think it was a good trade-off? Or are
you just ashamed of admitting that RH did something stupid?

> > compiler to something that works better RSN.  It apparently has problems
> > compiling stuff like the CVS snapshots of X etc too (and obviously,
> > anything you compile under gcc-2.96 is not likely to work anywhere else
> > except with the broken libraries). 
> 
> Can you point to things in X which were actually miscompiled because of bugs
> in gcc 2.96?

I have a report from a Sony VAIO user that couldn't compile the CVS X at
all on his picturebook (and you need to compile the CVS tree in order to
get required fixes for the ATI Rage Mobility in that machine). I don't
know the details, but they were apparently due to RH 7 issues. 

> So far I was aware about X bugs (already fixed in X CVS) which
> were triggered with -fstrict-aliasing which is now the default while
> gcc 2.95.2 had -fstrict-aliasing disabled by default.

I hope that's another thing that the gcc people fix by the time they do a
_real_ release. Anobody who thinks that "-fstrict-aliasing" being on by
default is a good idea is probably a compiler person who hasn't seen real
code.

> That is not to say there were not bugs in the gcc we shipped, but the bugs
> which were reported against it have been fixed already.

That's good.

It's even better if you don't play quite as fast-and-lose with your
shipping compiler.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
