Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUK1L0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUK1L0W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 06:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUK1L0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 06:26:22 -0500
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:61865
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S261436AbUK1LZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 06:25:22 -0500
Message-ID: <41A9B5D4.1090700@freemail.hu>
Date: Sun, 28 Nov 2004 12:26:12 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; hu; rv:1.7.3) Gecko/20041020
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM problem on x86-64
References: <41A84875.2030505@freemail.hu> <41A848C4.1030504@freemail.hu> <Pine.LNX.4.61.0411271035340.3173@montezuma.fsmlabs.com> <41A8C3BF.20904@freemail.hu> <Pine.LNX.4.61.0411271123350.3173@montezuma.fsmlabs.com> <41A8F4C3.9070000@freemail.hu> <Pine.LNX.4.61.0411271512030.3173@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0411271512030.3173@montezuma.fsmlabs.com>
Content-Type: multipart/mixed;
 boundary="------------010408020309020600070801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010408020309020600070801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Zwane Mwaikambo írta:
> On Sat, 27 Nov 2004, Zoltan Boszormenyi wrote:
> 
> 
>>I will soon. Although I have to apply this patch also, more than one
>>person use my machine at once. My 2 and a half year old son would be
>>angry without his cartoons. ;-)
>>
>>In the meantime it turned out that downing eth1 did not solve this
>>problem. The r8169 stopped spitting its messages but I still had one
>>
>>hda: dma_timer_expiry: dma status == 0x24
>>hda: DMA interrupt recovery
>>hda: lost interrupt
> 
> 
> Or you could try booting with acpi=off

I did. After about 2 hours uptime, I got some of these again.
Once when the machine was not too i/o stressed (playing a movie
off disk and xine was reading some hundreds of KB per second)
and then when I was extracting the kernel source tree.
It seems the problem doesn't depend on I/O stress. Although
the machine is 100MB+ into swap, it doesn make constant I/O
as the HDD led shows.

dmesg is attached again.

Now I try to compile a 2.6.10-rc2-bk11 with
the before mentioned extension and report back.

Best regards,
Zoltán Böszörményi

--------------010408020309020600070801
Content-Type: text/plain;
 name="dmesg-FC3-acpi-off.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-FC3-acpi-off.log"

Bootdata ok (command line is ro root=LABEL=/ dumbcon=1 rhgb acpi=off quiet)
Linux version 2.6.9-1.681ruby_FC3.root (root@wl-193.226.227-37-szolnok.dunaweb.hu) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Wed Nov 24 20:26:05 CET 2004
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
No mptable found.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: VIA      <6>Product ID: K8T400       <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 17
I/O APIC #2 Version 3 at 0xFEC00000.
Processors: 1
Checking aperture...
CPU 0: aperture @ d0000000 size 128 MB
Built 1 zonelists
Kernel command line: ro root=LABEL=/ dumbcon=1 rhgb acpi=off quiet console=tty0
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2000.138 MHz processor.
Console: Colour VGA+ 80x25 vc:1-16
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509312k/524224k available (2408k kernel code, 14156k reserved, 1292k data, 164k init)
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Using local APIC NMI watchdog using perfctr0
Using IO-APIC 2
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter disabled.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3227] at 0000:00:11.0
PCI->APIC IRQ transform: (B0,I5,P0) -> 137
PCI->APIC IRQ transform: (B0,I5,P0) -> 137
PCI->APIC IRQ transform: (B0,I6,P0) -> 145
PCI->APIC IRQ transform: (B0,I8,P0) -> 153
PCI->APIC IRQ transform: (B0,I10,P0) -> 145
PCI->APIC IRQ transform: (B0,I11,P0) -> 137
PCI->APIC IRQ transform: (B0,I13,P0) -> 145
PCI->APIC IRQ transform: (B0,I14,P0) -> 153
PCI->APIC IRQ transform: (B0,I15,P1) -> 145
PCI->APIC IRQ transform: (B0,I15,P0) -> 145
PCI->APIC IRQ transform: (B0,I16,P0) -> 161
PCI->APIC IRQ transform: (B0,I16,P0) -> 161
PCI->APIC IRQ transform: (B0,I16,P1) -> 161
PCI->APIC IRQ transform: (B0,I16,P1) -> 161
PCI->APIC IRQ transform: (B0,I16,P2) -> 161
PCI->APIC IRQ transform: (B0,I17,P2) -> 169
PCI->APIC IRQ transform: (B1,I0,P0) -> 137
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1101630820.170:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key A617AC2237592777
- User ID: Red Hat, Inc. (Kernel Module GPG key)
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 1
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 1
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 1
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 1
PCI: Via IRQ fixup for 0000:00:11.5, from 3 to 9
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
Console: mono dummy device 80x25 vc:17-17
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y120L0, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON COMBO LTC-48161H, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdc: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
keyboard.c: [AT Raw Set 2 keyboard] vc:1-16
input: AT Raw Set 2 keyboard on isa0060/serio1
keyboard.c: [AT Translated Set 2 keyboard] vc:17-17
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 28Kbytes
TCP: Hash tables configured (established 32768 bind 4681)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09b)
powernow-k8: BIOS error - no PSB
Freeing unused kernel memory: 164k freed
SCSI subsystem initialized
libata version 1.02 loaded.
sata_via version 0.20
sata_via(0000:00:0f.0): routed to hard irq line 1
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xC400 irq 145
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xC802 bmdma 0xC408 irq 145
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
sata_promise version 1.00
ata3: SATA max UDMA/133 cmd 0xFFFFFF0000054200 ctl 0xFFFFFF0000054238 bmdma 0x0 irq 145
ata4: SATA max UDMA/133 cmd 0xFFFFFF0000054280 ctl 0xFFFFFF00000542B8 bmdma 0x0 irq 145
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 4 roles, 280 types, 16 bools
security:  53 classes, 5494 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda10, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), not configured for labeling
SELinux: initialized (dev hugetlbfs, type hugetlbfs), not configured for labeling
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
inserting floppy driver for 2.6.9-1.681ruby_FC3.root
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
orinoco 0.13e (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
orinoco_pci 0.13e (Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au> & Jean Tourrilhes <jt@hpl.hp.com>)
orinoco_pci: Detected Orinoco/Prism2 PCI device at 0000:00:08.0, mem:0xCFBFD000 to 0xCFBFDFFF -> 0xffffff0000056000, irq:153
Reset done..............................................................................................................................................................................................................................................................;
Clear Reset............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFB9D4D - FFFB9B59
divert: allocating divert_blk for eth0
eth0: Station identity 001f:0006:0001:0003
eth0: Looks like an Intersil firmware version 1.3.6
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:09:5B:91:B2:E4
eth0: Station name "Prism  I"
eth0: ready
r8169 Gigabit Ethernet driver 1.2 loaded
r8169: NAPI enabled
divert: allocating divert_blk for eth1
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffff0000058f00, 00:0c:76:52:dc:54, IRQ 137
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: irq 161, pci mem ffffff000007cd00
SELinux: initialized (dev usbdevfs, type usbdevfs), uses genfs_contexts
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 161, io base 000000000000b000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 161, io base 000000000000b400
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 161, io base 000000000000b800
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: irq 161, io base 000000000000bc00
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[153]  MMIO=[cffee000-cffee7ff]  Max Packet=[2048]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
usb 3-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-1
usb 3-2: new low speed USB device using address 3
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c4af2]
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-2
EXT3 FS on hda10, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
usb 5-2: new full speed USB device using address 2
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
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80452a20(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Adding 522104k swap on /dev/hda3.  Priority:-1 extents:1
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 496 bytes per conntrack
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
eth0: New link status: Connected (0001)
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
i2c /dev entries driver
eth0: no IPv6 routers present
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
vmmon: module license 'unspecified' taints kernel.
vmmon: no version for "sys_ioctl" found: kernel tainted.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 3391 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth1: peer interface eth1 not found, will wait for it to come up
bridge-eth1: attached
/dev/vmnet: open called by PID 3414 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 5343 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
divert: allocating divert_blk for vmnet8
/dev/vmnet: open called by PID 5324 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
divert: allocating divert_blk for vmnet1
/dev/vmnet: open called by PID 5882 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 6097 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
[drm] Initialized radeon 1.11.0 20020828 on minor 0: 
[drm] Initialized radeon 1.11.0 20020828 on minor 1: 
vmnet8: no IPv6 routers present
vmnet1: no IPv6 routers present
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
application mozilla-bin uses obsolete OSS audio interface
Losing some ticks... checking if CPU frequency changed.
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip __do_softirq+0x41/0xa2
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt

--------------010408020309020600070801--
