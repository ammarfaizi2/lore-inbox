Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSEZQ13>; Sun, 26 May 2002 12:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSEZQ12>; Sun, 26 May 2002 12:27:28 -0400
Received: from bitmover.com ([192.132.92.2]:6359 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316199AbSEZQ11>;
	Sun, 26 May 2002 12:27:27 -0400
Date: Sun, 26 May 2002 09:27:29 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Larry McVoy <lm@bitmover.com>, David Schleef <ds@schleef.org>,
        Karim Yaghmour <karim@opersys.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526092729.B30144@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
	David Schleef <ds@schleef.org>, Karim Yaghmour <karim@opersys.com>,
	Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020525211328.B20253@work.bitmover.com> <Pine.GSO.4.21.0205260234460.15165-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 03:30:46AM -0400, Alexander Viro wrote:
> On Sat, 25 May 2002, Larry McVoy wrote:
> You are tripping.  bmap() is obviously different in 32V and 4.2BSD -
> filesystems are different and yes, it _is_ a profound part of filesystem.

You're right, I was tripping, I don't know what I was smokng, I know that
code path and they can't be the same.  That said...

> The only thing that
> does match is use of function and fact that old and new filesystems
> have similar data structure for indirect, etc. blocks.  Notice that
> it's similar, not identical - e.g. use of fragments in FFS changes
> quite a few things.

Oh, come on, read the code side by side, I'm doing it now (kind of fun, too,
it's been a long time since I've been in here).  If you have BK installed,
or have tkdiff, run that on the two functions side by side.  You're absolutely
right, they aren't identical (what was I thinking?  Shame on me, I've worked
on this code, it's impossible for them to be the same by definition), but
one is clearly an extension of the other.  This is *not* a rewrite.  Or if
it is, I didn't get the memo where they changed the definition of rewrite.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
