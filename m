Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133014AbRAGT5Q>; Sun, 7 Jan 2001 14:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135211AbRAGT5G>; Sun, 7 Jan 2001 14:57:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19216 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133014AbRAGT44>; Sun, 7 Jan 2001 14:56:56 -0500
Date: Sun, 7 Jan 2001 11:56:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <E14FLi2-0003Cy-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101071153470.27944-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Alan Cox wrote:

> > > I'll take a look at the ramfs one. I may have broken something else when fixing
> > > everything else with ramfs (like unlink) crashing
> > 
> > Ehh.. Plain 2.4.0 ramfs is fine, assuming you add a "UnlockPage()" to
> > ramfs_writepage(). So what do you mean by "fixing everything else"?
> 
> -ac has the rather extended ramfs with resource limits and stuff. That one
> also has rather more extended bugs 8). AFAIK none of those are in the vanilla
> ramfs code

Ahh, ok.

This is actually where I agree with whoever it was that said that ramfs as
it stands now (without the limit checking etc) is much nicer simply
because it can act as an example of how to do a simple filesystem. 

I wonder what to do about this - the limits are obviously useful, as would
the "use swap-space as a backing store" thing be. At the same time I'd
really hate to lose the lean-mean-clean ramfs. 

Anyway, I'm quite sure that the resource stuff would not be 2.4.1 material
(adding the UnlockPage() is), so I won't have to worry about this issue
for a while.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
