Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbTEYTws (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 15:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTEYTws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 15:52:48 -0400
Received: from smtp2.poczta.onet.pl ([213.180.130.30]:36481 "EHLO
	smtp2.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S263709AbTEYTwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 15:52:45 -0400
Message-ID: <000901c322f9$17eff9f0$928afea9@hal>
From: "Gutko" <gutko@poczta.onet.pl>
To: <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Still no DMA on boot on S-ATA (Asus A7N8X-deluxe)
Date: Sun, 25 May 2003 22:06:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware:
Asus A7N8X -deluxe v1.04 bios 1004
SI3112A sata chipset
IBM vancouver2 180GXP pata drive connected to sata trough Asus sata<->pata
converter
Kernel 2.4.21-rc3 (and all older 2.4.x with sata support)

Why my hdd is always detected as PIO?
I can enable udma5 using hdparm, later in rc.local but why it is not working
on boot?

----------DMESG-----------
Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100
controller on pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA at 0xe0f54000-0xe0f54007, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xe0f54008-0xe0f5400f, BIOS settings: hdg:pio, hdh:pio
hdc: LITE-ON LTR-48125S, ATAPI CD/DVD-ROM drive
hdd: HL-DT-STDVD-ROM GDR8160B, ATAPI CD/DVD-ROM drive
hde: IC35L180AVV207-1, ATA DISK drive
hdg: no response (status = 0xfe)
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xe0f54080-0xe0f54087,0xe0f5408a on irq 11
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 361882080 sectors (185284 MB) w/7965KiB Cache, CHS=22526/255/63


------------
hdparm -i /dev/hde
dma enabled manually

 Model=IC35L180AVV207-1, FwRev=V26OA60F, SerialNo=VNVF01G6G0VZ9D
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=DualPortCache, BuffSize=7965kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:  2 3 4 5 6



