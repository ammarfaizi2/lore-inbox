Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263654AbUJ3JD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUJ3JD3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 05:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUJ3JD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 05:03:29 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:5833 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S263654AbUJ3JDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 05:03:10 -0400
Date: Sat, 30 Oct 2004 12:03:08 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Linux 2.6.9-ac5 - more stupid FAT filesystems
Message-ID: <20041030090308.GA6060@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <1099060831.13098.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099060831.13098.33.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 03:40:32PM +0100, Alan Cox wrote:
> This update adds some of the more minor fixes as well as a fix
> for a nasty __init bug. Nothing terribly pressing for non-S390 users
> unless they are hitting one of the bugs described or need the new
> driver bits.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/
> 
> 2.6.9-ac5
> o	Fix oops in and enable IT8212 driver		(me)
> o	Minor delkin driver fix				(Mark Lord)
> o	Fix NFS mount hangs with long FQDN		(Jan Kasprzak)
> 	| I've used this version as its clearly correct for 2.6.9 
> 	| although it might not be the right future solution
> o	Fix overstrict FAT checks stopping reading of	(Vojtech Pavlik)
> 	some devices like Nokia phones

I guess Canon IXUS 400 is overstupid or something.

USB Mass Storage device found at 2
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 501760 512-byte hdwr sectors (257 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 00 00 00
sdb: assuming drive cache: write through
 sdb: sdb1
Attached scsi removable disk sdb at scsi0, channel 0, id 0, lun 1
Attached scsi removable disk sdc at scsi0, channel 0, id 0, lun 2
Attached scsi removable disk sdd at scsi0, channel 0, id 0, lun 3
FAT: invalid first entry of FAT (0xfff8 != 0xfff8)
VFS: Can't find a valid FAT filesystem on dev sdb1.

this is 256MB CF plugged into Lacie USB CF-reader,
Vendor=0aec ProdID=3260 Rev= 1.00.

# fdisk -l /dev/sdb

Disk /dev/sdb: 256 MB, 256901120 bytes
16 heads, 32 sectors/track, 980 cylinders
Units = cylinders of 512 * 512 = 262144 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1         979      250608    6  FAT16

CF works in Canon and Windows XP. *shrug*
I believe it's formatted in Canon.

Feel free to ask more info.

# dosfsck -V fatflash.bin 
dosfsck 2.8, 28 Feb 2001, FAT32, LFN
Starting check/repair pass.
Starting verification pass.
fatflash.bin: 34 files, 5481/62586 clusters

that was dosfstools-2.8-15 from Fedora.
So I can't even fsck the stupid thing so it could  be mounted. 

-- 

