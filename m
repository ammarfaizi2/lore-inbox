Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSIXDRd>; Mon, 23 Sep 2002 23:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbSIXDRd>; Mon, 23 Sep 2002 23:17:33 -0400
Received: from mark.mielke.cc ([216.209.85.42]:34564 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261541AbSIXDRc>;
	Mon, 23 Sep 2002 23:17:32 -0400
Date: Mon, 23 Sep 2002 23:20:17 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Peter W?chtler <pwaechtler@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Larry McVoy <lm@bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923232017.A2880@mark.mielke.cc>
References: <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain> <3D8F82E5.90A64E8@mac.com> <20020923184423.B26887@mark.mielke.cc> <20020923230122.GA3642@gnuppy.monkey.org> <20020923191132.D26887@mark.mielke.cc> <20020924002135.GB3797@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020924002135.GB3797@gnuppy.monkey.org>; from billh@gnuppy.monkey.org on Mon, Sep 23, 2002 at 05:21:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 05:21:35PM -0700, Bill Huey wrote:
> ...
> The incorrect example where you outline what you think is a M:N call
> conversion is (traditional async wrappers instead of upcalls), is something
> that don't want to be a future technical strawman that folks create in
> this community to attack M:N threading. It may very well still have
> legitimacy in the same way that part of the performance of the JVM depends
> on accessibilty to a thread's ucontext and run state, which seem to be
> initial oversight (unknown reason) when this was originally conceived.
> Those are kind of things are what I'm most worried about that eventually
> hurt what application folks are on building on top of Linux and its
> kernel facilities.
> ...
> That's the core of my rant and it took quite a while to write up. ;)

My part in the rant (really somebody else's rant...) is that if kernel
threads can be made to out-perform current implementations of M:N
threading, then all that has really been proven is that current M:N
practices are not fully optimal. 1:1 in an N:N system is just one face
of M:N in an N:N system. A fully functional M:N system _may choose_ to
allow M to equal N.

Worst possibly cases that I expect to see from people experimenting
with this stuff and having a 1:1 system that out-performs commonly
available M:N systems: 1) The M:N people innovate, potentially using
the new technology made available from the 1:1 people, making a
_better_ M:N system 2) The 1:1 system is better, and people use it.

As long as they all use a POSIX, or other standard interface, there
isn't a problem.

If the changes to the kernel made by the 1:1 people are bad, they will
be stopped by Linus and many other people, probably including
yourself... :-)

In any case, I see the 1:1 vs. M:N as a distraction from the *actual*
enhancements being designed, which seem to be, support for cheaper
kernel threads, something that benefits both parties.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

