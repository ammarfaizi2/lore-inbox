Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWINFS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWINFS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 01:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWINFS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 01:18:29 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5878 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751340AbWINFS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 01:18:26 -0400
Date: Wed, 13 Sep 2006 23:16:26 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.18-rc6-mm2
In-reply-to: <fa.7a4Rl1qDmYu4ew2hC2NUSUy6Roo@ifi.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Message-id: <4508E5AA.7000009@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.7a4Rl1qDmYu4ew2hC2NUSUy6Roo@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/

Seeing a problem with suspend-to-RAM or suspend-to-disk on my laptop. If 
I suspend (either way) once it is fine. If I suspend again the EHCI 
controller fails to suspend and the suspend is aborted.

Here is the dmesg from one suspend to RAM (successful) and then suspend 
to disk (failed):

Linux version 2.6.18-rc6-mm2 (rob@localhost.localdomain) (gcc version 
4.1.1 20060525 (Red Hat 4.1.1-1)) #1 Wed Sep 13 22:34:20 CST 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 
000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 
00000000000a0000 type: 2
copy_e820_map() start: 00000000000e0000 size: 0000000000020000 end: 
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fed0000 end: 
000000001ffd0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001ffd0000 size: 0000000000020c00 end: 
000000001fff0c00 type: 2
copy_e820_map() start: 000000001fff0c00 size: 000000000000b400 end: 
000000001fffc000 type: 4
copy_e820_map() start: 000000001fffc000 size: 0000000000004000 end: 
0000000020000000 type: 2
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
  BIOS-e820: 000000001ffd0000 - 000000001fff0c00 (reserved)
  BIOS-e820: 000000001fff0c00 - 000000001fffc000 (ACPI NVS)
  BIOS-e820: 000000001fffc000 - 0000000020000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Entering add_active_range(0, 0, 131024) 0 entries of 256 used
Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->   131024
   HighMem    131024 ->   131024
early_node_map[1] active PFN ranges
     0:        0 ->   131024
On node 0 totalpages: 131024
   DMA zone: 32 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 4064 pages, LIFO batch:0
   Normal zone: 991 pages used for memmap
   Normal zone: 125937 pages, LIFO batch:31
   HighMem zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f6560
ACPI: RSDT (v001 HP     CPQ0860  0x14070520 CPQ  0x00000001) @ 0x1fff0c84
ACPI: FADT (v002 HP     CPQ0860  0x00000002 CPQ  0x00000001) @ 0x1fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x1fff5c3c
ACPI: DSDT (v001 HP       nx7000 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 30000000 (gap: 20000000:e0000000)
Detected 1694.559 MHz processor.
Built 1 zonelists.  Total pages: 130001
Kernel command line: ro root=/dev/VolGroup00/LogVol00
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01404000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
cpu 0 current c0369480
Initializing CPU#0
CPU 0 irqstacks, hard=c0462000 soft=c0461000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513424k/524096k available (2036k kernel code, 10076k reserved, 
822k data, 228k init, 0k highmem)
virtual kernel memory layout:
     fixmap  : 0xfff9c000 - 0xfffff000   ( 396 kB)
     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
     vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
     lowmem  : 0xc0000000 - 0xdffd0000   ( 511 MB)
       .init : 0xc0423000 - 0xc045c000   ( 228 kB)
       .data : 0xc02fd14d - 0xc03cab14   ( 822 kB)
       .text : 0xc0100000 - 0xc02fd14d   (2036 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3390.77 BogoMIPS 
(lpj=16953877)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040 00000180 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1.70GHz stepping 06
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0c20)
checking if image is initramfs... it is
Freeing initrd memory: 1669k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
PM: Adding info for No Bus:virtual
PM: Adding info for No Bus:vtconsole
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Root Bridge [C046] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C046] bus is 0
PM: Adding info for No Bus:pci0000:00
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1100-113f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.C046._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:02:01.0
PM: Adding info for pci:0000:02:02.0
PM: Adding info for pci:0000:02:04.0
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C047._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C058._PRT]
ACPI: Embedded Controller [C0EA] (gpe 28) interrupt mode.
ACPI: Power Resource [C18D] (on)
ACPI: Power Resource [C195] (on)
ACPI: Power Resource [C19C] (on)
ACPI: Power Resource [C1A6] (on)
ACPI: PCI Interrupt Link [C0C2] (IRQs 5 *10)
ACPI: PCI Interrupt Link [C0C3] (IRQs 5 *10)
ACPI: PCI Interrupt Link [C0C4] (IRQs *5 10)
ACPI: PCI Interrupt Link [C0C5] (IRQs *5 10)
ACPI: PCI Interrupt Link [C0C6] (IRQs 5 10) *0, disabled.
ACPI: PCI Interrupt Link [C0C7] (IRQs 5 10) *11
ACPI: PCI Interrupt Link [C0C8] (IRQs 5 10) *0, disabled.
ACPI: PCI Interrupt Link [C0C9] (IRQs *5 10)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
pnp: PnP ACPI: found 15 devices
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
PCI: Bridge: 0000:00:01.0
   IO window: 3000-3fff
   MEM window: 90400000-904fffff
   PREFETCH window: 98000000-9fffffff
PCI: Bus 3, cardbus bridge: 0000:02:04.0
   IO window: 00002800-000028ff
   IO window: 00002c00-00002cff
   PREFETCH window: 30000000-31ffffff
   MEM window: 34000000-35ffffff
PCI: Bridge: 0000:00:1e.0
   IO window: 2000-2fff
   MEM window: 90000000-903fffff
   PREFETCH window: 30000000-31ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [C0C4] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
PM: Adding info for platform:pcspkr
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
PM: Adding info for No Bus:misc
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
audit(1158188552.800:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PM: Adding info for No Bus:vc
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:rtc
Real Time Clock Driver v1.12ac
PM: Adding info for No Bus:hpet
PM: Adding info for No Bus:nvram
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
PM: Adding info for No Bus:agpgart
agpgart: AGP aperture is 256M @ 0xb0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [C0C3] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PM: Adding info for No Bus:isa
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac7
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x4C40 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x4C48 irq 15
scsi0 : ata_piix
PM: Adding info for No Bus:host0
ata1.00: ATA-7, max UDMA/100, 156368016 sectors: LBA48
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
PM: Adding info for No Bus:host1
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG MP0804H  UE20 PQ: 0 ANSI: 5
PM: Adding info for scsi:0:0:0:0
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
PM: Adding info for No Bus:target1:0:0
scsi 1:0:0:0: CD-ROM            QSI      CDRW/DVD SBW-241 VH04 PQ: 0 ANSI: 5
PM: Adding info for scsi:1:0:0:0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
Yenta: CardBus bridge found at 0000:02:04.0 [0e11:0860]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x001c1112, devctl 0x44
Yenta: ISA IRQ mask 0x08d8, PCI irq 5
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x903fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:C1A3,PNP0f13:C1A4] at 0x60,0x64 irq 1,12
PM: Adding info for platform:i8042
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Adding info for serio:serio1
PM: Adding info for serio:serio2
Using IPI Shortcut mode
PM: Adding info for serio:serio3
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 228k freed
Write protecting the kernel read-only data: 422k
Time: tsc clocksource has been installed.
PM: Adding info for No Bus:vcs1
PM: Adding info for serio:serio4
PM: Adding info for No Bus:vcsa1
Time: acpi_pm clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initialised: 
dm-devel@redhat.com
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1158188556.189:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1481 types, 152 bools, 1 sens, 256 cats
security:  58 classes, 43474 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1158188556.529:3): policy loaded auid=4294967295
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
warning: process `date' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
input: PC Speaker as /class/input/input2
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.00 (30-Jul-2006)
PM: Adding info for platform:iTCO_wdt
iTCO_wdt: Found a ICH4-M TCO device (Version=1, TCOBASE=0x1060)
PM: Adding info for No Bus:watchdog
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PM: Adding info for No Bus:i2c-0
Floppy drive(s): fd0 is 1.44M
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
eth0: RTL-8139C+ at 0xe08ec000, 00:02:3f:65:4d:74, IRQ 10
intel_rng: FWH not detected
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
ACPI: PCI Interrupt Link [C0C9] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xa0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: new device found, idVendor=0000, idProduct=0000
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.18-rc6-mm2 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
ACPI: PCI Interrupt Link [C0C2] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 10, io base 0x000048c0
usb usb2: new device found, idVendor=0000, idProduct=0000
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.18-rc6-mm2 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ieee1394: Initialized config rom entry `ip1394'
PM: Adding info for No Bus:usbdev2.1_ep81
PM: Adding info for No Bus:usbdev2.1
ACPI: PCI Interrupt Link [C0C5] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 5, io base 0x000048e0
usb usb3: new device found, idVendor=0000, idProduct=0000
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.18-rc6-mm2 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4kmprq
ipw2200: Copyright(c) 2003-2006 Intel Corporation
PM: Adding info for No Bus:usbdev3.1_ep81
PM: Adding info for No Bus:usbdev3.1
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x00004c00
usb usb4: new device found, idVendor=0000, idProduct=0000
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.18-rc6-mm2 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
cs: IO port probe 0x100-0x3af: excluding 0x140-0x14f 0x200-0x20f 0x370-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
PM: Adding info for No Bus:usbdev4.1_ep81
PM: Adding info for No Bus:usbdev4.1
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[90200000-902007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
intel8x0_measure_ac97_clock: measured 59429 usecs
intel8x0: clocking to 48000
PM: Adding info for ac97:0-0:AD1981B
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
PM: Adding info for ac97:1-1:Si3036,8
PM: Adding info for ieee1394:00023f383800c298
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f383800c298]
PM: Adding info for ieee1394:00023f383800c298-0
floppy0: no floppy controllers found
warning: process `salsa' used the removed sysctl system call
warning: process `salsa' used the removed sysctl system call
warning: process `salsa' used the removed sysctl system call
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: AC Adapter [C134] (on-line)
ACPI: Battery Slot [C11F] (battery present)
bay: Unknown symbol is_dock_device
bay: Unknown symbol register_hotplug_dock_device
bay: Unknown symbol unregister_hotplug_dock_device
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [C1BE]
ACPI: Lid Switch [C136]
ibm_acpi: ec object not found
ACPI: Video Device [C0D0] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda2, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
NTFS driver 2.1.27 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS-fs warning (device sda1): load_system_files(): Unsupported volume 
flags 0x4000 encountered.
NTFS-fs error (device sda1): load_system_files(): Volume has unsupported 
flags set.  Mounting read-only.  Run chkdsk and mount in Windows.
SELinux: initialized (dev sda1, type ntfs), uses genfs_contexts
Adding 1048568k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 
across:1048568k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses 
genfs_contexts
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (4094 buckets, 32752 max) - 224 bytes per conntrack
eth0: link down
Bluetooth: Core ver 2.10
PM: Adding info for platform:bluetooth
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.6
wbsd: Copyright(c) Pierre Ossman
pnp: Device 00:02 activated.
mmc0: W83L51xD id 7112 at 0x248 irq 6 dma 0 PnP
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
[drm] Initialized radeon 1.25.0 20060524 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Setting GART location based on new memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 1 usecs
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
ieee80211_crypt: registered algorithm 'CCMP'
eth1: no IPv6 routers present
ADDRCONF(NETDEV_UP): eth1: link is not ready
PM: Preparing system for mem sleep
Stopping tasks: 
====================================================================================================|
Suspending device bluetooth
platform bluetooth: suspend
Suspending device 00023f383800c298-0
Suspending device 00023f383800c298
Suspending device 1-1:Si3036,8
ac97 1-1:Si3036,8: suspend
Suspending device 0-0:AD1981B
ac97 0-0:AD1981B: suspend
Suspending device fw-host0
Suspending device usbdev4.1
Suspending device usbdev4.1_ep81
Suspending device 4-0:1.0
hub 4-0:1.0: suspend
Suspending device usbdev4.1_ep00
Suspending device usb4
usb usb4: suspend, may wakeup
Suspending device usbdev3.1
Suspending device usbdev3.1_ep81
Suspending device 3-0:1.0
hub 3-0:1.0: suspend
Suspending device usbdev3.1_ep00
Suspending device usb3
usb usb3: suspend, may wakeup
Suspending device usbdev2.1
Suspending device usbdev2.1_ep81
Suspending device 2-0:1.0
hub 2-0:1.0: suspend
Suspending device usbdev2.1_ep00
Suspending device usb2
usb usb2: suspend, may wakeup
Suspending device usbdev1.1
Suspending device usbdev1.1_ep81
Suspending device 1-0:1.0
hub 1-0:1.0: suspend
Suspending device usbdev1.1_ep00
Suspending device usb1
usb usb1: suspend, may wakeup
Suspending device i2c-0
Suspending device watchdog
Suspending device iTCO_wdt
iTCO_wdt iTCO_wdt: suspend
Suspending device device-mapper
Suspending device serio4
Suspending device serio3
Suspending device serio2
Suspending device serio1
Suspending device serio0
Suspending device i8042
i8042 i8042: suspend
Suspending device 1:0:0:0
sr 1:0:0:0: suspend
Suspending device target1:0:0
Suspending device 0:0:0:0
sd 0:0:0:0: suspend
Suspending device target0:0:0
Suspending device host1
Suspending device host0
Suspending device isa
Suspending device serial8250
serial8250 serial8250: suspend
Suspending device agpgart
Suspending device nvram
Suspending device hpet
Suspending device rtc
Suspending device vcsa
Suspending device vcs
Suspending device vc
Suspending device pnp1
Suspending device vesafb.0
platform vesafb.0: suspend
Suspending device snapshot
Suspending device misc
Suspending device pcspkr
pcspkr pcspkr: suspend
Suspending device 00:0e
system 00:0e: suspend
Suspending device 00:0d
system 00:0d: suspend
Suspending device 00:0c
system 00:0c: suspend
Suspending device 00:0b
i8042 aux 00:0b: suspend
Suspending device 00:0a
i8042 kbd 00:0a: suspend
Suspending device 00:09
pnp 00:09: suspend
Suspending device 00:08
pnp 00:08: suspend
Suspending device 00:07
pnp 00:07: suspend
Suspending device 00:06
pnp 00:06: suspend
Suspending device 00:05
parport_pc 00:05: suspend
pnp: Device 00:05 disabled.
Suspending device 00:04
pnp 00:04: suspend
Suspending device 00:03
serial 00:03: suspend
pnp: Device 00:03 disabled.
Suspending device 00:02
wbsd 00:02: suspend
pnp: Device 00:02 disabled.
Suspending device 00:01
pnp 00:01: suspend
Suspending device 00:00
system 00:00: suspend
Suspending device pnp0
Suspending device 0000:02:04.0
yenta_cardbus 0000:02:04.0: suspend
Suspending device 0000:02:02.0
ipw2200 0000:02:02.0: suspend
eth1: Going into suspend...
Suspending device 0000:02:01.0
8139cp 0000:02:01.0: suspend
Suspending device 0000:02:00.0
ohci1394 0000:02:00.0: suspend
Suspending device 0000:01:00.0
pci 0000:01:00.0: suspend
Suspending device 0000:00:1f.6
Intel ICH Modem 0000:00:1f.6: suspend
Suspending device 0000:00:1f.5
Intel ICH 0000:00:1f.5: suspend
codec_write 0: semaphore is not ready for register 0x26
Suspending device 0000:00:1f.3
i801_smbus 0000:00:1f.3: suspend
Suspending device 0000:00:1f.1
ata_piix 0000:00:1f.1: suspend
pci_set_power_state(): 0000:00:1f.1: state=3, current state=5
Suspending device 0000:00:1f.0
pci 0000:00:1f.0: suspend
Suspending device 0000:00:1e.0
pci 0000:00:1e.0: suspend
Suspending device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: suspend, may wakeup
Suspending device 0000:00:1d.2
uhci_hcd 0000:00:1d.2: suspend
Suspending device 0000:00:1d.1
uhci_hcd 0000:00:1d.1: suspend
Suspending device 0000:00:1d.0
uhci_hcd 0000:00:1d.0: suspend
Suspending device 0000:00:01.0
pci 0000:00:01.0: suspend
Suspending device 0000:00:00.0
agpgart-intel 0000:00:00.0: suspend
Suspending device pci0000:00
Suspending device acpi
acpi acpi: suspend
Suspending device vtcon0
Suspending device vtconsole
Suspending device virtual
Suspending device platform
PM: Entering mem sleep
platform bluetooth: LATE suspend
iTCO_wdt iTCO_wdt: LATE suspend
i8042 i8042: LATE suspend
serial8250 serial8250: LATE suspend
platform vesafb.0: LATE suspend
pcspkr pcspkr: LATE suspend
yenta_cardbus 0000:02:04.0: LATE suspend
ipw2200 0000:02:02.0: LATE suspend
8139cp 0000:02:01.0: LATE suspend
ohci1394 0000:02:00.0: LATE suspend
pci 0000:01:00.0: LATE suspend
Intel ICH Modem 0000:00:1f.6: LATE suspend
Intel ICH 0000:00:1f.5: LATE suspend
i801_smbus 0000:00:1f.3: LATE suspend
pci 0000:00:1f.0: LATE suspend
pci 0000:00:1e.0: LATE suspend
pci 0000:00:01.0: LATE suspend
agpgart-intel 0000:00:00.0: LATE suspend
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
agpgart-intel 0000:00:00.0: EARLY resume
pci 0000:00:01.0: EARLY resume
uhci_hcd 0000:00:1d.0: EARLY resume
uhci_hcd 0000:00:1d.1: EARLY resume
uhci_hcd 0000:00:1d.2: EARLY resume
ehci_hcd 0000:00:1d.7: EARLY resume
pci 0000:00:1e.0: EARLY resume
pci 0000:00:1f.0: EARLY resume
ata_piix 0000:00:1f.1: EARLY resume
i801_smbus 0000:00:1f.3: EARLY resume
Intel ICH 0000:00:1f.5: EARLY resume
Intel ICH Modem 0000:00:1f.6: EARLY resume
pci 0000:01:00.0: EARLY resume
ohci1394 0000:02:00.0: EARLY resume
8139cp 0000:02:01.0: EARLY resume
ipw2200 0000:02:02.0: EARLY resume
yenta_cardbus 0000:02:04.0: EARLY resume
pcspkr pcspkr: EARLY resume
platform vesafb.0: EARLY resume
serial8250 serial8250: EARLY resume
i8042 i8042: EARLY resume
iTCO_wdt iTCO_wdt: EARLY resume
platform bluetooth: EARLY resume
PM: Finishing wakeup.
acpi acpi: resuming
agpgart-intel 0000:00:00.0: resuming
pci 0000:00:01.0: resuming
uhci_hcd 0000:00:1d.0: resuming
PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PM: Writing back config space on device 0000:00:1d.0 at offset f (was 
100, writing 10a)
PM: Writing back config space on device 0000:00:1d.0 at offset 8 (was 1, 
writing 48c1)
usb usb2: root hub lost power or was reset
uhci_hcd 0000:00:1d.1: resuming
PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PM: Writing back config space on device 0000:00:1d.1 at offset f (was 
200, writing 205)
PM: Writing back config space on device 0000:00:1d.1 at offset 8 (was 1, 
writing 48e1)
usb usb3: root hub lost power or was reset
uhci_hcd 0000:00:1d.2: resuming
PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PM: Writing back config space on device 0000:00:1d.2 at offset f (was 
300, writing 305)
PM: Writing back config space on device 0000:00:1d.2 at offset 8 (was 1, 
writing 4c01)
usb usb4: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: resuming
PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PM: Writing back config space on device 0000:00:1d.7 at offset f (was 
400, writing 405)
PM: Writing back config space on device 0000:00:1d.7 at offset 4 (was 0, 
writing a0000000)
usb usb1: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
pci 0000:00:1e.0: resuming
PM: Writing back config space on device 0000:00:1e.0 at offset 9 (was 
fff0, writing 31f03000)
PM: Writing back config space on device 0000:00:1e.0 at offset 7 (was 
22802020, writing 2802020)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pci 0000:00:1f.0: resuming
ata_piix 0000:00:1f.1: resuming
PM: Writing back config space on device 0000:00:1f.1 at offset f (was 
100, writing 105)
PM: Writing back config space on device 0000:00:1f.1 at offset 9 (was 0, 
writing 32000000)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.1 to 64
i801_smbus 0000:00:1f.3: resuming
Intel ICH 0000:00:1f.5: resuming
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
Intel ICH Modem 0000:00:1f.6: resuming
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
pci 0000:01:00.0: resuming
PM: Writing back config space on device 0000:01:00.0 at offset 6 (was 0, 
writing 90400000)
PM: Writing back config space on device 0000:01:00.0 at offset 3 (was 0, 
writing 8008)
ohci1394 0000:02:00.0: resuming
PM: Writing back config space on device 0000:02:00.0 at offset f (was 
20000100, writing 2000010a)
PM: Writing back config space on device 0000:02:00.0 at offset 5 (was 1, 
writing 2401)
PM: Writing back config space on device 0000:02:00.0 at offset 4 (was 0, 
writing 90200000)
PM: Writing back config space on device 0000:02:00.0 at offset 3 (was 0, 
writing 8008)
PM: Writing back config space on device 0000:02:00.0 at offset 1 (was 
2100080, writing 2100007)
8139cp 0000:02:01.0: resuming
ipw2200 0000:02:02.0: resuming
eth1: Coming out of suspend...
PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
PM: Writing back config space on device 0000:02:02.0 at offset f (was 
18030100, writing 1803010b)
PM: Writing back config space on device 0000:02:02.0 at offset 4 (was 0, 
writing 90000000)
PM: Writing back config space on device 0000:02:02.0 at offset 3 (was 0, 
writing 8008)
PM: Writing back config space on device 0000:02:02.0 at offset 1 (was 
2900002, writing 2900006)
yenta_cardbus 0000:02:04.0: resuming
PM: Writing back config space on device 0000:02:04.0 at offset f (was 
34001ff, writing 5c00105)
PM: Writing back config space on device 0000:02:04.0 at offset e (was 0, 
writing 2cfc)
PM: Writing back config space on device 0000:02:04.0 at offset d (was 0, 
writing 2c00)
PM: Writing back config space on device 0000:02:04.0 at offset c (was 0, 
writing 28fc)
PM: Writing back config space on device 0000:02:04.0 at offset b (was 0, 
writing 2800)
PM: Writing back config space on device 0000:02:04.0 at offset a (was 0, 
writing 35fff000)
PM: Writing back config space on device 0000:02:04.0 at offset 9 (was 0, 
writing 34000000)
PM: Writing back config space on device 0000:02:04.0 at offset 8 (was 0, 
writing 31fff000)
PM: Writing back config space on device 0000:02:04.0 at offset 7 (was 0, 
writing 30000000)
PM: Writing back config space on device 0000:02:04.0 at offset 6 (was 0, 
writing b0060302)
PM: Writing back config space on device 0000:02:04.0 at offset 4 (was 0, 
writing 90100000)
PM: Writing back config space on device 0000:02:04.0 at offset 3 (was 
20000, writing 2a820)
PM: Writing back config space on device 0000:02:04.0 at offset 1 (was 
2100000, writing 2100007)
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
system 00:00: resuming
pnp 00:01: resuming
wbsd 00:02: resuming
pnp: Device 00:02 activated.
serial 00:03: resuming
pnp: Device 00:03 activated.
pnp 00:04: resuming
parport_pc 00:05: resuming
pnp: Device 00:05 activated.
pnp 00:06: resuming
pnp 00:07: resuming
pnp 00:08: resuming
pnp 00:09: resuming
i8042 kbd 00:0a: resuming
pnp: Device 00:0a does not support activation.
i8042 aux 00:0b: resuming
pnp: Device 00:0b does not support activation.
system 00:0c: resuming
system 00:0d: resuming
system 00:0e: resuming
pcspkr pcspkr: resuming
platform vesafb.0: resuming
serial8250 serial8250: resuming
sd 0:0:0:0: resuming
sr 1:0:0:0: resuming
ata2: soft resetting port
i8042 i8042: resuming
atkbd serio0: resuming
serio serio1: resuming
serio serio2: resuming
serio serio3: resuming
psmouse serio4: resuming
ata2.00: configured for UDMA/33
ata2: EH complete
iTCO_wdt iTCO_wdt: resuming
usb usb1: resuming
  usbdev1.1_ep00: PM: resume from 0, parent usb1 still 2
hub 1-0:1.0: PM: resume from 0, parent usb1 still 2
hub 1-0:1.0: resuming
  usbdev1.1: PM: resume from 0, parent usb1 still 2
usb usb2: resuming
ata1: EH pending after completion, repeating EH (cnt=4)
ata1: soft resetting port
  usbdev2.1_ep00: PM: resume from 0, parent usb2 still 2
hub 2-0:1.0: PM: resume from 0, parent usb2 still 2
hub 2-0:1.0: resuming
  usbdev2.1: PM: resume from 0, parent usb2 still 2
usb usb3: resuming
  usbdev3.1_ep00: PM: resume from 0, parent usb3 still 2
hub 3-0:1.0: PM: resume from 0, parent usb3 still 2
hub 3-0:1.0: resuming
  usbdev3.1: PM: resume from 0, parent usb3 still 2
usb usb4: resuming
  usbdev4.1_ep00: PM: resume from 0, parent usb4 still 2
hub 4-0:1.0: PM: resume from 0, parent usb4 still 2
hub 4-0:1.0: resuming
  usbdev4.1: PM: resume from 0, parent usb4 still 2
ac97 0-0:AD1981B: resuming
ac97 1-1:Si3036,8: resuming
platform bluetooth: resuming
Restarting tasks... done
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [C1BE]
ACPI: Lid Switch [C136]
PM: Adding info for No Bus:vcs63
PM: Adding info for No Bus:vcsa63
PM: Removing info for No Bus:vcs63
PM: Removing info for No Bus:vcsa63
PM: Adding info for No Bus:vcs8
PM: Adding info for No Bus:vcsa8
PM: Removing info for No Bus:vcs8
PM: Removing info for No Bus:vcsa8
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
ADDRCONF(NETDEV_UP): eth1: link is not ready
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present
PM: suspend-to-disk mode set to 'platform'
Stopping tasks: 
===================================================================================================|
Shrinking memory...  -\|/done (56066 pages freed)
Suspending device bluetooth
platform bluetooth: freeze
Suspending device 00023f383800c298-0
Suspending device 00023f383800c298
Suspending device 1-1:Si3036,8
ac97 1-1:Si3036,8: freeze
Suspending device 0-0:AD1981B
ac97 0-0:AD1981B: freeze
Suspending device fw-host0
Suspending device usbdev4.1
  usbdev4.1: PM: suspend 0->1, parent usb4 already 2
Suspending device usbdev4.1_ep81
Suspending device 4-0:1.0
hub 4-0:1.0: PM: suspend 0->1, parent usb4 already 2
hub 4-0:1.0: freeze
Suspending device usbdev4.1_ep00
  usbdev4.1_ep00: PM: suspend 0->1, parent usb4 already 2
Suspending device usb4
usb usb4: PM: suspend 2-->1
Suspending device usbdev3.1
  usbdev3.1: PM: suspend 0->1, parent usb3 already 2
Suspending device usbdev3.1_ep81
Suspending device 3-0:1.0
hub 3-0:1.0: PM: suspend 0->1, parent usb3 already 2
hub 3-0:1.0: freeze
Suspending device usbdev3.1_ep00
  usbdev3.1_ep00: PM: suspend 0->1, parent usb3 already 2
Suspending device usb3
usb usb3: PM: suspend 2-->1
Suspending device usbdev2.1
  usbdev2.1: PM: suspend 0->1, parent usb2 already 2
Suspending device usbdev2.1_ep81
Suspending device 2-0:1.0
hub 2-0:1.0: PM: suspend 0->1, parent usb2 already 2
hub 2-0:1.0: freeze
Suspending device usbdev2.1_ep00
  usbdev2.1_ep00: PM: suspend 0->1, parent usb2 already 2
Suspending device usb2
usb usb2: PM: suspend 2-->1
Suspending device usbdev1.1
  usbdev1.1: PM: suspend 0->1, parent usb1 already 2
Suspending device usbdev1.1_ep81
Suspending device 1-0:1.0
hub 1-0:1.0: PM: suspend 0->1, parent usb1 already 2
hub 1-0:1.0: freeze
Suspending device usbdev1.1_ep00
  usbdev1.1_ep00: PM: suspend 0->1, parent usb1 already 2
Suspending device usb1
usb usb1: PM: suspend 2-->1
Suspending device i2c-0
Suspending device watchdog
Suspending device iTCO_wdt
iTCO_wdt iTCO_wdt: freeze
Suspending device device-mapper
Suspending device serio4
Suspending device serio3
Suspending device serio2
Suspending device serio1
Suspending device serio0
Suspending device i8042
i8042 i8042: freeze
Suspending device 1:0:0:0
sr 1:0:0:0: freeze
Suspending device target1:0:0
Suspending device 0:0:0:0
sd 0:0:0:0: freeze
Suspending device target0:0:0
Suspending device host1
Suspending device host0
Suspending device isa
Suspending device serial8250
serial8250 serial8250: freeze
Suspending device agpgart
Suspending device nvram
Suspending device hpet
Suspending device rtc
Suspending device vcsa
Suspending device vcs
Suspending device vc
Suspending device pnp1
Suspending device vesafb.0
platform vesafb.0: freeze
Suspending device snapshot
Suspending device misc
Suspending device pcspkr
pcspkr pcspkr: freeze
Suspending device 00:0e
system 00:0e: freeze
Suspending device 00:0d
system 00:0d: freeze
Suspending device 00:0c
system 00:0c: freeze
Suspending device 00:0b
i8042 aux 00:0b: freeze
Suspending device 00:0a
i8042 kbd 00:0a: freeze
Suspending device 00:09
pnp 00:09: freeze
Suspending device 00:08
pnp 00:08: freeze
Suspending device 00:07
pnp 00:07: freeze
Suspending device 00:06
pnp 00:06: freeze
Suspending device 00:05
parport_pc 00:05: freeze
pnp: Device 00:05 disabled.
Suspending device 00:04
pnp 00:04: freeze
Suspending device 00:03
serial 00:03: freeze
pnp: Device 00:03 disabled.
Suspending device 00:02
wbsd 00:02: freeze
pnp: Device 00:02 disabled.
Suspending device 00:01
pnp 00:01: freeze
Suspending device 00:00
system 00:00: freeze
Suspending device pnp0
Suspending device 0000:02:04.0
yenta_cardbus 0000:02:04.0: freeze
Suspending device 0000:02:02.0
ipw2200 0000:02:02.0: freeze
eth1: Going into suspend...
Suspending device 0000:02:01.0
8139cp 0000:02:01.0: freeze
Suspending device 0000:02:00.0
ohci1394 0000:02:00.0: freeze
Suspending device 0000:01:00.0
pci 0000:01:00.0: freeze
Suspending device 0000:00:1f.6
Intel ICH Modem 0000:00:1f.6: freeze
Suspending device 0000:00:1f.5
Intel ICH 0000:00:1f.5: freeze
codec_write 0: semaphore is not ready for register 0x26
Suspending device 0000:00:1f.3
i801_smbus 0000:00:1f.3: freeze
Suspending device 0000:00:1f.1
ata_piix 0000:00:1f.1: freeze
Suspending device 0000:00:1f.0
pci 0000:00:1f.0: freeze
Suspending device 0000:00:1e.0
pci 0000:00:1e.0: freeze
Suspending device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: freeze
usb_hcd_pci_suspend(): ehci_pci_suspend+0x0/0x84 [ehci_hcd]() returns -22
pci_device_suspend(): usb_hcd_pci_suspend+0x0/0x13d() returns -22
suspend_device(): pci_device_suspend+0x0/0x34() returns -22
Could not suspend device 0000:00:1d.7: error -22
pci 0000:00:1e.0: resuming
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pci 0000:00:1f.0: resuming
ata_piix 0000:00:1f.1: resuming
PCI: Setting latency timer of device 0000:00:1f.1 to 64
i801_smbus 0000:00:1f.3: resuming
Intel ICH 0000:00:1f.5: resuming
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
Intel ICH Modem 0000:00:1f.6: resuming
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
pci 0000:01:00.0: resuming
ohci1394 0000:02:00.0: resuming
8139cp 0000:02:01.0: resuming
ipw2200 0000:02:02.0: resuming
eth1: Coming out of suspend...
PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
PM: Writing back config space on device 0000:02:02.0 at offset f (was 
18030100, writing 1803010b)
PM: Writing back config space on device 0000:02:02.0 at offset 4 (was 0, 
writing 90000000)
PM: Writing back config space on device 0000:02:02.0 at offset 3 (was 0, 
writing 8008)
PM: Writing back config space on device 0000:02:02.0 at offset 1 (was 
2900002, writing 2900006)
yenta_cardbus 0000:02:04.0: resuming
PM: Writing back config space on device 0000:02:04.0 at offset 1 (was 
2100003, writing 2100007)
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
system 00:00: resuming
pnp 00:01: resuming
wbsd 00:02: resuming
pnp: Device 00:02 activated.
serial 00:03: resuming
pnp: Device 00:03 activated.
pnp 00:04: resuming
parport_pc 00:05: resuming
pnp: Device 00:05 activated.
pnp 00:06: resuming
pnp 00:07: resuming
pnp 00:08: resuming
pnp 00:09: resuming
i8042 kbd 00:0a: resuming
pnp: Device 00:0a does not support activation.
i8042 aux 00:0b: resuming
pnp: Device 00:0b does not support activation.
system 00:0c: resuming
system 00:0d: resuming
system 00:0e: resuming
pcspkr pcspkr: resuming
platform vesafb.0: resuming
serial8250 serial8250: resuming
sd 0:0:0:0: resuming
ata1: EH complete
sr 1:0:0:0: resuming
ata2: EH complete
i8042 i8042: resuming
atkbd serio0: resuming
serio serio1: resuming
serio serio2: resuming
serio serio3: resuming
psmouse serio4: resuming
iTCO_wdt iTCO_wdt: resuming
  usbdev1.1_ep00: PM: resume from 0, parent usb1 still 2
hub 1-0:1.0: PM: resume from 0, parent usb1 still 2
hub 1-0:1.0: resuming
  usbdev1.1: PM: resume from 0, parent usb1 still 2
  usbdev2.1_ep00: PM: resume from 0, parent usb2 still 2
hub 2-0:1.0: PM: resume from 0, parent usb2 still 2
hub 2-0:1.0: resuming
  usbdev2.1: PM: resume from 0, parent usb2 still 2
  usbdev3.1_ep00: PM: resume from 0, parent usb3 still 2
hub 3-0:1.0: PM: resume from 0, parent usb3 still 2
hub 3-0:1.0: resuming
  usbdev3.1: PM: resume from 0, parent usb3 still 2
  usbdev4.1_ep00: PM: resume from 0, parent usb4 still 2
hub 4-0:1.0: PM: resume from 0, parent usb4 still 2
hub 4-0:1.0: resuming
  usbdev4.1: PM: resume from 0, parent usb4 still 2
ac97 0-0:AD1981B: resuming
ac97 1-1:Si3036,8: resuming
platform bluetooth: resuming
Some devices failed to suspend
Restarting tasks... done
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [C1BE]
ACPI: Lid Switch [C136]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
ADDRCONF(NETDEV_UP): eth1: link is not ready
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth1: no IPv6 routers present

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


