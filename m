Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265273AbSJaRRt>; Thu, 31 Oct 2002 12:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSJaRRt>; Thu, 31 Oct 2002 12:17:49 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:24490 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265273AbSJaRRs>; Thu, 31 Oct 2002 12:17:48 -0500
Date: Thu, 31 Oct 2002 10:24:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031172405.GB30193@opus.bloom.county>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county> <20021031165113.GB8565@mark.mielke.cc> <20021031170420.GA30193@opus.bloom.county> <20021031171240.GE8565@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031171240.GE8565@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 12:12:40PM -0500, Mark Mielke wrote:

> On Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini wrote:
> > On Thu, Oct 31, 2002 at 11:51:13AM -0500, Mark Mielke wrote:
> > > Or specified more clearly: If the compiler optimization flag is
> > > configurable, choosing CONFIG_TINY should default the optimization flag
> > > to -Os before it defaults the optimization flag to -O2.
> > You're still missing the point of flexibility remark.  Changing the
> > optimization level has nothing to do with CONFIG_TINY, and is a
> > generally useful option, and should be done seperate from CONFIG_TINY.
> > In fact people seem to be getting the wrong idea about CONFIG_TINY.  We
> > ...
> 
> Please read it again... even if the optimization flag was
> configurable, choosing CONFIG_TINY should *default* the optimization
> flag to -Os before it defaults the optimization flag to -O2.

Yes, and I'm saying that CONFIG_TINY shouldn't exist.  It should be
CONFIG_FINE_TUNE (or so), to allow anyone to fine tune the optimization
level.  Changing optimization levels is a speed / size tradeoff (if it
wasn't, there wouldn't be -O2 / -Os, they would do the same thing) which
you cannot pick a sane default for.

> In the case where CONFIG_TINY is an option on its own, it means using -Os
> instead of -O2. In the case where CONFIG_TINY is a template *not an option*,
> the configurable "optimization flag" gets initialized to -Os. You could
> still override -Os to be -O2 if you wanted to, or if CONFIG_TINY was not
> specified, you could still override -O2 to be -Os... the default is -Os for
> CONFIG_TINY.

You're still falling into the 'embedded must mean small!' trap.  The
template should default to the well tested -O2, not the less tested
-Os.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
