Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316367AbSEZUR0>; Sun, 26 May 2002 16:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSEZURZ>; Sun, 26 May 2002 16:17:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12016 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316367AbSEZURI>;
	Sun, 26 May 2002 16:17:08 -0400
Date: Sun, 26 May 2002 16:17:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Schleef <ds@schleef.org>,
        Karim Yaghmour <karim@opersys.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020526120630.C30610@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0205261536360.16963-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 May 2002, Larry McVoy wrote:

> On Sun, May 26, 2002 at 08:40:44PM +0100, Alan Cox wrote:
> > On Sun, 2002-05-26 at 05:03, Larry McVoy wrote:
> > > Me too.  I've been here before, I was one of about 8 people who actually
> > > knew that AT&T should have won the BSD lawsuit because I diffed the code.
> > > And you can't diff it with a perl script, that simply doesn't work.  The
> > 
> > And then went on to cite bmap which is clearly different. Yes Larry, now
> > would you mind returning to the ward like a good patient 8)
> 
> Sniffle, whimper.  It is clearly different in that it calls out to the
> BSD allocation policy, which is completely different.

Um...  In 4.2 - more or less so.  In 4.4 - way more than that:
	* ffs_bmap() is not doing any allocations now
	* ffs_balloc() does (and is an analog of old bmap()) and it contains
a *lot* more code than bmap() had - handling of fragments, stuff forced
by new VM _and_ seriously different overall structure of code.

	WTF?  4BSD code is out there, in SCCS, no less.  Goes back
to 1982 or so.  It's not that checking it would be a problem - grab
the 4th CD from Kirk's 4-parter (CSRG archives) and see yourself.

	BTW, having _that_ converted to BK might be an interesting thing.
To do that one would need to take file moves into account, but they'd
got enough snapshots of the tree to reconstruct that...

