Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbSLPRTE>; Mon, 16 Dec 2002 12:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSLPRSE>; Mon, 16 Dec 2002 12:18:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23306 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266859AbSLPRRy>; Mon, 16 Dec 2002 12:17:54 -0500
Date: Mon, 16 Dec 2002 09:26:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben Collins <bcollins@debian.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.52
In-Reply-To: <20021216151639.GQ504@hopper.phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0212160920380.2799-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Dec 2002, Ben Collins wrote:
>
> How about pointing out some specifics? Maybe make my job easier by
> getting me some patches directly. Trying to track two seperate source
> tree's isn't as easy as you might think.

It's a lot easier if you track them _often_ instead of just occasionally.
That's the main problem I have with other peoples CVS trees - CVS has very
little support for tracking any outside sources, and that coupled with the
fact that people don't track it in a timely manner always generates
problems.

With CVS, a simple script like

 (a) get current version
 (b) diff against the last version you did the merge against
 (c) apply the diff to your new tree
 (d) _then_ do the diff against the current version
 (e) delete "last version merged", make current version that.

will work pretty easily most of the time for subsystems that don't get a
lot of input from outside the "maintainer". Especially if you do it
reasonably often (you can do the back-merge even when you're _not_ ready
to actually send me your stuff), the diff from my tree is often quite
small and thus easily mergible.

If you think that "maintainer" means that nobody else can touch the tree
and that you thus don't need to care, you're WRONG.

Alternatively, never EVER make a patch against the "current kernel
version". Only make a patch against the _last_ kernel that you merged
with, and if I cannot apply it I will tell you so. Making a patch just
between your tree and mine will _always_ end up losing fixes.

			Linus

