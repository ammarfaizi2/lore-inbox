Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271283AbRH1TFB>; Tue, 28 Aug 2001 15:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271611AbRH1TEw>; Tue, 28 Aug 2001 15:04:52 -0400
Received: from pa42.warszawa.sdi.tpnet.pl ([213.25.213.42]:4612 "HELO
	pa42.warszawa.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id <S271283AbRH1TEj>; Tue, 28 Aug 2001 15:04:39 -0400
Date: Tue, 28 Aug 2001 21:04:26 +0200
From: Piotrek Kaczmarek <kaczorek@msg.beta.pl>
To: linux-kernel@vger.kernel.org
Subject: VIA VT82C416MV support
Message-ID: <20010828210426.A278@msg.beta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I use 2.4.10-pre1-xfs series kernel (cvs checkout 2001-08-28)
on a P133 based on a motherboard (don't remeber the manufacturer) 
with some VIA IDE controller, which seems to be
PCI_IDE: unknown IDE controller on PCI bus 00 device 08, VID=1106, DID=1571
for IDE driver....
VIA_82CXXX suport is compiled in kernel

Unfortunately i was unable to use UDMA33 mode with my
FUJITSU MPF3204AT, ATA DISK drive (20496MB w/512KiB Cache)
Aug 22 22:32:49 vigo kernel: ide0: unexpected interrupt, status=0x58, count=2
Aug 22 22:33:03 vigo kernel: ide0: unexpected interrupt, status=0x58, count=3
Aug 22 22:33:12 vigo kernel: ide0: unexpected interrupt, status=0x58, count=4
Aug 22 22:33:22 vigo kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Aug 22 22:33:22 vigo kernel: hda: lost interrupt
Aug 22 22:33:22 vigo kernel: hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
Aug 22 22:33:22 vigo kernel: hda: status timeout: status=0xd0 { Busy }
Aug 22 22:33:22 vigo kernel: hda: DMA disabled
Aug 22 22:33:22 vigo kernel: ide0: unexpected interrupt, status=0xd0, count=5
Aug 22 22:33:22 vigo kernel: hda: drive not ready for command
Aug 22 22:33:22 vigo kernel: ide0: reset: success

Here's my lspci -vvv output
00:01.0 IDE interface: VIA Technologies, Inc. VT82C416MV (rev 04) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 6000 [size=16]
Is that controller supported in 2.4 kernels ? or maybe i am missing something?

I'd be appreciated for any response

Cheers,
kaczorek

P.S.
sorry for my terrible english
please CC, i'm not subscribing l-k

-- 
kaczorek
