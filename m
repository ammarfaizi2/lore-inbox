Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVAKCZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVAKCZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVAKCYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:24:49 -0500
Received: from ms-smtp-02-qfe0.socal.rr.com ([66.75.162.134]:48021 "EHLO
	ms-smtp-02-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S262583AbVAKCUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:20:11 -0500
Message-ID: <41E337DA.7080107@clones.net>
Date: Mon, 10 Jan 2005 18:20:10 -0800
From: Glendon Gross <gross@clones.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: UDF Support interfering with IDE boot?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

I've been struggling for the last few hours or so with a new build of 
2.6.10 on a machine where 2.6.9
boots fine (I have both in a lilo config menu.)  When I boot 2.6.10,  I 
get the following error:


UDF-fs:  No partition found (1)
Kernel Panic - not syncing: VFS:  Unable to mount root fs on unknown 
block(3,1)


I am curious, is there a quick fix for this?   Under 2.6.9 I have a 
successful boot.
(see below for 2.6.9 dmesg output)

Linux version 2.6.9-clonix_sound (root@optiplex) (gcc version 3.3.4) #20 
SMP Thu Dec 16 07:33:39 PST 2004
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
192MB LOWMEM available.
On node 0 totalpages: 49152
DMA zone: 4096 pages, LIFO batch:1
Normal zone: 45056 pages, LIFO batch:11
HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: Unable to locate RSDP
Built 1 zonelists
Kernel command line: BOOT_IMAGE=Linux-2.6.9 ro root=301
No local APIC present or hardware disabled
Initializing CPU#0
CPU 0 irqstacks, hard=c04f4000 soft=c04ec000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 364.283 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 189844k/196608k available (2520k kernel code, 6332k reserved, 
1267k data, 204k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
Ok.
Calibrating delay loop... 716.80 BogoMIPS (lpj=358400)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0387f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps:        0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 730.46 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfcf4e, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
i8k: unsupported model: OptiPlex GXa 366Mbr EM+
i8k: vendor=Dell Computer Corporation, model=OptiPlex GXa 366Mbr EM+, 
version=A10
i8k: unable to get SMM Dell signature
i8k: unable to get SMM BIOS version
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
pnp: the driver 'system' has been registered
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1105380620.805:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
atyfb: 3D RAGE PRO (BGA, AGP, 1x only) [0x4744 rev 0x7c] 2M SGRAM, 
14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
Console: switching to colour frame buffer device 80x25
fb0: ATY Mach64 frame buffer device on PCI
vesafb: abort, cannot reserve video memory at 0xfd000000
vesafb: framebuffer at 0xfd000000, mapped to 0xcd100000, size 1536k
vesafb: mode is 1024x768x8, linelength=1024, pages=1
vesafb: protected mode interface info at c000:4a9c
vesafb: scrolling: redraw
vesafb: Pseudocolor: size=6:6:6:6, shift=0:0:0:0
fb1: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440LX Chipset.
agpgart: Maximum main memory to use for agp memory: 150M
agpgart: AGP aperture is 64M @ 0xf0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
pnp: the driver 'serial' has been registered
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
  ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
  ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 91366U4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: DVD-RW IDE1008, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
pnp: the driver 'ide' has been registered
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 26588016 sectors (13613 MB) w/2048KiB Cache, CHS=26377/16/63, UDMA(33)
hda: cache flushes not supported
hda: hda1 hda2
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PCI: Found IRQ 10 for device 0000:02:09.0
PCI: Sharing IRQ 10 with 0000:02:0b.0
ahc_pci:2:9:0: hardware scb 64 bytes; kernel scb 52 bytes; ahc_dma 8 bytes
ahc_pci:2:9:0: Host Adapter Bios disabled.  Using default SCSI device 
parameters
scsi0: Waking DV thread
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
      <Adaptec aic7850 SCSI adapter>
      aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

Launching DV Thread
scsi0: Beginning Domain Validation
scsi0:A:0:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:0:0: Sending INQ
(scsi0:A:0:0): Saw Selection Timeout for SCB 0x3
scsi0:0:0: Command completed, status= 0x80000
scsi0:A:0:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:0:0: Failed DV inquiry, skipping
scsi0:A:1:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:1:0: Sending INQ
(scsi0:A:1:0): Saw Selection Timeout for SCB 0x2
scsi0:0:1: Command completed, status= 0x80000
scsi0:A:1:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:1:0: Failed DV inquiry, skipping
scsi0:A:2:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:2:0: Sending INQ
(scsi0:A:2:0): Saw Selection Timeout for SCB 0x3
scsi0:0:2: Command completed, status= 0x80000
scsi0:A:2:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:2:0: Failed DV inquiry, skipping
scsi0:A:3:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 1, status= 0x0, 
cmd->result= 0x10000
scsi0:2606: Going from state 1 to state 2
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 2, status= 0x0, 
cmd->result= 0x10000
scsi0:2606: Going from state 2 to state 3
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 3, status= 0x0, 
cmd->result= 0x10000
scsi0:2653: Going from state 3 to state 4
scsi0:A:3:0: Sending TUR
(scsi0:A:3:0): SCB 3: requests Check Status
(scsi0:A:3:0): Sending Sense
Copied 32 bytes of sense data:
0x70 0x0 0x6 0x0 0x0 0x0 0x0 0x18 0x0 0x0 0x0 0x0 0x29 0x0 0x0 0x0
0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
scsi0:0:3: Command completed, status= 0x80a0002
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 4, status= 
0x10905, cmd->result= 0x80a0002
scsi0:2799: Going from state 4 to state 4
scsi0:A:3:0: Sending TUR
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 4, status= 0x0, 
cmd->result= 0x10000
scsi0:2790: Going from state 4 to state 0
scsi0:A:4:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:4:0: Sending INQ
(scsi0:A:4:0): Saw Selection Timeout for SCB 0x3
scsi0:0:4: Command completed, status= 0x80000
scsi0:A:4:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:4:0: Failed DV inquiry, skipping
scsi0:A:5:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:5:0: Sending INQ
(scsi0:A:5:0): Saw Selection Timeout for SCB 0x2
scsi0:0:5: Command completed, status= 0x80000
scsi0:A:5:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:5:0: Failed DV inquiry, skipping
scsi0:A:6:0: Performing DV
scsi0:2431: Going from state 0 to state 1
scsi0:A:6:0: Sending INQ
(scsi0:A:6:0): Saw Selection Timeout for SCB 0x3
scsi0:0:6: Command completed, status= 0x80000
scsi0:A:6:0: Entering ahc_linux_dv_transition, state= 1, status= 
0x20005, cmd->result= 0x80000
scsi0:2625: Going from state 1 to state 0
scsi0:A:6:0: Failed DV inquiry, skipping
(scsi0:A:0:0): Saw Selection Timeout for SCB 0x2
(scsi0:A:1:0): Saw Selection Timeout for SCB 0x3
(scsi0:A:2:0): Saw Selection Timeout for SCB 0x2
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0xc0
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0x1
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0x3
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0x1
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0x19
scsi0:A:3:0: INITIATOR_MSG_OUT byte 0xf
scsi0:A:3:0: INITIATOR_MSG_OUT PHASEMIS in Message-in phase
scsi0:A:3:0: INITIATOR_MSG_IN byte 0x1
scsi0:A:3:0: INITIATOR_MSG_IN byte 0x3
scsi0:A:3:0: INITIATOR_MSG_IN byte 0x1
scsi0:A:3:0: INITIATOR_MSG_IN byte 0x19
scsi0:A:3:0: INITIATOR_MSG_IN byte 0xf
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
scsi0:A:3:0: INITIATOR_MSG_IN PHASEMIS in Command phase
Vendor: IBM       Model: DDRS-34560        Rev: S97B
Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:3:0: Tagged Queuing enabled.  Depth 32
(scsi0:A:4:0): Saw Selection Timeout for SCB 0x3
(scsi0:A:5:0): Saw Selection Timeout for SCB 0x2
(scsi0:A:6:0): Saw Selection Timeout for SCB 0x3
SCSI device sda: 8925000 512-byte hdwr sectors (4570 MB)
(scsi0:A:3:0): Handled Residual of 6 bytes
SCSI device sda: drive cache: write back
sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:11.0
uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
uhci_hcd 0000:00:07.2: irq 11, io base 0000cce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82371AB/EB/MB PIIX4 USB
usb usb1: Manufacturer: Linux 2.6.9-clonix_sound uhci_hcd
usb usb1: SerialNumber: 0000:00:07.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
usbcore: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
usbcore: registered new driver midi
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (1536 buckets, 12288 max) - 304 bytes per 
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: journal-1153: found in header: first_unflushed_offset 
7358, last_flushed_trans_id 219224
ReiserFS: hda1: journal-1206: Starting replay from offset 
941564205472958, trans_id 0
ReiserFS: hda1: journal-1299: Setting newest_mount_id to 111
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
uhci_hcd 0000:00:07.2: suspend_hc
Adding 441776k swap on /dev/hda2.  Priority:-1 extents:1
Linux Kernel Card Services
options:  [pci] [cardbus]
Intel ISA PCIC probe: not found.
Device 'i823650' does not have a release() function, it is broken and 
must be fixed.
Badness in device_release at drivers/base/core.c:85
[<c0104a35>] dump_stack+0x16/0x18
[<c020efc6>] kobject_cleanup+0x45/0x74
[<c020f309>] kref_put+0x60/0x6b
[<c020f01a>] kobject_put+0x18/0x1c
[<cc860e73>] init_i82365+0x71/0x186 [i82365]
[<c012b126>] sys_init_module+0xfc/0x21d
[<c0103bf7>] syscall_call+0x7/0xb
Databook TCIC-2 PCMCIA probe: not found.
PCI: Found IRQ 10 for device 0000:02:0b.0
PCI: Sharing IRQ 10 with 0000:02:09.0
PCI: Found IRQ 11 for device 0000:00:11.0
PCI: Sharing IRQ 11 with 0000:00:07.2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:11.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xcc80. Vers LK1.1.19
***INVALID CHECKSUM 003e*** eth0: Dropping NETIF_F_SG since no checksum 
feature.
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
nfs warning: mount version older than kernel
process `named' is using obsolete setsockopt SO_BSDCOMPAT



