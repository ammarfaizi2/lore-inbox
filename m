Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRAPD2H>; Mon, 15 Jan 2001 22:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbRAPD14>; Mon, 15 Jan 2001 22:27:56 -0500
Received: from isunix.it.ilstu.edu ([138.87.124.103]:36614 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S129641AbRAPD1v>; Mon, 15 Jan 2001 22:27:51 -0500
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200101160258.UAA04062@isunix.it.ilstu.edu>
Subject: IDE not fully found (2.4.0)
To: linux-kernel@vger.kernel.org
Date: Mon, 15 Jan 2001 20:58:06 -0600 (CST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just built a new system with Linux-2.4.0.

Motherboard (MSI 694D-AR) has Via Apollo Pro chipset, those IDE drives seem
fine.  Board also has a promise PDC20265  RAID/ATA100 controller.  On each
channel of this controller I have an IBM 45 GB ATA100 drive as master.
(hde and hdg?).  BIOS sees these drives fine.  Linux only see hde and never
hdg (ide[012] but not ide3).  I thought I'd post it here, in case anyone
else knew the answer right away.  

Second question:  Does the RAID functionality of this device work under
linux?  If so, is it better than LVM or MD?

boot snippet:
---------------
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 60
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
