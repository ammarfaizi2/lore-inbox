Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTF0PNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTF0PMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:12:09 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:10727 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264547AbTF0PJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:09:49 -0400
Subject: 2.5.73-mm1 Uninitialised timer warnings
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1056727439.2358.9.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Jun 2003 11:23:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is my dmesg output which contains several uninitialized timer
warnings. I assume someone wants to see them or else why print the
warning. :-)

BTW: Only three warnings during the compile of this kernel!

Linux version 2.5.73-mm1 (shane@mars.goatskin.org) (gcc version 2.96
20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Jun 27 10:47:16 EDT
2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000018000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
384MB LOWMEM available.
On node 0 totalpages: 98304
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94208 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=2.5.73-mm1 ro root=301
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1195.285 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2385.51 BogoMIPS
Memory: 386072k/393216k available (1475k kernel code, 6388k reserved,
503k data, 292k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1195.2690 MHz.
..... host bus clock speed is 265.6153 MHz.
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb160, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 8d & 1f ->
0d
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
spurious 8259A interrupt: IRQ7.
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Enabling SEP on CPU 0
Journalled Block Device driver loaded
udf: registering filesystem
Initializing Cryptographic API
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
anticipatory scheduling elevator
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc01e9d60, data=0x0
Call Trace:
 [<c0123a6e>] check_timer_failed+0x3e/0x50
 [<c01e9d60>] floppy_shutdown+0x0/0xb0
 [<c0123de8>] del_timer+0x18/0xb0
 [<c01e0321>] blk_init_queue+0x111/0x130
 [<c01e7ac1>] reschedule_timeout+0x21/0xa0
 [<c0304274>] floppy_init+0x144/0x530
 [<c01ec080>] do_fd_request+0x0/0x90
 [<c02f2789>] do_initcalls+0x39/0x90
 [<c0105098>] init+0x38/0x1a0
 [<c0105060>] init+0x0/0x1a0
 [<c0108a19>] kernel_thread_helper+0x5/0xc

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller at PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJNA-352030, ATA DISK drive
hdb: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 00:08.0
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
hde: IBM-DJNA-352030, ATA DISK drive
ide2 at 0xcc00-0xcc07,0xd002 on irq 10
hdg: MAXTOR 6L080J4, ATA DISK drive
ide3 at 0xd400-0xd407,0xd802 on irq 10
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=39560/16/63
 hda: hda1 hda2 hda3 hda4 < hda5 >
hde: max request size: 128KiB
hde: host protected area => 1
hde: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=39560/16/63,
UDMA(33)
 hde: hde1 hde2 hde3 hde4 < hde5 >
hdg: max request size: 128KiB
hdg: host protected area => 1
hdg: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63,
UDMA(133)
 hdg: unknown partition table
hdb: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
NET4: Linux TCP/IP 1.0 for NET4.0
input: AT Set 2 keyboard on isa0060/serio0
IP: routing cache hash table of 4096 buckets, 32Kbytes
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc022e350, data=0x0
Call Trace:
 [<c0123a6e>] check_timer_failed+0x3e/0x50
 [<c022e350>] peer_check_expire+0x0/0xe0
 [<c022e350>] peer_check_expire+0x0/0xe0
 [<c0123b80>] add_timer+0x50/0xa0
 [<c0138ddc>] kmem_cache_create+0x25c/0x3f0
 [<c030900e>] inet_initpeers+0x7e/0x90
 [<c0309ca7>] xfrm4_input_init+0x17/0x40
 [<c0308f68>] ip_rt_init+0x298/0x2c0
 [<c0174b46>] create_proc_entry+0x96/0xb0
 [<c0309037>] ip_init+0x17/0x40
 [<c030991c>] inet_init+0x14c/0x190
 [<c02f2789>] do_initcalls+0x39/0x90
 [<c0105098>] init+0x38/0x1a0
 [<c0105060>] init+0x0/0x1a0
 [<c0108a19>] kernel_thread_helper+0x5/0xc

TCP: Hash tables configured (established 32768 bind 65536)
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 292k freed
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc012a800, data=0xc02b83a0
Call Trace:
 [<c0123a6e>] check_timer_failed+0x3e/0x50
 [<c012a800>] delayed_work_timer_fn+0x0/0x60
 [<c012a800>] delayed_work_timer_fn+0x0/0x60
 [<c0123b80>] add_timer+0x50/0xa0
 [<c012a8bb>] queue_delayed_work+0x5b/0x80
 [<c01ca07e>] batch_entropy_store+0x7e/0x90
 [<c01ca20b>] add_timer_randomness+0xcb/0xe0
 [<c01ca2cb>] add_disk_randomness+0x2b/0x30
 [<c01f4313>] ide_end_request+0x93/0x120
 [<c0205a99>] ide_dma_intr+0x59/0x90
 [<c01f5822>] ide_intr+0xf2/0x170
 [<c0205a40>] ide_dma_intr+0x0/0x90
 [<c010c59c>] handle_IRQ_event+0x3c/0x60
 [<c010c870>] do_IRQ+0xa0/0x140
 [<c010b14c>] common_interrupt+0x18/0x20
 [<c0108874>] default_idle+0x24/0x30
 [<c0115415>] apm_cpu_idle+0x125/0x170
 [<c01152f0>] apm_cpu_idle+0x0/0x170
 [<c0108850>] default_idle+0x0/0x30
 [<c01088f2>] cpu_idle+0x32/0x50
 [<c0105000>] _stext+0x0/0x50
 [<c02f272e>] start_kernel+0x16e/0x180

Real Time Clock Driver v1.11
device-mapper: 1.0.6-ioctl (2002-10-15) initialised: dm@uk.sistina.com
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
Adding 128512k swap on /dev/hda2.  Priority:5 extents:1
Adding 128512k swap on /dev/hde2.  Priority:5 extents:1
bttv: driver version 0.9.4 loaded
bttv: using 16 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is VIA Technologies, In VT8363/8365 [KT133/K
bttv: Host bridge is VIA Technologies, In VT82C686 [Apollo Sup
bttv: Bt8xx card found (0).
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
bttv0: Bt848 (rev 18) at 00:0c.0, irq: 10, latency: 32, mmio: 0xe3005000
bttv0: using: BT848A(Zoltrix TV-Max) [card=15,insmod option]
bttv0: using tuner=-1
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tuner: chip found @ 0xc0
tuner(bttv): type forced to 6 (Temic NTSC (4032 FY5)) [insmod]
registering 0-0060
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on dm-7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on dm-9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on dm-14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:07.2, have irq 10, want irq 11
IRQ routing conflict for 00:07.3, have irq 10, want irq 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0a.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.19
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
PCI: Found IRQ 11 for device 00:07.2
IRQ routing conflict for 00:07.2, have irq 10, want irq 11
IRQ routing conflict for 00:07.3, have irq 10, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
uhci-hcd 0000:00:07.2: VIA Technologies, In USB
uhci-hcd 0000:00:07.2: irq 10, io base 0000c400
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
deprecated.
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:07.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: VIA Technologies, In USB
usb usb1: Manufacturer: Linux 2.5.73-mm1 uhci-hcd
usb usb1: SerialNumber: 00:07.2
usb usb1: usb_new_device - registering interface 1-0:0
hub 1-0:0: usb_device_probe
hub 1-0:0: usb_device_probe - got id
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: standalone hub
hub 1-0:0: ganged power switching
hub 1-0:0: global over-current protection
hub 1-0:0: Port indicators are not supported
hub 1-0:0: power on to power good time: 2ms
hub 1-0:0: hub controller current requirement: 0mA
hub 1-0:0: local power source is good
hub 1-0:0: no over-current condition exists
hub 1-0:0: enabling power on all ports
PCI: Found IRQ 11 for device 00:07.3
IRQ routing conflict for 00:07.2, have irq 10, want irq 11
IRQ routing conflict for 00:07.3, have irq 10, want irq 11
PCI: Sharing IRQ 11 with 00:0a.0
uhci-hcd 0000:00:07.3: VIA Technologies, In USB (#2)
uhci-hcd 0000:00:07.3: irq 10, io base 0000c800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci-hcd 0000:00:07.3: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: VIA Technologies, In USB (#2)
usb usb2: Manufacturer: Linux 2.5.73-mm1 uhci-hcd
usb usb2: SerialNumber: 00:07.3
usb usb2: usb_new_device - registering interface 2-0:0
hub 2-0:0: usb_device_probe
hub 2-0:0: usb_device_probe - got id
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
hub 2-0:0: standalone hub
hub 2-0:0: ganged power switching
hub 2-0:0: global over-current protection
hub 2-0:0: Port indicators are not supported
hub 2-0:0: power on to power good time: 2ms
hub 2-0:0: hub controller current requirement: 0mA
hub 2-0:0: local power source is good
hub 2-0:0: no over-current condition exists
hub 2-0:0: enabling power on all ports
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
deprecated.
hub 1-0:0: port 1, status 301, change 3, 1.5 Mb/s
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 2
usb 1-1: new device strings: Mfr=1, Product=0, SerialNumber=0
usb 1-1: Manufacturer: Logitech
usb 1-1: usb_new_device - registering interface 1-1:0
hub 1-0:0: port 2, status 100, change 3, 12 Mb/s
hub 1-0:0: port 2 enable change, status 100
hub 2-0:0: port 1, status 100, change 3, 12 Mb/s
hub 2-0:0: port 2, status 100, change 3, 12 Mb/s
hub 2-0:0: port 1 enable change, status 100
hub 2-0:0: port 2 enable change, status 100
drivers/usb/host/uhci-hcd.c: c800: suspend_hc
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
cdrom: open failed.
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command 
hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hde: drive_cmd: error=0x04 { DriveStatusError }
hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hde: drive_cmd: error=0x04 { DriveStatusError }
SCSI subsystem initialized
parport_pc: Via 686A parallel port disabled in BIOS
lp: driver loaded but no devices found
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Module nfsd cannot be unloaded due to unsafe usage in
include/linux/module.h:479
Module lockd cannot be unloaded due to unsafe usage in
include/linux/module.h:479
PCI: Found IRQ 5 for device 00:0d.0
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc01cf8f0, data=0x0
Call Trace:
 [<c0123a6e>] check_timer_failed+0x3e/0x50
 [<c01cf8f0>] kd_nosound+0x0/0x70
 [<c0123de8>] del_timer+0x18/0xb0
 [<c01d2742>] csi_K+0xc2/0x100
 [<c01cf975>] kd_mksound+0x15/0xb0
 [<c01d4c24>] do_con_write+0x5b4/0x680
 [<c020cb9d>] vgacon_cursor+0x19d/0x1b0
 [<c01d5278>] con_write+0x18/0x30
 [<c01c67bc>] opost_block+0x1bc/0x1d0
 [<c01d1a86>] set_cursor+0x66/0x80
 [<c01c8675>] write_chan+0x175/0x210
 [<c011a230>] default_wake_function+0x0/0x20
 [<c011a230>] default_wake_function+0x0/0x20
 [<c011a230>] default_wake_function+0x0/0x20
 [<c011a230>] default_wake_function+0x0/0x20
 [<c01c384f>] tty_write+0x21f/0x2d0
 [<c01c8500>] write_chan+0x0/0x210
 [<c0141ab5>] do_brk+0x115/0x1d0
 [<c014bdd9>] vfs_write+0xa9/0xe0
 [<c014be8d>] sys_write+0x2d/0x50
 [<c010a7df>] syscall_call+0x7/0xb

drivers/usb/core/usb.c: registered new driver hiddev
hid 1-1:0: usb_device_probe
hid 1-1:0: usb_device_probe - got id
input: USB HID v1.00 Mouse [Logitech] on usb-00:07.2-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc024a060, data=0x0
Call Trace:
 [<c0123a6e>] check_timer_failed+0x3e/0x50
 [<c024a060>] tcp_twkill+0x0/0xf0
 [<c024a060>] tcp_twkill+0x0/0xf0
 [<c0123c80>] mod_timer+0x30/0x180
 [<c021d02c>] __kfree_skb+0xac/0xc0
 [<c024a33d>] tcp_tw_schedule+0x15d/0x180
 [<c0249f84>] tcp_time_wait+0x164/0x240
 [<c023d6b5>] tcp_ack+0x115/0x330
 [<c0240a0d>] tcp_rcv_state_process+0x66d/0x830
 [<c011b820>] autoremove_wake_function+0x0/0x40
 [<c0247975>] tcp_v4_do_rcv+0xb5/0x100
 [<c0247e7d>] tcp_v4_rcv+0x4bd/0x7b0
 [<c022cadf>] ip_route_input+0x3f/0x1b0
 [<c022e703>] ip_local_deliver+0x103/0x1c0
 [<c022e965>] ip_rcv+0x1a5/0x390
 [<c022ead7>] ip_rcv+0x317/0x390
 [<d888354b>] boomerang_rx+0x2cb/0x470 [3c59x]
 [<c022125e>] netif_receive_skb+0x17e/0x1d0
 [<c015cb5e>] do_poll+0x6e/0xd0
 [<c022131d>] process_backlog+0x6d/0x130
 [<c022145c>] net_rx_action+0x7c/0x130
 [<c01208ab>] do_softirq+0x4b/0xa0
 [<c010c8e9>] do_IRQ+0x119/0x140
 [<c010b14c>] common_interrupt+0x18/0x20

Regards,

Shane


