Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTAHBb0>; Tue, 7 Jan 2003 20:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbTAHBb0>; Tue, 7 Jan 2003 20:31:26 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:32129 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S267361AbTAHBbZ>; Tue, 7 Jan 2003 20:31:25 -0500
Date: Wed, 8 Jan 2003 02:40:05 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.5.54: ide-scsi still buggy?
Message-ID: <20030108014005.GC725@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ide-scsi emulation does not work for drive /dev/hdg, why?

kernel boot parameters:
kernel /boot/vmlinuz-2.5.54bk3 ro root=/dev/hda1 ide=reverse vga=4 hdg=ide-scsi

It freezes kernel (sysrq do nothing) after lines:
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W512EB         Rev: 2
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi scan: host 0 channel 0 id 0 lun 0 identifier too long, length 60, max 50. Device might be improperly identified.

while attaching it to /dev/hde works ok. Why?

PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:DMA, hdd:pio
hda: ST380021A, ATA DISK drive
ide0 at 0x9000-0x9007,0x8802 on irq 10
hdc: IBM-DTLA-307045, ATA DISK drive
ide1 at 0x8400-0x8407,0x8002 on irq 10
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:DMA, hdh:pio
hde: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hde: DMA disabled
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
hdg: CD-W512EB, ATAPI CD/DVD-ROM drive
hdg: DMA disabled
^^^^^^^^^^^^^^^^^

hdparm reports:
/dev/hde:
 HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device
  IO_support   =  1 (32-bit)
  unmaskirq    =  1 (on)
  using_dma    =  1 (on)

-- 
Luká¹ Hejtmánek
