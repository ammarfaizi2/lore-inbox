Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272511AbTHKMaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272512AbTHKMaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:30:21 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35079
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S272511AbTHKMaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:30:20 -0400
Date: Mon, 11 Aug 2003 05:19:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill HDIO_GETGEO_BIG_RAW ioctl
In-Reply-To: <200308110137.21462.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10308110515510.12816-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


28bit it is a free for all, and anything goes in linux because nobody is
willing to commit and force anything over 8.4GB to LBA only.  People think
that "orphan sectors" are a bad thing.  IFF one can only IO in LBA with
the exception of sectors at or below the 8.4GB limit then one never needs
to worry about rogue programs existing out in nowhere land.

Cheers,

--a

On Mon, 11 Aug 2003, Bartlomiej Zolnierkiewicz wrote:

> On Monday 11 of August 2003 01:24, you wrote:
> > On Sunday 10 of August 2003 22:29, you wrote:
> > > Besure to force all devices to LBA only because wrapping the cylinder
> > > count tends to make a mess.
> 
> This should be fixed by a "[PATCH] disk geometry/capacity cleanups".
> drive->cyl won't be recalculated et all and cyls number from a disk itself
> will be used for set_geometry().
> 
> > Ahhh... you mean not doing set_geometry() for LBA disks (we currently don't
> > do it only for LBA-48 disks) because for large disks the cylinder count
> > wraps and its not a nice thing, right?
> 
> It still may be a good thing, cause we never fall-back to CHS addressing,
> even for taskfile ioctl requests (or fix taskfile and allow fall-back?).
> 
> --bartlomiej
> 

