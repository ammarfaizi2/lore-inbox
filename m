Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272043AbRH2TEE>; Wed, 29 Aug 2001 15:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272045AbRH2TDy>; Wed, 29 Aug 2001 15:03:54 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:35249 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S272043AbRH2TDl>; Wed, 29 Aug 2001 15:03:41 -0400
Date: Wed, 29 Aug 2001 13:03:46 -0600
Message-Id: <200108291903.f7TJ3kv10286@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
In-Reply-To: <20010829121732.I24270@turbolinux.com>
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua>
	<20010829021304.D24270@turbolinux.com>
	<6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
	<20010829121732.I24270@turbolinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> On Aug 29, 2001  15:14 +0300, VDA wrote:
> > Installed e2fsprogs 1.23. It does not print warning now on
> > "fsck /dev/scsi/host0/bus0/target1/lun0/part1"
> > However, it still cannot fs check root fs when given "fsck /" which I
> > really need in my init script. Now the only way to do root fs check
> > for me is to parse /proc/mounts and extract mount point for / via sed
> > (I have never used sed yet...).
> > 
> > # fsck /
> > Parallelizing fsck version 1.15 (18-Jul-1999)
> > e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
> > /sbin/e2fsck: Is a directory while trying to open /
> 
> That's because "/" is a directory and not a device.  fsck works with
> devices.  If you want to avoid specifying your root partition in
> /etc/fstab explicitly, then you can use an ext2 label instead.  Set
> the label on the filesystem with "tune2fs -L root <root_dev>", and
> then put "LABEL=root" in /etc/fstab instead of a device name.  This
> way if your root device gets moved around you are still OK.  This of
> course works with filesystems other than root as long as they are
> ext2/ext3/xfs (reiserfs does not have labels yet).

/dev/root works regardless of filesystem type :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
