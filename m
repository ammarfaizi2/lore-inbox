Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbTCLWvw>; Wed, 12 Mar 2003 17:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbTCLWvv>; Wed, 12 Mar 2003 17:51:51 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12292 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262080AbTCLWuw>;
	Wed, 12 Mar 2003 17:50:52 -0500
Date: Thu, 13 Mar 2003 00:38:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zack Brown <zbrown@tumblerings.org>
Cc: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030312233809.GD5958@zaurus.ucw.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v_14m_1@penguin.transmeta.com> <20030308225252.GA23972@renegade> <20030309000514.GB1807@work.bitmover.com> <20030309024522.GA25121@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309024522.GA25121@renegade>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [Long rant, summary: it's harder than you think, read on for the details]
> [skipping long description]
> 
> OK, so here is my distillation of Larry's post.
> 
>   Basic summary: a distributed, replicated, version controlled user level file
>   system with no limits on any of the file system events which may happened
>   in parallel. All changes must be put correctly back together, no matter how
>   much parallelism there has been.
> 
>   * Merging.
> 
>   * The graph structure.
> 
>   * Distributed rename handling. Centralized systems like Subversion don't
>   have as many problems with this because you can only create one file in
>   one directory entry because there is only one directory entry available.
>   In distributed rename handling, there can be an infinite number of different
>   files which all want to be src/foo.c. There are also many rename corner-cases.
> 
>   * Symbolic tags. This is adding a symbolic label on a revision. A distributed
>   system must handle the fact that the same symbol can be put on multiple
>   revisions. This is a variation of file renaming. One important thing to
>   consider is that time can go forward or backward.
> 
>   * Security semantics. Where should they go? How can they be integrated
>   into the system? How are hostile users handled when there is no central
>   server to lock down?
> 
>   * Time semantics. A distributed system cannot depend on reported time
>   being correct. It can go forward or backward at any rate.
> 
> I'd be willing to maintain this as the beginning of a feature list and
> post it regularly to lkml if enough people feel it would be useful and not
> annoying. The goal would be to identify the features/problems that would

Actually, check it in bitbucket's repository
on sf.net; it should not be annoying
there.
(He he "send it to the bitbucket" :-)
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

