Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSGTVYQ>; Sat, 20 Jul 2002 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317538AbSGTVYQ>; Sat, 20 Jul 2002 17:24:16 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:7920 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317536AbSGTVXq>; Sat, 20 Jul 2002 17:23:46 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 20 Jul 2002 15:24:14 -0600
To: David Weinehall <tao@acc.umu.se>
Cc: Austin Gonyou <austin@digitalroadkill.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020720212414.GL10315@clusterfs.com>
Mail-Followup-To: David Weinehall <tao@acc.umu.se>,
	Austin Gonyou <austin@digitalroadkill.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com> <1027199147.16819.39.camel@irongate.swansea.linux.org.uk> <1027197028.26159.2.camel@UberGeek.digitalroadkill.net> <20020720205520.GX29001@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020720205520.GX29001@khan.acc.umu.se>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 20, 2002  22:55 +0200, David Weinehall wrote:
> On Sat, Jul 20, 2002 at 03:30:29PM -0500, Austin Gonyou wrote:
> > On Sat, 2002-07-20 at 16:05, Alan Cox wrote:
> > Just IMHO, LVM2 makes better sense as there currently is no "stable"
> > module for XFS in EVMS, AFAIK.
> > Also, LVM is currently in 2.4 and a lot of peopel use it, LVM2 seems to
> > be the proper progression for 2.6. My $0.02
> 
> I'd rather see the EVMS go in, if a choice has to be made between the
> two. EVMS seems to have a lot of effort put in it, and has the
> experience from the (very good) volume-managers that IBM have in OS/2
> and AIX.

I, for one, would like to have the choice to use the AIX LVM format, and
I'm sure that people thinking of migrating from HP/UX or whatever would
want to be able to add support for their on-disk LVM format.  It really
provides a framework to consolidate all of the partition/MD code into
a single place (e.g. RAID, LVM, LDM (windows NT), DOS, BSD, Sun, etc).

EVMS also allows things like creating snapshots and resizing for
partitions that were not originally set up as LVM volumes (i.e. you can
"upgrade" your existing DOS partitions in-place to support LVM features
instead of requiring a backup/restore cycle.

> Afaik, EVMS supports LVM volumes. As for XFS, I'm sure an XFS module can
> be produced for EVMS (then again, XFS isn't merged yet either...)

Even if there is no XFS FSIM module for EVMS, it doesn't mean you can't
use XFS filesystems on EVMS volumes.  The only thing it means is that you
don't get integrated volume+filesystem resize+don't shoot foot support.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

