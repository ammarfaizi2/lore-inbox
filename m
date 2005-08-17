Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVHQLxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVHQLxJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVHQLxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:53:09 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:59581 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751103AbVHQLxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:53:08 -0400
Subject: Re: [Fwd: help with PCI hotplug and a PCI device enabled after
	boot]
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200508171315.32704@bilbo.math.uni-mannheim.de>
References: <1124269343.4423.35.camel@localhost>
	 <200508171147.22927@bilbo.math.uni-mannheim.de>
	 <1124276090.4423.46.camel@localhost>
	 <200508171315.32704@bilbo.math.uni-mannheim.de>
Content-Type: multipart/mixed; boundary="=-5PhaNl3QgPNXKJ/kG99y"
Date: Wed, 17 Aug 2005 08:53:00 -0300
Message-Id: <1124279580.4423.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-6mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5PhaNl3QgPNXKJ/kG99y
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Em Qua, 2005-08-17 às 13:15 +0200, Rolf Eike Beer escreveu:
> Am Mittwoch, 17. August 2005 12:54 schrieb Mauro Carvalho Chehab:
> >Rolf,
> >
> >Em Qua, 2005-08-17 às 11:47 +0200, Rolf Eike Beer escreveu:
> >> Mauro Carvalho Chehab wrote:
> >> >    I need some help with PCI hotplug for allowing a new driver at
> >> >Video4Linux.
> >> >
> >> >    I need memory to set its internal registers. Is there a way to make
> >> >PCI drivers to allocate a memory region for the board?
> >>
> >> Use dummyphp instead of fakephp. It should handle this case. You can find
> >> it here: http://opensource.sf-tec.de/kernel/dummyphp-2.6.13-rc1.diff
> >
> >	Didn't compile cleanly against -rc6. Do I need another patch or -mm
> >series?
> >
> >WARNING: /lib/modules/2.6.13-rc6/kernel/drivers/pci/hotplug/dummyphp.ko
> >needs unknown symbol pci_bus_add_resources
> 
> Damn, I should stop editing diffs by hand. 
	I'm also have this old habbit ;-)
> 
> Change this to 
> pci_bus_assign_resources and it should work. Sorry.
	It works, but produced an oops (attached).
> 
> Eike
Cheers, 
Mauro.

--=-5PhaNl3QgPNXKJ/kG99y
Content-Disposition: attachment; filename=oops.txt
Content-Type: text/plain; name=oops.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

...............................................................................................................................................................
Table [DSDT](id F004) - 701 Objects with 75 Devices 260 Methods 27 Regions
ACPI Namespace successfully loaded at root c045f6c0
evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=0 pin2=-1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
evgpeblk-0979 [06] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs on int 0x9
evgpeblk-0987 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:........................................................................
Initialized 27/27 Regions 1/1 Fields 28/28 Buffers 16/24 Packages (710 nodes)
Executing all Device _STA and_INI methods:..............................................................................
78 Devices found containing: 78 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:01.1[A] -> Link [APCS] -> GSI 23 (level, high) -> IRQ 23
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) -> IRQ 22
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) -> IRQ 21
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 20 (level, high) -> IRQ 20
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCH] -> GSI 22 (level, high) -> IRQ 22
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 21 (level, high) -> IRQ 21
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [APC4] -> GSI 19 (level, high) -> IRQ 19
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC4] -> GSI 19 (level, high) -> IRQ 19
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4200-0x427f has been reserved
pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
pnp: 00:01: ioport range 0x5000-0x503f has been reserved
pnp: 00:01: ioport range 0x5500-0x553f has been reserved
audit: initializing netlink socket (disabled)
audit(1124267613.114:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SAMSUNG SP1604N, ATA DISK drive
hdb: QUANTUM FIREBALL EL5.1A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-ST DVDRAM GSA-4081B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 >
hdb: max request size: 128KiB
hdb: 10018890 sectors (5129 MB) w/418KiB Cache, CHS=10602/15/63, UDMA(33)
hdb: cache flushes not supported
 /dev/ide/host0/bus0/target1/lun0: p1 p2
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
swsusp: Suspend partition has wrong signature?
ACPI wakeup devices: 
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
ACPI: (supports S0 S1 S4 S4bios S5)
input: AT Translated Set 2 keyboard on isa0060/serio0
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Real Time Clock Driver v1.12
ACPI: Power Button (FF) [PWRF]
EXT3 FS on hda7, internal journal
Adding 2008084k swap on /dev/hda6.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
input: PS/2 Generic Mouse on isa0060/serio1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
hdc: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xef
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.32.
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCH] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Bridge firewalling registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET: Registered protocol family 17
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 248 bytes per conntrack
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
lp: driver loaded but no devices found
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 21 (level, high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49739 usecs
intel8x0: clocking to 47433
Warning: /proc/ide/hd?/settings interface is obsolete, and will be removed soon!
cdrom: open failed.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
dummyphp: Dummy PCI Hot Plug Controller Driver
Linux video capture interface: v1.00
cx2388x v4l2 driver version 0.0.5 loaded
cx2388x: snapshot date 2005-08-17
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [APC4] -> GSI 19 (level, high) -> IRQ 19
CORE cx88[0]: subsystem: 0000:0000, board: PixelView PlayTV Ultra Pro (Stereo) [card=27,insmod option]
TV tuner 59 at 0x1fe, Radio tuner -1 at 0x1fe
cx88[0]: cx88_reset
tveeprom(cx88xx internal): Huh, no eeprom present (err=-121)?
cx88[0] IR: irq gpio=0xc0 code=0 | poll up
cx88[0]: registered IR remote control
cx88[0]/0: found at 0000:01:07.0, rev: 5, irq: 19, latency: 32, mmio: 0xe2000000
 : chip found @ 0xc0 (cx88[0])
tuner-0060 I2C RECV = 29 d5 38 00 00 ff ff ff ff ff ff ff ff ff ff ff 
 : TEA5767 detected.
 : Calling set_type_addr for type=59, addr=0xff, mode=0x04
tuner 0-0060: type set to 62 (Philips TEA5767HN FM Radio)
tuner 0-0060: cx88[0] tuner I2C addr 0xc0 with type 62 used for 0x02
 : chip found @ 0xc2 (cx88[0])
tuner-0061 I2C RECV = 79 79 79 79 79 79 79 79 79 79 79 79 79 79 79 79 
 : Setting mode_mask to 0x0c
 : Calling set_type_addr for type=59, addr=0xff, mode=0x04
 : tuner 0x61: called during i2c_client register by adapter's attach_inform
tuner 0-0061: type set to 59 (Ymec TVision TVF-5533MF)
tuner 0-0061: cx88[0] tuner I2C addr 0xc2 with type 59 used for 0x0c
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
cx88[0]/0: registered device radio0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c033bf0a
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: tuner cx8800 cx88xx i2c_algo_bit video_buf ir_common tveeprom i2c_core v4l1_compat v4l2_common btcx_risc videodev dummyphp pci_hotplug binfmt_misc snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore lp parport_pc parport usblp ipt_state ipt_REJECT ip_conntrack_irc ip_conntrack_ftp ip_conntrack iptable_filter ip_tables af_packet floppy bridge usbcore forcedeth ide_cd loop evdev nls_iso8859_1 nls_cp850 vfat fat psmouse video thermal processor fan container button battery ac rtc
CPU:    0
EIP:    0060:[<c033bf0a>]    Not tainted VLI
EFLAGS: 00010002   (2.6.12.4) 
EIP is at __down+0x5a/0x110
eax: 00000000   ebx: ded56380   ecx: daf5de80   edx: daf5c000
esi: 00000282   edi: daf5c000   ebp: df6c4a40   esp: daf5de70
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 8752, threadinfo=daf5c000 task=df6c4a40)
Stack: ded56388 00000001 df6c4a40 c0116ea0 ded56388 00000000 ddebe260 e0a95fc0 
       e0a94703 c89cf260 ded56000 ded56010 dff30400 c033c113 00003fe5 e0b3e6cc 
       e0b3a4ee e0b3b324 ded56010 00000000 e0b3af19 c89cf260 00000020 e2000000 
Call Trace:
 [<c0116ea0>] default_wake_function+0x0/0x20
 [<e0a94703>] video_register_device+0x153/0x200 [videodev]
 [<c033c113>] __down_failed+0x7/0xc
 [<e0b3a4ee>] .text.lock.cx88_video+0x9b/0xbd [cx8800]
 [<c0218c72>] pci_device_probe_static+0x52/0x70
 [<c0218ccc>] __pci_device_probe+0x3c/0x50
 [<c0218d0c>] pci_device_probe+0x2c/0x60
 [<c0282c9f>] driver_probe_device+0x2f/0x80
 [<c0282df2>] driver_attach+0x52/0xa0
 [<c0283358>] bus_add_driver+0x98/0xe0
 [<c0218fc5>] pci_register_driver+0x65/0x90
 [<e0b3a437>] cx8800_init+0x57/0x60 [cx8800]
 [<c01375a8>] sys_init_module+0x138/0x200
 [<c010326b>] sysenter_past_esp+0x54/0x75
Code: 02 00 00 00 9c 5e fa ff 42 14 8d 43 08 83 4c 24 04 01 8d 4c 24 10 89 04 24 89 c7 8b 40 04 89 7c 24 10 89 4f 04 89 d7 89 44 24 14 <89> 08 ff 43 04 eb 25 c7 43 04 01 00 00 00 56 9d 8b 47 08 ff 4f 
 <6>note: modprobe[8752] exited with preempt_count 1
scheduling while atomic: modprobe/0x10000001/8752
 [<c033c6d6>] schedule+0x596/0x640
 [<c014e64d>] zap_pte_range+0xed/0x1e0
 [<c014e7c5>] unmap_page_range+0x85/0xc0
 [<c033cf47>] cond_resched+0x27/0x40
 [<c014ea00>] unmap_vmas+0x200/0x220
 [<c01537b4>] exit_mmap+0x84/0x170
 [<c0114fe0>] do_page_fault+0x0/0x5de
 [<c0118517>] mmput+0x37/0xb0
 [<c011d120>] do_exit+0xc0/0x3a0
 [<c0114fe0>] do_page_fault+0x0/0x5de
 [<c0104558>] die+0x188/0x190
 [<c0114fe0>] do_page_fault+0x0/0x5de
 [<c011aee7>] printk+0x17/0x20
 [<c01153b7>] do_page_fault+0x3d7/0x5de
 [<c033c7c5>] preempt_schedule+0x45/0x70
 [<c012b480>] call_usermodehelper+0xb0/0xc0
 [<c012b360>] __call_usermodehelper+0x0/0x70
 [<c021224a>] vsnprintf+0x2ea/0x510
 [<c011ad25>] call_console_drivers+0x65/0x140
 [<c0114fe0>] do_page_fault+0x0/0x5de
 [<c0103d4b>] error_code+0x4f/0x54
 [<c033bf0a>] __down+0x5a/0x110
 [<c0116ea0>] default_wake_function+0x0/0x20
 [<e0a94703>] video_register_device+0x153/0x200 [videodev]
 [<c033c113>] __down_failed+0x7/0xc
 [<e0b3a4ee>] .text.lock.cx88_video+0x9b/0xbd [cx8800]
 [<c0218c72>] pci_device_probe_static+0x52/0x70
 [<c0218ccc>] __pci_device_probe+0x3c/0x50
 [<c0218d0c>] pci_device_probe+0x2c/0x60
 [<c0282c9f>] driver_probe_device+0x2f/0x80
 [<c0282df2>] driver_attach+0x52/0xa0
 [<c0283358>] bus_add_driver+0x98/0xe0
 [<c0218fc5>] pci_register_driver+0x65/0x90
 [<e0b3a437>] cx8800_init+0x57/0x60 [cx8800]
 [<c01375a8>] sys_init_module+0x138/0x200
 [<c010326b>] sysenter_past_esp+0x54/0x75

--=-5PhaNl3QgPNXKJ/kG99y--

