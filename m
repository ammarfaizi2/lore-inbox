Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSEZUdh>; Sun, 26 May 2002 16:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315922AbSEZUdg>; Sun, 26 May 2002 16:33:36 -0400
Received: from bitmover.com ([192.132.92.2]:42203 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S315278AbSEZUde>;
	Sun, 26 May 2002 16:33:34 -0400
Date: Sun, 26 May 2002 13:33:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
        Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526133335.F30610@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, David Schleef <ds@schleef.org>,
	Karim Yaghmour <karim@opersys.com>, Wolfgang Denk <wd@denx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020526120630.C30610@work.bitmover.com> <Pine.GSO.4.21.0205261536360.16963-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 04:17:07PM -0400, Alexander Viro wrote:
> > Sniffle, whimper.  It is clearly different in that it calls out to the
> > BSD allocation policy, which is completely different.
> 
> Um...  In 4.2 - more or less so.  In 4.4 - way more than that:
> 	* ffs_bmap() is not doing any allocations now
> 	* ffs_balloc() does (and is an analog of old bmap()) and it contains

I think I was looking at 4.3Tahoe, but it doesn't matter, what I was 
thinking about was your comment about frags, that makes things quite 
different.  And I know, err, am pretty sure, that by this point Kirk
had worked over the allocation policy to keep things in the same
cylinder group when possible and I don't think that the original
file system was quite as careful.

> 	WTF?  4BSD code is out there, in SCCS, no less.  Goes back
> to 1982 or so.  It's not that checking it would be a problem - grab
> the 4th CD from Kirk's 4-parter (CSRG archives) and see yourself.

Yup, got it.  I've had some fun in there.

> 	BTW, having _that_ converted to BK might be an interesting thing.
> To do that one would need to take file moves into account, but they'd
> got enough snapshots of the tree to reconstruct that...

Yes, I know, it's on my list of things to do.  There are some compat issues,
it isn't a trivial thing, but we can and will do it.  Another thing I plan
to do is to build up BK repositories of all the BSD docs as well as all the
troff docs.  I really like troff, I'm not a fan of latex or word, troff 
still works better for me but I think many people abandoned it out of a 
lack of documentation.  And when that's done, I'll make man page versions
of all the stupid info stuff so I can say "man whatever" and get what 
I need.

Wandering well into the weeds....
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
