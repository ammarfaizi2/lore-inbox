Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265021AbSKAOJf>; Fri, 1 Nov 2002 09:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265026AbSKAOJf>; Fri, 1 Nov 2002 09:09:35 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:19884 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265021AbSKAOJd>; Fri, 1 Nov 2002 09:09:33 -0500
Date: Fri, 1 Nov 2002 07:12:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021101141240.GC815@opus.bloom.county>
References: <20021031172405.GB30193@opus.bloom.county> <Pine.LNX.3.96.1021031210453.22444H-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021031210453.22444H-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 09:09:20PM -0500, Bill Davidsen wrote:
> On Thu, 31 Oct 2002, Tom Rini wrote:
> 
> > On Thu, Oct 31, 2002 at 12:12:40PM -0500, Mark Mielke wrote:
> > 
> > > On Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini wrote:
> > > > On Thu, Oct 31, 2002 at 11:51:13AM -0500, Mark Mielke wrote:
> > > > > Or specified more clearly: If the compiler optimization flag is
> > > > > configurable, choosing CONFIG_TINY should default the optimization flag
> > > > > to -Os before it defaults the optimization flag to -O2.
> > > > You're still missing the point of flexibility remark.  Changing the
> > > > optimization level has nothing to do with CONFIG_TINY, and is a
> > > > generally useful option, and should be done seperate from CONFIG_TINY.
> > > > In fact people seem to be getting the wrong idea about CONFIG_TINY.  We
> > > > ...
> > > 
> > > Please read it again... even if the optimization flag was
> > > configurable, choosing CONFIG_TINY should *default* the optimization
> > > flag to -Os before it defaults the optimization flag to -O2.
> > 
> > Yes, and I'm saying that CONFIG_TINY shouldn't exist.  It should be
> > CONFIG_FINE_TUNE (or so), to allow anyone to fine tune the optimization
> > level.  Changing optimization levels is a speed / size tradeoff (if it
> > wasn't, there wouldn't be -O2 / -Os, they would do the same thing) which
> > you cannot pick a sane default for.
> 
> By that reasoning there shouldn't be -O2 either, everyone should be forced
> to diddle everything for their architecture, cache size, gcc revision,
> patch level... does that sound as unrealistic to you as it does to me? -Os
> is a default, just like -O2, and if you want small -Os is probably a
> better starting point.

You're making the assumption that the biggest problem facing embedded
Linux developers is that the kernel is too big and that the size must be
reduced at all costs.  It's not.  It's that trying to tweak things which
aren't trivial to do (unlike changing the optimization level) require an
indepth knowledge of the subsystem.  It doesn't have to be this way.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
