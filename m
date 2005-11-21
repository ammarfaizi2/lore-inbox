Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVKUMHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVKUMHQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVKUMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:07:16 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:28039 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932275AbVKUMHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:07:14 -0500
Subject: Re: what is our answer to ZFS?
From: Kasper Sandberg <lkml@metanurb.dk>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051121114654.GA25180@merlin.emma.line.org>
References: <11b141710511210144h666d2edfi@mail.gmail.com>
	 <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
	 <20051121101959.GB13927@wohnheim.fh-wedel.de>
	 <20051121114654.GA25180@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 21 Nov 2005 13:07:11 +0100
Message-Id: <1132574831.15938.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 12:46 +0100, Matthias Andree wrote:
> On Mon, 21 Nov 2005, Jörn Engel wrote:
> 
> > o Checksums for data blocks
> >   Done by jffs2, not done my any hard disk filesystems I'm aware of.
> 
> Then allow me to point you to the Amiga file systems. The variants
> commonly dubbed "Old File System" use only 448 (IIRC) out of 512 bytes
> in a data block for payload and put their block chaining information,
> checksum and other "interesting" things into the blocks. This helps
> recoverability a lot but kills performance, so many people (used to) use
> the "Fast File System" that uses the full 512 bytes for data blocks.
> 
> Whether the Amiga FFS, even with multi-user and directory index updates,
> has a lot of importance today, is a different question that you didn't
> pose :-)
> 
> >   yet.  (I barely consider reiser4 to exist.  Any filesystem that is
> >   not considered good enough for kernel inclusion is effectively still
> >   in development phase.)
that isnt true, just because it isnt following the kernel coding style
and therefore has to be changed, does not make it any bit more unstable.


> 
> What the heck is reiserfs? I faintly recall some weirdo crap that broke
> NFS throughout the better parts of 2.2 and 2.4, would slowly write junk
> into its structures that reiserfsck could only fix months later.
well.. i remember that linux 2.6.0 had alot of bugs, is 2.6.14 still
crap because those particular bugs are fixed now?

> 
> ReiserFS 3.6 still doesn't work right (you cannot create an arbitrary
> amount of arbitrary filenames in any one directory even if there's
> sufficient space), after a while in production, still random flaws in
> the file systems that then require rebuild-tree that works only halfway.
> No thanks.
i have used reiserfs for a long time, and have never had the problem
that i was required to use rebuild-tree, not have issues requiring other
actions come, unless i have been hard rebooting/shutting down, in which
case the journal simply replayed a few transactions.

> 
> Why would ReiserFS 4 be any different? IMO reiserfs4 should be blocked
> from kernel baseline until:

you seem to believe that reiser4 (note, reiser4, NOT reiserfs4) is just
some simple new revision of reiserfs. well guess what, its an entirely
different filesystem, which before they began the changes to have it
merged, was completely stable, and i have confidence that it will be
just as stable again soon.

> 
> - reiserfs 3.6 is fully fixed up
> 
so you are saying that if for some reason the via ide driver for old
chipsets are broken, we cant merge a via ide driver for new ide
controllers?

> - reiserfs 4 has been debugged in production outside the kernel for at
>   least 24 months with a reasonable installed base, by for instance a
>   large distro using it for the root fs
no dist will ever use (except perhaps linspire) before its included in
the kernel.
> 
> - there are guarantees that reiserfs 4 will be maintained until the EOL
>   of the kernel branch it is included into, rather than the current "oh
>   we have a new toy and don't give a shit about 3.6" behavior.
why do you think that reiser4 will not be maintained? if there are bugs
in 3.6 hans is still interrested, but really, do you expect him to still
spend all the time trying to find bugs in 3.6, when people dont seem to
have issues, and while he in fact has created an entirely new
filesystem.
> 
> Harsh words, I know, but either version of reiserfs is totally out of
> the game while I have the systems administrator hat on, and the recent
> fuss between Namesys and Christoph Hellwig certainly doesn't raise my
> trust in reiserfs.
so you are saying that if two people doesent get along the product the
one person creates somehow falls in quality?
> 

