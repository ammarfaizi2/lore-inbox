Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTILSVC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTILSVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:21:02 -0400
Received: from bcsii.com ([67.114.178.171]:26349 "EHLO mail.bcsii.com")
	by vger.kernel.org with ESMTP id S261836AbTILST7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:19:59 -0400
Message-ID: <3F620F23.2030105@bcsii.net>
Date: Fri, 12 Sep 2003 11:23:31 -0700
From: Andriy Rysin <arysin@bcsii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bttv grabbing problems with recent kernels
Content-Type: multipart/mixed;
 boundary="------------040803040103010503070707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040803040103010503070707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've posted this to video4linux-list@redhat.com and got one confirmation 
of the problem and it seems like it's a kernel issue so I dared to post 
here. Please CC me on reply.

I've got some problems grabbing with bttv on recent kernels. If anybody
can confirm the problem or even help with this issue I would really
appreciate that.

The comandline is this:
streamer -c /dev/video0 -s NTSC -s 640x480 -f jpeg -o /tmp/foo00000.jpeg
-t 0:120 -r 30

I was using 2.4.20-6 from older rawhide and everything worked perfect -
every frame is grabbed. streamer is from xawtv 3.83.

On kernel-2.4.22-20.1.2024.2.36.nptl (wether UP or SMP) from recent
rawhide streamer misses about every 10th frame

On kernel 2.6.0-0.test5.1.34 it does it for every second frame, the
output is below.

This behavior was confirmed on 2.6.0-test3 with saa7134 driver compared 
to ok with 2.4.20.

I must say that with kernel 2.4.20-6 I was doing up to 80 frames per
second from 4 cards on same server so this is not CPU/chipset/grabber 
card/PCI throuput issue. My dmesg and lspci are attached.

bttv used with kernel 2.4.20 is 0.7.96 (and 0.7.97), bttv for 2.4.22 -
from kernel rpm (0.7.107), bttv for 2.6.0 - from kernel rpm (0.9.11)

Thanks in advance,
Andriy

files / video: JPEG (JFIF) / audio: none
Using stdout to output written files' names
20:23:16:  Lost one frame, total 1 since last restart.
/tmp/foo00000.jpegio: -0.133s   video: -0.015s
20:23:16:  Lost one frame, total 2 since last restart.
/tmp/foo00001.jpegio: -0.199s   video: -0.015s
20:23:16:  Lost one frame, total 3 since last restart.
/tmp/foo00002.jpegio: -0.266s   video: -0.015s
20:23:16:  Lost one frame, total 4 since last restart.
/tmp/foo00003.jpegio: -0.333s   video: -0.015s
20:23:16:  Lost one frame, total 5 since last restart.
/tmp/foo00004.jpegio: -0.399s   video: -0.015s
20:23:17:  Lost one frame, total 6 since last restart.
/tmp/foo00005.jpegio: -0.466s   video: -0.015s
20:23:17:  Lost one frame, total 7 since last restart.
/tmp/foo00006.jpegio: -0.533s   video: -0.015s
20:23:17:  Lost one frame, total 8 since last restart.
/tmp/foo00007.jpegio: -0.600s   video: -0.015s
20:23:17:  Lost one frame, total 9 since last restart.




--------------040803040103010503070707
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.0-0.test5.1.34 (bhcompile@bugs.devel.redhat.com) (gcc version 3.3.1 20030903 (Red Hat Linux 3.3.1-4)) #1 Thu Sep 11 06:36:21 EDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126972 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5690
ACPI: RSDT (v001 ASUS   P4S533-X 0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   P4S533-X 0x42302e31 MSFT 0x31313031) @ 0x1fffc0c0
ACPI: BOOT (v001 ASUS   P4S533-X 0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   P4S533-X 0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS P4S533-X 0x00001000 MSFT 0x0100000b) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.6.0up ro BOOT_FILE=/boot/vmlinuz-2.6.0-0.test5.1.34 hdc=ide-scsi root=LABEL=/ panic=60
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 3059.352 MHz processor.
Console: colour VGA+ 80x25
Memory: 515136k/524272k available (1795k kernel code, 8340k reserved, 722k data, 172k init, 0k highmem)
Calibrating delay loop... 6045.69 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Not enabled at boot.
Capability LSM initialized
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1060, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15, enabled at IRQ 9)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
divert: not allocating divert_blk for non-ethernet device lo
pty: 2048 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
No supported AGP bridge found.
You can boot with agp=try_unsupported
agpgart: Detected SiS 646 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe4000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-00CRA1, ATA DISK drive
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-48125W, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 >
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 243k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
3ware Storage Controller device driver for Linux v1.02.00.032.
scsi0 : Found a 3ware Storage Controller at 0x9400, IRQ: 10, P-chip: 1.3
scsi0 : 3ware Storage Controller
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.0 
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 960478720 512-byte hdwr sectors (491765 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 172k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 5, pci mem e082e000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda3, internal journal
Adding 891568k swap on /dev/hda5.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: LTR-48125W        Rev: VS04
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue dfdd551c, I/O limit 4095Mb (mask 0xffffffff)


--------------040803040103010503070707
Content-Type: text/plain;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host & Memory & AGP Controller (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 25)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 91)
00:0e.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:0e.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:10.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:10.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:11.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:11.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
00:12.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX DDR] (rev b2)


--------------040803040103010503070707--

