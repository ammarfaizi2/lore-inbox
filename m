Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVJOFN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVJOFN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 01:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVJOFN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 01:13:59 -0400
Received: from 10.ctyme.com ([69.50.231.10]:20973 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S1751083AbVJOFN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 01:13:59 -0400
Message-ID: <4350900F.7040000@perkel.com>
Date: Fri, 14 Oct 2005 22:13:51 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops - more info
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
X-Mail-from: marc@perkel.com
X-Sender-host-address: 204.95.16.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  OK - Got the logs: Hardware is Athlon 64 X2 processor:

Oct 14 16:40:36 pascal autossh[2469]: port down, restarting ssh
Oct 14 16:40:36 pascal autossh[2469]: starting ssh (count 460)
Oct 14 16:40:36 pascal autossh[2469]: ssh child pid is 3294
Oct 14 16:44:45 pascal kernel: Unable to handle kernel NULL pointer 
dereference at 0000000000000800 RIP:
Oct 14 16:44:45 pascal kernel: <ffffffff8017cafe>{__mpol_copy+46}
Oct 14 16:44:45 pascal kernel: PGD aae7067 PUD 8e38e067 PMD 0
Oct 14 16:44:45 pascal kernel: Oops: 0000 [1] SMP
Oct 14 16:44:45 pascal kernel: CPU 1
Oct 14 16:44:45 pascal kernel: Modules linked in: iptable_nat 
ip_conntrack iptable_filter ip_tables autofs4 ipv6 dm_mod video button 
ohci1394 ieee1394 uhci$
Oct 14 16:44:45 pascal kernel: Pid: 32050, comm: spamd Not tainted 2.6.13.2
Oct 14 16:44:45 pascal kernel: RIP: 0010:[<ffffffff8017cafe>] 
<ffffffff8017cafe>{__mpol_copy+46}
Oct 14 16:44:45 pascal kernel: RSP: 0018:ffff81007e3f3dd8  EFLAGS: 00010286
Oct 14 16:44:46 pascal kernel: RAX: ffff8100be888450 RBX: 
ffff8100be888450 RCX: 0000000000000010
Oct 14 16:44:46 pascal kernel: RDX: ffff8100bffad000 RSI: 
ffff8100be888000 RDI: ffff810037eb8f48
Oct 14 16:44:47 pascal kernel: RBP: 0000000000000800 R08: 
ffff8100be888028 R09: ffff810037e85010
Oct 14 16:44:47 pascal kernel: R10: 0000000000000000 R11: 
0000000000000001 R12: ffff8100825b69d0
Oct 14 16:44:47 pascal kernel: R13: 0000000001200011 R14: 
ffff81000fcbf378 R15: 0000000000000000
Oct 14 16:44:47 pascal kernel: FS:  00002aaaaaad7de0(0000) 
GS:ffffffff804d1880(0000) knlGS:000000005557f6c0
Oct 14 16:44:51 pascal kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Oct 14 16:44:51 pascal kernel: CR2: 0000000000000800 CR3: 
000000004c557000 CR4: 00000000000006e0
Oct 14 16:44:51 pascal kernel: Process spamd (pid: 32050, threadinfo 
ffff81007e3f2000, task ffff81006f691070)
Oct 14 16:44:51 pascal kernel: Stack: 0000000000000000 0000000000000000 
ffff8100825b69d0 ffffffff8013523c
Oct 14 16:44:51 pascal kernel:        ffff8100825b6b00 ffff8100614f2e18 
00002aaaaaad7e70 0000000000000000
Oct 14 16:44:53 pascal kernel:        ffff81007e3f3f58 00007fffffedc400
Oct 14 16:44:53 pascal kernel: Call 
Trace:<ffffffff8013523c>{copy_process+3196} <ffffffff80135be5>{do_fork+261}
Oct 14 16:44:54 pascal kernel:        <ffffffff8010de56>{tracesys+209} 
<ffffffff8010e063>{ptregscall_common+103}
Oct 14 16:44:55 pascal kernel:
Oct 14 16:44:56 pascal kernel:
Oct 14 16:44:56 pascal kernel: Code: 48 8b 45 00 48 89 03 66 83 7b 04 02 
48 8b 45 08 c7 03 01 00
Oct 14 16:44:56 pascal kernel: RIP <ffffffff8017cafe>{__mpol_copy+46} 
RSP <ffff81007e3f3dd8>
Oct 14 16:44:56 pascal kernel: CR2: 0000000000000800
Oct 14 16:44:56 pascal kernel:  <3>Debug: sleeping function called from 
invalid context at include/linux/rwsem.h:43
Oct 14 16:44:57 pascal kernel: in_atomic():0, irqs_disabled():1
Oct 14 16:44:57 pascal kernel:
Oct 14 16:44:57 pascal kernel: Call Trace:<ffffffff801383c8>{exit_mm+72} 
<ffffffff80139201>{do_exit+481}
Oct 14 16:44:57 pascal kernel:        
<ffffffff8021ec8d>{vgacon_cursor+221} <ffffffff80120fee>{do_page_fault+1950}
Oct 14 16:44:57 pascal kernel:        <ffffffff8010e811>{error_exit+0} 
<ffffffff8017cafe>{__mpol_copy+46}
Oct 14 16:44:57 pascal kernel:        <ffffffff8017caf6>{__mpol_copy+38} 
<ffffffff8013523c>{copy_process+3196}
Oct 14 16:44:57 pascal kernel:        <ffffffff80135be5>{do_fork+261} 
<ffffffff8010de56>{tracesys+209}
Oct 14 16:44:57 pascal kernel:        
<ffffffff8010e063>{ptregscall_common+103}


I have upgraded the kernel from 2.6.113.2 to 2.6.23.4 but this should 
tell you what kind of hardware I'm running:

Bootdata ok (command line is ro root=/dev/hda3 vga=1)
Linux version 2.6.13.4 (root@pascal.ctyme.com) (gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)) #1 SMP Fri Oct 14 20:10:55 PDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bffb0000 (usable)
 BIOS-e820: 00000000bffb0000 - 00000000bffc0000 (ACPI data)
 BIOS-e820: 00000000bffc0000 - 00000000bfff0000 (ACPI NVS)
 BIOS-e820: 00000000bfff0000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000fa7c0
ACPI: RSDT (v001 A M I  OEMRSDT  0x06000530 MSFT 0x00000097) @ 0x00000000bffb0000
ACPI: FADT (v001 A M I  OEMFACP  0x06000530 MSFT 0x00000097) @ 0x00000000bffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x06000530 MSFT 0x00000097) @ 0x00000000bffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000530 MSFT 0x00000097) @ 0x00000000bffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 00000000bffb0000
Using 24 for the hash shift. Max adder is bffb0000 
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-00000000bffb0000
On node 0 totalpages: 786255
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 782256 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c0000000 (gap: c0000000:3f780000)
Checking aperture...
CPU 0: aperture @ ec000000 size 64 MB
Built 1 zonelists
Kernel command line: ro root=/dev/hda3 vga=1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2002.647 MHz processor.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3090068k/3145408k available (2355k kernel code, 0k reserved, 1171k data, 200k init)
Calibrating delay using timer specific routine.. 4014.90 BogoMIPS (lpj=8029804)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.516 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4005.37 BogoMIPS (lpj=8010754)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -77 cycles, maxerr 565 cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xec000000
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: faf00000-fbffffff
  PREFETCH window: f0000000-f9ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1129321191.300:1): initialized
Total HugeTLB memory allocated, 0
JFS: nTxBlock = 8192, nTxLock = 65536
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y250P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6Y250P0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdc: max request size: 1024KiB
hdc: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63, UDMA(133)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 200k freed
SCSI subsystem initialized
libata version 1.12 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 0
sata_via(0000:00:0f.0): routed to hard irq line 0
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xC000 irq 16
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xC008 irq 16
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
floppy0: no floppy controllers found
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 18
natsemi eth1: NatSemi DP8381[56] at 0xfac00000 (0000:00:0b.0), 00:02:e3:23:c5:c4, IRQ 18, port TP.
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 3
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 19, io mem 0xfae00000
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 3
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 19, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 3
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 19, io base 0x0000e000
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 3
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 19, io base 0x0000e400
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 3
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 19, io base 0x0000e800
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:07.0, from 11 to 2
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[18]  MMIO=[fa800000-fa8007ff]  Max Packet=[2048]
audit(1129346401.993:2): user pid=1031 uid=0 auid=4294967295 msg='hwclock: op=changing system time id=0 res=success'
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e0180000c8a84e]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1020116k swap on /dev/hda2.  Priority:-1 extents:1
Adding 3951980k swap on /dev/hdc2.  Priority:-2 extents:1


