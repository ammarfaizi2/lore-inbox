Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbSJaREM>; Thu, 31 Oct 2002 12:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265244AbSJaREL>; Thu, 31 Oct 2002 12:04:11 -0500
Received: from auto-matic.ca ([216.209.85.42]:33796 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265243AbSJaREI>;
	Thu, 31 Oct 2002 12:04:08 -0500
Date: Thu, 31 Oct 2002 12:12:40 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031171240.GE8565@mark.mielke.cc>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county> <20021031165113.GB8565@mark.mielke.cc> <20021031170420.GA30193@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031170420.GA30193@opus.bloom.county>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini wrote:
> On Thu, Oct 31, 2002 at 11:51:13AM -0500, Mark Mielke wrote:
> > Or specified more clearly: If the compiler optimization flag is
> > configurable, choosing CONFIG_TINY should default the optimization flag
> > to -Os before it defaults the optimization flag to -O2.
> You're still missing the point of flexibility remark.  Changing the
> optimization level has nothing to do with CONFIG_TINY, and is a
> generally useful option, and should be done seperate from CONFIG_TINY.
> In fact people seem to be getting the wrong idea about CONFIG_TINY.  We
> ...

Please read it again... even if the optimization flag was
configurable, choosing CONFIG_TINY should *default* the optimization
flag to -Os before it defaults the optimization flag to -O2.

In the case where CONFIG_TINY is an option on its own, it means using -Os
instead of -O2. In the case where CONFIG_TINY is a template *not an option*,
the configurable "optimization flag" gets initialized to -Os. You could
still override -Os to be -O2 if you wanted to, or if CONFIG_TINY was not
specified, you could still override -O2 to be -Os... the default is -Os for
CONFIG_TINY.

K... I don't think this needs any more time.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

