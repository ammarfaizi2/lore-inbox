Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbSIXAQl>; Mon, 23 Sep 2002 20:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSIXAQl>; Mon, 23 Sep 2002 20:16:41 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:15490 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261491AbSIXAQi>; Mon, 23 Sep 2002 20:16:38 -0400
Date: Mon, 23 Sep 2002 17:21:35 -0700
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Peter W?chtler <pwaechtler@mac.com>, Ingo Molnar <mingo@elte.hu>,
       Larry McVoy <lm@bitmover.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020924002135.GB3797@gnuppy.monkey.org>
References: <Pine.LNX.4.44.0209232233250.2343-100000@localhost.localdomain> <3D8F82E5.90A64E8@mac.com> <20020923184423.B26887@mark.mielke.cc> <20020923230122.GA3642@gnuppy.monkey.org> <20020923191132.D26887@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020923191132.D26887@mark.mielke.cc>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 07:11:32PM -0400, Mark Mielke wrote:
> I do not find it to be profitable to discourage the people working on
> this project. If they fail, nobody loses. If they succeed, they can
> re-invent the math behind threading, and Linux ends up on the forefront
> of operating systems offering the technology.

Math, unlikely. Performance issues, maybe. Overall kernel technology,
highly unlikely and bordering on preposterous claim.

This is forum, like anything else, is to propose a new infrastructure
for something that's very important to the function of this operating
system. For this project to succeed, it must address possible problems
that various folks bring up in examining what's been proposed or built.
That's the role of these discussions.

> As for 'crazy synchronization', solutions such as the FUTEX have no
> real negative aspects. It wasn't long ago that the FUTEX did not
> exist. Why couldn't innovation make 'crazy synchronization by
> non-web-server like applications' more efficient using kernel threads?

To be blunt, I don't believe it. It's out of a technical point of view
from my bias to a FreeBSD's scheduler activation threading and because
people are too easily dismissing M:N performance issues while reaching
conclusions about it that seem to be presumptuous.

The incorrect example where you outline what you think is a M:N call
conversion is (traditional async wrappers instead of upcalls), is something
that don't want to be a future technical strawman that folks create in
this community to attack M:N threading. It may very well still have
legitimacy in the same way that part of the performance of the JVM depends
on accessibilty to a thread's ucontext and run state, which seem to be
initial oversight (unknown reason) when this was originally conceived.

Those are kind of things are what I'm most worried about that eventually
hurt what application folks are on building on top of Linux and its
kernel facilities.

> Concurrency experts would welcome the change. Concurrent 'experts'
> would not welcome the change, as it would force them to have to
> re-learn everything they know, effectively obsoleting their 'expert'
> status. (note the difference between the unquoted, and the quoted...)

Well, what I mean by concurrency experts is there can be specialized
applications where people much become experts in concurrency to solve
difficult problem that might be know to this group at this time.
Dimissing that in the above paragraph doesn't negate that need.

The bottom line here is that ultimately the kernel is providing useable
primitive/terms for applications programmers. It's not the scenario
where kernel folks just build something that's conceptually awkward and
then it's up to applications people to work around bogus design problems
that result from that. So what I meant by folks that have applications
that might push the limits of what the current synchronization model
offers.

That's the core of my rant and it took quite a while to write up. ;)

bill

