Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTIKQnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbTIKQnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:43:37 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:38532 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S261422AbTIKQmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:42:51 -0400
Date: Thu, 11 Sep 2003 18:42:48 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: IRQs and APIC conflicts with 2.6.0-test6 
Message-ID: <Pine.LNX.4.44.0309111837260.4640-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a bunch of problems, all showed in the atached dmesg.
This is an Acer Laptop with Via Chipset (I've sent the lspci in a previuos 
mail).

Mainly, part of the hardware is not properly, detected, I cannot use 
neither pcmcia nor usb, I cannot suspend.... a total mess :(

I'm willing to try any patch to fix it . Thanks.

Linux version 2.6.0-test5 (pau@pau.intranet.ct) (gcc version 3.2.2 
20030222 (Red Hat Linux 3.2.2-5)) #4 Wed Sep 10 10:41:38 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002dff0000 (usable)
 BIOS-e820: 000000002dff0000 - 000000002dffffc0 (ACPI data)
 BIOS-e820: 000000002dffffc0 - 000000002e000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
735MB LOWMEM available.
On node 0 totalpages: 188400
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 184304 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 OID_00                                    ) @ 0x000e5010
ACPI: RSDT (v001 INSYDE RSDT_000 0x00000001 _CSI 0x00010101) @ 0x2dfffbc0
ACPI: FADT (v001 INSYDE FACP_000 0x00000100 _CSI 0x00010101) @ 0x2dfffac0
ACPI: BOOT (v001 INSYDE SYS_BOOT 0x00000100 _CSI 0x00010101) @ 0x2dfffb50
ACPI: DBGP (v001 INSYDE DBGP_000 0x00000100 _CSI 0x00010101) @ 0x2dfffb80
ACPI: DSDT (v001 INSYDE    KN266 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: ro root=LABEL=/ resume=/dev/hda10 pci=noacpi 
pci=usepirqmask pci=biosirq
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1525.896 MHz processor.
Console: colour VGA+ 80x25
Memory: 742692k/753600k available (1510k kernel code, 10152k reserved, 
626k data, 148k init, 0k highmem)
Calibrating delay loop... 2981.88 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0183fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1cbfbff 00000000 00000000
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1525.0612 MHz.
..... host bus clock speed is 265.0323 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xe8a04, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15, disabled)
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3177] at 0000:00:11.0
PCI: Cannot allocate resource region 0 of device 0000:00:0a.0
divert: not allocating divert_blk for non-ethernet device lo
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.1, from 255 to 0
ACPI: AC Adapter [ADP0] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (43 C)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1108-0x110f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, 
UDMA(100)
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 > hda2
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
swsusp: Resume From Partition: /dev/hda10, Device: hda10
Resume Machine: This is normal swap space
Resume Machine: Error -22 resuming
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 166k freed
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 148k freed
Real Time Clock Driver v1.12
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: No IRQ known for interrupt pin D of device 0000:00:10.3.
drivers/usb/core/hcd-pci.c: Found HC with no IRQ.  Check BIOS/PCI 
0000:00:10.3 setup!
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
uhci-hcd 0000:00:10.0: UHCI Host Controller
uhci-hcd 0000:00:10.0: irq 11, io base 00001200
uhci-hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: No IRQ known for interrupt pin B of device 0000:00:10.1.
drivers/usb/core/hcd-pci.c: Found HC with no IRQ.  Check BIOS/PCI 
0000:00:10.1 setup!
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda6, internal journal
Adding 811240k swap on /dev/hda10.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
blk: queue edd44a00, I/O limit 4095Mb (mask 0xffffffff)
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
MCE: The hardware reports a non fatal, correctable incident occurred on 
CPU 0.
Bank 0: e615000000000185
kudzu: numerical sysctl 1 23 is obsolete.
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
inserting floppy driver for 2.6.0-test5
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
ip_tables: (C) 2000-2002 Netfilter core team
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
divert: allocating divert_blk for eth0
eth0: VIA VT6102 Rhine-II at 0xf0008000, 00:c0:9f:29:06:73, IRQ 11.
eth0: MII PHY found at address 1, status 0x7829 advertising 01e1 Link 
0021.
ip_tables: (C) 2000-2002 Netfilter core team
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:0a.0 [10cf:10e7]
Yenta: ISA IRQ list 0018, PCI irq11
Socket status: 30000007
Bluetooth: Core ver 2.2
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
------------[ cut here ]------------
kernel BUG at include/net/sock.h:459!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<ee8f283e>]    Not tainted
EFLAGS: 00010282
EIP is at l2cap_sock_alloc+0xce/0xe0 [l2cap]
eax: ee94ed40   ebx: ec0f7e40   ecx: ec2dc680   edx: ec0f7e40
esi: 00000000   edi: ffffffa3   ebp: 00000001   esp: ec17befc
ds: 007b   es: 007b   ss: 0068
Process sdpd (pid: 563, threadinfo=ec17a000 task=ec17d880)
Stack: ec2dc680 00000000 00000024 000000d0 ee94ee84 00000000 ee8f28c6 
ec2dc680 
       00000000 000000d0 ee9420ff ec2dc680 00000000 0000001f ffffff9f 
ec2dc680 
       c02166b0 ec2dc680 00000000 00000000 00000001 ec17bf90 00000000 
c021685b 
Call Trace:
 [<ee8f28c6>] l2cap_sock_create+0x76/0xb0 [l2cap]
 [<ee9420ff>] bt_sock_create+0x9f/0x110 [bluetooth]
 [<c02166b0>] sock_create+0xf0/0x270
 [<c021685b>] sys_socket+0x2b/0x60
 [<c0217875>] sys_socketcall+0x95/0x2b0
 [<c01115da>] do_gettimeofday+0x1a/0x90
 [<c010b3a5>] sysenter_past_esp+0x52/0x71

Code: 0f 0b cb 01 86 60 8f ee e9 68 ff ff ff 90 8d 74 26 00 83 ec 
 hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem initialized
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
ip_tables: (C) 2000-2002 Netfilter core team
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
svc: unknown version (3)
nfs warning: mount version older than kernel
NFS: NFSv3 not supported.
lp0: using parport0 (polling).
lp0: console ready
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
PCI: Setting latency timer of device 0000:00:11.5 to 64
cdrom: This disc doesn't have any tracks I recognize!


-- 

Pau

