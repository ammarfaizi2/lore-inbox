Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbWASSVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWASSVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbWASSVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:21:10 -0500
Received: from cable-212.76.255.90.static.coditel.net ([212.76.255.90]:60299
	"EHLO jekyll.org") by vger.kernel.org with ESMTP id S1161106AbWASSVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:21:08 -0500
Message-ID: <43CFD877.4090503@jekyll.org>
Date: Thu, 19 Jan 2006 19:20:39 +0100
From: Gilles May <gilles@jekyll.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP trouble
References: <43CAFF80.2020707@jekyll.org> <Pine.LNX.4.64.0601181817410.20777@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0601181817410.20777@montezuma.fsmlabs.com>
Content-Type: multipart/mixed;
 boundary="------------030106010508010806030405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030106010508010806030405
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Zwane Mwaikambo wrote:

>On Mon, 16 Jan 2006, Gilles May wrote:
>
>  
>
>>I got a wierd problem with my dual Athlon box.
>>The board is a K7D Master-L with 2 Athlon-MP 2800+ processors.
>>Running it with SMP enabled in the kernel makes it freeze on heavy activity. I
>>can always reproduce a freeze
>>by watching a movie while copying files to/from USB disk, or on ping -f to a
>>box on my LAN. Without SMP
>>support in the kernel I can do this for hours and no freeze.
>>The kernels I tried are ranging from 2.6.11-1.1369 (FC4) to 2.6.15 vanilla
>>kernel. Running from console
>>with no X nor any proprietary modules loaded.
>>    
>>
>
>Try booting the SMP kernel with 'noapic' kernel parameter and then send 
>the kernel bootlog.
>  
>
Hi and thanks for answering..
Attached the bootlog with noapic parameter passed to the kernel. It 
still freezes though. :(
What I do exactly to make it freeze is after boot:

In one console I do a ping -f to a box on my local network using the 
e100 card. (integrated on the motherboard)

In another console I copy a 2.5 GB file from my USB HDD to the IDE HDD 
in a while loop (or do a readcd from USB DVD Writer to a file on IDE HDD)

In a third one I play an MP3 using mplayer (or mpg123) also in a while [ 
1 ] loop

This guarantees me a nice freeze after at most 20 Minutes. The same 
thing runs very well for hours without SMP support compiled in.

Regards, Gilles May

--------------030106010508010806030405
Content-Type: text/x-log;
 name="noapic-2.6.15.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="noapic-2.6.15.log"

Linux version 2.6.15smp (root@dual.jekyll.org) (gcc version 4.0.0 20050519 (Red Hat 4.0.0-8)) #8 SMP PREEMPT Tue Jan 17 01:12:56 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4b00
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
Using APIC driver default
ACPI: RSDP (v000 AMD2P                                 ) @ 0x000f6470
ACPI: RSDT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff6480
ACPI: DSDT (v001 AMD2P  AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x608
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:10 APIC version 16
ACPI: Skipping IOAPIC probe due to 'noapic' option.
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: ro root=/dev/hdb1 noapic
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c03e2000 soft=c03da000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2133.652 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033216k/1048512k available (2095k kernel code, 14640k reserved, 582k data, 216k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4272.65 BogoMIPS (lpj=8545318)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0820)
CPU0: AMD Athlon(tm) MP 2800+ stepping 00
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c03e3000 soft=c03db000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4267.39 BogoMIPS (lpj=8534796)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) MP stepping 00
Total of 2 processors activated (8540.05 BogoMIPS).
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 1080k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xfb130, last bus=2
PCI: Using configuration type 1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:05.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPP._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f8000000-f9ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:10.0
  IO window: c000-cfff
  MEM window: fb000000-fcffffff
  PREFETCH window: 50000000-500fffff
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1137690536.000:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
BIOS failed to enable PCI standards compliance, fixing this error.
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: 0000:00:07.1 (rev 04) UDMA100 controller
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6E040L0, ATA DISK drive
hdb: Maxtor 6E040L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6Y120L0, ATA DISK drive
hdd: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1
hdb: max request size: 128KiB
hdb: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2
hdc: max request size: 128KiB
hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
usbmon: debugfs is not available
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 216k freed
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
input: PS2++ Logitech MX Mouse as /class/input/input1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xfc022000, irq 11, MAC addr 00:0C:76:2A:2F:55
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xf8840000, 00:0f:b5:f8:fc:b6, IRQ 11
ACPI: PCI Interrupt 0000:00:07.5[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
intel8x0_measure_ac97_clock: measured 54990 usecs
intel8x0: clocking to 48000
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 128M @ 0xf0000000
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:04.2[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ehci_hcd 0000:02:04.2: EHCI Host Controller
ehci_hcd 0000:02:04.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:02:04.2: irq 5, io mem 0xfc021000
ehci_hcd 0000:02:04.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt 0000:02:00.0[D] -> Link [LNKD] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:02:00.0: OHCI Host Controller
ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:02:00.0: irq 5, io mem 0xfc023000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:02:04.0: OHCI Host Controller
ohci_hcd 0000:02:04.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:02:04.0: irq 11, io mem 0xfc024000
usb 1-2: new high speed USB device using ehci_hcd and address 2
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
usb 1-3: new high speed USB device using ehci_hcd and address 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 1-4: new high speed USB device using ehci_hcd and address 4
ACPI: PCI Interrupt 0000:02:04.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:02:04.1: OHCI Host Controller
ohci_hcd 0000:02:04.1: new USB bus registered, assigned bus number 4
ohci_hcd 0000:02:04.1: irq 11, io mem 0xfc020000
usb 2-3: new full speed USB device using ohci_hcd and address 2
usb 1-2.1: new full speed USB device using ehci_hcd and address 5
usb 1-2.1: not running at top speed; connect to a high speed hub
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
usbcore: registered new driver snd-usb-audio
HID device not claimed by input or hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
input: Yealink usb-p1k as /class/input/input2
usbcore: registered new driver yealink
drivers/usb/input/yealink.c: Yealink phone driver:yld-20050816
cdrom: open failed.
cdrom: open failed.
EXT3 FS on hdb1, internal journal
NTFS driver 2.1.25 [Flags: R/O MODULE].
NTFS volume version 3.1.
NTFS volume version 3.1.
Adding 4192956k swap on /dev/hdb2.  Priority:-1 extents:1 across:4192956k
  Vendor: PHILIPS   Model: ED16DVDS          Rev: J5S7
  Type:   CD-ROM                             ANSI SCSI revision: 00
usb-storage: device scan complete
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
  Vendor: SAMSUNG   Model: MP0402H           Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 00
usb-storage: device scan complete
r8169: eth1: link down
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
lp0: console ready
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth1: link is not ready
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
sr 1:0:0:0: Attached scsi CD-ROM sr0
SCSI device sda: 78242976 512-byte hdwr sectors (40060 MB)
sda: assuming drive cache: write through
SCSI device sda: 78242976 512-byte hdwr sectors (40060 MB)
sda: assuming drive cache: write through
 sda: sda1
sd 0:0:0:0: Attached scsi disk sda

--------------030106010508010806030405--
