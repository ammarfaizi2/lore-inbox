Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTK1OEb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTK1OEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:04:31 -0500
Received: from math.ut.ee ([193.40.5.125]:57544 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262228AbTK1OE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:04:26 -0500
Date: Fri, 28 Nov 2003 16:04:15 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: gibbs@scsiguy.com, <linux-kernel@vger.kernel.org>
Subject: aic7xxx problem on sparc64 (2.6)
Message-ID: <Pine.GSO.4.44.0311281452110.6614-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I inserted my known working 2940 (7880) into a Sun Ultra 5 (32-bit PCI).
modprobe aic7xxx gave some errors and asked to report the bug.
modprobe sd_mod gave a lot more errors and put the disk offline. The
same hardware (host, HBA and disk) works fine with latest 2.4 kernel
(2.4.23-rc5 currently). The problem is with 2.6.0-test11.


PROMLIB: Sun IEEE Boot Prom 3.25.3 2000/06/29 14:12
Linux version 2.6.0-test11 (mroos@mandariin) (gcc version 3.3.2 (Debian)) #38 Thu Nov 27 12:26:42 EET 2003
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
On node 0 totalpages: 40491
  DMA zone: 40491 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 ro
PID hash table entries: 2048 (order 11: 32768 bytes)
Console: colour dummy device 80x25
Memory: 317760k available (1872k kernel code, 552k data, 144k init) [fffff80000000000,000000001ff46000]
Calibrating delay loop... 719.25 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 8192 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Probing for controllers.
PCI: Found SABRE, main regs at 000001fe00000000, wsync at 000001fe00001c20
SABRE: Shared PCI config space at 000001fe01000000
SABRE: DVMA at c0000000 [20000000]
PCI-IRQ: Routing bus[ 2] slot[ 1] map[0] to INO[10]
PCI-IRQ: Routing bus[ 2] slot[ 2] map[0] to INO[14]
PCI-IRQ: Routing bus[ 2] slot[ 3] map[0] to INO[18]
PCI0(PBMA): Bus running at 33MHz
PCI-IRQ: Routing bus[ 1] slot[ 1] map[0] to INO[21]
PCI-IRQ: Routing bus[ 1] slot[ 2] map[0] to INO[0f]
PCI-IRQ: Routing bus[ 1] slot[ 3] map[0] to INO[20]
PCI0(PBMB): Bus running at 33MHz
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree] [eeprom] [flashprom] [SUNW,CS4231]
power: Control reg at 000001fff1724000 ... powerd running.
atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 4M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
fb0: ATY Mach64 frame buffer device on PCI
Initializing Cryptographic API
Console: switching to mono PROM 80x34
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
rtc_init: no PC rtc found
su0 at 0x000001fff13062f8 (irq = 4,7ea) is a 16550A
su1 at 0x000001fff13083f8 (irq = 9,7e9) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
sunhme.c:v2.02 24/Aug/2003 David S. Miller (davem@redhat.com)
divert: allocating divert_blk for eth0
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:f8:c7:72
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
CMD646: IDE controller at PCI slot 0000:01:03.0
CMD646: chipset revision 3
CMD646: chipset revision 0x03, MultiWord DMA Force Limited
CMD646: 100% native mode on irq 4,7e0
    ide0: BM-DMA at 0x1fe02c00020-0x1fe02c00027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1fe02c00028-0x1fe02c0002f, BIOS settings: hdc:pio, hdd:pio
hda: ST38410A, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1fe02c00000-0x1fe02c00007,0x1fe02c0000a on irq 4,7e0
hdc: CRD-8322B, ATAPI CD/DVD-ROM drive
ide1 at 0x1fe02c00010-0x1fe02c00017,0x1fe02c0001a on irq 4,7e0 (shared with ide0)
hda: max request size: 128KiB
hda: 16841664 sectors (8622 MB) w/512KiB Cache, CHS=16708/16/63, (U)DMA
 hda: hda1 hda2 hda3
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
input: su/serio1/input on su/serio1
input: Sun Mouse on su/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Adding 944984k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ohci_hcd 0000:02:02.0: OHCI Host Controller
ohci_hcd 0000:02:02.0: irq 10,7d4, pci mem 000001ff00004000
ohci_hcd 0000:02:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:02:02.0: WARNING: OPTi workarounds unavailable
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
NET: Registered protocol family 15
NET: Registered protocol family 10
Disabled Privacy Extensions on device 000000000062bc00(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
nfs warning: mount version older than kernel
eth0: no IPv6 routers present
SCSI subsystem initialized
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:2:0): data overrun detected in Data-in phase.  Tag == 0x6.
(scsi0:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 1.
sg[0] - Addr 0x0c3fee0c0 : Length 32
scsi0:A:2:0: DV failed to configure device.  Please file a bug report against this driver.
(scsi0:A:2): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: FUJITSU   Model: M2954ESP SUN4.2G  Rev: 2545
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
SCSI device sda: 8385121 512-byte hdwr sectors (4293 MB)
scsi0:0:2:0: Attempting to queue an ABORT message
CDB: 0x1a 0x0 0x8 0x0 0x4 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State in Data-in phase, at SEQADDR 0x73
Card was paused
ACCUM = 0x4, SINDEX = 0xb8, DINDEX = 0xa8, ARG_2 = 0xff
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x46] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x40]
SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x88] SEQCTL[0x10]
SEQ_FLAGS[0x20] SSTAT0[0x7] SSTAT1[0x3] SSTAT2[0x17]
SSTAT3[0x1] SIMODE0[0x0] SIMODE1[0xac] SXFRCTL0[0xa8]
DFCNTRL[0x0] DFSTATUS[0x29]
STACK: 0x0 0x169 0x199 0x6e
SCB count = 8
Kernel NEXTQSCB = 6
Card NEXTQSCB = 6
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
Sequencer SCB Info:
  0 SCB_CONTROL[0x68] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0x7]
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
Pending list:
  7 SCB_CONTROL[0x68] SCB_SCSIID[0x27] SCB_LUN[0x0]
Kernel Free SCB list: 5 4 3 2 1 0
DevQ(0:2:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi0:0:2:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi0:0:2:0: Attempting to queue a TARGET RESET message
CDB: 0x1a 0x0 0x8 0x0 0x4 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
(scsi0:A:2:0): data overrun detected in Data-in phase.  Tag == 0x6.
(scsi0:A:2:0): Have seen Data Phase.  Length = 0.  NumSGs = 1.
sg[0] - Addr 0x0c3fee0c0 : Length 32
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 2 lun 0
sda: asking for cache data failed
sda: assuming drive cache: write through
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0

-- 
Meelis Roos (mroos@linux.ee)


