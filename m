Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbUK0SOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbUK0SOM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 13:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUK0SOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 13:14:11 -0500
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:30876
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S261288AbUK0SMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 13:12:34 -0500
Message-ID: <41A8C3BF.20904@freemail.hu>
Date: Sat, 27 Nov 2004 19:13:19 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; hu; rv:1.7.3) Gecko/20041020
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM problem on x86-64
References: <41A84875.2030505@freemail.hu> <41A848C4.1030504@freemail.hu> <Pine.LNX.4.61.0411271035340.3173@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0411271035340.3173@montezuma.fsmlabs.com>
Content-Type: multipart/mixed;
 boundary="------------060104030903030602050603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060104030903030602050603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Zwane Mwaikambo írta:
> On Sat, 27 Nov 2004, Zoltan Boszormenyi wrote:
> 
> 
>>Sorry, this last statement is not true, just compare the two error
>>reports above. Both hda and hdc show this error.
> 
> 
> Please provide full dmesg, lspci and if possible state around which kernel 
> version the problems began occuring
> 
> Thanks,
> 	Zwane

They are attached. I am running the linuxconsole.sf.net multiconsole
extension, I patched the Fedora Core 3 original and the second errata
kernel with it and made a custom RPM.

$ rpm -q kernel
kernel-2.6.9-1.667
kernel-2.6.9-1.667ruby.root
kernel-2.6.9-1.681ruby_FC3.root
$ uname -a
Linux wl-193.226.227-37-szolnok.dunaweb.hu 2.6.9-1.681ruby_FC3.root #1 
Wed Nov 24 20:26:05 CET 2004 x86_64 x86_64 x86_64 GNU/Linux

I used my machine this way with my old FC1 installation,
I had linux-2.6.8.1 with the above mentioned patch before
I reinstalled my machine with FC3. It definitely didn't show
this error. It was a 32-bit system, now I have a 64-bit system
installed. I had VMWare installed then and also now. My Realtek 8169
ethernet's (soldered on the mainboard) driver also filled my log up
since it isn't connected to anywhere:

r8169: eth1: PHY reset until link up

But what I haven't seen in my logs at that time is this:

Losing some ticks... checking if CPU frequency changed.

and

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip rtl8169_phy_timer+0x1b2/0x1ba [r8169]

Could it be the cause? I will test whether it helps if I disable
it at boot time.

The mainboard is an MSI K8T Neo FIS2R, all other peripherals you
can find in dmesg and lspci outputs.

Best regards,
Zoltán Böszörményi

--------------060104030903030602050603
Content-Type: text/plain;
 name="dmesg-FC3.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-FC3.log"

Bootdata ok (command line is ro root=LABEL=/ dumbcon=1 rhgb quiet)
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
ACPI: RSDP (v000 AMI                                   ) @ 0x00000000000fa3f0
ACPI: RSDT (v001 AMIINT VIA_K8   0x00000010 MSFT 0x00000097) @ 0x000000001fff0000
ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT 0x00000097) @ 0x000000001fff0030
ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT 0x00000097) @ 0x000000001fff00c0
ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT 0x0100000d) @ 0x0000000000000000
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
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ d0000000 size 128 MB
Built 1 zonelists
Kernel command line: ro root=LABEL=/ dumbcon=1 rhgb quiet console=tty0
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2000.130 MHz processor.
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
Using local APIC timer interrupts.
Detected 12.500 MHz APIC timer.
checking if image is initramfs... it is
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
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
ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:05.1[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 201
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 209
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1101574061.193:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key A617AC2237592777
- User ID: Red Hat, Inc. (Kernel Module GPG key)
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 9
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 9
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 9
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 9
PCI: Via IRQ fixup for 0000:00:11.5, from 3 to 1
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: probe of vesafb0 failed with error -6
ACPI: Processor [CPU1] (supports C1)
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
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 193
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
hdc: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
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
ACPI: (supports S0 S1 S4 S5)
ACPI wakeup devices: 
PCI0 UAR1 USB1 USB2 USB3 USB4 EHCI USBD  AC9  MC9 ILAN SLPB 
Freeing unused kernel memory: 164k freed
SCSI subsystem initialized
libata version 1.02 loaded.
sata_via version 0.20
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 193
sata_via(0000:00:0f.0): routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD002 bmdma 0xC400 irq 193
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xC802 bmdma 0xC408 irq 193
ata1: no device found (phy stat 00000000)
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
sata_promise version 1.00
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 177
ata3: SATA max UDMA/133 cmd 0xFFFFFF000001A200 ctl 0xFFFFFF000001A238 bmdma 0x0 irq 177
ata4: SATA max UDMA/133 cmd 0xFFFFFF000001A280 ctl 0xFFFFFF000001A2B8 bmdma 0x0 irq 177
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: no device found (phy stat 00000000)
scsi3 : sata_promise
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
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
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 185
orinoco_pci: Detected Orinoco/Prism2 PCI device at 0000:00:08.0, mem:0xCFBFD000 to 0xCFBFDFFF -> 0xffffff000001c000, irq:185
Reset done..............................................................................................................................................................................................................................................................;
Clear Reset............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................;
pci_cor : reg = 0x0 - FFFB9D12 - FFFB9B1E
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
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 169
r8169: NAPI enabled
divert: allocating divert_blk for eth1
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xffffff000001ef00, 00:0c:76:52:dc:54, IRQ 169
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 209
PCI: Setting latency timer of device 0000:00:11.5 to 64
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 201
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: irq 201, pci mem ffffff0000076d00
SELinux: initialized (dev usbdevfs, type usbdevfs), uses genfs_contexts
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 201, io base 000000000000b000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 201, io base 000000000000b400
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 201, io base 000000000000b800
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 201
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: irq 201, io base 000000000000bc00
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 185
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[185]  MMIO=[cffee000-cffee7ff]  Max Packet=[2048]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
usb 3-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-1
usb 3-2: new low speed USB device using address 3
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c4af2]
usb 5-2: new full speed USB device using address 2
EXT3 FS on hda10, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x54
ide: failed opcode was 100
end_request: I/O error, dev hdc, sector 1436800
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hda2
Starting XFS recovery on filesystem: hda2 (dev: hda2)
Ending XFS recovery on filesystem: hda2 (dev: hda2)
SELinux: initialized (dev hda2, type xfs), uses xattr
XFS mounting filesystem hda5
Ending clean XFS mount for filesystem: hda5
SELinux: initialized (dev hda5, type xfs), uses xattr
XFS mounting filesystem hda7
Starting XFS recovery on filesystem: hda7 (dev: hda7)
Ending XFS recovery on filesystem: hda7 (dev: hda7)
SELinux: initialized (dev hda7, type xfs), uses xattr
XFS mounting filesystem hda11
Starting XFS recovery on filesystem: hda11 (dev: hda11)
Ending XFS recovery on filesystem: hda11 (dev: hda11)
SELinux: initialized (dev hda11, type xfs), uses xattr
XFS mounting filesystem hda6
Starting XFS recovery on filesystem: hda6 (dev: hda6)
Ending XFS recovery on filesystem: hda6 (dev: hda6)
SELinux: initialized (dev hda6, type xfs), uses xattr
XFS mounting filesystem hda9
Starting XFS recovery on filesystem: hda9 (dev: hda9)
Ending XFS recovery on filesystem: hda9 (dev: hda9)
SELinux: initialized (dev hda9, type xfs), uses xattr
XFS mounting filesystem hda8
Starting XFS recovery on filesystem: hda8 (dev: hda8)
Ending XFS recovery on filesystem: hda8 (dev: hda8)
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
r8169: eth1: PHY reset until link up
eth1: no IPv6 routers present
vmmon: module license 'unspecified' taints kernel.
vmmon: no version for "sys_ioctl" found: kernel tainted.
/dev/vmmon: Module vmmon: registered with major=10 minor=165
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 3497 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth1: enabling the bridge
bridge-eth1: up
bridge-eth1: already up
bridge-eth1: attached
/dev/vmnet: open called by PID 3520 (vmnet-natd)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
/dev/vmnet: open called by PID 5740 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
divert: allocating divert_blk for vmnet1
/dev/vmnet: open called by PID 5747 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
divert: allocating divert_blk for vmnet8
/dev/vmnet: open called by PID 6193 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 6198 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 177
[drm] Initialized radeon 1.11.0 20020828 on minor 0: 
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[drm] Initialized radeon 1.11.0 20020828 on minor 1: 
r8169: eth1: PHY reset until link up
vmnet1: no IPv6 routers present
vmnet8: no IPv6 routers present
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
Losing some ticks... checking if CPU frequency changed.
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip rtl8169_phy_timer+0x1b2/0x1ba [r8169]
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SELinux: initialized (dev hdc, type iso9660), uses genfs_contexts
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
application mozilla-bin uses obsolete OSS audio interface
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up
r8169: eth1: PHY reset until link up

--------------060104030903030602050603
Content-Type: text/plain;
 name="lspci-FC3.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-FC3.log"

00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
	Subsystem: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [c0] HyperTransport: Slave or Primary Interface
	!!! Possibly incomplete decoding
		Command: BaseUnitID=0 UnitCnt=3 MastHost- DefDir-
		Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config 0: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
		Link Config 1: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
		Revision ID: 1.02
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] HyperTransport: Interrupt Discovery and Configuration
00: 06 11 88 31 06 00 30 22 01 00 00 06 00 08 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 88 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: cfc00000-cfcfffff
	Prefetchable memory behind bridge: 9fb00000-bfafffff
	Secondary status: 66Mhz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 88 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 90 90 20 22
20: c0 cf c0 cf b0 9f a0 bf 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0e 00

00:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Subsystem: Avermedia Technologies Inc: Unknown device 0003
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at cfbfe000 (32-bit, prefetchable) [size=4K]
00: 9e 10 6e 03 06 00 80 02 02 00 00 04 00 20 80 00
10: 08 e0 bf cf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 61 14 03 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 10 28

00:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: Avermedia Technologies Inc: Unknown device 0003
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at cfbff000 (32-bit, prefetchable) [size=4K]
00: 9e 10 78 08 06 00 80 02 02 00 80 04 00 20 80 00
10: 08 f0 bf cf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 61 14 03 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 04 ff

00:06.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7c02
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at e000 [size=256]
	Region 2: Memory at cffd0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at cff80000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 59 51 87 00 90 02 00 00 00 03 08 20 00 00
10: 08 00 00 c0 01 e0 00 00 00 00 fd cf 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 02 7c
30: 00 00 f8 cf 50 00 00 00 00 00 00 00 0a 01 08 00

00:08.0 Network controller: Intersil Corporation Prism 2.5 Wavelan chipset (rev 01)
	Subsystem: Netgear MA311 802.11b wireless adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin A routed to IRQ 185
	Region 0: Memory at cfbfd000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 60 12 73 38 17 00 90 02 01 00 80 02 08 20 00 00
10: 08 d0 bf cf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 85 13 05 41
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 00 00

00:0a.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at cfe00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 11 00 83 06 00 10 02 02 00 80 04 00 20 00 00
10: 00 00 e0 cf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 00 00
40: 01 00 01 00 00 00 00 00
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at cfffbf00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at cff60000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 69 81 17 00 b0 02 10 00 00 02 08 40 00 00
10: 01 dc 00 00 00 bf ff cf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 2c 70
30: 00 00 f6 cf dc 00 00 00 00 00 00 00 0b 01 20 40

00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak 378/SATA 378) (rev 02)
	Subsystem: Micro-Star International Co., Ltd. K8T NEO FIS2R motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (1000ns min, 4500ns max), Cache Line Size 91
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at ec00 [size=64]
	Region 1: I/O ports at e800 [size=16]
	Region 2: I/O ports at e400 [size=128]
	Region 3: Memory at cffef000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at cffa0000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 73 33 17 00 30 02 02 00 04 01 91 60 00 00
10: 01 ec 00 00 01 e8 00 00 01 e4 00 00 00 f0 fe cf
20: 00 00 fa cf 00 00 00 00 00 00 00 00 62 14 2e 70
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 04 12

00:0e.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80) (prog-if 10 [OHCI])
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 185
	Region 0: Memory at cffee000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at d800 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 44 30 17 00 10 02 80 10 00 0c 08 20 00 00
10: 00 e0 fe cf 01 d8 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 2d 70
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 01 00 20

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
	Subsystem: Micro-Star International Co., Ltd. K8T Neo 2 Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 193
	Region 0: I/O ports at d400 [size=8]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at cc00 [size=8]
	Region 3: I/O ports at c800 [size=4]
	Region 4: I/O ports at c400 [size=16]
	Region 5: I/O ports at c000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 d4 00 00 01 d0 00 00 01 cc 00 00 01 c8 00 00
20: 01 c4 00 00 01 c0 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 02 00 00

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 193
	Region 4: I/O ports at fc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 fc 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin A routed to IRQ 201
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b0 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 01 00 00

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin A routed to IRQ 201
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 01 00 00

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin B routed to IRQ 201
	Region 4: I/O ports at b800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 02 00 00

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 08
	Interrupt: pin B routed to IRQ 201
	Region 4: I/O ports at bc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 bc 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 02 00 00

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size 10
	Interrupt: pin C routed to IRQ 201
	Region 0: Memory at cfffbd00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 17 00 10 02 86 20 03 0c 10 20 80 00
10: 00 bd ff cf 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 20 70
30: 00 00 00 00 80 00 00 00 00 00 00 00 03 03 00 00

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800 South]
	Subsystem: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800 South]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 27 32
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: Micro-Star International Co., Ltd. K8T NEO 2 motherboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 209
	Region 0: I/O ports at ac00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 ac 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 80 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 01 03 00 00

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] HyperTransport: Host or Secondary Interface
	!!! Possibly incomplete decoding
		Command: WarmRst+ DblEnd-
		Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
		Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
		Revision ID: 1.02
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01) (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 7c26
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at b0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9800 [size=256]
	Region 2: Memory at cfcf0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at cfcc0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 64 59 07 00 b0 02 01 00 00 03 08 20 80 00
10: 08 00 00 b0 01 98 00 00 00 00 cf cf 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 26 7c
30: 00 00 cc cf 58 00 00 00 00 00 00 00 0b 01 08 00

01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
	Subsystem: PC Partner Limited: Unknown device 7c27
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), Cache Line Size 08
	Region 0: Memory at a8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at cfce0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 44 5d 07 00 b0 02 01 00 80 03 08 20 00 00
10: 08 00 00 a8 00 00 ce cf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 27 7c
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00


--------------060104030903030602050603--
