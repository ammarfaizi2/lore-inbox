Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131528AbRAGT1S>; Sun, 7 Jan 2001 14:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132252AbRAGT1I>; Sun, 7 Jan 2001 14:27:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44303 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131528AbRAGT0z>; Sun, 7 Jan 2001 14:26:55 -0500
Date: Sun, 7 Jan 2001 11:26:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <E14FGG7-0002ff-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101071124540.27944-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Alan Cox wrote:

> > >ramfs croaks with 'kernel BUG in filemap.c line 2559' anytime I make a
> > >file in ac2 and ac3.  Works fine in 2.4.0 vanilla.  Should be quite
> > >repeatable...
> 
> I'll take a look at the ramfs one. I may have broken something else when fixing
> everything else with ramfs (like unlink) crashing

Ehh.. Plain 2.4.0 ramfs is fine, assuming you add a "UnlockPage()" to
ramfs_writepage(). So what do you mean by "fixing everything else"?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
