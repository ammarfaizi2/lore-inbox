Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129380AbQKQAnV>; Thu, 16 Nov 2000 19:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129941AbQKQAnL>; Thu, 16 Nov 2000 19:43:11 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:47242 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129380AbQKQAmw>; Thu, 16 Nov 2000 19:42:52 -0500
Message-Id: <5.0.0.25.2.20001116182436.00ab3160@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Fri, 17 Nov 2000 00:13:18 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: How to add a drive to DMA black list?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have an ide hard drive that misbehaves when the option "enable DMA at 
boot time" (2.4.x kernel) is selected (this is on a on board ide 
controller). But on the other hand I have a Promise Ultra-ATA-100 
controller with an IBM ATA-100 drive that, according to the menuconfig 
information and the information at the top of the driver requires the 
"enable DMA at boot time" feature to be selected.

I tried adding the string that is output for the bad drive by hdparm -i 
into drivers/ide/ide-dma.c::drive_blacklist and 
drivers/ide/ide-dma.c::bad_dma_drives but the kernel still says that it is 
using DMA and the kernel hangs after displaying:

PIIX: chipset revision 2
PIIX: not 100% native mode: will probe irqs later
[snip]
PDC20267: IDE controller on PCI bus 00 dev 98
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
[snip]
hdc: Conner Peripherals 1275MB - CFS1275A, ATA DISK drive
hde: IBM-DTLA-307045, ATA DISK drive
[snip]
hdc: 2496876 sectors (1278 MB) w/64KiB Cache, CHS=2477/16/63, DMA
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63. UDMA(100)
Partition check:
  hda: hda1 hda2 < hda5 >
  hdc:hdc: timout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
_
Dead.

What should I do? Thanks in advance,

Anton

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
