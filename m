Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288897AbSBIXxZ>; Sat, 9 Feb 2002 18:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288948AbSBIXxP>; Sat, 9 Feb 2002 18:53:15 -0500
Received: from bitmover.com ([192.132.92.2]:3470 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S288897AbSBIXxA>;
	Sat, 9 Feb 2002 18:53:00 -0500
Date: Sat, 9 Feb 2002 15:52:58 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Lang <dlang@diginsite.com>, Larry McVoy <lm@bitmover.com>,
        Tom Rini <trini@kernel.crashing.org>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020209155258.E18734@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <dlang@diginsite.com>, Larry McVoy <lm@bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020209090527.B13735@work.bitmover.com> <Pine.LNX.4.44.0202091258110.25220-100000@dlang.diginsite.com> <20020209134132.J13735@work.bitmover.com> <20020209163603.B9826@lynx.turbolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020209163603.B9826@lynx.turbolabs.com>; from adilger@turbolabs.com on Sat, Feb 09, 2002 at 04:36:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 04:36:03PM -0700, Andreas Dilger wrote:
> On Feb 09, 2002  13:41 -0800, Larry McVoy wrote:
> > We don't, but we can, and we should.  "bk relink tree1 tree2" seems like 
> > the right interface.
> 
> Yes, this would be great.  It should probably only do this for files in
> SCCS and BitKeeper directories, because vim (for example) will do the

Correct.

> One thing that I've noticed (got my first linux-2.5 clone last night) is
> that the kernel build process is somewhat broken by the fact that not
> everything that you need to build is checked out of the repository by
> make.
> 
> It appears to handle .c files ok, but it failed for all of the .h files.

This is because the dependencies are incorrect in the makefiles.  If you
have correct dependencies in the makefiles, make will do the right thing.

One alternative would be to have a scripts/bk-get which takes as an arg
the architecture[s] you want and gets the files that make sense for
that architecture.  That would help somewhat.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
