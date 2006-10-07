Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422853AbWJGBx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422853AbWJGBx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 21:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422860AbWJGBxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 21:53:55 -0400
Received: from moci.net4u.de ([217.7.64.195]:11740 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1422853AbWJGBxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 21:53:52 -0400
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc1 [ueagle-atm] Oops
Date: Sat, 7 Oct 2006 03:53:37 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610070353.38257.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin.

Works without problems on 2.6.18. 

2.6.19-rc1: 
(no, it does not work. The message 
"usb 2-2: [ueagle-atm] modem operational" below is a lie;)

usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
usb 2-2: [ueagle-atm] ADSL device founded vid (0X1110) pid (0X900F) : Eagle I
usb 2-2: reset full speed USB device using uhci_hcd and address 3
BUG: unable to handle kernel paging request at virtual address 74617473
 printing eip:
c018c5ab
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: dvb_bt8xx bt878 dvb_pll cx24110 bttv ir_common compat_ioctl32
btcx_risc tveeprom stv0299 ves1x93 ueagle_atm usbatm atm dvb_ttpci ttpci_eeprom
saa7146_vv video_buf videodev v4l1_compat v4l2_common saa7146 dvb_core processor
button ohci_hcd uhci_hcd ehci_hcd usbcore iptable_nat ipt_MASQUERADE ip_nat
ip_conntrack nfnetlink iptable_filter ip_tables x_tables pppoe pppox ppp_async
ppp_generic slhc crc_ccitt tun ebtables ppdev parport_pc lp parport evdev psmouse
CPU:    0
EIP:    0060:[<c018c5ab>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19-rc1 #1)
EIP is at sysfs_dirent_exist+0x4b/0x6f
eax: f99e9573   ebx: f7e41a04   ecx: 00000004   edx: 00000004
esi: f99e9561   edi: 74617473   ebp: f55593e0   esp: f54b7c68
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 4078, ti=f54b7000 task=f54bc540 task.ti=f54b7000)
Stack: 74617473 f99e948a f56fc714 00000000 f55593d4 c018bec6 00008124 00000004
       00000004 c0117574 0000000f f553ba50 f54b7cc0 f56fc714 f99eae24 00000000
       f99ead4c c018dab0 f56fc714 f553ba50 f5432180 00000000 f54d24e0 f99e800c
Call Trace:
 [<c018bec6>] sysfs_add_file+0x2e/0x70
 [<c0117574>] nr_processes+0x4/0x6
 [<c018dab0>] sysfs_create_group+0x5b/0xcb
 [<f99e800c>] uea_bind+0x215/0x53c [ueagle_atm]
 [<f99e6e73>] uea_kthread+0x0/0xb98 [ueagle_atm]
 [<f99e7df7>] uea_bind+0x0/0x53c [ueagle_atm]
 [<f99e23b9>] usbatm_usb_probe+0x109/0x7b2 [usbatm]
 [<f99e83a6>] uea_probe+0x73/0x17d [ueagle_atm]
 [<f9996da3>] usb_probe_interface+0x56/0x83 [usbcore]
 [<c0275c4e>] really_probe+0x2e/0xbf
 [<c0275d1e>] driver_probe_device+0x3f/0x93
 [<c02752da>] bus_for_each_drv+0x3e/0x5c
 [<c0275dd9>] device_attach+0x62/0x66
 [<c0275d72>] __device_attach+0x0/0x5
 [<c027527b>] bus_attach_device+0x1e/0x3f
 [<c02745b7>] device_add+0x3c6/0x476
 [<f999551a>] usb_set_configuration+0x394/0x4b1 [usbcore]
 [<f999c509>] generic_probe+0x15c/0x223 [usbcore]
 [<f9996a75>] usb_probe_device+0x33/0x38 [usbcore]
 [<c0275c4e>] really_probe+0x2e/0xbf
 [<c0275d1e>] driver_probe_device+0x3f/0x93
 [<c02752da>] bus_for_each_drv+0x3e/0x5c
 [<c0275dd9>] device_attach+0x62/0x66
 [<c0275d72>] __device_attach+0x0/0x5
 [<c027527b>] bus_attach_device+0x1e/0x3f
 [<c02745b7>] device_add+0x3c6/0x476
 [<f9995182>] usb_cache_string+0x7e/0x82 [usbcore]
 [<f9990dc5>] usb_new_device+0x5d/0xcb [usbcore]
 [<f9991bd5>] hub_thread+0x4d6/0xbc8 [usbcore]
 [<c0360571>] schedule+0x2b1/0x64a
 [<c012b1fe>] autoremove_wake_function+0x0/0x37
 [<f99916ff>] hub_thread+0x0/0xbc8 [usbcore]
 [<c012b0a5>] kthread+0xc9/0xcd
 [<c012afdc>] kthread+0x0/0xcd
 [<c01038eb>] kernel_thread_helper+0x7/0x1c
 =======================
Code: 16 eb 42 8b 5b 04 83 eb 04 8b 43 04 0f 18 00 90 8d 43 04 39 e8 74 2e 8b 43 14 85 c0 74 e5 89 d8 e8 6b ee ff ff 89 c6 8b 3c 24 ac <ae> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 c5 b8 ef
EIP: [<c018c5ab>] sysfs_dirent_exist+0x4b/0x6f SS:ESP 0068:f54b7c68


----------------------------------------------------------------------
Full dmesg:

Linux version 2.6.19-rc1 (root@oernie) (gcc version 4.1.1 (Gentoo 4.1.1)) #1 PREEMPT Sat Oct 7 02:29:35 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
 BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Entering add_active_range(0, 0, 524208) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   524208
early_node_map[1] active PFN ranges
    0:        0 ->   524208
On node 0 totalpages: 524208
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2303 pages used for memmap
  HighMem zone: 292529 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fad80
ACPI: XSDT (v001 A M I  OEMXSDT  0x09000507 MSFT 0x00000097) @ 0x7ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x09000507 MSFT 0x00000097) @ 0x7ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x09000507 MSFT 0x00000097) @ 0x7ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x09000507 MSFT 0x00000097) @ 0x7ffc0040
ACPI: DSDT (v001  A0030 A0030011 0x00000011 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7fb80000)
Detected 2798.861 MHz processor.
Built 1 zonelists.  Total pages: 520113
Kernel command line: root=/dev/md2 video=radeonfb:1280x1024-32@60 netconsole=4444@217.7.64.224/eth1,6666@217.7.64.225/00:30:1B:B2:40:0C
netconsole: local port 4444
netconsole: local IP 217.7.64.224
netconsole: interface eth1
netconsole: remote port 6666
netconsole: remote IP 217.7.64.225
netconsole: remote ethernet address 00:30:1b:b2:40:0c
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c046d000 soft=c046c000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074364k/2096832k available (2444k kernel code, 21300k reserved, 850k data, 184k init, 1179328k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0439000 - 0xc0467000   ( 184 kB)
      .data : 0xc03630db - 0xc04379e8   ( 850 kB)
      .text : 0xc0100000 - 0xc03630db   (2444 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5599.27 BogoMIPS (lpj=2799637)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
intel_rng: FWH not detected
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0a: ioport range 0x680-0x6ff has been reserved
pnp: 00:0a: ioport range 0x290-0x297 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: fe900000-fe9fffff
  PREFETCH window: b7e00000-f7dfffff
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: fea00000-feafffff
  PREFETCH window: f7e00000-f7efffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=325.00 Mhz, System=203.00 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type CRT found
radeonfb: EDID probed
Console: switching to colour frame buffer device 160x64
radeonfb (0000:01:00.0): ATI Radeon AQ 
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized drm 1.0.1 20051102
[drm] Initialized radeon 1.25.0 20060524 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level, low) -> IRQ 17
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:02:09.0: 3Com PCI 3c905C Tornado at f8804400.
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 18
eth1: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 17
eth2: VIA Rhine II at 0x1d000, 00:05:5d:dd:0a:80, IRQ 17.
eth2: MII PHY found at address 8, status 0x7809 advertising 01e1 Link 0000.
netconsole: device eth1 not up yet, forcing it
netconsole: timeout waiting for carrier
eth1: -- ERROR --
        Class:  Hardware failure
        Nr:  0x270
        Msg:  2 Pair Downshift detected
eth1: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  disabled
    tx-checksum:     disabled
    rx-checksum:     disabled
netconsole: network logging started
libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2.00: ATA-7, max UDMA/100, 156368016 sectors: LBA48 
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6Y080P0   YAR4 PQ: 0 ANSI: 5
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SP0802N  TK10 PQ: 0 ANSI: 5
SCSI device sdb: 156368016 512-byte hdwr sectors (80060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156368016 512-byte hdwr sectors (80060 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF60 irq 19
ata4: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF68 irq 19
scsi2 : ata_piix
ata3.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ata_piix
ata4.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0
sata_promise 0000:02:04.0: version 1.04
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 23 (level, low) -> IRQ 20
ata5: SATA max UDMA/133 cmd 0xF8806200 ctl 0xF8806238 bmdma 0x0 irq 20
ata6: SATA max UDMA/133 cmd 0xF8806280 ctl 0xF88062B8 bmdma 0x0 irq 20
scsi4 : sata_promise
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/133
scsi5 : sata_promise
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7, max UDMA7, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata6.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: sde1
sd 4:0:0:0: Attached scsi disk sde
sd 4:0:0:0: Attached scsi generic sg4 type 0
scsi 5:0:0:0: Direct-Access     ATA      SAMSUNG SP2504C  VT10 PQ: 0 ANSI: 5
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 488397168 512-byte hdwr sectors (250059 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
 sdf: sdf1
sd 5:0:0:0: Attached scsi disk sdf
sd 5:0:0:0: Attached scsi generic sg5 type 0
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    609 MB/s
raid6: int32x2    792 MB/s
raid6: int32x4    765 MB/s
raid6: int32x8    511 MB/s
raid6: mmxx1     2191 MB/s
raid6: mmxx2     2875 MB/s
raid6: sse1x1    1339 MB/s
raid6: sse1x2    2519 MB/s
raid6: sse2x1    2535 MB/s
raid6: sse2x2    3152 MB/s
raid6: using algorithm sse2x2 (3152 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3556.000 MB/sec
raid5: using function: pIII_sse (3556.000 MB/sec)
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Using IPI Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Time: tsc clocksource has been installed.
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdf1 ...
md:  adding sdf1 ...
md:  adding sde1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md: sdb3 has different UUID to sdf1
md: sdb2 has different UUID to sdf1
md: sdb1 has different UUID to sdf1
md: sda3 has different UUID to sdf1
md: sda2 has different UUID to sdf1
md: sda1 has different UUID to sdf1
md: created md3
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
md: bind<sdf1>
md: running: <sdf1><sde1><sdd1><sdc1>
raid5: device sdf1 operational as raid disk 3
raid5: device sde1 operational as raid disk 2
raid5: device sdd1 operational as raid disk 1
raid5: device sdc1 operational as raid disk 0
raid5: allocated 4196kB for md3
raid5: raid level 5 set md3 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:sdc1
 disk 1, o:1, dev:sdd1
 disk 2, o:1, dev:sde1
 disk 3, o:1, dev:sdf1
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: sda1 has different UUID to sdb3
md: created md2
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
md2: setting max_sectors to 32, segment boundary to 8191
raid0: looking at sdb3
raid0:   comparing sdb3(76035520) with sdb3(76035520)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda3
raid0:   comparing sda3(77894592) with sdb3(76035520)
raid0:   NOT EQUAL
raid0:   comparing sda3(77894592) with sda3(77894592)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking sda3 ... contained as device 0
  (77894592) is smallest!.
raid0: checking sdb3 ... nope.
raid0: zone->nb_dev: 1, size: 1859072
raid0: current zone offset: 77894592
raid0: done.
raid0 : md_size is 153930112 blocks.
raid0 : conf->hash_spacing is 152071040 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
md1: setting max_sectors to 32, segment boundary to 8191
raid0: looking at sdb2
raid0:   comparing sdb2(1951808) with sdb2(1951808)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda2
raid0:   comparing sda2(1952896) with sdb2(1951808)
raid0:   NOT EQUAL
raid0:   comparing sda2(1952896) with sda2(1952896)
raid0:   END
raid0:   ==> UNIQUE
raid0: 2 zones
raid0: FINAL 2 zones
raid0: zone 1
raid0: checking sda2 ... contained as device 0
  (1952896) is smallest!.
raid0: checking sdb2 ... nope.
raid0: zone->nb_dev: 1, size: 1088
raid0: current zone offset: 1952896
raid0: done.
raid0 : md_size is 3904704 blocks.
raid0 : conf->hash_spacing is 3903616 blocks.
raid0 : nb_zone is 2.
raid0 : Allocating 8 bytes for hash.
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
ReiserFS: md2: found reiserfs format "3.6" with standard journal
ReiserFS: md2: using ordered data mode
ReiserFS: md2: journal params: device md2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md2: checking transaction log (md2)
ReiserFS: md2: replayed 206 transactions in 15 seconds
ReiserFS: md2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 184k freed
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
parport0: Printer, Hewlett-Packard OfficeJet T Series
lp0: using parport0 (interrupt-driven).
ppdev: user-space parallel port driver
Ebtables v2.0 registered
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
PPP generic driver version 2.4.2
NET: Registered protocol family 24
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 228 bytes per conntrack
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfebffc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 16, io base 0x0000ef00
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000ef20
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-2: new full speed USB device using uhci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 19, io base 0x0000ef40
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x0000ef80
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Getting cpuindex for acpiid 0x2
Linux video capture interface: v2.00
saa7146: register extension 'dvb'.
ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 18
saa7146: found saa7146 @ mem f99b6000 (revision 1, irq 18) (0x13c2,0x0003).
NET: Registered protocol family 8
NET: Registered protocol family 20
[ueagle-atm] driver ueagle 1.3 loaded
usb 2-2: [ueagle-atm] ADSL device founded vid (0X1110) pid (0X9010) : Eagle I
usb 2-2: reset full speed USB device using uhci_hcd and address 2
usb 2-2: [ueagle-atm] pre-firmware device, uploading firmware
usb 2-2: [ueagle-atm] loading firmware ueagle-atm/eagleI.fw
usbcore: registered new interface driver ueagle-atm
DVB: registering new adapter (Technotrend/Hauppauge WinTV Nexus-S rev2.X).
adapter has MAC addr = 00:d0:5c:23:85:9b
dvb-ttpci: info @ card 0: firm f0240009, rtsl b0250018, vid 71010068, app 80002622
dvb-ttpci: firmware @ card 0 supports CI link layer interface
dvb-ttpci: Crystal audio DAC @ card 0 detected
saa7146_vv: saa7146 (0): registered device video0 [v4l2]
saa7146_vv: saa7146 (0): registered device vbi0 [v4l2]
usb 2-2: [ueagle-atm] firmware uploaded
usb 2-2: USB disconnect, address 2
DVB: registering frontend 0 (ST STV0299 DVB-S)...
input: DVB on-card IR receiver as /class/input/input2
dvb-ttpci: found av7110-0.
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 22
bttv0: Bt878 (rev 17) at 0000:02:0c.0, irq: 22, latency: 64, mmio: 0xf7efe000
bttv0: detected: Pinnacle PCTV Sat [card=94], PCI subsystem ID is 11bd:001c
bttv0: using: Pinnacle PCTV Sat [card=94,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=009f00fc [init]
bttv0: using tuner=-1
bttv0: registered device video1
bttv0: registered device vbi1
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: add subdevice "dvb0"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI Interrupt 0000:02:0c.1[A] -> GSI 20 (level, low) -> IRQ 22
bt878_probe: card id=[0x1c11bd],[ Pinnacle PCTV Sat ] has DVB functions.
bt878(0): Bt878 (rev 17) at 02:0c.1, irq: 22, latency: 64, memory: 0xf7eff000
DVB: registering new adapter (bttv0).
DVB: registering frontend 1 (Conexant CX24110 DVB-S)...
usb 2-2: new full speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
usb 2-2: [ueagle-atm] ADSL device founded vid (0X1110) pid (0X900F) : Eagle I
usb 2-2: reset full speed USB device using uhci_hcd and address 3
BUG: unable to handle kernel paging request at virtual address 74617473
 printing eip:
c018c5ab
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: dvb_bt8xx bt878 dvb_pll cx24110 bttv ir_common compat_ioctl32 btcx_risc tveeprom stv0299 ves1x93 ueagle_atm usbatm atm dvb_ttpci ttpci_eeprom saa7146_vv video_buf videodev v4l1_compat v4l2_common saa7146 dvb_core processor button ohci_hcd uhci_hcd ehci_hcd usbcore iptable_nat ipt_MASQUERADE ip_nat ip_conntrack nfnetlink iptable_filter ip_tables x_tables pppoe pppox ppp_async ppp_generic slhc crc_ccitt tun ebtables ppdev parport_pc lp parport evdev psmouse
CPU:    0
EIP:    0060:[<c018c5ab>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19-rc1 #1)
EIP is at sysfs_dirent_exist+0x4b/0x6f
eax: f99e9573   ebx: f7e41a04   ecx: 00000004   edx: 00000004
esi: f99e9561   edi: 74617473   ebp: f55593e0   esp: f54b7c68
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 4078, ti=f54b7000 task=f54bc540 task.ti=f54b7000)
Stack: 74617473 f99e948a f56fc714 00000000 f55593d4 c018bec6 00008124 00000004 
       00000004 c0117574 0000000f f553ba50 f54b7cc0 f56fc714 f99eae24 00000000 
       f99ead4c c018dab0 f56fc714 f553ba50 f5432180 00000000 f54d24e0 f99e800c 
Call Trace:
 [<c018bec6>] sysfs_add_file+0x2e/0x70
 [<c0117574>] nr_processes+0x4/0x6
 [<c018dab0>] sysfs_create_group+0x5b/0xcb
 [<f99e800c>] uea_bind+0x215/0x53c [ueagle_atm]
 [<f99e6e73>] uea_kthread+0x0/0xb98 [ueagle_atm]
 [<f99e7df7>] uea_bind+0x0/0x53c [ueagle_atm]
 [<f99e23b9>] usbatm_usb_probe+0x109/0x7b2 [usbatm]
 [<f99e83a6>] uea_probe+0x73/0x17d [ueagle_atm]
 [<f9996da3>] usb_probe_interface+0x56/0x83 [usbcore]
 [<c0275c4e>] really_probe+0x2e/0xbf
 [<c0275d1e>] driver_probe_device+0x3f/0x93
 [<c02752da>] bus_for_each_drv+0x3e/0x5c
 [<c0275dd9>] device_attach+0x62/0x66
 [<c0275d72>] __device_attach+0x0/0x5
 [<c027527b>] bus_attach_device+0x1e/0x3f
 [<c02745b7>] device_add+0x3c6/0x476
 [<f999551a>] usb_set_configuration+0x394/0x4b1 [usbcore]
 [<f999c509>] generic_probe+0x15c/0x223 [usbcore]
 [<f9996a75>] usb_probe_device+0x33/0x38 [usbcore]
 [<c0275c4e>] really_probe+0x2e/0xbf
 [<c0275d1e>] driver_probe_device+0x3f/0x93
 [<c02752da>] bus_for_each_drv+0x3e/0x5c
 [<c0275dd9>] device_attach+0x62/0x66
 [<c0275d72>] __device_attach+0x0/0x5
 [<c027527b>] bus_attach_device+0x1e/0x3f
 [<c02745b7>] device_add+0x3c6/0x476
 [<f9995182>] usb_cache_string+0x7e/0x82 [usbcore]
 [<f9990dc5>] usb_new_device+0x5d/0xcb [usbcore]
 [<f9991bd5>] hub_thread+0x4d6/0xbc8 [usbcore]
 [<c0360571>] schedule+0x2b1/0x64a
 [<c012b1fe>] autoremove_wake_function+0x0/0x37
 [<f99916ff>] hub_thread+0x0/0xbc8 [usbcore]
 [<c012b0a5>] kthread+0xc9/0xcd
 [<c012afdc>] kthread+0x0/0xcd
 [<c01038eb>] kernel_thread_helper+0x7/0x1c
 =======================
Code: 16 eb 42 8b 5b 04 83 eb 04 8b 43 04 0f 18 00 90 8d 43 04 39 e8 74 2e 8b 43 14 85 c0 74 e5 89 d8 e8 6b ee ff ff 89 c6 8b 3c 24 ac <ae> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 c5 b8 ef 
EIP: [<c018c5ab>] sysfs_dirent_exist+0x4b/0x6f SS:ESP 0068:f54b7c68
 <6>usb 2-2: [ueagle-atm] (re)booting started
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: md3: found reiserfs format "3.6" with standard journal
ReiserFS: md3: using ordered data mode
ReiserFS: md3: journal params: device md3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md3: checking transaction log (md3)
ReiserFS: md3: Using r5 hash to sort names
Adding 3904696k swap on /dev/md1.  Priority:-1 extents:1 across:3904696k
warning: process `touch' used the removed sysctl system call
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 50658 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 23
w83627hf 9191-0290: Reading VID from GPIO5
usb 2-2: [ueagle-atm] modem operational
usb 2-2: [ueagle-atm] ATU-R firmware version : 40e4be96
usb 2-2: [ueagle-atm] setting new timeout 0
device eth0 entered promiscuous mode
eth0:  setting full-duplex.
device eth1 entered promiscuous mode
device eth2 entered promiscuous mode
eth2: link down
br1: port 2(eth1) entering learning state
br1: port 1(eth0) entering learning state
NET: Registered protocol family 17
br1: topology change detected, propagating
br1: port 2(eth1) entering forwarding state
br1: topology change detected, propagating
br1: port 1(eth0) entering forwarding state
process `named' is using obsolete setsockopt SO_BSDCOMPAT
