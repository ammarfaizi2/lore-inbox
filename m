Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSLMJLb>; Fri, 13 Dec 2002 04:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSLMJL3>; Fri, 13 Dec 2002 04:11:29 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:64656 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S261693AbSLMJKT>;
	Fri, 13 Dec 2002 04:10:19 -0500
Date: Thu, 12 Dec 2002 08:14:53 -0300
From: Aryix <aryix@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: via82cxxx probable incorrect detection (urgency=low)........
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Face: =)
X-Operating-System: Debian GNU/Linux (forever)
User-Agent: Ke paso maestro?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3DF9A5CE.00001047@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am Argentino <- i don't speak english, please be patient

Kernel-2.4.20-final

lspci -vvv

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8
a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



cat /proc/pci
 Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 33).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xd000 [0xd00f].

dmesg 

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx <- is my error?
VP_IDE: VIA vt82c686a (rev 21) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLlct20 30, ATA DISK drive
hdc: ST36421A, ATA DISK drive
hdd: ATAPI 44X CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c030a5c4, I/O limit 4095Mb (mask 0xffffffff)
hda: 58633344 sectors (30020 MB) w/418KiB Cache, CHS=3649/255/63, (U)DMA <- ??????????
blk: queue c030a928, I/O limit 4095Mb (mask 0xffffffff)
hdc: 12596850 sectors (6450 MB) w/256KiB Cache, CHS=13330/15/63, UDMA(66) <- this is ok
hdd: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33) <- ok!

i have a chip via82c686a (Epox 7-kxa)
at boot time is been detected via82c686a
proc says via82c586b
lspci -vvv no says 
the udma capabilities is not work propetly i set manually with "hdparm -m 8 -W 1 -X udma5 /dev/hda"
whats happening here?

-- 
/root/.gnupg/pubring.gpg
------------------------
pub  1024D/BE8E00BE 2002-12-06 Aryix Berius (nothing.........) <aryix@softhome.net>
     Key fingerprint = 249D C5BC 8B9A C46A C7F4  397D 2A6D 9FF6 BE8E 00BE
sub  2048g/C1C6CB29 2002-12-06

