Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313850AbSDFBK1>; Fri, 5 Apr 2002 20:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313849AbSDFBKQ>; Fri, 5 Apr 2002 20:10:16 -0500
Received: from bitmover.com ([192.132.92.2]:18385 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313848AbSDFBKD>;
	Fri, 5 Apr 2002 20:10:03 -0500
Date: Fri, 5 Apr 2002 17:10:01 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
Message-ID: <20020405171001.C6087@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200204052027.g35KRc002869@bitshadow.namesys.com> <Pine.LNX.4.33.0204051347500.1746-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 01:48:30PM -0800, Linus Torvalds wrote:
> 
> On Sat, 6 Apr 2002, Hans Reiser wrote:
> > 
> > This changeset is to fix several reiserfs problems which can be
> > fixed in non-intrusive way.
> 
> Please don't use bk patches, they have turned out to be pretty much 
> unusable.

I suspect that the problem is that BK won't let you accept a patch unless
the receiving repository has the parent of the patch.  In other words,
this won't work:

	bk clone bk://linux.bkbits.net/linux-2.5
	<make some changes>
	bk commit (or bk citool)	# creates changeset 1.800
	<make some changes>
	bk commit (or bk citool)	# creates changeset 1.801

	# Now you want to send the second patch to Linus so you do a:
	bk send -r+ - | mail linux-kernel@vger.kernel.org

That will fail when Linus tries to accept the patch, because he doesn't
have your 1.800.

The easiest thing is to do what he suggests:

> Either make a (controlled) bk tree available for pulling, or just use 
> old-fashioned patches.

and if you want to go the "tree for pulling", you can either point him at
a BK url you maintain, or you are welcome to go grab resierfs.bkbits.net
and stash it there.  See http://www.bitkeeper.com/Hosted.html for information
on how to set up a project here.

At some point, we'll package up the whole bkbits.net infrastructure as an
installable RPM (not the project data, the infrastructure), and you'll be
able to do this at resierfs.bkbits.kernel.org or something like that, but
right now we're just too overworked to do so.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
