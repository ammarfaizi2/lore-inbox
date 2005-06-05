Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVFEGfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVFEGfC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 02:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFEGfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 02:35:02 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:7860 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S261479AbVFEGei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 02:34:38 -0400
Message-ID: <42A2A0B2.7020003@freemail.hu>
Date: Sun, 05 Jun 2005 08:50:26 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
Content-Type: multipart/mixed;
 boundary="------------050400080401010004000808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050400080401010004000808
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

$SUBJECT says almost all, system is MSI K8TNeo FIS2R,
Athlon64 3200+, running FC3/x86-64. I use the multiconsole
extension from linuxconsole.sf.net, the patch does not touch
anything relevant under drivers/input or drivers/usb.

The mice are detected just fine but the mouse pointers
do not move on either of my two screens. The same patch
(not counting the trivial reject fixes) do work on the
2.6.11-1.14_FC3 errata kernel. Both PS2 keyboard on the
keyboard and aux ports work correctly.

I attached dmesg and the contents of /proc/interrupts.
The interrupt count on USB does not increase if I move either
mouse.

Best regards,
Zoltán Böszörményi


--------------050400080401010004000808
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Bootdata ok (command line is ro root=LABEL=/ dumbcon=1:1)
Linux version 2.6.12-rc5-git9-ruby (zozo@wl-193.226.227-37-szolnok.dunaweb.hu) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.fc3)) #1 Sat Jun 4 21:03:29 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d6000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 AMI                                   ) @ 0x00000000000fa0c0
ACPI: RSDT (v001 AMIINT VIA_K8   0x00000010 MSFT 0x00000097) @ 0x000000001fff0000
ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT 0x00000097) @ 0x000000001fff0030
ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT 0x00000097) @ 0x000000001fff00c0
ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT 0x0100000d) @ 0x0000000000000000
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Checking aperture...
CPU 0: aperture @ d0000000 size 128 MB
Built 1 zonelists
Kernel command line: ro root=LABEL=/ dumbcon=1:1
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2000.107 MHz processor.
time.c: Using PIT/TSC based timekeeping.
Console: Colour VGA+ 80x25 vc:1-16
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509160k/524224k available (2853k kernel code, 14240k reserved, 887k data, 192k init)
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 128M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1117950537.226:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Console: mono dummy device 80x25 vc:17-17
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 76 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 169
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y120L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON COMBO LTC-48161H, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdc: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 28Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.40.2)
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0xa (1300 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x2 (1500 mV)
cpu_init done, current fid 0xc, vid 0x2
ACPI wakeup devices: 
PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD  AC9  MC9 ILAN SLPB 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 192k freed
keyboard.c: [AT Raw Set 2 keyboard] vc:1-16
SCSI subsystem initialized
input: AT Raw Set 2 keyboard on isa0060/serio1
libata version 1.11 loaded.
sata_via version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xC400 irq 169
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xC802 bmdma 0xC408 irq 169
keyboard.c: [AT Translated Set 2 keyboard] vc:17-17
input: AT Translated Set 2 keyboard on isa0060/serio0
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
sata_promise version 1.01
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 177
ata3: SATA max UDMA/133 cmd 0xFFFFC2000001A200 ctl 0xFFFFC2000001A238 bmdma 0x0 irq 177
ata4: SATA max UDMA/133 cmd 0xFFFFC2000001A280 ctl 0xFFFFC2000001A2B8 bmdma 0x0 irq 177
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
security:  3 users, 4 roles, 320 types, 23 bools
security:  53 classes, 10952 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda10, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured for labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
orinoco 0.14alpha2 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_pci 0.14alpha2 (Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 185
orinoco_pci: Detected device 0000:00:08.0, mem:0xcfbfd000-0xcfbfdfff, irq 185
eth0: Hardware identity 8013:0000:0001:0000
eth0: Station identity  001f:0006:0001:0003
eth0: Firmware determined as Intersil 1.3.6
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:09:5B:91:B2:E4
eth0: Station name "Prism  I"
eth0: ready
r8169 Gigabit Ethernet driver 2.2LK loaded
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 193
r8169: NAPI enabled
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffc2000001ef00, 00:0c:76:52:dc:54, IRQ 193
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:11.5 to 64
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 209
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 209, io mem 0xcfffed00
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 209
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 209, io base 0x0000b000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 209
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 209, io base 0x0000b400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 209
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 209, io base 0x0000b800
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 209
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 209, io base 0x0000bc00
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using uhci_hcd and address 2
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 185
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-1
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[185]  MMIO=[cfffe000-cfffe7ff]  Max Packet=[2048]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
usb 3-2: new low speed USB device using uhci_hcd and address 3
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c4af2]
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ibm_acpi: ec object not found
EXT3 FS on hda10, internal journal
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hda2
Ending clean XFS mount for filesystem: hda2
SELinux: initialized (dev hda2, type xfs), uses xattr
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
SELinux: initialized (dev hda5, type xfs), uses xattr
XFS mounting filesystem hda7
Ending clean XFS mount for filesystem: hda7
SELinux: initialized (dev hda7, type xfs), uses xattr
XFS mounting filesystem hda11
Ending clean XFS mount for filesystem: hda11
SELinux: initialized (dev hda11, type xfs), uses xattr
XFS mounting filesystem hda6
Ending clean XFS mount for filesystem: hda6
SELinux: initialized (dev hda6, type xfs), uses xattr
XFS mounting filesystem hda9
Ending clean XFS mount for filesystem: hda9
SELinux: initialized (dev hda9, type xfs), uses xattr
XFS mounting filesystem hda8
Ending clean XFS mount for filesystem: hda8
SELinux: initialized (dev hda8, type xfs), uses xattr
Adding 522104k swap on /dev/hda3.  Priority:-1 extents:1
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 384 bytes per conntrack
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
eth0: New link status: Connected (0001)
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
i2c /dev entries driver
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80461540(lo)
IPv6 over IPv4 tunneling driver
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: no IPv6 routers present
ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 177
[drm] Initialized radeon 1.16.0 20050311 on minor 0: 
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
[drm] Initialized radeon 1.16.0 20050311 on minor 1: 
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: reserved bits set in mode 0x1f000a0f. Fixed.
agpgart: X tried to set rate=x12. Setting to AGP3 x8 mode.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[drm] Loading R200 Microcode
audit(1117950690.785:0): avc:  denied  { name_connect } for  dest=631 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:reserved_port_t tclass=tcp_socket
audit(1117950732.767:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950735.157:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950735.157:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950735.202:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950735.202:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950795.307:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950795.307:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950795.356:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950795.357:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950855.417:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950855.417:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950855.462:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950855.462:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950915.517:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950915.518:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950920.600:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950920.600:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950980.644:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950980.645:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950980.696:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117950980.696:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117951040.799:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117951040.799:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117951040.846:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117951040.846:0): avc:  denied  { name_connect } for  dest=80 scontext=user_u:system_r:unconfined_t tcontext=system_u:object_r:http_port_t tclass=tcp_socket
audit(1117951263.125:0): avc:  denied  { name_connect } for  dest=25 scontext=system_u:system_r:unconfined_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket
audit(1117951263.126:0): avc:  denied  { name_connect } for  dest=25 scontext=system_u:system_r:unconfined_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket

--------------050400080401010004000808
Content-Type: text/plain;
 name="interrupts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts"

           CPU0       
  0:    1710965    IO-APIC-edge  timer
  1:       3240    IO-APIC-edge  i8042
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:         10    IO-APIC-edge  i8042
 14:      99907    IO-APIC-edge  ide0
 15:      14762    IO-APIC-edge  ide1
169:          0   IO-APIC-level  libata
177:     121910   IO-APIC-level  libata, radeon@pci:0000:00:06.0
185:       6379   IO-APIC-level  eth0, ohci1394
193:     121255   IO-APIC-level  radeon@pci:0000:01:00.0
201:          0   IO-APIC-level  VIA8237
209:         91   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4, uhci_hcd:usb5
NMI:        245 
LOC:    1710703 
ERR:          0
MIS:          0

--------------050400080401010004000808--
