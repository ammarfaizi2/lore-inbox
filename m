Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUJWO3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUJWO3u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUJWO3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:29:50 -0400
Received: from eva.fit.vutbr.cz ([147.229.10.14]:63245 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S261197AbUJWO3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:29:11 -0400
Date: Sat, 23 Oct 2004 16:29:06 +0200
From: David Jez <dave.jez@seznam.cz>
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: PCI & IRQ problems on TI Extensa 600CD
Message-ID: <20041023142906.GA15789@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi Martin,

  i spent few last nights with my Extensa. This notebook has PCI 2.1 wich
works only under m$ window$ :-(. I tried many version of kernel, 2.2,
2.4 and 2.6 tree and nothing helps me. I tried pci=bios pci=bios,biosirq
kernel options, PCI=BIOS instead of ANY...
  Result is always same:
PCI: No IRQ known for interrupt pin A of device 00:04.0.
  this cause for example that PCMCIA doesn't work. See attached dmesg log
and other files for details.
  In Window$ everythink works OK and IRQ routing table is get from PCI
BIOS.

  Any ideas?
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.18 (root@midas) (gcc version 2.95.3 20010315 (release)) #1 Wed Jun 5 11:31:58 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f1dfc - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000002800000 (usable)
 BIOS-e820: 00000000ffff1dfc - 0000000100000000 (reserved)
On node 0 totalpages: 10240
zone(0): 4096 pages.
zone(1): 6144 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1 rw pci=biosirq reboot=fast BOOT_IMAGE=vmlinuz
Initializing CPU#0
Detected 165.786 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 330.95 BogoMIPS
Memory: 36844k/40960k available (1955k kernel code, 3728k reserved, 553k data, 264k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xf7019, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device 11, VID=10b9, DID=5219
PCI: No IRQ known for interrupt pin A of device 00:02.1.
PCI_IDE: chipset revision 32
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:pio, hdd:pio
hda: TOSHIBA MK6017MAP, ATA DISK drive
hdc: UJDCD6700, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 11733120 sectors (6007 MB), CHS=776/240/63, (U)DMA
hdc: ATAPI 6X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 hda: hda1 hda4
paride: aten registered as protocol 0
paride: bpck registered as protocol 1
paride: comm registered as protocol 2
paride: dstr registered as protocol 3
paride: epat registered as protocol 4
paride: epia registered as protocol 5
paride: frpw registered as protocol 6
paride: friq registered as protocol 7
paride: fit2 registered as protocol 8
paride: fit3 registered as protocol 9
paride: k951 registered as protocol 10
paride: k971 registered as protocol 11
paride: ktti registered as protocol 12
paride: on20 registered as protocol 13
paride: on26 registered as protocol 14
pd: pd version 1.05, major 45, cluster 64, nice 0
epat_init_protopda: Autoprobe failed
pd: no valid drive found
pcd: pcd version 1.07, major 46, nice 0
epat_init_protopcd0: Autoprobe failed
pcd: No CD-ROM drive found
pf: pf version 1.04, major 47, cluster 64, nice 0
epat_init_protopf0: Autoprobe failed
pf: No ATAPI disk detected
pg: pg version 1.02, major 97
epat_init_protopg0: Autoprobe failed
pg: No ATAPI device detected
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
ppa: Version 2.07 (for Linux 2.4.x)
WARNING - no ppa compatible devices found.
  As of 31/Aug/1998 Iomega started shipping parallel
  port ZIP drives with a different interface which is
  supported by the imm (ZIP Plus) driver. If the
  cable is marked with "AutoDetect", this is what has
  happened.
imm: Version 2.05 (for Linux 2.4.0)
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 11:33:38 Jun  5 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :    60.000 MB/sec
   32regs    :    76.800 MB/sec
raid5: using function: 32regs (76.800 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.1-rc4(ish)(03/10/2001)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
UMSDOS 0.86k (compatibility level 0.4, fast msdos)
check_pseudo_root: mounted as root
check_pseudo_root: found //linux
check_pseudo_root: found sbin/init, enabling pseudo-root
UMSDOS: changed to alternate root
VFS: Mounted root (umsdos filesystem).
Freeing unused kernel memory: 264k freed
Adding Swap: 504k swap-space (priority -1)
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Linux PCMCIA Card Services 3.1.33
  kernel build: 2.4.18 #1 Wed May 8 13:51:37 PDT 2002
  options:  [pci] [cardbus]
Intel ISA/PCI/CardBus PCIC probe:
PCI: No IRQ known for interrupt pin A of device 00:04.0.
PCI: No IRQ known for interrupt pin B of device 00:04.1.
  TI 1130 rev 04 PCI-to-CardBus at slot 00:04, mem 0x2800000
    host opts [0]: [isa irq] [no pci irq] [lat 64/176] [bus 1/5]
    host opts [1]: [isa irq] [no pci irq] [lat 64/176] [bus 6/10]
    ISA irqs (scanned) = 5,7,9,10,11,12 polling interval = 1000 ms
UMSDOS_notify_change: //linux not in EMD, ret=-2

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1521 [Aladdin III] (rev 1c)
00:02.0 ISA bridge: Acer Laboratories Inc. [ALi] M1523 (rev 07)
00:02.1 IDE interface: Acer Laboratories Inc. [ALi] M5219 (rev 20)
00:04.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
00:04.1 CardBus bridge: Texas Instruments PCI1130 (rev 04)
00:06.0 VGA compatible controller: Chips and Technologies F65550 (rev 45)

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-vvvnx

00:00.0 Class 0600: 10b9:1521 (rev 1c)
	Subsystem: 10b9:1521
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
00: b9 10 21 15 06 00 00 24 1c 00 00 06 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 21 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 Class 0601: 10b9:1523 (rev 07)
	Subsystem: 10b9:1523
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0
00: b9 10 23 15 0f 00 00 32 07 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 23 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.1 Class 0101: 10b9:5219 (rev 20) (prog-if fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at fcf0 [size=16]
00: b9 10 19 52 05 00 80 02 20 fa 01 01 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: f1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 02 04

00:04.0 Class 0607: 104c:ac12 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 04
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 02800000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=05, sec-latency=176
	Memory window 0: fffff000-00000000
	Memory window 1: fffff000-00000000
	I/O window 0: 0000fffc-00000003
	I/O window 1: 0000fffc-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001
00: 4c 10 12 ac 07 00 00 02 04 00 07 06 04 40 82 00
10: 00 00 80 02 00 00 00 02 00 01 05 b0 00 f0 ff ff
20: 00 00 00 00 00 f0 ff ff 00 00 00 00 fc ff 00 00
30: 00 00 00 00 fc ff 00 00 00 00 00 00 ff 01 c0 00
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 Class 0607: 104c:ac12 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 04
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at 02802000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=0a, sec-latency=176
	Memory window 0: 00000000-00000000
	Memory window 1: fffff000-00000000
	I/O window 0: 0000fffc-00000003
	I/O window 1: 0000fffc-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001
00: 4c 10 12 ac 07 00 00 02 04 00 07 06 04 40 82 00
10: 00 20 80 02 00 00 00 22 00 06 0a b0 00 00 00 00
20: 00 00 00 00 00 f0 ff ff 00 00 00 00 fc ff 00 00
30: 00 00 00 00 fc ff 00 00 00 00 00 00 ff 02 c0 00
40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Class 0300: 102c:00e0 (rev 45)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=256K]
00: 2c 10 e0 00 83 00 80 02 45 00 00 03 00 00 00 00
10: 00 00 00 fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--oyUTqETQ0mS9luUI
Content-Type: application/x-gtar
Content-Disposition: attachment; filename="proc.tgz"
Content-Transfer-Encoding: base64

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
wMDAwMDAwOB5xf8BuVWxvwB4AAA=

--oyUTqETQ0mS9luUI--
