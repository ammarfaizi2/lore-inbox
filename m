Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTJOEYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 00:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTJOEYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 00:24:42 -0400
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:23528 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id S262221AbTJOEYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 00:24:35 -0400
Message-Id: <200310150424.h9F4OXoE013702@nerd-xing.mit.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
cc: josh@MIT.EDU
Subject: nforce2 ide dma unstable on 2.4.22
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Oct 2003 00:24:33 -0400
From: Joshua Jacobs <josh@MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having problems getting a stable system up and running on my new Biostar 
AMD Nforce2 motherboard.  When hard disk DMA is not enabled, the system is 
slow but apparantly stable.

When I enable dma (hdparm -d 1 /dev/hda), the system crashes about once a day.

Google searches revaled problems with acpi/apic on nforce2 motherboards, so 
I've included the output of dmesg,lspci and the contents of /proc/interupts.  
(I tried disabling acpi/apic options in my kernel & bios in an effort to fix 
the problem.)

please cc me on any replies.  Thanks!

-Josh

josh@www:~$ lspci
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev 
c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:07.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
01:0a.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
02:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW 
[Radeon 7500]
josh@www:~$ dmesg
Linux version 2.4.22 (root@www) (gcc version 3.3.2 20030908 (Debian 
prerelease)) #8 SMP Mon Sep 22 07:12:09 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=303 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Found and enabled local APIC!
Initializing CPU#0
Detected 1830.024 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3643.80 BogoMIPS
Memory: 903336k/917504k available (2348k kernel code, 13780k reserved, 743k 
data, 184k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU0: AMD Athlon(tm) XP 2500+ stepping 00
per-CPU timeslice cutoff: 1462.76 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1830.0283 MHz.
..... host bus clock speed is 332.7323 MHz.
cpu: 0, clocks: 3327323, slice: 1663661
CPU0<T0:3327312,T1:1663648,D:3,S:1663661,C:3327323>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [10de/01e0] at 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Compaq SMART2 Driver (v 2.4.25)
HP CISS Driver (v 2.4.47)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
HDLC support module revision 1.11
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: nVidia Corporation nForce2 IDE (rev a2) UDMA100 controller on 
pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hdb: C/H/S=39236/16/255 from BIOS ignored
hda: Maxtor 6Y160P0, ATA DISK drive
hdb: Maxtor 4D080H4, ATA DISK drive
hdc: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
hdd: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63
hdb: attached ide-disk driver.
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63
hdd: attached ide-disk driver.
hdd: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1
 hdd: hdd1
Promise Fasttrak(tm) Softwareraid driver 0.03beta: No raid array found
Highpoint HPT370 Softwareraid driver for linux version 0.02
SCSI subsystem driver Revision: 1.00
Red Hat/Adaptec aacraid driver (1.1.2 Sep 22 2003 07:13:42)
DC390: 0 adapters found
3ware Storage Controller device driver for Linux v1.02.00.036.
3w-xxxx: No cards found.
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 9
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
i2o_scsi.c: Version 0.0.1
  chain_pool: 0 bytes @ f7c7dc40
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 2008116k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
01:07.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xc000. Vers LK1.1.18-ac
 00:60:08:48:6f:92, IRQ 11
  product code 4b4b rev 00.0 date 07-11-97
  Internal config register is 16302d8, transceivers 0xe040.
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
01:07.0: scatter/gather enabled. h/w checksums disabled
eth0: Dropping NETIF_F_SG since no checksum feature.
hdc: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-24102B        Rev: 5S0D
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
cmpci: version $Revision: 5.64 $ time 07:24:27 Sep 22 2003
cmpci: found CM8738 adapter at io 0xc400 irq 5
cmpci: chip version = 037
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,65), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:02.0 to 64
usb-ohci.c: USB OHCI at membase 0xf8948000, IRQ 10
usb-ohci.c: usb-00:02.0, nVidia Corporation nForce2 USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Setting latency timer of device 00:02.1 to 64
usb-ohci.c: USB OHCI at membase 0xf894a000, IRQ 11
usb-ohci.c: usb-00:02.1, nVidia Corporation nForce2 USB Controller (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
uhci.c: USB Universal Host Controller Interface driver v1.1
usb-uhci.c: $Revision: 1.275 $ time 07:25:16 Sep 22 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
[drm] Initialized radeon 1.1.1 20010405 on minor 0
spurious 8259A interrupt: IRQ7.
josh@www:~$ cat /proc/interrupts
           CPU0
  0:      93759          XT-PIC  timer
  1:       1910          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  cmpci
  8:          4          XT-PIC  rtc
 10:          0          XT-PIC  usb-ohci
 11:       9872          XT-PIC  usb-ohci, eth0
 12:      43991          XT-PIC  PS/2 Mouse
 14:      17030          XT-PIC  ide0
 15:        151          XT-PIC  ide1
NMI:          0
LOC:      93718
ERR:         33
MIS:          0


----------
Josh Jacobs
Josh@mit.edu


