Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWFJNqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWFJNqo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 09:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWFJNqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 09:46:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9482 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751515AbWFJNqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 09:46:43 -0400
Date: Sat, 10 Jun 2006 15:46:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610134645.GB11634@stusta.de>
References: <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org> <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 10:58:00AM -0700, Gerrit Huizenga wrote:
> 
> On Fri, 09 Jun 2006 09:09:01 PDT, Linus Torvalds wrote:
> > On Fri, 9 Jun 2006, Gerrit Huizenga wrote:
> > > 
> > > Jeff's approach taken to the rediculous would mean that we'd have
> > > ext versions 1-40 by now at least.  I don't think that helps much,
> > > either.
> > 
> > On the other hand, I _guarantee_ you that it helps that we have ext2-3, 
> > and not just ext2 (nobody even tried to keep ext1 compatible, thank the 
> > Gods).
>  
> I had originally argued for ext4 as well based on the fact that it would
> allow lots of potential cleanups & simplifications and at the same time
> would allow a break in the on disk filesystems layout.
> 
> These changes don't yet change the actual on-disk layout and that might
> be something that would be done if ext4 were a real, new filesystem.
> 
> But then how long until ext4 is used enough to be put into production?
> How much testing will it *really* get in any form?  How long before
> the people that are using 100 TB+ disk farms today (some of which are
> chopping filesystems into 2-8 GB chunks, others with 2 TB filesystems
> today) actually trust this new filesystem (most vendors don't support
> JFS today, XFS support isn't much better).

You want to get the new features into ext3 instead of creating ext4 for
getting them better tested.

Other people in this thread want to get the new features into ext3 
instead of creating ext4 telling that this won't do harm for existing 
users since users will have to explicitely enable it.

Hearing people using contrary arguments in the same discussion always 
sounds as if they don't actually know what they want to do...

> We are seeing storage needs increasing at a frightening rate.  Health
> Care folks want to store your MRI's, x-ray's, ultraounds, etc. in high
> res digital format across your entire life in near-line format.  Terabytes
> over time per person.  Europe is already doing this pretty extensively,
> the US is following suit.  Digital media creation has huge storage needs.
> Most everything is moving to podcasts, webcasts, streaming audio & video.
> Storage is huge, and ext3 is at the current breaking point.
> 
> I'd argue that whatever we call it, we need a standard, stable, supported
> solution *soon* for large files, large filesystems, large storage systems
> in Linux.
> 
> I'd think the quickest path is to relieve the pressure now in ext3.

Why aren't JFS and XFS good enough for relieving the pressure now?

> We still haven't solved the filesystem check time problem, which is the
> next big bugaboo.  But getting large fileysstems to real customers soon,
> e.g. in mainline, well tested, ready for distro support is my real goal.
>...

Other people have the "no regressions for existing ext3 users" goal.

> gerrit

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

