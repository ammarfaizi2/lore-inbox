Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSJaQnO>; Thu, 31 Oct 2002 11:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSJaQnN>; Thu, 31 Oct 2002 11:43:13 -0500
Received: from mark.mielke.cc ([216.209.85.42]:25604 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262665AbSJaQmh>;
	Thu, 31 Oct 2002 11:42:37 -0500
Date: Thu, 31 Oct 2002 11:51:13 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031165113.GB8565@mark.mielke.cc>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031143301.GC28191@opus.bloom.county>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 07:33:01AM -0700, Tom Rini wrote:
> > If gcc regularly generates larger code with -Os the answer is to talk to
> > the gcc people, not to avoid using -Os...
> It's not that it does regularly, it's that it can, and if it does, it's
> not really a gcc bug from what I recall.  So I don't think CONFIG_TINY
> should prefer -Os over -O2 but instead we should just ask the user what
> level of optimization they want.  Remember, one of the real important
> parts of embedded systems is flexibility.

Not to stretch this point too long, but turning off inlined functions 'can'
make code bigger too. It usually doesn't.

I have no problem with the other suggestion that CONFIG_TINY specify a
template for a set of build options, but if CONFIG_TINY is used (either
as an option, or a template of options) -Os should always be preferred
over -O2. Whether the user can still override this or not is a different
issue from whether -Os should be preferred over -O2 when CONFIG_TINY is
specified.

Or specified more clearly: If the compiler optimization flag is configurable,
choosing CONFIG_TINY should default the optimization flag to -Os before it
defaults the optimization flag to -O2.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

