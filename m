Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbTDITlP (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbTDITlP (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:41:15 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:33005 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263709AbTDITlM (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 15:41:12 -0400
Date: Wed, 9 Apr 2003 21:58:29 +0200
From: Dominik Brodowski <linux@brodo.de>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.67-ac1 IDE trouble
Message-ID: <20030409195829.GA4586@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

In recent 2.5. kernels I see a few messages like this during heavy I/O load:

hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt

Doubt it's a hardware issue - fairly new HD, s.m.a.r.t tells of no problems,
earlier kernels (esp. 2.5.54-bkX) work fine.

CONFIG_PREEMPT is on, btw.

Some more info:

Linux version 2.5.67-ac1 (linux@mondschein) (gcc version 3.2) #2 Tue Apr 8 23:35:23 CEST 2003
...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L080AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STDVD-ROM GDR8161B, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST GCE-8480B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63, UDMA(100)
 hda: [PTBL] [10011/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >

---

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE]
02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)


	Dominik
