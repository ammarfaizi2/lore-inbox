Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315764AbSEDCYl>; Fri, 3 May 2002 22:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315765AbSEDCYk>; Fri, 3 May 2002 22:24:40 -0400
Received: from jalon.able.es ([212.97.163.2]:24001 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315764AbSEDCYj>;
	Fri, 3 May 2002 22:24:39 -0400
Date: Sat, 4 May 2002 04:24:33 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: ide-convert-9 oops on boot
Message-ID: <20020504022433.GA1803@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Just patched pre8 with ide-convert-9, and system hangs on boot:

PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Conner Peripherals 1080MB - CFS1081A, ATA DISK drive
hdb: CREATIVE CD5230E, ATAPI CD/DVD-ROM drive
hdc: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

<=======0 OOPS here, just got hung...
 <usual output follows >
hda: 2114180 sectors (1082 MB), CHS=524/64/63, DMA
ide-cd: passing drive hdb to ide-scsi emulation.
ide-cd: passing drive hdc to ide-scsi emulation.
ide-floppy driver 0.99.newide

If it is not a known problem, and anyone needs more info I can write
down the hex and decode it.

TIA

werewolf:/proc/ide# lspci
00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:0e.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev 01)
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 06)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev b2)

werewolf:/proc/ide# cat piix

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               no 
UDMA enabled:   no               no              no                no 
UDMA enabled:   X                X               X                 X
UDMA
DMA
PIO

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam9 #2 SMP mié may 1 12:09:38 CEST 2002 i686
