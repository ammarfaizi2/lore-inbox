Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272263AbTHOWyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272159AbTHOWyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:54:38 -0400
Received: from defout.telus.net ([199.185.220.240]:5341 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S272302AbTHOWyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:54:31 -0400
Subject: Firewire still bOrken (sigh)
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060988126.3006.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 Aug 2003 16:55:26 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly for Ben Collins (although any and all are encouraged to
take a peek).  After reading LKML for test2 and all of the work that
went in, I hoped firewire would be happy.  Unfortunately not.  The good
news is that a lot of other stuff is happy.  
(for instance, I am typing this to you from `uname -r`== 2.6.0-test3).

To be sure I didn't have any wacky configurations happening, I wiped /
and re-installed RH9, then module-init-tools, and rebuild 2.6.0-test3.
dmesg gives me the following:
Linux version 2.6.0-test3 (root@localhost.localdomain) (gcc version
3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Fri Aug 15 15:56:43 MDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda3 hdd=ide-scsi
ide_setup: hdd=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1890.214 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3735.55 BogoMIPS
Memory: 1034180k/1048512k available (1816k kernel code, 13420k reserved,
698k data, 244k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 3febfbff 00000000 00000000
00000000
CPU:     After vendor identify, caps: 3febfbff 00000000 00000000
00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 3febfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 1.80GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1889.0743 MHz.
..... host bus clock speed is 104.0985 MHz.
Initializing RT netlink socket
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci]
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
PCI: Using IRQ router default [1039/0645] at 0000:00:00.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try
pci=usepirqmaskpty: 256 Unix98 ptys configured
toshiba: not a supported Toshiba laptop
highmem bounce pool size: 64 pages
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
lp0: console ready
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 92041U4, ATA DISK drive
hdb: Maxtor 98196H8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
hdd: CR-4804TE, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 40020624 sectors (20490 MB) w/512KiB Cache, CHS=39703/16/63,
UDMA(66)
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63,
UDMA(100)
 hdb: hdb1
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at Virtual EISA Bridge
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 37449)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning (device hda3): ext2_fill_super: mounting ext3 filesystem
as ext2 
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 244k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Adding 1050832k swap on /dev/hda2.  Priority:-1 extents:1
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdb1, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdb1) for (hdb1)
Using r5 hash to sort names
ohci1394: $Rev: 1023 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[e7005000-e70057ff]  Max
Packet=[2048]
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0030e000e0000b39]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0030e000e0000ae3]
ieee1394: Host added: ID:BUS[0-02:1023]  GUID[001106001a250051]
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MITSUMI   Model: CR-4804TE         Rev: 2.4C
  Type:   CD-ROM                             ANSI SCSI revision: 02
sbp2: $Rev: 1018 $ Ben Collins <bcollins@debian.org>
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
arch/i386/kernel/semaphore.c:84: spin_is_locked on uninitialized
spinlock f75f98f8.
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c01c1c7a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01c1c7a>]    Not tainted
EFLAGS: 00010097
EIP is at vsnprintf+0x2de/0x44d
eax: 6b6b6b6b   ebx: 0000000a   ecx: 6b6b6b6b   edx: fffffffe
esi: c03b9feb   edi: 00000000   ebp: f7585d80   esp: f7585d48
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 769, threadinfo=f7584000 task=f7932200)
Stack: c03b9fdd c03ba3bf 00000054 00000000 0000000a ffffffff 00000001
00000002
       ffffffff ffffffff c03ba3bf c03b9fc0 00000046 f75f98f8 f7585dd0
c01222b6
       c03b9fc0 00000400 c02d0632 f7585de8 00000086 f75f98c8 f75aab6c
f75aaba0
Call Trace:
 [<c01222b6>] printk+0x16f/0x3b7
 [<c011c2ee>] __wake_up_locked+0x22/0x26
 [<c0108092>] __down+0x1b1/0x2e2
 [<c011c10e>] default_wake_function+0x0/0x2e
 [<f89fe0dd>] sbp2util_allocate_write_packet+0x68/0x74 [sbp2]
 [<c0108647>] __down_failed+0xb/0x14
 [<f8a01b5c>] .text.lock.sbp2+0xf/0x2f [sbp2]
 [<f89ff546>] sbp2_start_device+0x205/0x3e6 [sbp2]
 [<f89ff303>] sbp2_start_ud+0x106/0x144 [sbp2]
 [<f89fee34>] sbp2_probe+0x4b/0x4f [sbp2]
 [<c01f23e3>] bus_match+0x43/0x6e
 [<c01f24e5>] driver_attach+0x5c/0x60
 [<c01f2757>] bus_add_driver+0x91/0xa3
 [<c01f2ba2>] driver_register+0x88/0x8c
 [<f8919b04>] hpsb_register_protocol+0x17/0x28 [ieee1394]
 [<f8a01b26>] sbp2_module_init+0x7d/0xa4 [sbp2]
 [<c01401cb>] sys_init_module+0x1bb/0x318
 [<c0109d81>] sysenter_past_esp+0x52/0x71
 
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75
 <6>kudzu: numerical sysctl 1 23 is obsolete.
Slab corruption: start=f75f98c0, expend=f75f9937, problemat=f75f9900
Last user: [<f891218f>](free_hpsb_packet+0x2c/0x33 [ieee1394])
Data: ****************************************************************6A
******************************************************A5
Next: 71 F0 2C .8F 21 91 F8 71 F0 2C .....................
slab error in check_poison_obj(): cache `hpsb_packet': object was
modified after freeing
Call Trace:
 [<c0149894>] check_poison_obj+0x16c/0x1ac
 [<c0149a60>] slab_destroy+0x18c/0x194
 [<c014d63c>] cache_reap+0x293/0x408
 [<c012b68b>] update_process_times+0x46/0x50
 [<c014c78a>] reap_timer_fnc+0x0/0x29
 [<c014c795>] reap_timer_fnc+0xb/0x29
 [<c012b80c>] run_timer_softirq+0x15d/0x3d0
 [<c0111c9c>] timer_interrupt+0x152/0x36d
 [<c0126b75>] do_softirq+0xa1/0xa3
 [<c010c733>] do_IRQ+0x20e/0x348
 [<c0122e71>] profile_hook+0x21/0x25
 [<c0107009>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0x2a
 [<c010a740>] common_interrupt+0x18/0x20
 [<c0107009>] default_idle+0x0/0x2c
 [<c0105000>] rest_init+0x0/0x2a
 [<c0107030>] default_idle+0x27/0x2c
 [<c01070a1>] cpu_idle+0x31/0x3a
 [<c03786aa>] start_kernel+0x13d/0x13f
 [<c037843f>] unknown_bootoption+0x0/0xfa
 
ip_tables: (C) 2000-2002 Netfilter core team
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xe000, IRQ 11, 00:50:2c:02:96:89.
eth0: Media Link On 10mbps half-duplex
cdrom: This disc doesn't have any tracks I recognize!
[bob@localhost bob]$

...the build script looks like this:

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=m
                                                                                
#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
                                                                                
#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=m
                                                                                
#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_CMP is not set

..I have VIDEO1394 for a firewire attached camcorder.  Serial bus
protocol2 is for the firewire drives.  The hardware looks like:
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 43).

Send me mail for more info., I'm not on majordomo.
Thanks,
Bob

-- 
Bob Gill <gillb4@telusplanet.net>

