Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSK0NDQ>; Wed, 27 Nov 2002 08:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSK0NDQ>; Wed, 27 Nov 2002 08:03:16 -0500
Received: from services.cam.org ([198.73.180.252]:12733 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S262464AbSK0NDO>;
	Wed, 27 Nov 2002 08:03:14 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: reiserfs-list@namesys.com
Subject: Reiserfs fs corruption with 2.5.49 
Date: Wed, 27 Nov 2002 08:10:06 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211270810.06553.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing reiserfs (3.6 r5 hash) fs corruption in 2.5.49

oscar% ls alsa*
zsh: no matches found: alsa*
oscar% ls mod*
alsa-driver-0.9+0beta4-4
oscar% rm "alsa-driver-0.9+0beta4-4"
rm: cannot remove `alsa-driver-0.9+0beta4-4': No such file or directory

The fs with the above error passed an reiserfsck (3.6.4) 2 and a half days 
ago (just before the last reboot) - when I had to do a rebuild tree after 
booting 2.5.49-mm1, which did oops.  Looks like the bug is not just in -mm1 
though.

System is still booted.  The log is clean - no oops or other tracebacks.
System is a K3-2 400 on a via mvp3 MB.

ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP KA13.6, ATA DISK drive
hda: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
hdd: HP COLORADO 20GB, ATAPI TAPE drive
hdc: DMA disabled
hdd: DMA disabled
ide1 at 0x170-0x177,0x376 on irq 15
PDC20267: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 12 for device 00:09.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xeb000000
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:DMA
hde: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide2 at 0xac00-0xac07,0xb002 on irq 12
hdg: QUANTUM FIREBALLP AS40.0, ATA DISK drive
ide3 at 0xb400-0xb407,0xb802 on irq 12
hda: host protected area => 1
hda: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=1684/255/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 >
hde: host protected area => 1
hde: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)
 hde: hde1 hde2 hde3 hde4 < hde5 >
hdg: host protected area => 1
hdg: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=77557/16/63, UDMA(100)

What info can I gather before fixing this fs?

Ed Tomlinson

