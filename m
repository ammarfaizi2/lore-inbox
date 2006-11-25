Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935120AbWKYBZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935120AbWKYBZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 20:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935119AbWKYBZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 20:25:13 -0500
Received: from bizon.gios.gov.pl ([212.244.124.8]:4558 "EHLO bizon.gios.gov.pl")
	by vger.kernel.org with ESMTP id S935120AbWKYBZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 20:25:12 -0500
Date: Sat, 25 Nov 2006 02:25:08 +0100 (CET)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: pata_via in 2.6.19-rc6: UDMA/66 hdd downgraded to UDMA/33
Message-ID: <Pine.LNX.4.64.0611250216550.26262@bizon.gios.gov.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-742963814-1164417908=:26262"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-742963814-1164417908=:26262
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello,

After upgrading to 2.6.19-rc6 and enabling experimental support of=20
pata_via noticed that my hdd was downgraded to UDMA/33:

Before (2.6.18-rc & via82cxxx):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override withidebus=3Dx=
x
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: VIA IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 16
VP_IDE: not 100%% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: max request size: 128KiB
hda: 40031712 sectors (20496 MB) w/512KiB Cache, CHS=3D39714/16/63, UDMA(66=
)
hda: cache flushes not supported
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >


Now (2.6.16-rc6 & pata_via):

pata_via 0000:00:07.1: version 0.1.14
ata1: PATA max UDMA/66 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata2: PATA max UDMA/66 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi0 : pata_via
ata1.00: ATA-5, max UDMA/66, 40031712 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/33
scsi1 : pata_via
ata2: port is slow to respond, please be patient (Status 0xff)
ata2: port failed to respond (30 secs, Status 0xff)
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: softreset failed, retrying in 5 secs
ata2: SRST failed (status 0xFF)
ata2: SRST failed (err_mask=3D0x100)
ata2: reset failed, giving up
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MPF3204A 0031 PQ: 0 ANSI: =
5
SCSI device sda: 40031712 512-byte hdwr sectors (20496 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 40031712 512-byte hdwr sectors (20496 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
sd 0:0:0:0: Attached scsi disk sda

# hdparm -I /dev/sda|grep dma
         DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

BTW: is it possible to do something with this annoying long delay with=20
the "port is slow to respond, please be patient" message? :)

Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-742963814-1164417908=:26262--
