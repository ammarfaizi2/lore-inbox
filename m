Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315788AbSEDIjx>; Sat, 4 May 2002 04:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315789AbSEDIjw>; Sat, 4 May 2002 04:39:52 -0400
Received: from moutvdomng0.kundenserver.de ([212.227.126.180]:53960 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S315788AbSEDIjw>; Sat, 4 May 2002 04:39:52 -0400
Date: Sat, 4 May 2002 10:45:02 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Cc: jamagallon@able.es, andre@linux-ide.org
Subject: Re: ide-convert-9 oops on boot
Message-ID: <20020504084502.GA979@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, jamagallon@able.es,
	andre@linux-ide.org
In-Reply-To: <20020504022433.GA1803@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
User-Agent: Mutt/1.5.1i (Linux 2.4.19-pre7 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat May 04 2002, J.A. Magallon wrote:

> Just patched pre8 with ide-convert-9, and system hangs on boot:

Exactly the same thing here. You're not alone ;)

[....]
Journalled Block Device driver loaded
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DHEA-36481, ATA DISK drive
hdb: Conner Peripherals 1275MB - CFS1275A, ATA DISK drive
hdc: CD-540E, ATAPI CD/DVD-ROM drive
hdd: CD-W54E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=790/255/63, UDMA(33)
hdb: 2496876 sectors (1278 MB) w/64KiB Cache, CHS=619/64/63, DMA
[....]

chiara:~ # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 41)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:11.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)

chiara:~ cat /proc/ide/via

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x41 IDE 0x6
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xe000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       DMA      UDMA       DMA
Address Setup:       30ns      30ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:          60ns     120ns      60ns     120ns
Transfer Rate:   33.3MB/s  16.6MB/s  33.3MB/s  16.6MB/s

-- 
# Heinz Diehl, 68259 Mannheim, Germany
