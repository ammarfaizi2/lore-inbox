Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271976AbRH2O1r>; Wed, 29 Aug 2001 10:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271978AbRH2O1h>; Wed, 29 Aug 2001 10:27:37 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10161 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271976AbRH2O1c>; Wed, 29 Aug 2001 10:27:32 -0400
Date: Wed, 29 Aug 2001 08:27:19 -0600
Message-Id: <200108291427.f7TERJj07458@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: fsck root fs: fsck, devfs, /proc/mounts miscooperate.
In-Reply-To: <6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <22075604.20010829095413@port.imtp.ilyichevsk.odessa.ua>
	<20010829021304.D24270@turbolinux.com>
	<6410958637.20010829151417@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA@port.imtp.ilyichevsk.odessa.ua writes:
> Hello Andreas,
> 
> Wednesday, August 29, 2001, 11:13:04 AM, you wrote:
> >> # fsck /dev/scsi/host0/bus0/target1/lun0/part1
> >> Parallelizing fsck version 1.15 (18-Jul-1999)
> >> e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
> >> /dev/scsi/host0/bus0/target1/lun0/part1 is mounted.
> >> 
> >> WARNING!!!  Running e2fsck on a mounted filesystem may cause
> >> SEVERE filesystem damage...
> 
> AD> Get a new version of e2fsprogs (at http://sf.net/projects/e2fsprogs).
> AD> The detection of mounted root filesystems has changed in recent releases,
> AD> so it _should_ be fixed - let us know if it is not.
> 
> Installed e2fsprogs 1.23. It does not print warning now on
> "fsck /dev/scsi/host0/bus0/target1/lun0/part1"
> However, it still cannot fs check root fs when given "fsck /" which I
> really need in my init script. Now the only way to do root fs check
> for me is to parse /proc/mounts and extract mount point for / via sed
> (I have never used sed yet...).
> 
> # fsck /
> Parallelizing fsck version 1.15 (18-Jul-1999)
> e2fsck 1.15, 18-Jul-1999 for EXT2 FS 0.5b, 95/08/09
> /sbin/e2fsck: Is a directory while trying to open /
> 
> The superblock could not be read or does not describe a correct ext2
> filesystem...

You say you are running devfs. Well, if that's the case, you can
simply do:
# fsck /dev/root

because devfs makes /dev/root a symbolic link to the root FS device.
Magic.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
