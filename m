Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSGSUAS>; Fri, 19 Jul 2002 16:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSGSUAS>; Fri, 19 Jul 2002 16:00:18 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:46213 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317003AbSGSUAS>; Fri, 19 Jul 2002 16:00:18 -0400
Date: Fri, 19 Jul 2002 15:01:16 -0500
From: Shawn <core@enodev.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020719150116.A31973@q.mn.rr.com>
References: <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com> <20020716161158.A461@shookay.newview.com> <20020716152231.B6254@q.mn.rr.com> <20020717114501.GB28284@merlin.emma.line.org> <20020717190259.GA31503@clusterfs.com> <20020719102906.A5131@krusty.dt.e-technik.uni-dortmund.de> <20020719163907.GD10315@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020719163907.GD10315@clusterfs.com>; from adilger@clusterfs.com on Fri, Jul 19, 2002 at 10:39:07AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19, Andreas Dilger said something like:
> On Jul 19, 2002  10:29 +0200, Matthias Andree wrote:
> > What kernel version is necessary to achieve this on production kernels
> > (i. e. 2.4)?
> > 
> > Does "consistent" mean "fsck proof"?
> > 
> > Here's what I tried, on Linux-2.4.19-pre10-ac3 (IIRC) (ext3fs):
> > 
> > (from memory, history not available, different machine):
> > lvcreate --snapshot snap /dev/vg0/home
> > e2fsck -f /dev/vg0/snap
> > dump -0 ...
> > 
> > It reported zero dtime for one file and two bitmap differences.
> 
> That is because one critical piece is missing from 2.4, the VFS lock
> patch.  It is part of the LVM sources at sistina.com.  Chris Mason has
> been trying to get it in, but it is delayed until 2.4.19 is out.
> 
> > dump did not complain however, and given what e2fsck had to complain,
> > I'd happily force mount such a file system when just a deletion has not
> > completed.
> 
> You cannot mount a dirty ext3 filesystem from read-only media.

I thought you could "mount -t ext2" ext3 volumes, and thought you could
force mount ext2.

I'm no Andreas Dilger, so don't take this like I'm disagreeing...

--
Shawn Leas
core@enodev.com

I went to the bank and asked to borrow a cup of money.  They
said, "What for?"  I said, "I'm going to buy some sugar."
						-- Stephen Wright
