Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVAKFDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVAKFDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 00:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVAKFDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 00:03:47 -0500
Received: from ms-smtp-01-qfe0.socal.rr.com ([66.75.162.133]:58292 "EHLO
	ms-smtp-01-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S262367AbVAKFDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 00:03:17 -0500
Date: Mon, 10 Jan 2005 13:04:42 -0800 (PST)
From: Glendon Gross <gross@clones.net>
To: linux-kernel@vger.kernel.org
Subject: Successful build of 2.6.10 after IDE boot problem.
Message-ID: <Pine.LNX.4.60.0501101259460.3267@optiplex.clones.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For anyone who is interested,  my IDE boot problem was solved after I 
reconfigured the 2.6.10 kernel sources using my old /proc/config.gz from 
2.6.9.    [Thanks a million to whoever thought of that feature, as I had 
already done rm -rf /linux-2.6.9-sources so I had no other copy of
my config file.

I'm not sure why the generic kernel sources to 2.6.10 would not boot
initially.  I verified that IDE/ATA support was in the kernel.  Evidently
something had changed re:  the order in which modules are loaded.
For anyone who is interested, here is my dmesg from my first successful 
boot of 2.6.10:

c identify, caps: 0387f9ff 00000000 00000000 00000000
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
CPU0:
  domain 0: span 01
   groups: 01
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfcf4e, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
i8k: unsupported model: OptiPlex GXa 366Mbr EM+
i8k: vendor=Dell Computer Corporation, model=OptiPlex GXa 366Mbr EM+, version=A10
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
audit(1105390157.055:0): initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
atyfb: using auxiliary register aperture
atyfb: 3D RAGE PRO (Mach64 GD, BGA, AGP 1x) [0x4744 rev 0x7c]
atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
atyfb: BIOS frequency table:
atyfb: PCLK_min_freq 984, PCLK_max_freq 23500, ref_freq 1432, ref_divider 31
atyfb: MCLK_pwd 4200, MCLK_max_freq 7500, XCLK_max_freq 10000, SCLK_freq 5000
atyfb: 2M SGRAM (1:1), 14.31818 MHz XTAL, 235 MHz PLL, 75 Mhz MCLK, 100 MHz XCLK
atyfb: setting up CRTC
atyfb: set primary CRT to 640x480 PP composite N
atyfb: CRTC_H_TOTAL_DISP: 4f0063
atyfb: CRTC_H_SYNC_STRT_WID: c0052
atyfb: CRTC_V_TOTAL_DISP: 1df020c
atyfb: CRTC_V_SYNC_STRT_WID: 201ea
atyfb: CRTC_OFF_PITCH: 14000000
atyfb: CRTC_VLINE_CRNT_VLINE: 0
atyfb: CRTC_GEN_CNTL: b000200
atyfb: atyfb_set_par
atyfb:  Set Visible Mode to 640x480-8
atyfb:  Virtual resolution 640x3251, pixclock_in_ps 39726 (calculated 39726)
atyfb:  Dot clock:           25 MHz
atyfb:  Horizontal sync:     31 kHz
atyfb:  Vertical refresh:    59 Hz
atyfb:  x  style: 25.6850 640 664 760 800   480 491 493 525
atyfb:  fb style: 39726  40 640 24 96 32 480 11 2
debug atyfb: Mach64 non-shadow register values:
debug atyfb: 0x2000:  004F0063 000C0052 01DF020C 000201EA
debug atyfb: 0x2010:  015D0000 14000000 00000020 0B000200
debug atyfb: 0x2020:  005807EE 008207A5 00000000 00382848
debug atyfb: 0x2030:  00000000 00000000 00000000 0000C000
debug atyfb: 0x2040:  00000000 00000000 00000000 056007F2
debug atyfb: 0x2050:  03F805B5 00000000 00000000 00000000
debug atyfb: 0x2060:  00000000 AAAAAA0F 00000000 00000000
debug atyfb: 0x2070:  00000000 00000000 00007DDD 00803800
debug atyfb: 0x2080:  08900800 00801800 00000000 00000000
debug atyfb: 0x2090:  00A63003 00000000 0A008000 00000000
debug atyfb: 0x20A0:  7B23A050 00000000 00000000 65000C01
debug atyfb: 0x20B0:  10751A73 00010000 00010000 00000000
debug atyfb: 0x20C0:  00FF0000 87010182 00000000 00000000
debug atyfb: 0x20D0:  00000108 003C0130 00000000 00003F46
debug atyfb: 0x20E0:  7C004744 00000015 00000000 00000000
debug atyfb: 0x20F0:  00000000 00005A00 FCFFF4F8 00000000

debug atyfb: Mach64 PLL register values:
debug atyfb: 0x00:  ADD51F64 D803FFDA F5DADA01 A61B0000
debug atyfb: 0x10:  00008000 10A2CC10 00000000 00000000
debug atyfb: 0x20:  ADD51F64 D803FFDA F5DADA01 A61B0000
debug atyfb: 0x30:  00008000 10A2CC10 00000000 00000000

Console: switching to colour frame buffer device 80x30
atyfb: fb0: ATY Mach64 frame buffer device on PCI
vesafb: abort, cannot reserve video memory at 0xfd000000
vesafb: framebuffer at 0xfd000000, mapped to 0xcd100000, using 1536k, total 2048k
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
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
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
ahc_pci:2:9:0: Host Adapter Bios disabled.  Using default SCSI device parameters
scsi0: Waking DV thread
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec aic7850 SCSI adapter>
         aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

Launching DV Thread
scsi0: Beginning Domain Validation
scsi0:A:0:0: Performing DV
scsi0:2362: Going from state 0 to state 1
scsi0:A:0:0: Sending INQ
(scsi0:A:0:0): Saw Selection Timeout for SCB 0x3
scsi0:0:0: Command completed, status= 0x80000
scsi0:A:0:0: Entering ahc_linux_dv_transition, state= 1, status= 0x20005, cmd->result= 0x80000
scsi0:2556: Going from state 1 to state 0
scsi0:A:0:0: Failed DV inquiry, skipping
scsi0:A:1:0: Performing DV
scsi0:2362: Going from state 0 to state 1
scsi0:A:1:0: Sending INQ
(scsi0:A:1:0): Saw Selection Timeout for SCB 0x2
scsi0:0:1: Command completed, status= 0x80000
scsi0:A:1:0: Entering ahc_linux_dv_transition, state= 1, status= 0x20005, cmd->result= 0x80000
scsi0:2556: Going from state 1 to state 0
scsi0:A:1:0: Failed DV inquiry, skipping
scsi0:A:2:0: Performing DV
scsi0:2362: Going from state 0 to state 1
scsi0:A:2:0: Sending INQ
(scsi0:A:2:0): Saw Selection Timeout for SCB 0x3
scsi0:0:2: Command completed, status= 0x80000
scsi0:A:2:0: Entering ahc_linux_dv_transition, state= 1, status= 0x20005, cmd->result= 0x80000
scsi0:2556: Going from state 1 to state 0
scsi0:A:2:0: Failed DV inquiry, skipping
scsi0:A:3:0: Performing DV
scsi0:2362: Going from state 0 to state 1
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 1, status= 0x0, cmd->result= 0x10000
scsi0:2537: Going from state 1 to state 2
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 2, status= 0x0, cmd->result= 0x10000
scsi0:2537: Going from state 2 to state 3
scsi0:A:3:0: Sending INQ
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 3, status= 0x0, cmd->result= 0x10000
scsi0:2584: Going from state 3 to state 4
scsi0:A:3:0: Sending TUR
(scsi0:A:3:0): SCB 3: requests Check Status
(scsi0:A:3:0): Sending Sense
Copied 32 bytes of sense data:
0x70 0x0 0x6 0x0 0x0 0x0 0x0 0x18 0x0 0x0 0x0 0x0 0x29 0x0 0x0 0x0 
0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 
scsi0:0:3: Command completed, status= 0x80a0002
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 4, status= 0x10905, cmd->result= 0x80a0002
scsi0:2730: Going from state 4 to state 4
scsi0:A:3:0: Sending TUR
scsi0:0:3: Command completed, status= 0x10000
scsi0:A:3:0: Entering ahc_linux_dv_transition, state= 4, status= 0x0, cmd->result= 0x10000
scsi0:2721: Going from state 4 to state 0
scsi0:A:4:0: Performing DV
scsi0:2362: Going from state 0 to state 1
scsi0:A:4:0: Sending INQ
(scsi0:A:4:0): Saw Selection Timeout for SCB 0x3
scsi0:0:4: Command completed, status= 0x80000
scsi0:A:4:0: Entering ahc_linux_dv_transition, state= 1, status= 0x20005, cmd->result= 0x80000
scsi0:2556: Going from state 1 to state 0
scsi0:A:4:0: Failed DV inquiry, skipping
scsi0:A:5:0: Performing DV
scsi0:2362: Going from state 0 to state 1
scsi0:A:5:0: Sending INQ
(scsi0:A:5:0): Saw Selection Timeout for SCB 0x2
scsi0:0:5: Command completed, status= 0x80000
scsi0:A:5:0: Entering ahc_linux_dv_transition, state= 1, status= 0x20005, cmd->result= 0x80000
scsi0:2556: Going from state 1 to state 0
scsi0:A:5:0: Failed DV inquiry, skipping
scsi0:A:6:0: Performing DV
scsi0:2362: Going from state 0 to state 1
scsi0:A:6:0: Sending INQ
(scsi0:A:6:0): Saw Selection Timeout for SCB 0x3
scsi0:0:6: Command completed, status= 0x80000
scsi0:A:6:0: Entering ahc_linux_dv_transition, state= 1, status= 0x20005, cmd->result= 0x80000
scsi0:2556: Going from state 1 to state 0
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
uhci_hcd 0000:00:07.2: irq 11, io base 0xcce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Intel Corp. 82371AB/EB/MB PIIX4 USB
usb usb1: Manufacturer: Linux 2.6.10-clonix_sound uhci_hcd
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
hub 1-0:1.0: state 5 ports 2 chg ffff evt ffff
usbcore: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
hub 1-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
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
ip_conntrack version 2.1 (1536 buckets, 12288 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: journal-1153: found in header: first_unflushed_offset 533, last_flushed_trans_id 220912
ReiserFS: hda1: journal-1206: Starting replay from offset 948814110261781, trans_id 0
ReiserFS: hda1: journal-1299: Setting newest_mount_id to 114
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 208k freed
uhci_hcd 0000:00:07.2: suspend_hc
Adding 441776k swap on /dev/hda2.  Priority:-1 extents:1
PCI: Found IRQ 10 for device 0000:02:0b.0
PCI: Sharing IRQ 10 with 0000:02:09.0
PCI: Found IRQ 11 for device 0000:00:11.0
PCI: Sharing IRQ 11 with 0000:00:07.2
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:11.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xcc80. Vers LK1.1.19
  ***INVALID CHECKSUM 003e*** eth0: Dropping NETIF_F_SG since no checksum feature.
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
nfs warning: mount version older than kernel
process `named' is using obsolete setsockopt SO_BSDCOMPAT

