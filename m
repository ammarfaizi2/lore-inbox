Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTJJTCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbTJJTCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:02:34 -0400
Received: from h13.ing.unife.it ([192.167.215.13]:1988 "EHLO
	liston.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S263118AbTJJTC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:02:26 -0400
From: Simone Piunno <pioppo@ferrara.linux.it>
To: linux-kernel@vger.kernel.org
Subject: OOPS: proc_pid_stat
Date: Fri, 10 Oct 2003 21:11:04 +0200
User-Agent: KMail/1.5
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
X-Operating-System: Linux 2.6.0-test3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310102111.04711.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I get the following on -test7, while completing init scripts immediatly after 
boot.

Unable to handle kernel NULL pointer dereference at virtual address 00000034
 printing eip:
c017d931
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c017d931>]    Not tainted
EFLAGS: 00010212
EIP is at proc_pid_stat+0x211/0x3e0
eax: 00000000   ebx: 00000000   ecx: 0000ad97   edx: c91e3340
esi: 0000000a   edi: c91f78a0   ebp: c9043f48   esp: c9043ef0
ds: 007b   es: 007b   ss: 0068
Process pidof (pid: 946, threadinfo=c9042000 task=c9a34160)
Stack: 0000115b 00000000 c031167c 0000ad97 00000000 000003b5 53311454 00000000 
       ffffffff 00000000 00000010 c011f5a7 bffff1cc 401aeedc 019b3000 00000000 
       00000000 00000000 00000000 c91e3340 c8f444e0 c8f42000 c9043f6c c017aab4 
Call Trace:
 [<c011f5a7>] do_exit+0x2e7/0x3c0
 [<c017aab4>] proc_info_read+0x54/0x180
 [<c017aa60>] proc_info_read+0x0/0x180
 [<c01512d8>] vfs_read+0x98/0xe0
 [<c01514ec>] sys_read+0x2c/0x60
 [<c010a3b7>] syscall_call+0x7/0xb

Code: 8b 58 34 8b 70 2c ff 72 40 ff b2 60 01 00 00 6a 00 8b 45 e4

TIA
  Simone Piunno



Linux version 2.6.0-test7 (pioppo@abulafia.casa) (gcc version 3.2.2 (Mandrake 
Linux 9.1 3.2.2-3mdk)) #8 Thu Oct 9 21:42:21 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000bffc000 (usable)
 BIOS-e820: 000000000bffc000 - 000000000bfff000 (ACPI data)
 BIOS-e820: 000000000bfff000 - 000000000c000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
191MB LOWMEM available.
On node 0 totalpages: 49148
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45052 pages, LIFO batch:10
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.0 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f7f20
ACPI: RSDT (v001 ASUS   P5A      0x00000000  0x00000000) @ 0x0bffc000
ACPI: FADT (v001 ASUS   P5A      0x00000000  0x00000000) @ 0x0bffc080
ACPI: BOOT (v001 ASUS   P5A      0x00000000  0x00000000) @ 0x0bffc040
ACPI: DSDT (v001   ASUS P5A      0x00001000 MSFT 0x01000001) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=260test7 ro root=1606 devfs=mount pci=noacpi 
acpi=force
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 350.889 MHz processor.
Console: colour VGA+ 80x25
Memory: 191104k/196592k available (1805k kernel code, 4848k reserved, 553k 
data, 368k init, 0k highmem)
Calibrating delay loop... 694.27 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 008021bf 808029bf 00000000 00000000
CPU:     After vendor identify, caps: 008021bf 808029bf 00000000 00000000
Enabling new style K6 write allocation for 191 Mb
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU:     After all inits, caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0560, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030918
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fcfa0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xcfd0, dseg 0xf0000
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 0000:00:07.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2 C3)
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative SB16 PnP'
isapnp: 1 Plug & Play card detected total
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
ALI15X3: chipset revision 193
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALLlct10 10, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: SAMSUNG SV6003H, ATA DISK drive
hdd: PHILIPS CDRW1610A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 20044080 sectors (10262 MB) w/418KiB Cache, CHS=19885/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2
 p2: <openbsd: p5 p6bad subpartition - ignored
 >
hdc: max request size: 128KiB
hdc: 117304992 sectors (60060 MB) w/1945KiB Cache, CHS=65535/16/63, UDMA(33)
 /dev/ide/host0/bus1/target0/lun0: p1 p2 < p5 p6 p7 p8 >
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
ACPI: (supports S0 S1 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc6, size 8192, journal first block 18, max 
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc6) for (hdc6)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 368k freed
Adding 255488k swap on /dev/hdc5.  Priority:-1 extents:1
registering 1-0290
registering 0-0050
registering 0-0051
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 9 for device 0000:00:0a.0
PCI: Setting latency timer of device 0000:00:0a.0 to 64
eth0: RealTek RTL8139 at 0xcc8ee000, 00:48:54:1b:25:30, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
NET: Registered protocol family 17
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
PCI: Found IRQ 11 for device 0000:00:02.0
ohci-hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci-hcd 0000:00:02.0: irq 11, pci mem cc8f5000
ohci-hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 1-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb-0000:00:02.0-1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT2-fs warning (device hdc1): ext2_fill_super: mounting ext3 filesystem as 
ext2
Disabled Privacy Extensions on device c031de60(lo)
pnp: Device 01:01.00 activated.
pnp SB16: port=0x220, mpu port=0x330, fm port=0x388
pnp SB16: dma1=1, dma2=5, irq=5
SB [0x220]: DSP chip found, version = 4.13
OPL3: stat1 = 0xff
OPL2/3 chip not detected at 0x388/0x38a
sb16: no OPL device at 0x388-0x38a
####### Oops happens here #######
 <6>eth0: link up, 100Mbps, full-duplex, lpa 0x41E1

