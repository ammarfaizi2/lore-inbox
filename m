Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284460AbRL2Q2U>; Sat, 29 Dec 2001 11:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284944AbRL2Q2L>; Sat, 29 Dec 2001 11:28:11 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:62796 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S284876AbRL2Q2G>; Sat, 29 Dec 2001 11:28:06 -0500
Date: Sat, 29 Dec 2001 17:29:30 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.2-pre3] Harddisk Performance
Message-ID: <20011229162930.GA317@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24-current-20011226i (Linux 2.4.17-spc i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Running 2.5.2-pre3, hdparm shows up very poor harddisk performance
on my system compared to 2.4.x:

[Kernel 2.5.2-pre3]

elfie:~ # hdparm -tT /dev/hda

/dev/hda:
Timing buffer-cache reads:   128 MB in  1.77 seconds = 72.32 MB/sec
Timing buffered disk reads:  64 MB in 22.09 seconds =  2.90 MB/sec
                                                       ^^^^
[Kernel 2.4.17]

elfie:~ # hdparm -tT /dev/hda

/dev/hda:
Timing buffer-cache reads:   128 MB in  1.81 seconds = 70.72 MB/sec
Timing buffered disk reads:  64 MB in  6.61 seconds =  9.68 MB/sec
                                                       ^^^^
The tests were made under the same circumstances, of course, so no other
process can be the cause.

Here come the harddisk and system informations:

elfie:~ # hdparm -i /dev/hda

/dev/hda:

Model=IBM-DHEA-36481, FwRev=HP6OA20C, SerialNo=SG0SGFJ0623
Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
RawCHS=12592/16/63, TrkSize=0, SectSize=0, ECCbytes=28
BuffType=DualPortCache, BuffSize=472kB, MaxMultSect=16, MultSect=16
CurCHS=12592/16/63, CurSects=12692736, LBA=yes, LBAsects=12692736
IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4
DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2

Linux version 2.4.17 (root@elfie) (gcc version 2.95.3 20010315
(release)) #1 Sat Dec 29 12:05:30 CET 2001
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
No local APIC present or hardware disabled
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 hdc=ide-scsi
hdd=ide-scsi idebus=33
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
ide_setup: idebus=33
Initializing CPU#0
Detected 400.914 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 256696k/262144k available (841k kernel code, 5064k reserved,
216k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: L2 Cache: 256K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU:     After generic, caps: 008021bf 808029bf 00000000 00000002
CPU:             Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
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
Partition check:
	  hda: hda1 hda2 hda3 < hda5 hda6 >
 hdb: hdb1 < hdb5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Vendor: TEAC      Model: CD-540E           Rev: 3.0A
Type:   CD-ROM                             ANSI SCSI revision: 02
Vendor: TEAC      Model: CD-W54E           Rev: 1.1B
Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 130748k swap-space (priority -1)
[....]

elfie:~ # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 41)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:11.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)

-- 
# Heinz Diehl, 68259 Mannheim, Germany
