Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUFFMwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUFFMwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUFFMwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:52:44 -0400
Received: from smtp.vzavenue.net ([66.171.59.140]:44346 "EHLO
	smtp.vzavenue.net") by vger.kernel.org with ESMTP id S263475AbUFFMvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:51:38 -0400
Message-ID: <40C313AE.10503@vzavenue.net>
Date: Sun, 06 Jun 2004 08:53:02 -0400
From: Vincent van de Camp <vncnt@vzavenue.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ktech@wanadoo.es
CC: manfred@colorfullife.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: 2.6.7-rc1 breaks forcedeth
References: <E1BWwTR-0003d0-I6@mb07.in.mad.eresmas.com>
In-Reply-To: <E1BWwTR-0003d0-I6@mb07.in.mad.eresmas.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Junkmail-Status: score=0/50, host=smtp.vzavenue.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not use the forcedeth driver, but I do have IRQ 11 problems with an 
nforce2 motherboard. I'm not entirely sure if this is the same problem, 
but loading the ehci module (managed by hotplug) triggers the kernel to 
disable IRQ 11. Dmesg with some stack traces:

Linux version 2.6.6 (root@a7n8x) (gcc version 3.3.2 20031218 (Gentoo 
Linux 3.3.2-r5, propolice-3.3-7)) #4 Fri Jun 4 07:47:27 EDT 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000005fff0000 (usable)
  BIOS-e820: 000000005fff0000 - 000000005fff3000 (ACPI NVS)
  BIOS-e820: 000000005fff3000 - 0000000060000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393200
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 163824 pages, LIFO batch:16
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6d60
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x5fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x5fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x5fff74c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
Kernel command line: root=/dev/hda2 hdc=none
ide_setup: hdc=none
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2162.633 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 1556320k/1572800k available (1850k kernel code, 15312k reserved, 
681k data, 124k init, 655296k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4276.22 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 3000+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB1._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, 
disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11
ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 11
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 5
ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
ACPI: PCI Interrupt Link [L3CM] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
SGI XFS with no debug enabled
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: 100% native mode on irq 11
     ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
     ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: WDC WD360GD-00FNA0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0xf8808080-0xf8808087,0xf880808a on irq 11
hda: max request size: 64KiB
hda: 72303840 sectors (37019 MB) w/8192KiB Cache, CHS=16383/255/63, 
UDMA(133)
  hda: hda1 hda2 hda3
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 296 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
ACPI: (supports S0 S1 S3 S4 S4bios S5)
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 124k freed
NET: Registered protocol family 1
Adding 1606492k swap on /dev/hda3.  Priority:-1 extents:1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:01.0: 3Com PCI 3c920 Tornado at 0xb000. Vers LK1.1.19
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
     ide2: BM-DMA at 0xf000-0xf007, BIOS settings: hde:DMA, hdf:DMA
     ide3: BM-DMA at 0xf008-0xf00f, BIOS settings: hdg:DMA, hdh:DMA
hde: YAMAHA CRW2200E, ATAPI CD/DVD-ROM drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
input: PS/2 Logitech Mouse on isa0060/serio1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 1430M
agpgart: AGP aperture is 64M @ 0xd8000000
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 5, pci mem f893c000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem f8943000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 11, pci mem f8945000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
irq 11: nobody cared!
  [<c0105a9a>] __report_bad_irq+0x2a/0x90
  [<c0105b90>] note_interrupt+0x70/0xa0
  [<c0105e31>] do_IRQ+0x121/0x130
  [<c0104208>] common_interrupt+0x18/0x20
  [<c011ae30>] __do_softirq+0x30/0x80
  [<c011aea6>] do_softirq+0x26/0x30
  [<c0105e0d>] do_IRQ+0xfd/0x130
  [<c0104208>] common_interrupt+0x18/0x20
  [<c020821f>] pci_bus_read_config_byte+0x5f/0x90
  [<f89a539e>] ehci_start+0x2ce/0x360 [ehci_hcd]
  [<c01175fd>] printk+0x10d/0x170
  [<f8952507>] usb_register_bus+0x137/0x160 [usbcore]
  [<f895758b>] usb_hcd_pci_probe+0x2ab/0x4e0 [usbcore]
  [<c020bb42>] pci_device_probe_static+0x52/0x70
  [<c020bb9b>] __pci_device_probe+0x3b/0x50
  [<c020bbdc>] pci_device_probe+0x2c/0x50
  [<c02441cf>] bus_match+0x3f/0x70
  [<c02442f9>] driver_attach+0x59/0x90
  [<c02445a1>] bus_add_driver+0x91/0xb0
  [<c0244a5f>] driver_register+0x2f/0x40
  [<c020be5c>] pci_register_driver+0x5c/0x90
  [<f8936023>] init+0x23/0x30 [ehci_hcd]
  [<c012cc04>] sys_init_module+0x114/0x230
  [<c0104049>] sysenter_past_esp+0x52/0x71

handlers:
[<c0258b90>] (ide_intr+0x0/0x190)
[<f8953300>] (usb_hcd_irq+0x0/0x70 [usbcore])
Disabling IRQ #11
irq 11: nobody cared!
  [<c0105a9a>] __report_bad_irq+0x2a/0x90
  [<c0105b90>] note_interrupt+0x70/0xa0
  [<c0105e31>] do_IRQ+0x121/0x130
  [<c0104208>] common_interrupt+0x18/0x20
  [<c011ae30>] __do_softirq+0x30/0x80
  [<c011aea6>] do_softirq+0x26/0x30
  [<c0105e0d>] do_IRQ+0xfd/0x130
  [<c0104208>] common_interrupt+0x18/0x20
  [<c0248b86>] generic_unplug_device+0x26/0x70
  [<c0248bf1>] blk_backing_dev_unplug+0x21/0x30
  [<c01f3fef>] pagebuf_iowait+0x5f/0x70
  [<c01f39f9>] pagebuf_iostart+0x69/0xb0
  [<c01f30dc>] pagebuf_get+0x14c/0x1b0
  [<c01e485c>] xfs_trans_read_buf+0x31c/0x380
  [<c01af7e9>] xfs_da_do_buf+0x6a9/0x9b0
  [<c01f30dc>] pagebuf_get+0x14c/0x1b0
  [<c01c9944>] xfs_itobp+0x114/0x270
  [<c01afba7>] xfs_da_read_buf+0x57/0x60
  [<c01b3d42>] xfs_dir2_block_lookup_int+0x52/0x190
  [<c01b3d42>] xfs_dir2_block_lookup_int+0x52/0x190
  [<c01b3c5f>] xfs_dir2_block_lookup+0x2f/0xc0
  [<c01b1fd3>] xfs_dir2_lookup+0xc3/0x140
  [<c01e59bc>] xfs_dir_lookup_int+0x4c/0x130
  [<c01eb3f0>] xfs_lookup+0x50/0x90
  [<c01f7977>] linvfs_lookup+0x67/0xa0
  [<c015be4b>] real_lookup+0xcb/0xf0
  [<c015c0d6>] do_lookup+0x96/0xb0
  [<c015c215>] link_path_walk+0x125/0x960
  [<c015ccb7>] path_lookup+0x77/0x140
  [<c015d363>] open_namei+0x83/0x400
  [<c014db1e>] filp_open+0x3e/0x70
  [<c014dfeb>] sys_open+0x5b/0x90
  [<c0104049>] sysenter_past_esp+0x52/0x71

handlers:
[<c0258b90>] (ide_intr+0x0/0x190)
[<f8953300>] (usb_hcd_irq+0x0/0x70 [usbcore])
Disabling IRQ #11
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49415 usecs
intel8x0: clocking to 47438
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[5] 
MMIO=[e2083000-e20837ff]  Max Packet=[2048]
nfs warning: mount version older than kernel

ktech@wanadoo.es wrote:
> Hi manfred,
> 
> 
> 
> My ethernet drivers don't work even with that patch.
> 
> 
> 
> This is the relevant part that I think you want of the dmesg:
> 
> 
> 
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
> 
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11
> 
> PCI: Setting latency timer of device 0000:00:04.0 to 64
> 
> forcedeth: irq line 11, Status 0x       4, Mask 08x
> 
> eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0
> 
> 
> 
> And this is the entire dmesg:
> 
> 
> 
> Linux version 2.6.7-rc2-Redeeman1 (root@evanescence) (gcc versi?n 3.4.0 20040519 (Gentoo Linux 3.4.0-r5, ssp-3.4-2, pie-8.7.6.2)) #4 Sun Jun 6 00:32:25 CEST 2004
> 
> BIOS-provided physical RAM map:
> 
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> 
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> 
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> 
>  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
> 
>  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
> 
>  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
> 
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> 
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> 
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 
> Warning only 896MB will be used.
> 
> Use a HIGHMEM enabled kernel.
> 
> 896MB LOWMEM available.
> 
> On node 0 totalpages: 229376
> 
>   DMA zone: 4096 pages, LIFO batch:1
> 
>   Normal zone: 225280 pages, LIFO batch:16
> 
>   HighMem zone: 0 pages, LIFO batch:1
> 
> DMI 2.2 present.
> 
> ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6ba0
> 
> ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
> 
> ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
> 
> ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
> 
> Built 1 zonelists
> 
> Initializing CPU#0
> 
> Kernel command line: BOOT_IMAGE=2.6.7rc2-rd1 ro root=304
> 
> PID hash table entries: 4096 (order 12: 32768 bytes)
> 
> Detected 2037.724 MHz processor.
> 
> Using tsc for high-res timesource
> 
> Console: colour VGA+ 80x25
> 
> Memory: 906844k/917504k available (1789k kernel code, 9912k reserved, 518k data, 120k init, 0k highmem)
> 
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> 
> Calibrating delay loop... 4030.46 BogoMIPS
> 
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> 
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> 
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> 
> CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
> 
> CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
> 
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> 
> CPU: L2 Cache: 512K (64 bytes/line)
> 
> CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
> 
> Intel machine check architecture supported.
> 
> Intel machine check reporting enabled on CPU#0.
> 
> CPU: AMD Athlon(tm)  stepping 00
> 
> Enabling fast FPU save and restore... done.
> 
> Enabling unmasked SIMD FPU exception support... done.
> 
> Checking 'hlt' instruction... OK.
> 
> NET: Registered protocol family 16
> 
> PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2
> 
> PCI: Using configuration type 1
> 
> mtrr: v2.0 (20020519)
> 
> ACPI: Subsystem revision 20040326
> 
> ACPI: IRQ9 SCI: Edge set to Level Trigger.
> 
> ACPI: Interpreter enabled
> 
> ACPI: Using PIC for interrupt routing
> 
> ACPI: PCI Root Bridge [PCI0] (00:00)
> 
> PCI: Probing PCI hardware (bus 00)
> 
> PCI: nForce2 C1 Halt Disconnect fixup
> 
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> 
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
> 
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
> 
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> 
> ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> 
> ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> 
> ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LAPU] (IRQs *3 4 5 6 7 10 11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 *7 10 11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> 
> ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> 
> ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> 
> ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> 
> ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
> 
> ACPI: PCI Interrupt Link [APC1] (IRQs *16)
> 
> ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
> 
> ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
> 
> ACPI: PCI Interrupt Link [APC4] (IRQs *19)
> 
> ACPI: PCI Interrupt Link [APCE] (IRQs *16), disabled.
> 
> ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
> 
> ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
> 
> ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0
> 
> ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0
> 
> ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0
> 
> ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
> 
> ACPI: PCI Interrupt Link [APCS] (IRQs *23)
> 
> ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
> 
> ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
> 
> ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
> 
> ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
> 
> SCSI subsystem initialized
> 
> PCI: Using ACPI for IRQ routing
> 
> ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 7
> 
> ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 7 (level, low) -> IRQ 7
> 
> ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5
> 
> ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 5 (level, low) -> IRQ 5
> 
> ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 10
> 
> ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 10 (level, low) -> IRQ 10
> 
> ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11
> 
> ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 11 (level, low) -> IRQ 11
> 
> ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 11
> 
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11
> 
> ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 3
> 
> ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 3 (level, low) -> IRQ 3
> 
> ACPI: PCI Interrupt Link [LACI] enabled at IRQ 7
> 
> ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 7 (level, low) -> IRQ 7
> 
> ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
> 
> ACPI: PCI interrupt 0000:01:08.0[A] -> GSI 5 (level, low) -> IRQ 5
> 
> ACPI: PCI interrupt 0000:01:08.1[A] -> GSI 5 (level, low) -> IRQ 5
> 
> ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
> 
> ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 10 (level, low) -> IRQ 10
> 
> Machine check exception polling timer started.
> 
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> 
> devfs: boot_options: 0x1
> 
> Initializing Cryptographic API
> 
> ACPI: Power Button (FF) [PWRF]
> 
> ACPI: Fan [FAN] (on)
> 
> ACPI: Processor [CPU0] (supports C1)
> 
> ACPI: Thermal Zone [THRM] (52 C)
> 
> Real Time Clock Driver v1.12
> 
> Linux agpgart interface v0.100 (c) Dave Jones
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> 
> NFORCE2: IDE controller at PCI slot 0000:00:09.0
> 
> NFORCE2: chipset revision 162
> 
> NFORCE2: not 100% native mode: will probe irqs later
> 
> NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
> 
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
> 
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
> 
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> 
> hda: ST380023A, ATA DISK drive
> 
> Using cfq io scheduler
> 
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 
> hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
> 
> ide1 at 0x170-0x177,0x376 on irq 15
> 
> hda: max request size: 128KiB
> 
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> 
> hda: cache flushes supported
> 
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3 p4
> 
> hdc: ATAPI 40X CD-ROM CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)
> 
> Uniform CD-ROM driver Revision: 3.20
> 
> mice: PS/2 mouse device common for all mice
> 
> serio: i8042 AUX port at 0x60,0x64 irq 12
> 
> input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
> 
> serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> input: AT Translated Set 2 keyboard on isa0060/serio0
> 
> NET: Registered protocol family 2
> 
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> 
> TCP: Hash tables configured (established 262144 bind 65536)
> 
> NET: Registered protocol family 1
> 
> NET: Registered protocol family 17
> 
> VFS: Mounted root (reiser4 filesystem) readonly.
> 
> Mounted devfs on /dev
> 
> Freeing unused kernel memory: 120k freed
> 
> Adding 498004k swap on /dev/hda3.  Priority:-1 extents:1
> 
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
> 
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11
> 
> PCI: Setting latency timer of device 0000:00:04.0 to 64
> 
> forcedeth: irq line 11, Status 0x       4, Mask 08x
> 
> eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0
> 
> agpgart: Detected NVIDIA nForce2 chipset
> 
> agpgart: Maximum main memory to use for agp memory: 816M
> 
> agpgart: AGP aperture is 256M @ 0xa0000000
> 
> usbcore: registered new driver usbfs
> 
> usbcore: registered new driver hub
> 
> ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 7 (level, low) -> IRQ 7
> 
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> 
> intel8x0_measure_ac97_clock: measured 49429 usecs
> 
> intel8x0: clocking to 47452
> 
> ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 11 (level, low) -> IRQ 11
> 
> ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
> 
> PCI: Setting latency timer of device 0000:00:02.2 to 64
> 
> ehci_hcd 0000:00:02.2: irq 11, pci mem f8a0c000
> 
> ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
> 
> irq 11: nobody cared!
> 
>  [<c01059aa>]
> 
>  [<c0105ac3>]
> 
>  [<c0105db8>]
> 
>  [<c01040a8>]
> 
>  [<c01191b0>]
> 
>  [<c0119236>]
> 
>  [<c0105dc5>]
> 
>  [<c01040a8>]
> 
>  [<c01e8dbe>]
> 
>  [<f8a938a2>]
> 
>  [<c0115a38>]
> 
>  [<f8a3e870>]
> 
>  [<f8a43d6a>]
> 
>  [<c01eca72>]
> 
>  [<c01ecacc>]
> 
>  [<c01ecb0c>]
> 
>  [<c0229b9f>]
> 
>  [<c0229cf2>]
> 
>  [<c0229fb1>]
> 
>  [<c022a45f>]
> 
>  [<c01ecddc>]
> 
>  [<f8a0a020>]
> 
>  [<c012bd9f>]
> 
>  [<c0103f3b>]
> 
> 
> 
> handlers:
> 
> [<f8a3f800>]
> 
> Disabling IRQ #11
> 
> PCI: cache line size of 64 is not supported by device 0000:00:02.2
> 
> ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
> 
> hub 1-0:1.0: USB hub found
> 
> hub 1-0:1.0: 6 ports detected
> 
> ACPI: PCI interrupt 0000:01:08.1[A] -> GSI 5 (level, low) -> IRQ 5
> 
> USB Universal Host Controller Interface driver v2.2
> 
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
> 
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
> 
> inserting floppy driver for 2.6.7-rc2-Redeeman1
> 
> Floppy drive(s): fd0 is 1.44M
> 
> FDC 0 is a post-1991 82077
> 
> 
> 
> 
> 
> Any more things to try?
> 
> 
> 
> 
> 
> 
> 
> ----- Mensaje Original -----
> 
> Remitente: Manfred Spraul manfred@colorfullife.com
> 
> Destinatario: Linus Torvalds torvalds@osdl.org
> 
> Fecha: Domingo, Junio 6, 2004 10:36am
> 
> Asunto: Re: 2.6.7-rc1 breaks forcedeth
> 
> 
> 
> 
>>Linus Torvalds wrote:
> 
> 
>>>I suspect that the driver should at the very least make sure to 
> 
> 
>>disable>any potentially pending interrupts in the "nv_probe()" 
> 
> 
>>function. I have no 
> 
> 
>>>idea how to do that, but it looks like something like
> 
> 
> 
>>>	writel(0, base + NvRegIrqMask);
> 
> 
>>>	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
> 
> 
> 
>>>should probably do it. It would be better to reset the thing 
> 
> 
>>completely, 
> 
> 
>>>methinks, but whatever.
> 
> 
> 
>>> 
> 
> 
> 
>>I'll add that, but it's only a partial fix: what if ehci_hcd is 
> 
> 
>>loaded 
> 
> 
>>before the forcedeth driver?
> 
> 
>>Luis, could you apply the patch and boot with it? It should print 
> 
> 
>>something like
> 
> 
>>forcedeth: irq line 11, Status 0x00000020, Mask 0x00000020
> 
> 
>>If mask and status are really not zero, then it explains your 
> 
> 
>>problems. 
> 
> 
>>Additionally I try to reset the nic in nv_probe - there were a few 
> 
> 
>>reports seemed to indicate that the nic generates timer interrupts 
> 
> 
>>even 
> 
> 
>>if the mask is zero.
> 
> 
>>--
> 
> 
>>  Manfred--- 2.6/drivers/net/forcedeth.c	2004-05-10 
> 
> 
>>04:31:59.000000000 +0200
> 
> 
>>+++ build-2.6/drivers/net/forcedeth.c	2004-06-06 10:31:43.826368991 
> 
> 
>>+0200@@ -1195,16 +1195,13 @@
> 
> 
>>	enable_irq(dev->irq);
> 
> 
>>}
> 
> 
> 
>>-static int nv_open(struct net_device *dev)
> 
> 
>>+static void nv_reset(struct net_device *dev)
> 
> 
>>{
> 
> 
>>-	struct fe_priv *np = get_nvpriv(dev);
> 
> 
>>	u8 *base = get_hwbase(dev);
> 
> 
>>-	int ret, oom, i;
> 
> 
> 
>>-	dprintk(KERN_DEBUG "nv_open: begin\n");
> 
> 
>>+	writel(0, base + NvRegIrqMask);
> 
> 
>>+	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);
> 
> 
> 
>>-	/* 1) erase previous misconfiguration */
> 
> 
>>-	/* 4.1-1: stop adapter: ignored, 4.3 seems to be overkill */
> 
> 
>>	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
> 
> 
>>	writel(0, base + NvRegMulticastAddrB);
> 
> 
>>	writel(0, base + NvRegMulticastMaskA);
> 
> 
>>@@ -1215,6 +1212,20 @@
> 
> 
>>	writel(0, base + NvRegUnknownTransmitterReg);
> 
> 
>>	nv_txrx_reset(dev);
> 
> 
>>	writel(0, base + NvRegUnknownSetupReg6);
> 
> 
>>+	pci_push(base);
> 
> 
>>+}
> 
> 
>>+
> 
> 
>>+static int nv_open(struct net_device *dev)
> 
> 
>>+{
> 
> 
>>+	struct fe_priv *np = get_nvpriv(dev);
> 
> 
>>+	u8 *base = get_hwbase(dev);
> 
> 
>>+	int ret, oom, i;
> 
> 
>>+
> 
> 
>>+	dprintk(KERN_DEBUG "nv_open: begin\n");
> 
> 
>>+
> 
> 
>>+	/* 1) erase previous misconfiguration */
> 
> 
>>+	/* 4.1-1: stop adapter: ignored, 4.3 seems to be overkill */
> 
> 
>>+	nv_reset(dev);
> 
> 
> 
>>	/* 2) initialize descriptor rings */
> 
> 
>>	np->in_shutdown = 0;
> 
> 
>>@@ -1506,6 +1517,11 @@
> 
> 
>>	writel(0, base + NvRegWakeUpFlags);
> 
> 
>>	np->wolenabled = 0;
> 
> 
> 
>>+printk(KERN_ERR "forcedeth: irq line %d, Status 0x%8x, Mask %0x8x\n",
> 
> 
>>+		       		pci_dev->irq, readl(base + NvRegIrqStatus),
> 
> 
>>+				readl(base + NvRegIrqMask));
> 
> 
>>+	nv_reset(dev);
> 
> 
>>+
> 
> 
>>	np->tx_flags = 
> 
> 
>>cpu_to_le16(NV_TX_LASTPACKET|NV_TX_LASTPACKET1|NV_TX_VALID); 	if (id-
> 
> 
>>>driver_data & DEV_NEED_LASTPACKET1)
> 
> 
>>		np->tx_flags |= cpu_to_le16(NV_TX_LASTPACKET1);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
