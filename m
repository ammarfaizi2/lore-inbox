Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTCCQFX>; Mon, 3 Mar 2003 11:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTCCQFX>; Mon, 3 Mar 2003 11:05:23 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:1169 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S266527AbTCCQFV>;
	Mon, 3 Mar 2003 11:05:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Edward S. Marshall" <esm@logic.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Tue, 4 Mar 2003 00:06:48 +0100
X-Mailer: KMail [version 1.3.2]
Cc: diegocg@teleline.es, andrea@suse.de, hch@infradead.org,
       linux-kernel@vger.kernel.org, pavel@janik.cz, pavel@ucw.cz
References: <200303020223.SAA13660@adam.yggdrasil.com> <20030303152626.GG16908@talus.logic.net>
In-Reply-To: <20030303152626.GG16908@talus.logic.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030303161547.498E63E659@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 March 2003 16:26, Edward S. Marshall wrote:
> On Sat, Mar 01, 2003 at 06:23:21PM -0800, Adam J. Richter wrote:
> >
> > [Subversion] uses its own underlying repository format that isn't 
> > particularly compatible with anything else
>
> Lacking an on-disk format that's actually useful for storing more
> information than files and diffs, they invented one. I don't blame them.

There is plenty of justification all right.  Besides adding metadata 
versioning, they built it around an optimal binary-dff algorithm borrowed 
from Josh Macdonald's PRCS/Xdelta, so the version database is more compact 
and efficient than you can achieve with a diff or pure SCCS-based design.

> The fun part, of course, is that svn is architected such that bolting up
> to another repository storage system (say, an RDBMS, or even, horrors, a
> bitkeeper-compatible SCCS derivative) is really just a matter of writing
> the code (with a few caveats, obviously, but that's the basic idea).

For the long run, svn looks very good.  I've seen many pot shots aimed at it, 
but few survive scrutiny.  The ones that do are:

   - It's not quite here yet
   - It's not Linus-compatible

The second one will take longer to solve than the first. In the meantime, 
those who can't use Bitkeeper (that includes me, since I did some work on a 
versioning filesystem, never mind annoying Larry) need some tools in order to 
have any chance of keeping current with Linus and other maintainers.  The 
contributions of Andrea, Pavel and Rik in that area are extremely valuable, 
and I thank them for it.

Regards,

Daniel.
