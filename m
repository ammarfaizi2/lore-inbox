Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUBPRps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUBPRps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:45:48 -0500
Received: from YahooBB219197212132.bbtec.net ([219.197.212.132]:7041 "EHLO
	rai.sytes.net") by vger.kernel.org with ESMTP id S265750AbUBPRpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:45:34 -0500
Message-ID: <403101BA.1060202@yahoo.com>
Date: Tue, 17 Feb 2004 02:45:30 +0900
From: Tetsuji Rai <tetsuji_rai@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040211
X-Accept-Language: en, ja, zh-tw, zh-cn, zh-hk
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cannot enable APIC with 2.6.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I enabled APIC in config file of kernel 2.6.2, however APIC is not enabled
on boot.   I'm sure APIC is enabled on my machine by BIOS, because I
confirmed it with WIndows XP.  What's wrong with my settings?   Or it's a
bug of kernel?.....I suspect my config should be wrong.....

I attach my config file and /var/log/dmesg and /proc/interrupts.

I am running debian testing with kernel 2.6.2 download from ftp.kernel.org.

TIA!!!!

---config----(necessary part)

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y

-----dmesg-----
Linux version 2.6.2 (root@rai.sytes.net) (gcc version 3.3.3 20040125
(prerelease) (Debian)) #1 Mon Feb 16 11:12:00 JST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
 BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda2 hdc=ide-cd hdd=ide-scsi
ide_setup: hdc=ide-cd
ide_setup: hdd=ide-scsi
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2597.821 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 904704k/917504k available (1709k kernel code, 12016k reserved, 661k
data, 312k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5128.19 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2597.0081 MHz.
..... host bus clock speed is 108.0211 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf11b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9680
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x96b0, dseg 0xf0000
pnp: match found with the PnP device '00:09' and the driver 'system'
pnp: match found with the PnP device '00:12' and the driver 'system'
pnp: 00:12: ioport range 0xe600-0xe61f has been reserved
pnp: 00:12: ioport range 0xe400-0xe47f has been reserved
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Enabling SiS 96x SMBus.
PCI: Using IRQ router default [1039/0963] at 0000:00:02.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try
pci=usepirqmaskPCI: Cannot allocate resource region 4 of device 0000:00:02.1
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.6 [Flags: R/O].
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:02' and the driver 'serial'
pnp: match found with the PnP device '00:03' and the driver 'serial'
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD400BB-00AUA1, ATA DISK drive
hdb: ST320413A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
hdd: CD-W58E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 < hda5 > hda2 hda3
hdb: max request size: 128KiB
hdb: Host Protected Area detected.
        current capacity is 39102336 sectors (20020 MB)
        native  capacity is 39102337 sectors (20020 MB)
hdb: 39102336 sectors (20020 MB) w/1024KiB Cache, CHS=38792/16/63, UDMA(100)
 hdb: hdb1 hdb2 hdb3
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: reset, control = 0x0
ohci_hcd 0000:00:03.0: irq 9, pci mem f8800000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:03.0: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.2 ohci_hcd
usb usb1: SerialNumber: 0000:00:03.0
usb usb1: registering 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
ohci_hcd 0000:00:03.0: created debug files
ohci_hcd 0000:00:03.0: OHCI controller state
ohci_hcd 0000:00:03.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:03.0: control 0x08f HCFS=operational IE PLE CBSR=3
ohci_hcd 0000:00:03.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:03.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:03.0: intrenable 0x80000002 MIE WDH
ohci_hcd 0000:00:03.0: hcca frame #0010
ohci_hcd 0000:00:03.0: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci_hcd 0000:00:03.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:03.0: roothub.status 00000000
ohci_hcd 0000:00:03.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:03.0: roothub.portstatus [1] 0x00010101 CSC PPS CCS
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: reset, control = 0x0
ohci_hcd 0000:00:03.1: irq 9, pci mem f8802000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.1: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.2 ohci_hcd
usb usb2: SerialNumber: 0000:00:03.1
usb usb2: registering 2-0:1.0 (config #1, interface 0)
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: ganged power switching
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
ohci_hcd 0000:00:03.1: created debug files
ohci_hcd 0000:00:03.1: OHCI controller state
ohci_hcd 0000:00:03.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:03.1: control 0x08f HCFS=operational IE PLE CBSR=3
ohci_hcd 0000:00:03.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:03.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:03.1: intrenable 0x80000002 MIE WDH
ohci_hcd 0000:00:03.1: hcca frame #0010
ohci_hcd 0000:00:03.1: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci_hcd 0000:00:03.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:03.1: roothub.status 00000000
ohci_hcd 0000:00:03.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:03.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: reset, control = 0x0
ohci_hcd 0000:00:03.2: irq 9, pci mem f8804000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.2: root hub device address 1
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.2 ohci_hcd
usb usb3: SerialNumber: 0000:00:03.2
usb usb3: registering 3-0:1.0 (config #1, interface 0)
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: ganged power switching
hub 3-0:1.0: global over-current protection
hub 3-0:1.0: Port indicators are not supported
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: hub controller current requirement: 0mA
hub 3-0:1.0: local power source is good
hub 3-0:1.0: no over-current condition exists
hub 3-0:1.0: enabling power on all ports
ohci_hcd 0000:00:03.2: created debug files
ohci_hcd 0000:00:03.2: OHCI controller state
ohci_hcd 0000:00:03.2: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:03.2: control 0x08f HCFS=operational IE PLE CBSR=3
ohci_hcd 0000:00:03.2: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:03.2: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:03.2: intrenable 0x80000002 MIE WDH
ohci_hcd 0000:00:03.2: hcca frame #0010
ohci_hcd 0000:00:03.2: roothub.a 01000202 POTPGT=1 NPS NDP=2
ohci_hcd 0000:00:03.2: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:03.2: roothub.status 00000000
ohci_hcd 0000:00:03.2: roothub.portstatus [0] 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:03.2: roothub.portstatus [1] 0x00000100 PPS
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
ohci_hcd 0000:00:03.0: GetStatus roothub.portstatus [2] = 0x00010101 CSC PPS
CCShub 1-0:1.0: port 2, status 101, change 1, 12 Mb/s
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 312k freed
hub 1-0:1.0: debounce: port 2: delay 100ms stable 4 status 0x101
ohci_hcd 0000:00:03.0: GetStatus roothub.portstatus [2] = 0x00100103 PRSC
PPS PES CCS
hub 1-0:1.0: new USB device on port 2, assigned address 2
usb 1-2: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 2 default language ID 0x409
usb 1-2: Product: Inkjet color printer
usb 1-2: Manufacturer: Lexmark
usb 1-2: registering 1-2:1.0 (config #1, interface 0)
ohci_hcd 0000:00:03.2: GetStatus roothub.portstatus [1] = 0x00010301 CSC
LSDA PPS CCS
hub 3-0:1.0: port 1, status 301, change 1, 1.5 Mb/s
hub 3-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
ohci_hcd 0000:00:03.2: GetStatus roothub.portstatus [1] = 0x00100303 PRSC
LSDA PPS PES CCS
hub 3-0:1.0: new USB device on port 1, assigned address 2
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 2 default language ID 0x409
usb 3-1: Product: SideWinder Precision 2 Joystick
usb 3-1: Manufacturer: Microsoft
usb 3-1: registering 3-1:1.0 (config #1, interface 0)
Adding 979924k swap on /dev/hdb1.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
Real Time Clock Driver v1.12
drivers/usb/core/usb.c: registered new driver hiddev
hid 3-1:1.0: usb_probe_interface
hid 3-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Joystick [Microsoft SideWinder Precision 2 Joystick] on
usb-0000:00:03.2-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as
device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TEAC      Model: CD-W58E           Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
ip_conntrack version 2.1 (7168 buckets, 57344 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
nvidia: no version for "struct_module" found: kernel tainted.
nvidia: no version magic, tainting kernel.
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed
Jul 16 19:03:09 PDT 2003
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS volume version 3.1.
NTFS volume version 3.1.
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0: Transceiver selection forced to 100baseTx.
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #1 config 3000 status 782d advertising 05e1.
tulip0:  Advertising 01e1 on PHY 1, previously advertising 05e1.
eth1: Digital DS21140 Tulip rev 34 at 0xf8983000, 00:90:CC:0F:D9:50, IRQ 5.
e100: eth0 NIC Link is Up 100 Mbps Full duplex

----/proc/interrupts-------------
           CPU0
  0:    1805735          XT-PIC  timer
  1:       2285          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:        269          XT-PIC  eth1
  7:          0          XT-PIC  cmpci
  8:          4          XT-PIC  rtc
  9:         30          XT-PIC  ohci_hcd, ohci_hcd, ohci_hcd
 10:          0          XT-PIC  cmpci
 11:     228283          XT-PIC  eth0, nvidia
 12:     150636          XT-PIC  i8042
 14:      15491          XT-PIC  ide0
 15:        100          XT-PIC  ide1
NMI:          0
LOC:    1805720
ERR:          0
MIS:          0
