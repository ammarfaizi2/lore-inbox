Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131517AbRAVRK0>; Mon, 22 Jan 2001 12:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132379AbRAVRKQ>; Mon, 22 Jan 2001 12:10:16 -0500
Received: from rkstest.urz.tu-dresden.de ([141.30.66.133]:40849 "HELO
	POP3.tu-dresden.de") by vger.kernel.org with SMTP
	id <S131517AbRAVRKJ>; Mon, 22 Jan 2001 12:10:09 -0500
From: ujr@physik.phy.tu-dresden.de (Ulf Jaenicke-Roessler)
Message-Id: <10101221709.AA27602@physik.phy.tu-dresden.de>
Subject: hda: dma_intr: errors
To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2001 18:09:15 +0100 (MET)
X-Mailer: ELM [version 2.5 PL2]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please Cc: me for replies, as I'm currently not subscribed. Thanks.)

Hello,

 with 2.4.0 I get lots of

kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

 errors. I already got those errors with the -test series.
 The current 2.2.x kernels (2.2.18/2.2.19p7) do not show this
 behaviour.
 It's a VIA motherboard with the following IDE config:

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide0: VIA Bus-Master (U)DMA Timing Config Success
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
ide1: VIA Bus-Master (U)DMA Timing Config Success
hda: IBM-DJNA-351520, ATA DISK drive
hdb: NEC CD-ROM DRIVE:282, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: IBM-DJNA-351520, 14664MB w/430kB Cache, CHS=1869/255/63

 Any hint what I can do about this? I use simply

CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

 in my .config.

 Thanks!
  Ulf

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
