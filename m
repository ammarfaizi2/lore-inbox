Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSFFSnT>; Thu, 6 Jun 2002 14:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSFFSmH>; Thu, 6 Jun 2002 14:42:07 -0400
Received: from waste.org ([209.173.204.2]:26511 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317092AbSFFSkZ>;
	Thu, 6 Jun 2002 14:40:25 -0400
Date: Thu, 6 Jun 2002 13:40:19 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Jens Axboe <axboe@suse.de>, Xavier Bestel <xavier.bestel@free.fr>,
        Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFDEE17.FD1306A0@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206061338120.2614-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Andrew Morton wrote:

> Jens Axboe wrote:
> >
> > On Wed, Jun 05 2002, Xavier Bestel wrote:
> > > Le mer 05/06/2002 à 01:43, Andrew Morton a écrit :
> > >
> > > > Also, it has been suggested that the feature become more fully-fleshed,
> > > > to support desktops with one disk spun down, etc.  It's not really
> > > > rocket science to do that - the `struct backing_dev_info' gives
> > > > a specific communication channel between the high-level VFS code and
> > > > the request queue.  But that would require significantly more surgery
> > > > against the writeback code, so I'm fishing for requirements here.  If
> > > > the current (simple) patch is sufficient then, well, it is sufficient.
> > >
> > > Have per-disk laptop-mode, so that some user-mode proggy (e.g. hotplug)
> > > could decide what to do.
> >
> > And get rid of disk_spun_up(), make it a queue flag instead and signal
> > the spin up before calling the request_fn instead of shoving it inside
> > the driver request_fn's.
>
> Then writes to the ramdisk would cause a spinup.
>
> Yes, it could be per-queue.  That would add complexity to
> the already-murky fs/fs-writeback.c.  It that justifiable?

Yes, see Zip and USB/Firewire drives. Laptops can have multiple spindles.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

