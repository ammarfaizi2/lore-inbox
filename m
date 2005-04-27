Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVD0TXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVD0TXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 15:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVD0TXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 15:23:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:9915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261970AbVD0TXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 15:23:19 -0400
Date: Wed, 27 Apr 2005 12:23:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: vgoyal@in.ibm.com
Cc: akpm@osdl.org, sharyathi@in.ibm.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [Fastboot] Re: Kdump Testing
Message-Id: <20050427122312.358f5bd6.rddunlap@osdl.org>
In-Reply-To: <20050426085448.GB4234@in.ibm.com>
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
	<OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
	<20050425160925.3a48adc5.rddunlap@osdl.org>
	<20050426085448.GB4234@in.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 14:24:48 +0530
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> > 
> > 2.6.12-rc2-mm3 reboots vmlinux-recover-UP on panic.
> > (vmlinux-recover-SMP hangs during [early] reboot, but -UP
> > goes further....)
> > 
> > (BTW, how does I do serial console from the second
> > kernel...?  It has the drivers, but not the command
> > line info?  TBD.)
> > 
> 
> 
> While pre-loading the capture kernel using kexec, you can specify the command
> line options to second kernel using --append="". You must already be passing
> the root device. Add you serial console parameters as well something like
> --append="console=ttyS0, 38400"
> 
> 
> > vmlinux-recover-UP gets to this point, hand-written,
> > several lines missing:
> > 
> > kfree_debugcheck: bad ptr c3dbffb0h.  ( == %esi)
> > kernel BUG at <bad filename>:23128!
> > invalid operand: 0000 [#1]
> > DEBUG_PAGEALLOC
> > EIP is at kfree_debugcheck+0x45/0x50
> > 
> > Stack dump shows lots of ext3 cache and inode functions...
> > 
> 
> Can you post a full serial console output of second kernel? That would help.

I did another test run, same kernels (both running and recovery).
The recovery kernel got a little further this time, still had
Badness and a BUG.

---

Kernel panic - not syncing: crashtest
 Linux version 2.6.12-rc2-mm3 (rddunlap@gargoyle) (gcc version 3.3.3 (SuSE Linux)) #25 Tue Apr 26 17:52:39 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 0000000001000000 - 000000000144d000 (usable)
 user: 00000000014ed400 - 0000000005000000 (usable)
0MB HIGHMEM available.
80MB LOWMEM available.
DMI 2.3 present.
Allocating PCI resources starting at 05000000 (gap: 05000000:fb000000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda9 nosmp console=ttyS0,115200n8 console=tty0 init 1 memmap=exactmap memmap=640K@0K memmap=4404K@16384K memmap=60491K@21429K elfcorehdr=21428K
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 1685.983 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Unknown interrupt or fault at EIP 00000246 00000060 c13d6653
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 59468k/81920k available (2561k kernel code, 5956k reserved, 1311k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Xeon(TM) CPU 1.70GHz stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
softlockup thread 0 started up.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb110, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/2440] at 0000:00:1f.0
fscache: general fs caching registered
CacheFS: general fs caching v0.1 registered
inotify device minor=63
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i860 Chipset.
agpgart: AGP aperture is 64M @ 0xe8000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Intel(R) PRO/1000 Network Driver - version 5.7.6-k2
Copyright (c) 1999-2004 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Found IRQ 10 for device 0000:04:04.0
e100: eth0: e100_probe: addr 0xf4020000, irq 10, MAC addr 00:02:55:1A:35:D4
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 4
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST3160023A, ATA DISK drive
hdb: ST3160023A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LTN486S, ATAPI CD/DVD-ROM drive
hdd: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 >
hdb: max request size: 1024KiB
hdb: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
PCI: Enabling device 0000:03:01.0 (0006 -> 0007)
PCI: Found IRQ 11 for device 0000:03:01.0
PCI: Sharing IRQ 11 with 0000:03:01.1
PCI: Enabling device 0000:03:01.1 (0006 -> 0007)
PCI: Found IRQ 11 for device 0000:03:01.1
PCI: Sharing IRQ 11 with 0000:03:01.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

scsi2 : scsi_debug, version 1.75 [20050113], dev_size_mb=8, opts=0x0
  Vendor: Linux     Model: scsi_debug        Rev: 0004
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
SCSI device sda: drive cache: write back
 sda: unknown partition table
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
SCSI Media Changer driver v0.24 
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:1f.2
uhci_hcd 0000:00:1f.2: Intel Corporation 82801BA/BAM USB (Hub #1)
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 11, io base 0x0000b000
uhci_hcd 0000:00:1f.2: detected 2 ports
usb usb1: Product: Intel Corporation 82801BA/BAM USB (Hub #1)
usb usb1: Manufacturer: Linux 2.6.12-rc2-mm3 uhci_hcd
usb usb1: SerialNumber: 0000:00:1f.2
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
i2c /dev entries driver
EISA: Probing bus 0 at eisa.0
Cannot allocate resource for EISA slot 4
Cannot allocate resource for EISA slot 5
EISA: Detected 0 cards.
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
PCI: Found IRQ 11 for device 0000:00:1f.5
PCI: Sharing IRQ 11 with 0000:00:1f.3
input: AT Translated Set 2 keyboard on isa0060/serio0
intel8x0_measure_ac97_clock: measured 49559 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: Intel 82801BA-ICH2 with AD1885 at 0xb800, irq 11
NET: Registered protocol family 26
NET: Registered protocol family 2
IP: routing cache hash table of 128 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 4, 114688 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
CacheFS: Wrong magic number on cache
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding 2104472k swap on /dev/hda7.  Priority:42 extents:1
mismatch in kmem_cache_free: expected cache c168fc80, got c4daca80
c4daca80 is ext3_inode_cache.
c168fc80 is skbuff_head_cache.
Badness in cache_free_debugcheck at mm/slab.c:1917
 [<c1003368>] dump_stack+0x16/0x18
 [<c1041a94>] cache_free_debugcheck+0x88/0x1d5
 [<c10424fd>] kmem_cache_free+0x26/0x65
 [<c10a8c01>] ext3_destroy_inode+0x17/0x19
 [<c10784c9>] destroy_inode+0x27/0x3d
 [<c1078837>] dispose_list+0x60/0x178
 [<c1078f81>] prune_icache+0x363/0x399
 [<c1078fd0>] shrink_icache_memory+0x19/0x32
 [<c1044dd7>] shrink_slab+0x104/0x172
 [<c104641e>] try_to_free_pages+0xbe/0x16f
 [<c103d9a0>] __alloc_pages+0x1d3/0x393
 [<c104037c>] kmem_getpages+0x2d/0x7f
 [<c1041869>] cache_grow+0x155/0x2a8
 [<c1041f1f>] cache_alloc_refill+0x285/0x2c2
 [<c10423c6>] kmem_cache_alloc+0x5d/0x77
 [<c1075dac>] d_alloc+0x16/0x27a
 [<c106b2b9>] real_lookup+0x40/0xc2
 [<c106b68e>] do_lookup+0x41/0x75
 [<c106c3a7>] __link_path_walk+0xce5/0x1066
 [<c106c768>] link_path_walk+0x40/0xc7
 [<c106ca87>] path_lookup+0xec/0xf7
 [<c106cbc9>] __user_walk+0x28/0x42
 [<c10667b3>] vfs_lstat+0x17/0x3f
 [<c1066d1e>] sys_lstat64+0x13/0x29
 [<c1002c5f>] sysenter_past_esp+0x54/0x75
slab error in cache_free_debugcheck(): cache `ext3_inode_cache': double free, or memory outside object was overwritten
 [<c1003368>] dump_stack+0x16/0x18
 [<c1041ad2>] cache_free_debugcheck+0xc6/0x1d5
 [<c10424fd>] kmem_cache_free+0x26/0x65
 [<c10a8c01>] ext3_destroy_inode+0x17/0x19
 [<c10784c9>] destroy_inode+0x27/0x3d
 [<c1078837>] dispose_list+0x60/0x178
 [<c1078f81>] prune_icache+0x363/0x399
 [<c1078fd0>] shrink_icache_memory+0x19/0x32
 [<c1044dd7>] shrink_slab+0x104/0x172
 [<c104641e>] try_to_free_pages+0xbe/0x16f
 [<c103d9a0>] __alloc_pages+0x1d3/0x393
 [<c104037c>] kmem_getpages+0x2d/0x7f
 [<c1041869>] cache_grow+0x155/0x2a8
 [<c1041f1f>] cache_alloc_refill+0x285/0x2c2
 [<c10423c6>] kmem_cache_alloc+0x5d/0x77
 [<c1075dac>] d_alloc+0x16/0x27a
 [<c106b2b9>] real_lookup+0x40/0xc2
 [<c106b68e>] do_lookup+0x41/0x75
 [<c106c3a7>] __link_path_walk+0xce5/0x1066
 [<c106c768>] link_path_walk+0x40/0xc7
 [<c106ca87>] path_lookup+0xec/0xf7
 [<c106cbc9>] __user_walk+0x28/0x42
 [<c10667b3>] vfs_lstat+0x17/0x3f
 [<c1066d1e>] sys_lstat64+0x13/0x29
 [<c1002c5f>] sysenter_past_esp+0x54/0x75
c3d7afb0: redzone 1: 0x0, redzone 2: 0x0.
------------[ cut here ]------------
kernel BUG at <bad filename>:18422!
invalid operand: 0000 [#1]
DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c1041b46>]    Not tainted VLI
EFLAGS: 00010002   (2.6.12-rc2-mm3) 
EIP is at cache_free_debugcheck+0x13a/0x1d5
eax: c3d7a000   ebx: c3d7a000   ecx: 00001000   edx: 00000fb0
esi: c3d7afb0   edi: c4daca80   ebp: c2f73bb8   esp: c2f73bac
ds: 007b   es: 007b   ss: 0068
Process showconsole (pid: 1264, threadinfo=c2f72000 task=c2f68ac0)
Stack: c4d0fec4 c4daca80 c3d7bd44 c2f73be0 c10424fd c4daca80 c3d7bd44 c10a8c01 
       00000080 00000286 c3d7bddc c2f73c2c 00000080 c2f73bf0 c10a8c01 c4daca80 
       c3d7bd44 c2f73c00 c10784c9 c3d7bddc c3d7bddc c2f73c1c c1078837 c3d7bddc 
Call Trace:
 [<c100334a>] show_stack+0x7a/0x82
 [<c1003453>] show_registers+0xe9/0x153
 [<c100369f>] die+0x15c/0x23d
 [<c1003a79>] do_invalid_op+0x90/0x97
 [<c1002ed3>] error_code+0x4f/0x54
 [<c10424fd>] kmem_cache_free+0x26/0x65
 [<c10a8c01>] ext3_destroy_inode+0x17/0x19
 [<c10784c9>] destroy_inode+0x27/0x3d
 [<c1078837>] dispose_list+0x60/0x178
 [<c1078f81>] prune_icache+0x363/0x399
 [<c1078fd0>] shrink_icache_memory+0x19/0x32
 [<c1044dd7>] shrink_slab+0x104/0x172
 [<c104641e>] try_to_free_pages+0xbe/0x16f
 [<c103d9a0>] __alloc_pages+0x1d3/0x393
 [<c104037c>] kmem_getpages+0x2d/0x7f
 [<c1041869>] cache_grow+0x155/0x2a8
 [<c1041f1f>] cache_alloc_refill+0x285/0x2c2
 [<c10423c6>] kmem_cache_alloc+0x5d/0x77
 [<c1075dac>] d_alloc+0x16/0x27a
 [<c106b2b9>] real_lookup+0x40/0xc2
 [<c106b68e>] do_lookup+0x41/0x75
 [<c106c3a7>] __link_path_walk+0xce5/0x1066
 [<c106c768>] link_path_walk+0x40/0xc7
 [<c106ca87>] path_lookup+0xec/0xf7
 [<c106cbc9>] __user_walk+0x28/0x42
 [<c10667b3>] vfs_lstat+0x17/0x3f
 [<c1066d1e>] sys_lstat64+0x13/0x29
 [<c1002c5f>] sysenter_past_esp+0x54/0x75
Code: e8 bc e4 ff ff 8b 55 10 89 10 58 5a 8b 5b 0c 89 f0 31 d2 8b 4f 34 29 d8 f7 f1 3b 47 3c 72 02 0f 0b 0f af c1 8d 04 18 39 c6 74 02 <0f> 0b f6 47 39 02 74 15 6a 05 57 57 e8 1d e4 ff ff 8d 04 30 89 
 
