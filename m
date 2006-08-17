Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWHQJCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWHQJCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWHQJCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:02:13 -0400
Received: from xs.wurtel.net ([83.68.3.130]:42681 "EHLO mx.wurtel.net")
	by vger.kernel.org with ESMTP id S1750841AbWHQJCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:02:12 -0400
Date: Thu, 17 Aug 2006 11:01:49 +0200
From: Paul Slootman <paul+nospam@wurtel.net>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060817090149.GA7919@wurtel.net>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org
References: <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com> <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com> <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com> <20060814120032.E2698880@wobbly.melbourne.sgi.com> <ebv3ji$gls$1@news.cistron.nl> <20060817084750.B2787212@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817084750.B2787212@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Scanner: exiscan *1GDdl8-0000Bm-00*AkyAFuZpeT6*Wurtel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Aug 2006, Nathan Scott wrote:
> On Wed, Aug 16, 2006 at 12:38:10PM +0000, Paul Slootman wrote:
> > Nathan Scott  <nathans@sgi.com> wrote:
> > >On Fri, Aug 11, 2006 at 12:25:03PM +0200, Jesper Juhl wrote:
> > >> I didn't capture all of the xfs_repair output, but I did get this :
> > >> ...
> > >> Phase 4 - check for duplicate blocks...
> > >>         - setting up duplicate extent list...
> > >>         - clear lost+found (if it exists) ...
> > >>         - clearing existing "lost+found" inode
> > >>         - deleting existing "lost+found" entry
> > >>         - check for inodes claiming duplicate blocks...
> > >>         - agno = 0
> > >>         - agno = 1
> > >>         - agno = 2
> > >>         - agno = 3
> > >>         - agno = 4
> > >>         - agno = 5
> > >>         - agno = 6
> > >> LEAFN node level is 1 inode 412035424 bno = 8388608
> > >
> > >Ooh.  Can you describe this test case you're using?  Something with
> > >a bunch of renames in it, obviously, but I'd also like to be able to
> > >reproduce locally with the exact data set (file names in particular),
> > >if at all possible.
> > 
> > >From your reaction above I gather that "LEAFN node level is 1 inode ..."
> > is a bad thing?
> > 
> > My filesystem (that crashes under heavy load, while rsyncing to and from
> > it) has a lot of these messages when xfs_repair is run.
> 
> Do you have a reproducible test case?  Please send a go-to-woe recipe
> so I can see the problem first hand... and preferably one that is, er,
> slightly simpler than Jesper's case.

Unfortunately no, this is a 1.1TB filesystem with 54% usage, and dozens
of large rsyncs to and from it. However during this XFS panicks.

That was with 2.6.17.7 (after 2.6.17.4 had buggered it with the endian
bug, but after numerous xfs_repairs).  Interestingly I rebooted into an
old 2.6.15.6 kernel yesterday after the last XFS crash, and it survived
last night's activities perfectly well. After a couple of days I'm
willing to give the latest 2.6.18-rc or whatever a try (once I've a
complete set of backups again, and they've been passed on to the
long-term backup system).


Paul Slootman
