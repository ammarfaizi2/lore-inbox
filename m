Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTI1V6W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTI1V6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:58:22 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:7825 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S262770AbTI1V6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:58:12 -0400
Subject: ICH5 SATA trouble when booting from harddisk, not floppy
	(2.4.22-ac4)
From: Martin List-Petersen <martin@list-petersen.se>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8XdjuJAWxozh/zDlhA1+"
Message-Id: <1064786271.16565.27.camel@loke>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 28 Sep 2003 23:57:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8XdjuJAWxozh/zDlhA1+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've recently run into trouble with an ICH5 based motherboard.

When i try to boot from harddisk. The kernel would fail by endless
stating:
kmod: failed to exec /sbin/modprobe -s -k binfmt-0000, errno =3D 8
on screen.

Now the funny thing is, if I boot the same kernel from a bootdisk
(syslinux + kernel) i don't get into trouble. It'll boot the machine
just fine.

We are talking a vanilla 2.4.22 with ac4 patch (ac1 had the same
behavior, i updated to ac4 to see, if that changed anything, but didn't
help).=20

Here is the section from ICH5 IDE starting up (floppy):

Uniform Multi-Platform E-IDE driver Revision: 7.00beta5-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH5: IDE controller at PCI slot 00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
hdd: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: attached ide-cdrom driver.
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
ata_piix version 0.94
PCI: Setting latency timer of device 00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 18
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 18
ata1: bus reset via SRST
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:=
207f
ata1: dev 0 ATA, max UDMA/133, 234375000 sectors (lba48)
ata1: dev 0 configured for UDMA/133
ata2: port disabled. ignoring.
ata2: thread exiting
scsi0 : ata_piix
scsi1 : ata_piix
  Vendor: ATA       Model: ST3120026AS       Rev: 0.71
  Type:   Direct-Access                      ANSI SCSI revision: 05
libata version 0.71 loaded.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 234375000 512-byte hdwr sectors (120000 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2

The kernel on the syslinux floppy and on the harddisk are the identical bin=
aries. I also tried an isolinux boot,
which also works. It's just failing when booting from the harddisk.

Please cc me on replies, i'm not on the list at the moment. Any ideas
what i can test or hints in the right direction are appretiated.

Regards,
Martin List-Petersen
martin at list-petersen dot se
--
Hhhmmmmmmmm
waterbeds for cows
eleet
Culus: why would a cow need a waterbed?
cas: To be comfy warm

--=-8XdjuJAWxozh/zDlhA1+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/d1lezAGaxP8W1ugRArjiAJ9fopc3gyy/n/vr59CbLp8VfFtbMgCgxKjw
TFsab6NjQCA1tVwmRfVNVeg=
=K8UJ
-----END PGP SIGNATURE-----

--=-8XdjuJAWxozh/zDlhA1+--

