Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbVJSWZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbVJSWZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVJSWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:25:33 -0400
Received: from 82-68-65-126.dsl.in-addr.zen.co.uk ([82.68.65.126]:5761 "EHLO
	www.drunkenpirates.co.uk") by vger.kernel.org with ESMTP
	id S1751615AbVJSWZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:25:32 -0400
Message-ID: <001601c5d4fc$06ea9090$6401a8c0@CMR>
From: "Chris Rutherford" <chris1@hackinghardware.com>
To: "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: pci bridge 0000:00:1c.1 compaq nc8230 laptop
Date: Wed, 19 Oct 2005 23:25:35 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Just a quick update re the pci bridge 0000:00:1c.1 problem.

I have tried to 2.6.13.4 without the APCI and Yentra modules.  It 
boots fine with APCI and Yentra disabled.  TPM still not found on 
nc8230, but one step closer.

I have now tried up to 2.6.13.4 using the default kernel config and it 
still crashes at boot. i.e.
bridge 0000:00:1c.1 then halt.


Linux version 2.6.13.4 (root@localhost.localdomain) (gcc version 3.3.3 
20040412 (Red Hat Linux 3.3.3-7)) #2 Thu Oct 20 07:50:16 BST 2005
BIOS-provided physical RAM map:

BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)

BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)

BIOS-e820: 000000001ffd0000 - 000000001ffefc00 (reserved)

BIOS-e820: 000000001ffefc00 - 000000001fffb000 (ACPI NVS)

BIOS-e820: 000000001fffb000 - 0000000020000000 (reserved)

BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)

BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)

BIOS-e820: 00000000fed20000 - 00000000fed9b000 (reserved)

BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)

BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)

BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)

0MB HIGHMEM available.

511MB LOWMEM available.

On node 0 totalpages: 131024

DMA zone: 4096 pages, LIFO batch:1

Normal zone: 126928 pages, LIFO batch:31

HighMem zone: 0 pages, LIFO batch:1

DMI 2.3 present.

Allocating PCI resources starting at 20000000 (gap: 20000000:c0000000)

Built 1 zonelists

Kernel command line: ro root=LABEL=/ rhgb quiet

Initializing CPU#0

PID hash table entries: 2048 (order: 11, 32768 bytes)

Detected 1729.151 MHz processor.

Using tsc for high-res timesource

Console: colour VGA+ 80x25

Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

Memory: 515356k/524096k available (1928k kernel code, 8128k reserved, 
608k data, 160k init, 0k highmem)

Checking if this processor honours the WP bit even in supervisor 
mode... Ok.

Calibrating delay using timer specific routine.. 3464.53 BogoMIPS 
(lpj=6929079)

Security Framework v1.0.0 initialized

SELinux: Initializing.

SELinux: Starting in permissive mode

selinux_register_security: Registering secondary module capability

Capability LSM initialized as secondary

Mount-cache hash table entries: 512

CPU: After generic identify, caps: afe9fbff 00000000 00000000 00000000 
00000180 00000000 00000000

CPU: After vendor identify, caps: afe9fbff 00000000 00000000 00000000 
00000180 00000000 00000000

CPU: L1 I cache: 32K, L1 D cache: 32K

CPU: L2 cache: 2048K

CPU: After all inits, caps: afe9fbff 00000000 00000000 00000040 
00000180 00000000 00000000

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

mtrr: v2.0 (20020519)

CPU: Intel(R) Pentium(R) M processor 1.73GHz stepping 08

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

checking if image is initramfs...it isn't (no cpio magic); looks like 
an initrd

Freeing initrd memory: 197k freed

NET: Registered protocol family 16

PCI: PCI BIOS revision 2.10 entry at 0xf0322, last bus=32

PCI: Using configuration type 1

Linux Plug and Play Support v0.97 (c) Adam Belay

usbcore: registered new driver usbfs

usbcore: registered new driver hub

PCI: Probing PCI hardware

PCI: Probing PCI hardware (bus 00)

PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1

Boot video device is 0000:01:00.0

PCI: Transparent bridge - 0000:00:1e.0

PCI: Using IRQ router PIIX/ICH [8086/2641] at 0000:00:1f.0

PCI: IRQ 0 for device 0000:00:01.0 doesn't match PIRQ mask - try 
pci=usepirqmask

PCI: Found IRQ 10 for device 0000:00:01.0

PCI: Sharing IRQ 10 with 0000:00:1c.0

PCI: Sharing IRQ 10 with 0000:00:1f.1

PCI: Sharing IRQ 10 with 0000:01:00.0

PCI: Sharing IRQ 10 with 0000:10:00.0

PCI: IRQ 0 for device 0000:00:1c.1 doesn't match PIRQ mask - try 
pci=usepirqmask

PCI: Found IRQ 11 for device 0000:00:1c.1

PCI: Sharing IRQ 11 with 0000:00:1d.1

PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.1

PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.1

PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.1

PCI: Bridge: 0000:00:01.0

IO window: 2000-2fff

MEM window: c8800000-c8bfffff

PREFETCH window: c0000000-c7ffffff

PCI: Bridge: 0000:00:1c.0

IO window: disabled.

MEM window: c8000000-c83fffff

PREFETCH window: disabled.

PCI: Bridge: 0000:00:1c.1

IO window: disabled.

MEM window: disabled.

PREFETCH window: disabled.

PCI: Bus 3, cardbus bridge: 0000:02:06.0

IO window: 00004000-00004fff

IO window: 00005000-00005fff

PREFETCH window: 20000000-21ffffff

MEM window: 22000000-23ffffff

PCI: Bridge: 0000:00:1e.0

IO window: 4000-5fff

MEM window: c8400000-c87fffff

PREFETCH window: 20000000-21ffffff

PCI: Found IRQ 10 for device 0000:00:01.0

PCI: Sharing IRQ 10 with 0000:00:1c.0

PCI: Sharing IRQ 10 with 0000:00:1f.1

PCI: Sharing IRQ 10 with 0000:01:00.0

PCI: Sharing IRQ 10 with 0000:10:00.0

PCI: Setting latency timer of device 0000:00:01.0 to 64

PCI: Found IRQ 10 for device 0000:00:1c.0

PCI: Sharing IRQ 10 with 0000:00:01.0

PCI: Sharing IRQ 10 with 0000:00:1f.1

PCI: Sharing IRQ 10 with 0000:01:00.0

PCI: Sharing IRQ 10 with 0000:10:00.0

PCI: Setting latency timer of device 0000:00:1c.0 to 64

PCI: Device 0000:00:1c.1 not available because of resource collisions

PCI: Setting latency timer of device 0000:00:1c.1 to 64

PCI: Setting latency timer of device 0000:00:1e.0 to 64

PCI: Found IRQ 11 for device 0000:02:06.0

PCI: Sharing IRQ 11 with 0000:00:1d.2

PCI: Sharing IRQ 11 with 0000:02:06.5

apm: BIOS not found.

audit: initializing netlink socket (disabled)

audit(1129795129.180:1): initialized

Total HugeTLB memory allocated, 0

VFS: Disk quotas dquot_6.5.1

Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)

SELinux: Registering netfilter hooks

Initializing Cryptographic API

pci_hotplug: PCI Hot Plug PCI Core version: 0.5

PCI: Found IRQ 10 for device 0000:00:01.0

PCI: Sharing IRQ 10 with 0000:00:1c.0

PCI: Sharing IRQ 10 with 0000:00:1f.1

PCI: Sharing IRQ 10 with 0000:01:00.0

PCI: Sharing IRQ 10 with 0000:10:00.0

PCI: Setting latency timer of device 0000:00:01.0 to 64

assign_interrupt_mode Found MSI capability

Allocate Port Service[pcie00]

PCI: Found IRQ 10 for device 0000:00:1c.0

PCI: Sharing IRQ 10 with 0000:00:01.0

PCI: Sharing IRQ 10 with 0000:00:1f.1

PCI: Sharing IRQ 10 with 0000:01:00.0

PCI: Sharing IRQ 10 with 0000:10:00.0

PCI: Setting latency timer of device 0000:00:1c.0 to 64

assign_interrupt_mode Found MSI capability

Allocate Port Service[pcie00]

Allocate Port Service[pcie02]

PCI: Device 0000:00:1c.1 not available because of resource collisions

isapnp: Scanning for PnP cards...

isapnp: No Plug & Play device found

Real Time Clock Driver v1.12

Linux agpgart interface v0.101 (c) Dave Jones

agpgart: Detected an Intel 915GM Chipset.

agpgart: AGP aperture is 256M @ 0x0

[drm] Initialized drm 1.0.0 20040925

PNP: No PS/2 controller found. Probing ports directly.

i8042.c: Detected active multiplexing controller, rev 1.1.

serio: i8042 AUX0 port at 0x60,0x64 irq 12

serio: i8042 AUX1 port at 0x60,0x64 irq 12

serio: i8042 AUX2 port at 0x60,0x64 irq 12

serio: i8042 AUX3 port at 0x60,0x64 irq 12

serio: i8042 KBD port at 0x60,0x64 irq 1

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing 
enabled

PCI: Found IRQ 10 for device 0000:00:1e.3

PCI: Sharing IRQ 10 with 0000:02:06.2

io scheduler noop registered

io scheduler anticipatory registered

io scheduler deadline registered

io scheduler cfq registered

RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx

ICH6: IDE controller at PCI slot 0000:00:1f.1

PCI: Found IRQ 10 for device 0000:00:1f.1

PCI: Sharing IRQ 10 with 0000:00:01.0

PCI: Sharing IRQ 10 with 0000:00:1c.0

PCI: Sharing IRQ 10 with 0000:01:00.0

PCI: Sharing IRQ 10 with 0000:10:00.0

ICH6: chipset revision 3

ICH6: not 100% native mode: will probe irqs later

ide0: BM-DMA at 0x3580-0x3587, BIOS settings: hda:DMA, hdb:DMA

Probing IDE interface ide0...

hda: HTS541040G9AT00, ATA DISK drive

hdb: UJDA765aDVD/CDRW, ATAPI CD/DVD-ROM drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

Probing IDE interface ide1...

hda: max request size: 128KiB

hda: 78140160 sectors (40007 MB) w/7539KiB Cache, CHS=65535/16/63, 
UDMA(100)

hda: cache flushes supported

hda: hda1 hda2 hda3

hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, (U)DMA

Uniform CD-ROM driver Revision: 3.20

ide-floppy driver 0.99.newide

usbmon: debugfs is not available

usbcore: registered new driver hiddev

usbcore: registered new driver usbhid

drivers/usb/input/hid-core.c: v2.01:USB HID core driver

mice: PS/2 mouse device common for all mice

md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27

md: bitmap version 3.38

NET: Registered protocol family 2

input: AT Translated Set 2 keyboard on isa0060/serio0

IP route cache hash table entries: 8192 (order: 3, 32768 bytes)

TCP established hash table entries: 32768 (order: 6, 262144 bytes)

TCP bind hash table entries: 32768 (order: 5, 131072 bytes)

TCP: Hash tables configured (established 32768 bind 32768)

TCP reno registered

TCP bic registered

Initializing IPsec netlink socket

NET: Registered protocol family 1

NET: Registered protocol family 17

Using IPI Shortcut mode

md: Autodetecting RAID arrays.

md: autorun ...

md: ... autorun DONE.

RAMDISK: Compressed image found at block 0

VFS: Mounted root (ext2 filesystem).

kjournald starting. Commit interval 5 seconds

EXT3-fs: mounted filesystem with ordered data mode.

Freeing unused kernel memory: 160k freed

Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 
0xa44793/0x300000

serio: Synaptics pass-through port at isa0060/serio4/input0

input: SynPS/2 Synaptics TouchPad on isa0060/serio4

SELinux: Disabled at runtime.

SELinux: Unregistering netfilter hooks

PCI: Found IRQ 10 for device 0000:00:1d.7

PCI: Sharing IRQ 10 with 0000:00:1d.0

PCI: Setting latency timer of device 0000:00:1d.7 to 64

ehci_hcd 0000:00:1d.7: EHCI Host Controller

ehci_hcd 0000:00:1d.7: debug port 1

ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1

ehci_hcd 0000:00:1d.7: irq 10, io mem 0xc8c00000

PCI: cache line size of 32 is not supported by device 0000:00:1d.7

ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 
2004

hub 1-0:1.0: USB hub found

hub 1-0:1.0: 8 ports detected

USB Universal Host Controller Interface driver v2.3

PCI: Found IRQ 10 for device 0000:00:1d.0

PCI: Sharing IRQ 10 with 0000:00:1d.7

PCI: Setting latency timer of device 0000:00:1d.0 to 64

uhci_hcd 0000:00:1d.0: UHCI Host Controller

uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2

uhci_hcd 0000:00:1d.0: irq 10, io base 0x00003000

hub 2-0:1.0: USB hub found

hub 2-0:1.0: 2 ports detected

PCI: Found IRQ 11 for device 0000:00:1d.1

PCI: Sharing IRQ 11 with 0000:00:1c.1

PCI: Setting latency timer of device 0000:00:1d.1 to 64

uhci_hcd 0000:00:1d.1: UHCI Host Controller

uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3

uhci_hcd 0000:00:1d.1: irq 11, io base 0x00003020

hub 3-0:1.0: USB hub found

hub 3-0:1.0: 2 ports detected

PCI: Found IRQ 11 for device 0000:00:1d.2

PCI: Sharing IRQ 11 with 0000:02:06.0

PCI: Sharing IRQ 11 with 0000:02:06.5

PCI: Setting latency timer of device 0000:00:1d.2 to 64

uhci_hcd 0000:00:1d.2: UHCI Host Controller

uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4

uhci_hcd 0000:00:1d.2: irq 11, io base 0x00003040

usb 1-2: new high speed USB device using ehci_hcd and address 2

input: PS/2 Generic Mouse on synaptics-pt/serio0

hub 4-0:1.0: USB hub found

hub 4-0:1.0: 2 ports detected

SCSI subsystem initialized

Initializing USB Mass Storage driver...

scsi0 : SCSI emulation for USB Mass Storage devices

usb-storage: device found at 2

usb-storage: waiting for device to settle before scanning

usbcore: registered new driver usb-storage

USB Mass Storage support registered.

EXT3 FS on hda2, internal journal

device-mapper: 4.4.0-ioctl (2005-01-12) initialised: 
dm-devel@redhat.com

cdrom: open failed.

Adding 1024120k swap on /dev/hda3. Priority:-1 extents:1

IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>

microcode: No new microcode data for CPU0

Vendor: Lexar Model: JumpDrive I.D. Rev: 1000

Type: Direct-Access ANSI SCSI revision: 00

usb-storage: device scan complete

SCSI device sda: 502784 512-byte hdwr sectors (257 MB)

sda: Write Protect is off

sda: Mode Sense: 43 00 00 00

sda: assuming drive cache: write through

SCSI device sda: 502784 512-byte hdwr sectors (257 MB)

sda: Write Protect is off

sda: Mode Sense: 43 00 00 00

sda: assuming drive cache: write through

sda: sda1

Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0, type 0

Floppy drive(s): fd0 is 1.44M

floppy0: no floppy controllers found

tg3.c:v3.37 (August 25, 2005)

PCI: Found IRQ 10 for device 0000:10:00.0

PCI: Sharing IRQ 10 with 0000:00:01.0

PCI: Sharing IRQ 10 with 0000:00:1c.0

PCI: Sharing IRQ 10 with 0000:00:1f.1

PCI: Sharing IRQ 10 with 0000:01:00.0

PCI: Setting latency timer of device 0000:10:00.0 to 64

eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] 
(PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:12:79:c2:9c:36

eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]

eth0: dma_rwctrl[76180000]

ip_tables: (C) 2000-2002 Netfilter core team

ip_conntrack version 2.1 (4094 buckets, 32752 max) - 212 bytes per 
conntrack

lp: driver loaded but no devices found

NET: Registered protocol family 10

Disabled Privacy Extensions on device c03432c0(lo)

IPv6 over IPv4 tunneling driver

usb 1-2: USB disconnect, address 2

Floppy drive(s): fd0 is 1.44M

floppy0: no floppy controllers found

usb 2-1: new full speed USB device using uhci_hcd and address 2

scsi1 : SCSI emulation for USB Mass Storage devices

usb-storage: device found at 2

usb-storage: waiting for device to settle before scanning

Floppy drive(s): fd0 is 1.44M

floppy0: no floppy controllers found

Vendor: Wincan Model: HARD DRIVE DISK Rev: 1.04

Type: Direct-Access ANSI SCSI revision: 00

SCSI device sda: 128000 512-byte hdwr sectors (66 MB)

sda: Write Protect is off

sda: Mode Sense: 43 00 00 00

sda: assuming drive cache: write through

SCSI device sda: 128000 512-byte hdwr sectors (66 MB)

sda: Write Protect is off

sda: Mode Sense: 43 00 00 00

sda: assuming drive cache: write through

sda: sda1

Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0

Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0, type 0

usb-storage: device scan complete

tpm_infineon: No Infineon TPM found! Sorry!

tpm_infineon: unable to pci_register_driver minor 224

tpm_infineon: No Infineon TPM found! Sorry!

tpm_infineon: unable to pci_register_driver minor 224


I'd solve this problem but my Linux kernel coding skills are aren't 
yet up to the challenge, give me a parallel port problem anyday 
(especially a simple one).

Thanks

Chris R  www.hackinghardware.com 


