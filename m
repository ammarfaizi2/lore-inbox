Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTEKPHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 11:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTEKPHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 11:07:13 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:11992 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S261580AbTEKPHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 11:07:11 -0400
Date: Sun, 11 May 2003 17:19:48 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PROBLEM: ide_floppy and 2.5.69
Message-Id: <20030511171948.1efa2ec8.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
X-Outlook: <html><form><input type crash></form></html>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.yJ?8E0eTJHy0ma"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.yJ?8E0eTJHy0ma
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

Someone already reported problems with ide-floppy in 2.5.69, but this seems to
be a slightly different issue. I'm not seeing timeouts, but the following
backtrace with an IDE Zip drive (hde) instead. Also strange is that I have
sector 0 read errors on the cdrom (hdf) during bootup.
Looks like it tries to read the partition table from a cdrom without cd.
See below.

-Regards,
-Udo.


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller at PCI slot 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x8000-0x8007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x8008-0x800f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: IC35L120AVV207-0, ATA DISK drive
ide0 at 0x9400-0x9407,0x9002 on irq 10
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:pio, hdf:DMA
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
hde: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdf: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
 hda: hda1
hdb: host protected area => 1
hdb: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=15017/255/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 >
end_request: I/O error, dev hdf, sector 0
hdf: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdf, sector 0
ide-floppy driver 0.99.newide
hde: 98304kB, 196608 blocks, 512 sector size
hde: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hde: hde1
 hde: hde1
Badness in kobject_register at lib/kobject.c:293
Call Trace:
 [<c020c968>] kobject_register+0x58/0x70
 [<c017c747>] register_disk+0x137/0x140
 [<c026609e>] add_disk+0x4e/0x60
 [<c0266020>] exact_match+0x0/0x10
 [<c0266030>] exact_lock+0x0/0x20
 [<c02a6def>] idefloppy_attach+0x16f/0x1a0
 [<c029b49f>] ata_attach+0x4f/0x120
 [<c029c3b5>] ide_register_driver+0xf5/0x110
 [<c02a6e3b>] idefloppy_init+0x1b/0x60
 [<c046272c>] do_initcalls+0x2c/0xa0
 [<c01288df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c010707d>] kernel_thread_helper+0x5/0x18

--=.yJ?8E0eTJHy0ma
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+vmoWnhRzXSM7nSkRAkMkAJ0RtNhq8xJZxstm1MDrQtz+gfiA5wCgga9c
NQdQCPA8edqI64euVxpEhI4=
=Pt3w
-----END PGP SIGNATURE-----

--=.yJ?8E0eTJHy0ma--
