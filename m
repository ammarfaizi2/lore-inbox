Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbTIQVVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbTIQVVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:21:08 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:38617 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262843AbTIQVUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:20:00 -0400
Date: Wed, 17 Sep 2003 21:48:36 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: linux-kernel@vger.kernel.org
Subject: USB-problem with uhci-hcd since version 2.6.0-test5
Message-ID: <20030917214836.A26822@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Since linux 2.6.0-test5 I seem to have a problem with the IRQ handling of the uhci-hcd module.
Since the IRQ that get's disabled is the same IRQ as my adaptec SCSI controller, my system crashes rather hard.

I included the log file of what happens.

Greetings,
Wim.

[root@stafke root]# dmesg 
Linux version 2.6.0-test5 (root@stafke.infomag.iguana.be) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #4 Tue Sep 16 22:20:03 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
Building zonelist for node : 0
Kernel command line: ro noinitrd root=/dev/sda1
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 299.208 MHz processor.
Console: colour VGA+ 80x25
Memory: 126472k/131008k available (1513k kernel code, 3984k reserved, 521k data, 304k init, 0k highmem)
Calibrating delay loop... 589.82 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0080f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0080f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0080f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Klamath) stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb1d0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
pty: 2048 Unix98 ptys configured
ikconfig 0.6 with /proc/ikconfig
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory scheduling io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 10 for device 0000:00:09.0
eth0: RealTek RTL8139 at 0xc880d000, 00:10:a7:04:d6:a1, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: Sharing IRQ 11 with 0000:00:07.2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: IBM       Model: DFHSS2W           Rev: 4141
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 4404489 512-byte hdwr sectors (2255 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 5
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 304k freed
pcwd_pci: PCI-PC Watchdog driver, v1.00 (07/09/2003)
pcwd_pci: Found card at port 0xe400 (Firmware: 1.50) with temp option.
pcwd_pci: No previous trip detected - Cold boot or reset
pcwd_pci: initialized. timeout=2 sec (nowayout=0)
EXT3 FS on sda1, internal journal
Adding 265064k swap on /dev/sda2.  Priority:-1 extents:1
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
ip_tables: (C) 2000-2002 Netfilter core team
[root@stafke root]# lsmod
Module                  Size  Used by
iptable_filter          2656  0 
ip_tables              16880  1 iptable_filter
pcwd_pci                8612  0 
[root@stafke root]# modinfo usbcore
license:        GPL
vermagic:       2.6.0-test5 PENTIUMII gcc-3.2
depends:        
alias:          usb:v*p*dl*dh*dc09dsc*dp*ic*isc*ip*
alias:          usb:v*p*dl*dh*dc*dsc*dp*ic09isc*ip*
[root@stafke root]# modprobe usbcore
[root@stafke root]# dmesg | tail
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
ip_tables: (C) 2000-2002 Netfilter core team
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
[root@stafke root]# lsmod
Module                  Size  Used by
usbcore               105492  0 
iptable_filter          2656  0 
ip_tables              16880  1 iptable_filter
pcwd_pci                8612  0 
[root@stafke root]# modinfo uhci-hcd
parm:           debug:Debug level
author:         Linus 'Frodo Rabbit' Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti Fliegl, Thomas Sailer, Roman Weissgaerber
description:    USB Universal Host Controller Interface driver
license:        GPL
vermagic:       2.6.0-test5 PENTIUMII gcc-3.2
depends:        usbcore
alias:          pci:v*d*sv*sd*bc0Csc03i00*
[root@stafke root]# lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:08.0 DPIO module: Quicklogic Corporation PC Watchdog (rev 01)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01)
00:0b.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
[root@stafke root]# modprobe uhci-hcd
[root@stafke root]# dmesg 
Linux version 2.6.0-test5 (root@stafke.infomag.iguana.be) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #4 Tue Sep 16 22:20:03 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB LOWMEM available.
On node 0 totalpages: 32752
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 28656 pages, LIFO batch:6
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
Building zonelist for node : 0
Kernel command line: ro noinitrd root=/dev/sda1
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 299.208 MHz processor.
Console: colour VGA+ 80x25
Memory: 126472k/131008k available (1513k kernel code, 3984k reserved, 521k data, 304k init, 0k highmem)
Calibrating delay loop... 589.82 BogoMIPS
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0080f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0080f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0080f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Klamath) stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb1d0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 0000:00:07.0
pty: 2048 Unix98 ptys configured
ikconfig 0.6 with /proc/ikconfig
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP(,...)]
lp0: using parport0 (polling).
Using anticipatory scheduling io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 10 for device 0000:00:09.0
eth0: RealTek RTL8139 at 0xc880d000, 00:10:a7:04:d6:a1, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: Sharing IRQ 11 with 0000:00:07.2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
(scsi0:A:6): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: IBM       Model: DFHSS2W           Rev: 4141
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
SCSI device sda: 4404489 512-byte hdwr sectors (2255 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 5
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 304k freed
pcwd_pci: PCI-PC Watchdog driver, v1.00 (07/09/2003)
pcwd_pci: Found card at port 0xe400 (Firmware: 1.50) with temp option.
pcwd_pci: No previous trip detected - Cold boot or reset
pcwd_pci: initialized. timeout=2 sec (nowayout=0)
EXT3 FS on sda1, internal journal
Adding 265064k swap on /dev/sda2.  Priority:-1 extents:1
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
ip_tables: (C) 2000-2002 Netfilter core team
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0b.0
uhci-hcd 0000:00:07.2: UHCI Host Controller
irq 11: nobody cared!
Call Trace:
 [<c010c96b>] __report_bad_irq+0x2b/0x90
 [<c010ca56>] note_interrupt+0x66/0xa0
 [<c010cc60>] do_IRQ+0xf0/0x100
 [<c010b18c>] common_interrupt+0x18/0x20
 [<c011dd7d>] do_softirq+0x4d/0xc0
 [<c010cc47>] do_IRQ+0xd7/0x100
 [<c010b18c>] common_interrupt+0x18/0x20
 [<c01a81c8>] pci_bus_write_config_word+0x58/0x60
 [<c885d0e0>] uhci_reset+0x40/0x60 [uhci_hcd]
 [<c8876325>] usb_hcd_pci_probe+0x205/0x480 [usbcore]
 [<c017bead>] sysfs_new_inode+0x5d/0xa0
 [<c017bf54>] sysfs_create+0x64/0x90
 [<c01aa38d>] pci_device_probe_static+0x4d/0x60
 [<c01aa4cc>] __pci_device_probe+0x3c/0x50
 [<c01aa50c>] pci_device_probe+0x2c/0x50
 [<c01cea6d>] bus_match+0x3d/0x70
 [<c01cebd0>] driver_attach+0x70/0xb0
 [<c01cee90>] bus_add_driver+0x90/0xb0
 [<c01cf2c1>] driver_register+0x31/0x40
 [<c01aa75f>] pci_register_driver+0x5f/0x90
 [<c88420db>] uhci_hcd_init+0xdb/0x13d [uhci_hcd]
 [<c012f022>] sys_init_module+0x102/0x1d0
 [<c010afcd>] sysenter_past_esp+0x52/0x71

handlers:
[<c020b9a0>] (ahc_linux_isr+0x0/0x280)
Disabling IRQ #11
uhci-hcd 0000:00:07.2: irq 11, io base 0000e000
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
[root@stafke root]# dmesg | tail

Message from syslogd@stafke at Wed Sep 17 21:28:32 2003 ...
stafke kernel: Disabling IRQ #11

Message from syslogd@stafke at Wed Sep 17 21:28:32 2003 ...
stafke kernel: journal commit I/O error
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue a TARGET RESET message
CDB: 0x2a 0x0 0x0 0x2 0x87 0x3f 0x0 0x0 0x8 0x0
scsi0:0:0:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
[root@stafke root]# dmesg 
id 0, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 5
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 304k freed
pcwd_pci: PCI-PC Watchdog driver, v1.00 (07/09/2003)
pcwd_pci: Found card at port 0xe400 (Firmware: 1.50) with temp option.
pcwd_pci: No previous trip detected - Cold boot or reset
pcwd_pci: initialized. timeout=2 sec (nowayout=0)
EXT3 FS on sda1, internal journal
Adding 265064k swap on /dev/sda2.  Priority:-1 extents:1
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
(scsi0:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi0:A:0:0): Saw underflow (76 of 96 bytes). Treated as error
ip_tables: (C) 2000-2002 Netfilter core team
ip_tables: (C) 2000-2002 Netfilter core team
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
ip_tables: (C) 2000-2002 Netfilter core team
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0b.0
uhci-hcd 0000:00:07.2: UHCI Host Controller
irq 11: nobody cared!
Call Trace:
 [<c010c96b>] __report_bad_irq+0x2b/0x90
 [<c010ca56>] note_interrupt+0x66/0xa0
 [<c010cc60>] do_IRQ+0xf0/0x100
 [<c010b18c>] common_interrupt+0x18/0x20
 [<c011dd7d>] do_softirq+0x4d/0xc0
 [<c010cc47>] do_IRQ+0xd7/0x100
 [<c010b18c>] common_interrupt+0x18/0x20
 [<c01a81c8>] pci_bus_write_config_word+0x58/0x60
 [<c885d0e0>] uhci_reset+0x40/0x60 [uhci_hcd]
 [<c8876325>] usb_hcd_pci_probe+0x205/0x480 [usbcore]
 [<c017bead>] sysfs_new_inode+0x5d/0xa0
 [<c017bf54>] sysfs_create+0x64/0x90
 [<c01aa38d>] pci_device_probe_static+0x4d/0x60
 [<c01aa4cc>] __pci_device_probe+0x3c/0x50
 [<c01aa50c>] pci_device_probe+0x2c/0x50
 [<c01cea6d>] bus_match+0x3d/0x70
 [<c01cebd0>] driver_attach+0x70/0xb0
 [<c01cee90>] bus_add_driver+0x90/0xb0
 [<c01cf2c1>] driver_register+0x31/0x40
 [<c01aa75f>] pci_register_driver+0x5f/0x90
 [<c88420db>] uhci_hcd_init+0xdb/0x13d [uhci_hcd]
 [<c012f022>] sys_init_module+0x102/0x1d0
 [<c010afcd>] sysenter_past_esp+0x52/0x71

handlers:
[<c020b9a0>] (ahc_linux_isr+0x0/0x280)
Disabling IRQ #11
uhci-hcd 0000:00:07.2: irq 11, io base 0000e000
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x2a 0x0 0x0 0x2 0x87 0x3f 0x0 0x0 0x8 0x0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue a TARGET RESET message
CDB: 0x2a 0x0 0x0 0x2 0x87 0x3f 0x0 0x0 0x8 0x0
scsi0:0:0:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi0:0:0:0: Command already completed
aic7xxx_abort returns 0x2002
scsi0:0:0:0: Attempting to queue an ABORT message
CDB: 0x0 0x0 0x0 0x0 0x0 0x0
scsi0: At time of recovery, card was paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x171
Card was paused
ACCUM = 0xa0, SINDEX = 0x61, DINDEX = 0xc0, ARG_2 = 0x8
HCNT = 0x0 SCBPTR = 0x3
SCSISIGI[0xb6]:(REQI|BSYI|ATNI|MSGI|CDI) ERROR[0x0] 
SCSIBUSL[0xc0] LASTPHASE[0xa0]:(MSGI|CDI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x0] SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0x40]:(NO_CDB_SENT) SSTAT0[0x7]:(DMADONE|SPIORDY|SDONE) 
SSTAT1[0x3]:(REQINIT|PHASECHG) SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x4]:(DIRECTION) 
DFSTATUS[0x6d]:(FIFOEMP|DFTHRESH|HDONE|FIFOQWDEMP|DFCACHETH) 
STACK: 0xe4 0x0 0x169 0x199
SCB count = 160
Kernel NEXTQSCB = 21
Card NEXTQSCB = 21
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 6 11 14 10 12 15 0 9 8 4 5 2 1 13 7 
Sequencer SCB Info: 
  0 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  1 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  2 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  3 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7] SCB_LUN[0x0] 
SCB_TAG[0x20] 
  4 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  5 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  6 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  7 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  8 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
  9 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 10 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 11 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 12 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 13 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 14 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
 15 SCB_CONTROL[0xe0]:(TAG_ENB|DISCENB|TARGET_SCB) SCB_SCSIID[0x7] 
SCB_LUN[0x0] SCB_TAG[0xff] 
Pending list: 
 32 SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7] SCB_LUN[0x0] 
Kernel Free SCB list: 25 4 3 19 26 28 39 13 17 11 27 14 12 36 0 20 24 10 31 18 1 7 35 30 8 43 29 156 15 2 33 9 6 16 37 5 34 22 38 23 157 158 159 152 153 154 155 148 149 150 151 144 145 146 147 140 141 142 143 136 137 138 139 132 133 134 135 128 129 130 131 124 125 126 127 120 121 122 123 116 117 118 119 112 113 114 115 108 109 110 111 104 105 106 107 100 101 102 103 96 97 98 99 92 93 94 95 88 89 90 91 84 85 86 87 80 81 82 83 76 77 78 79 72 73 74 75 68 69 70 71 64 65 66 67 60 61 62 63 56 57 58 59 52 53 54 55 48 49 50 51 44 45 46 47 40 41 42 
DevQ(0:0:0): 0 waiting
DevQ(0:6:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi0:0:0:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
SCSI error : <0 0 0 0> return code = 0x6000000
end_request: I/O error, dev sda, sector 165695
Buffer I/O error on device sda1, logical block 20704
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 393225
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 393216
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 393217
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 393218
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 393376
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 393377
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 393395
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 393399
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 393723
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 425986
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 425997
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 426043
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 426071
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 458808
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 360479
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 327696
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 327697
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 327695
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 327689
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 229423
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 229420
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 229407
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 229396
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 229395
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 229390
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 229384
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 164035
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 131229
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 131161
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 65801
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 65787
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 32787
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 0
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 1
lost page write due to I/O error on sda1
Buffer I/O error on device sda1, logical block 2
lost page write due to I/O error on sda1
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 1731
lost page write due to I/O error on sda1
Aborting journal on device sda1.
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device sda1) in ext3_reserve_inode_write: Journal has aborted
buffer layer error at fs/buffer.c:1260
Call Trace:
 [<c014bf54>] mark_buffer_dirty+0x54/0x60
 [<c018b69d>] ext3_commit_super+0x4d/0x80
 [<c0188dd1>] ext3_handle_error+0x81/0xc0
 [<c0188f5b>] __ext3_std_error+0x4b/0x60
 [<c0184a59>] ext3_reserve_inode_write+0x59/0xd0
 [<c0184af8>] ext3_mark_inode_dirty+0x28/0x60
 [<c0184bb1>] ext3_dirty_inode+0x81/0x90
 [<c01668b6>] __mark_inode_dirty+0xc6/0xd0
 [<c0161206>] update_atime+0xd6/0xe0
 [<c0156307>] link_path_walk+0x4a7/0x810
 [<c0115fe6>] do_page_fault+0x156/0x4ac
 [<c0156fc7>] open_namei+0x87/0x400
 [<c0148c21>] filp_open+0x41/0x70
 [<c0149035>] sys_open+0x55/0x90
 [<c010b01f>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2664
Call Trace:
 [<c014e05f>] submit_bh+0x12f/0x180
 [<c014e1b9>] sync_dirty_buffer+0x69/0xd0
 [<c0188dd1>] ext3_handle_error+0x81/0xc0
 [<c0188f5b>] __ext3_std_error+0x4b/0x60
 [<c0184a59>] ext3_reserve_inode_write+0x59/0xd0
 [<c0184af8>] ext3_mark_inode_dirty+0x28/0x60
 [<c0184bb1>] ext3_dirty_inode+0x81/0x90
 [<c01668b6>] __mark_inode_dirty+0xc6/0xd0
 [<c0161206>] update_atime+0xd6/0xe0
 [<c0156307>] link_path_walk+0x4a7/0x810
 [<c0115fe6>] do_page_fault+0x156/0x4ac
 [<c0156fc7>] open_namei+0x87/0x400
 [<c0148c21>] filp_open+0x41/0x70
 [<c0149035>] sys_open+0x55/0x90
 [<c010b01f>] syscall_call+0x7/0xb

scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 0
lost page write due to I/O error on sda1
journal commit I/O error
ext3_abort called.
EXT3-fs abort (device sda1): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
EXT3-fs error (device sda1) in start_transaction: Journal has aborted
EXT3-fs error (device sda1) in ext3_dirty_inode: Journal has aborted
[root@stafke root]# exit
logout
-bash: /root/.bash_logout: Input/output error
