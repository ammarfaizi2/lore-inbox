Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVDOHey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVDOHey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 03:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVDOHey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 03:34:54 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:24037 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261759AbVDOHet convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 03:34:49 -0400
Message-ID: <33007639.1113550489129.JavaMail.tomcat@pne-ps4-sn1>
Date: Fri, 15 Apr 2005 09:34:49 +0200 (MEST)
From: gabriel <gabriel.j@telia.com>
Reply-To: gabriel <gabriel.j@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Sv: RE: Booting from USB with initrd
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: CP Presentation Server
X-clientstamp: [83.227.221.136]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um yes it is.
How could I otherwise have booted far enough to get the panic?
My boot partition is on the usb I cant boot from hard drive.

----Ursprungligt meddelande----
Från: Jason.Jones@monteith2.areur.army.mil
Datum: Apr 15, 2005 9:29:06 AM
Till: gabriel <gabriel.j@telia.com>
Ärende: RE: Booting from USB with initrd

Is USB even an option to boot off of in the BIOS?  How could the OS boot to
something that isn't detected in the bios?  IMHO.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of gabriel
Sent: Friday, April 15, 2005 9:28 AM
To: linux-kernel@vger.kernel.org
Subject: Booting from USB with initrd

Hi Im trying to boot an encrypted file system using an initrd on a USB. 
I use syslinux for the actual boot process as I couldnt get Grub to boot
of it for some reason. This is the .cfg

 default vmlinuz
 timeout 100
 prompt 1
 label linux
 kernel vmlinuz
 append initrd=/initrd.gz root=/dev/ram0 rootfstype=minix init=/linuxrc

As far as I can tell this should load the initrd but that never happens.
Everything seems to boot fine. Syslinux loads the kernel and I get to 
the point where initrd should be mounted only to get this error.

Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
followed by the USB information and stop.
<5> Vendor SWISSBIT Mode: Victorinox 2.0 Rev 2.00
Type Direct-Access ANSI SCSI Revision: 02
SCSI device sdb: 1022720 512 byte hdwr sectors (524mb)
sdb: Write Protect is off
sdb: asuming driver cache: write-through

I have support for minix, vfat, ext2 and ext3 in the kernel. I have
recompiled the 
kernel 
like 20 times to test different things. So what Im thinking is that the 
USB device doesn't 
get realized before syslinux tries to load it?

Oh I do have the ramdisk in the kernel and everything.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



