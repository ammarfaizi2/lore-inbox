Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTK2FRX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 00:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTK2FRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 00:17:23 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:33455 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S263639AbTK2FRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 00:17:21 -0500
Date: Sat, 29 Nov 2003 07:16:31 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Andrew Clausen <clausen@gnu.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
In-Reply-To: <20031129022221.GA516@gnu.org>
Message-ID: <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Nov 2003, Andrew Clausen wrote:
> On Fri, Nov 28, 2003 at 03:24:52PM +0100, Andries Brouwer wrote:
> >
> > There is no such thing as a "correct" disk geometry.
> 
> Yes there is.  "Correct" is defined by the BIOS.  It is important
> for boot loaders (in particular Windows).  

I suspected the same ... What Windows you mean? DOS (9x/ME/etc) or NT based
(NT4/2000/XP/2003)? All?

> I'm not sure if this is still a big issue worth worrying about.

IMHO it might be. At least I'm getting an increasing number of emails from
people who can't boot Windows anymore after resizing and repartitioning
NTFS on Linux. Everybody thinks it's the Linux NTFS code's fault but so far
it was always about the repartitioning going wrong. I just had to write a
FAQ entry about this issue recently

	http://mlf.linux.rulez.org/mlf/ezaz/ntfsresize.html#troubleshoot

Some users, having problems, did mention the usage of 2.6 kernel. If the
geometry changed during the fdisk, etc process then it could result also
booting problem? It's just a speculation because I've never had enough
information to investigate.

Also, can Parted save/restore the full and exact partition table a
scriptable way? I mean something like this:

	sfdisk -d /dev/hda > hda.pt       # save
	sfdisk /dev/hda < hda.pt          # restore

sfdisk can't recover geometry so apparently no one-liner, widely available,
partition table backup/recovery is possible at present on Linux :-o
dd if=/dev/hda of=hda.mbr bs=512 count=1 won't save the logical partitions.

	Szaka
