Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290303AbSA3SAG>; Wed, 30 Jan 2002 13:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290292AbSA3R6X>; Wed, 30 Jan 2002 12:58:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43018 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290253AbSA3R5Z>; Wed, 30 Jan 2002 12:57:25 -0500
Date: Wed, 30 Jan 2002 09:56:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Jeff Garzik <garzik@havoc.gtf.org>, <linux-kernel@vger.kernel.org>,
        <lm@bitmover.com>
Subject: Re: real BK usage (was: A modest proposal -- We need a patch penguin)
In-Reply-To: <20020130102458.B763@lynx.adilger.int>
Message-ID: <Pine.LNX.4.33.0201300948050.1928-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Andreas Dilger wrote:
>
> Well, the one benefit of using SCCS directories (which are only 1/3
> louder than CVS directories)

Note that I dislike CVS too. So it's not 1/3 loader than CSV, it's
infinitely louder than nothing at all, and it's quite noticeably louder
than a ".bitkeeper" subdirectory.

>			 is that tools like patch, make, ctags,
> emacs (I believe), etc. already understand what they are and how to
> extract the latest version of a file from there.

So past stupidities would keep you from doing it _right_?

>				  If these tools were
> changed to also recognize .SCCS dirs, then BK could eventually follow
> suit, but it would be impractical until they are widely available.*

Don't be silly. It obviously works the other way. Nobody patches lots of
different tools for a situation that doesn't even exist. But patching
_one_ tool (bk) to be sane makes sense, and then if/when people start
using them, the other tools will certainly follow.

> I would have to agree.  Ted uses BK for e2fsprogs, and there have been
> several times when I try to send him a CSET, but he is unable to apply
> it because it is missing dependencies, even though I know those prior
> CSETs are actually independent changes that just happen to touch the
> same files.

I won't use changesets for this reason, and Larry knows it. I'd still
apply patches, even if I was using bk. It's not as if everybody else would
use bk anyway.

The advantage of bk is that unlike CVS I can use bk in many different
places, and just clone the bk trees. Let's face it, CVS branches suck,
always have, and always will. CVS doesn't allow you to have different CVS
trees, and if one of them starts to look successful, you merge that tree
into your main one.

So I'd personally use changesets just for my _own_ use.

Now, Larry has promised me usable changesets for a long time, but it
obviously hasn't happened yet.

		Linus

