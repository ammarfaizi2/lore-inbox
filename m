Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbTGJHla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268992AbTGJHla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:41:30 -0400
Received: from outbound02.telus.net ([199.185.220.221]:12526 "EHLO
	priv-edtnes04.telusplanet.net") by vger.kernel.org with ESMTP
	id S269023AbTGJHjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:39:36 -0400
Subject: Firewire in 2.5.74 --Close to joy, but not quite
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057823705.6248.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 Jul 2003 01:55:05 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had been having problems with building 2.5.74.  First ACPI went out,
then firewire went out.  ACPI is still out but I got help with
firewire.  I added #include <linux/pci.h> to sbp2.c.  Joy!  compiling
sbp2 didn't kill the whole kernel compile.  Unfortunately on boot, there
is still no joy.  It coughs up nasty error messages (that's the bad
news).  The good news is that dmesg caught all of it.  I present it to
you here.  If it is something I am doing, (or even appears something I
am doing) please reply and I will attempt any an all requested changes
or tests.  Thanks in advance,

Bob


dmesg output:
 Linux version 2.5.74 (root@localhost.localdomain) (gcc version 3.2.2
20030222 (Red Hat Linux 3.2.2-5)) #1 Wed Jul 9 22:23:00 MDT 2003
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
Detected 1890.207 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3735.55 BogoMIPS
Memory: 1034072k/1048512k available (1920k kernel code, 13528k reserved,
695k data, 244k init, 131008k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000080
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
..... CPU clock speed is 1889.0746 MHz.
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
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [pm]
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
PCI: Using IRQ router default [1039/0645] at 0000:00:00.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try
pci=usepirqmaskpty: 256 Unix98 ptys configured
toshiba: not a supported Toshiba laptop
Enabling SEP on CPU 0
highmem bounce pool size: 64 pages
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: Found 1 daisy-chained devices
lp0: using parport0 (polling).
lp0: console ready
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
hda: host protected area => 1
hda: 40020624 sectors (20491 MB) w/512KiB Cache, CHS=39703/16/63,
UDMA(66)
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: host protected area => 1
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(100)
 hdb: hdb1
hdc: ATAPI 47X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at Virtual EISA Bridge
Cannot allocate resource for EISA slot 1
Cannot allocate resource for EISA slot 4
EISA: Detected 0 cards.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 37449)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning (device hda3): ext2_fill_super: mounting ext3 filesystem
as
ext2                                                                                
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 244k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
deprecated.
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
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MITSUMI   Model: CR-4804TE         Rev: 2.4C
  Type:   CD-ROM                             ANSI SCSI revision: 02
ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[e7005000-e70057ff]  Max
Packet=[2048]
ip_tables: (C) 2000-2002 Netfilter core team
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0030e000e0000b39]
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0030e000e0000ae3]
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc20160 ffc20000 00000000 42820404
scsi1 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
arch/i386/kernel/semaphore.c:84: spin_is_locked on uninitialized
spinlock f7d058f8.
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c01d241a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01d241a>]    Not tainted
EFLAGS: 00010097
EIP is at vsnprintf+0x2de/0x44d
eax: 6b6b6b6b   ebx: 0000000a   ecx: 6b6b6b6b   edx: fffffffe
esi: c03d406b   edi: 00000000   ebp: f7525d78   esp: f7525d40
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 874, threadinfo=f7524000 task=f7930800)
Stack: c03d405d c03d443f 00000054 00000000 0000000a ffffffff 00000001
00000002
       ffffffff ffffffff c03d443f c03d4040 00000046 00000282 f7525dc8
c0123c86
       c03d4040 00000400 c02e86b2 f7525de0 00000086 f7d058c0 00000004
f7d058c8
Call Trace:
 [<c0123c86>] printk+0x17a/0x3f8
 [<f8931edf>] dma_trm_flush+0xcf/0xe9 [ohci1394]
 [<c0108347>] __down+0x1e2/0x347
 [<c011cf08>] default_wake_function+0x0/0x2e
 [<f89140dd>] sbp2util_allocate_write_packet+0x68/0x74 [sbp2]
 [<c01089b3>] __down_failed+0xb/0x14
 [<f8918157>] .text.lock.sbp2+0x5/0x34 [sbp2]
 [<f8915692>] sbp2_start_device+0x1e8/0x3c9 [sbp2]
 [<f891546c>] sbp2_start_ud+0x106/0x144 [sbp2]
 [<f8914f6c>] sbp2_probe+0x32/0x3d [sbp2]
 [<c02057c3>] bus_match+0x43/0x6e
 [<c02058c5>] driver_attach+0x5c/0x60
 [<c0205b37>] bus_add_driver+0x91/0xa3
 [<c0205f82>] driver_register+0x88/0x8c
 [<f89250dc>] hpsb_register_protocol+0x17/0x28 [ieee1394]
 [<f8918128>] sbp2_module_init+0xa0/0xca [sbp2]
 [<c0143a8c>] sys_init_module+0x1db/0x392
 [<c010a1b1>] sysenter_past_esp+0x52/0x71
                                                                                
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75
 <6>note: modprobe[874] exited with preempt_count 2
Slab corruption: start=f7d058c0, expend=f7d05937, problemat=f7d05900
Last user: [<f891d1fd>](free_hpsb_packet+0x2c/0x33 [ieee1394])
Data: ****************************************************************6A
******************************************************A5
Next: 71 F0 2C .FD D1 91 F8 71 F0 2C .....................
slab error in check_poison_obj(): cache `hpsb_packet': object was
modified after freeing
Call Trace:
 [<c014d752>] check_poison_obj+0x155/0x195
 [<c014f6a2>] kmem_cache_alloc+0x120/0x158
 [<f891d0e0>] alloc_hpsb_packet+0x21/0x112 [ieee1394]
 [<f891d0e0>] alloc_hpsb_packet+0x21/0x112 [ieee1394]
 [<f891fc2a>] hpsb_make_readpacket+0x43/0xd2 [ieee1394]
 [<f892009a>] hpsb_read+0x59/0xff [ieee1394]
 [<f8923f49>] nodemgr_read_quadlet+0x5b/0x99 [ieee1394]
 [<f89253a9>] read_businfo_block+0x4f/0x185 [ieee1394]
 [<f8925518>] nodemgr_node_probe_one+0x39/0xe9 [ieee1394]
 [<c011d112>] __wake_up_locked+0x22/0x26
 [<f8925702>] nodemgr_node_probe+0x104/0x109 [ieee1394]
 [<f89259e6>] nodemgr_host_thread+0x113/0x179 [ieee1394]
 [<f89258d3>] nodemgr_host_thread+0x0/0x179 [ieee1394]
 [<c0107471>] kernel_thread_helper+0x5/0xb
                                                                                
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xe000, IRQ 11, 00:50:2c:02:96:89.
eth0: Media Link On 10mbps half-duplex
Linux video capture interface: v1.00
bttv: driver version 0.9.4 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is Silicon Integrated S SiS645 Host & Memory
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 0000:00:0b.0, irq: 5, latency: 32, mmio:
0xe7003000
bttv0: detected: ATI TV Wonder/VE [card=64], PCI subsystem ID is
1002:0003
bttv0: using: BT878(ATI TV-Wonder VE) [card=64,autodetected]
bttv0: using tuner=19
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tuner: chip found @ 0xc0
tuner: type set to 19 (Temic PAL* auto (4006 FN5))
registering 0-0060
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
imm: Version 2.05 (for Linux 2.4.0)
imm: Found device at ID 6, Attempting to use EPP 32 bit
imm: Found device at ID 6, Attempting to use PS/2
imm: Communication established at 0x378 with ID 6 using PS/2
scsi2 : Iomega VPI2 (imm) interface
IMM: IEEE1284 negotiate indicates no data available.
bad: scheduling while atomic!
Call Trace:
 [<c011ceb3>] schedule+0x6e4/0x6e9
 [<c014f6b6>] kmem_cache_alloc+0x134/0x158
 [<c012fa53>] send_signal+0x144/0x14b
 [<c011d6cb>] wait_for_completion+0x13c/0x325
 [<c011cf08>] default_wake_function+0x0/0x2e
 [<c011cf08>] default_wake_function+0x0/0x2e
 [<c013095b>] kill_proc_info+0x41/0x62
 [<f8925e81>] nodemgr_remove_host+0x55/0x93 [ieee1394]
 [<f892136d>] highlevel_remove_host+0x72/0x82 [ieee1394]
 [<f8936f4c>] ohci1394_pci_remove+0x3e/0x159 [ohci1394]
 [<c01d8178>] pci_device_remove+0x3b/0x3d
 [<c0205929>] device_release_driver+0x60/0x62
 [<c020594d>] driver_detach+0x22/0x31
 [<c0205b84>] bus_remove_driver+0x3b/0x70
 [<c0205f9a>] driver_unregister+0x14/0x28
 [<c01d8572>] pci_unregister_driver+0x17/0x25
 [<f89375ba>] ohci1394_cleanup+0x12/0x16 [ohci1394]
 [<c0141b26>] sys_delete_module+0x11e/0x15c
 [<c015d907>] sys_munmap+0x43/0x61
 [<c010a1b1>] sysenter_past_esp+0x52/0x71

...and that's all folks!
...the kernel otherwise boots and runs, ieee1394 and sbp2 show up in
lsmod as being loaded, but no devices show up in /proc/partitions. 
Attempting to rmmod sbp2 causes another oops. (no crash, just an oops). 
-- 
Bob Gill <gillb4@telusplanet.net>

