Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSKACEK>; Thu, 31 Oct 2002 21:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265579AbSKACEK>; Thu, 31 Oct 2002 21:04:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29201 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265578AbSKACEH>; Thu, 31 Oct 2002 21:04:07 -0500
Date: Thu, 31 Oct 2002 21:09:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
In-Reply-To: <20021031172405.GB30193@opus.bloom.county>
Message-ID: <Pine.LNX.3.96.1021031210453.22444H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Tom Rini wrote:

> On Thu, Oct 31, 2002 at 12:12:40PM -0500, Mark Mielke wrote:
> 
> > On Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini wrote:
> > > On Thu, Oct 31, 2002 at 11:51:13AM -0500, Mark Mielke wrote:
> > > > Or specified more clearly: If the compiler optimization flag is
> > > > configurable, choosing CONFIG_TINY should default the optimization flag
> > > > to -Os before it defaults the optimization flag to -O2.
> > > You're still missing the point of flexibility remark.  Changing the
> > > optimization level has nothing to do with CONFIG_TINY, and is a
> > > generally useful option, and should be done seperate from CONFIG_TINY.
> > > In fact people seem to be getting the wrong idea about CONFIG_TINY.  We
> > > ...
> > 
> > Please read it again... even if the optimization flag was
> > configurable, choosing CONFIG_TINY should *default* the optimization
> > flag to -Os before it defaults the optimization flag to -O2.
> 
> Yes, and I'm saying that CONFIG_TINY shouldn't exist.  It should be
> CONFIG_FINE_TUNE (or so), to allow anyone to fine tune the optimization
> level.  Changing optimization levels is a speed / size tradeoff (if it
> wasn't, there wouldn't be -O2 / -Os, they would do the same thing) which
> you cannot pick a sane default for.

By that reasoning there shouldn't be -O2 either, everyone should be forced
to diddle everything for their architecture, cache size, gcc revision,
patch level... does that sound as unrealistic to you as it does to me? -Os
is a default, just like -O2, and if you want small -Os is probably a
better starting point.

As noted in another note, anyone good enough to make those decisions is
probably able to find a string in a Makefile.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

