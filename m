Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTFLQso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTFLQso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:48:44 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:30656 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S264887AbTFLQse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:48:34 -0400
Subject: Re: Broken USB, sound in 2.5.70-mmX series
From: Michel Alexandre Salim <mas118@york.ac.uk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1055436599.6845.7.camel@bushido>
References: <1055436599.6845.7.camel@bushido>
Content-Type: multipart/mixed; boundary="=-2W5KDqY5/8gNax7d1nkk"
Organization: University of York
Message-Id: <1055437375.6143.2.camel@bushido>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 18:02:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2W5KDqY5/8gNax7d1nkk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-06-12 at 17:49, Michel Alexandre Salim wrote:

> USB compiled as all modular, using uhci_hcd and ehci_hcd, but I don't
> have any USB2 devices. Under 2.5.70-mm8 sound does not work either - the
> ALSA driver (snd-ymfpci) is loaded but no sound came out. Presumably the
> same is true with the other kernels.
> 
Correction - snd-intel8x0

> Something seems broken in the initialisation process. ACPI changes? I
> saw a message from someone else having to use acpi=off. This is not an
> option for me - the computer is horrible without ACPI, with various
> devices all running on the same IRQ (the first thing I did after
> installing Linux was ripping out the kernel and putting an ACPI enabled
> one).
It is definitely ACPI - I tried booting with ACPI off, everything works
(sound stutters though). Booting with ACPI, the sound driver is not
loaded. Manually loading, sound stuttered then stopped after one second.
Keyboard and mouse (both USB) do not work with ACPI even though the
drivers are loaded.

Attached are the dmesg output:

Hope to see a fix soon. Thanks,

Michel

--=-2W5KDqY5/8gNax7d1nkk
Content-Disposition: attachment; filename=2.5.70-acpi.log
Content-Type: text/plain; name=2.5.70-acpi.log; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux version 2.5.70-mm7 (michel@bushido) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Jun 12 16:11:11 BST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff70000 (usable)
 BIOS-e820: 000000000ff70000 - 000000000ff7c000 (ACPI data)
 BIOS-e820: 000000000ff7c000 - 000000000ff80000 (ACPI NVS)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffff000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65392
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61296 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
Sony Vaio laptop detected.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f69e0
ACPI: RSDT (v001   SONY       G0 08195.00517) @ 0x0ff78062
ACPI: FADT (v002   SONY       G0 08195.00517) @ 0x0ff7bec2
ACPI: BOOT (v001   SONY       G0 08195.00517) @ 0x0ff7bfd8
ACPI: SSDT (v001   SONY       G0 08195.00517) @ 0x0ff78092
ACPI: DSDT (v001   SONY       G0 08195.00517) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda7
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1290.092 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2575.56 BogoMIPS
Memory: 255344k/261568k available (2000k kernel code, 5476k reserved, 464k data, 128k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After generic, caps: a7e9f9bf 00000000 00000000 00000040
CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd9c3, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030522
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................................................................................................................
Table [DSDT](id F005) - 501 Objects with 48 Devices 143 Methods 17 Regions
Parsing all Control Methods:....
Table [SSDT](id F003) - 7 Objects with 0 Devices 4 Methods 0 Regions
ACPI Namespace successfully loaded at root c0398c7c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0743 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000001028 on int 9
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L03 as GPE number 0x03
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L04 as GPE number 0x04
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L05 as GPE number 0x05
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0C as GPE number 0x0C
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0D as GPE number 0x0D
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0B as GPE number 0x0B
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L1D as GPE number 0x1D
Completing Region/Field/Buffer/Package initialization:..................................................................
Initialized 17/17 Regions 0/0 Fields 24/24 Buffers 25/25 Packages (516 nodes)
Executing all Device _STA and_INI methods:.................................................
49 Devices found containing: 49 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - PCI device 8086:2448
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *9)
ACPI: PCI Interrupt Link [LNKB] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
ACPI: PCI Interrupt Link [LNKF] (IRQs 9, enabled at IRQ 3)
ACPI: PCI Interrupt Link [LNKG] (IRQs 9, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 9, disabled)
ACPI: Embedded Controller [EC0] (gpe 28)
Linux Plug and Play Support v0.96 (c) Adam Belay
pty: 256 Unix98 ptys configured
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 9
 pci_irq-0295 [25] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:1f.1
ACPI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Lid Switch [LID0]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [ATF0] (54 C)
Real Time Clock Driver v1.11
Intel(R) PRO/100 Network Driver - version 2.3.13-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
 pci_irq-0295 [26] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:1f.1
ACPI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23EA-40, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/2048KiB Cache, CHS=77520/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Yenta IRQ list 0cb0, PCI irq3
Socket status: 30000411
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.4 (Fri Jun 06 09:23:03 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
irq 9: nobody cared!
Call Trace: [<c010aa2e>]  [<c010ab06>]  [<c010ad9d>]  [<c0109350>]  [<c01c007b>]  [<c012057c>]  [<c010ad79>]  [<c010701e>]  [<c0109350>]  [<c010701e>]  [<c0119325>]  [<c010912d>]  [<c010701e>]  [<c01f17a4>]  [<c0105000>]  [<c01f1668>]  [<c010701e>]  [<c01070a9>]  [<c0105000>]  [<c036c674>]  [<c036c3d8>] 
handlers:
[<c01c22be>]
Disabling IRQ #9
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Setting latency timer of device 00:1d.7 to 64
ehci-hcd 00:1d.7: PCI device 8086:24cd
ehci-hcd 00:1d.7: irq 9, pci mem d081e000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ehci-hcd 00:1d.7: new USB bus registered, assigned bus number 1
ehci-hcd 00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 32 is not supported by device 00:1d.7
ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Setting latency timer of device 00:1d.0 to 64
uhci-hcd 00:1d.0: PCI device 8086:24c2
uhci-hcd 00:1d.0: irq 9, io base 00001800
uhci-hcd 00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
uhci-hcd 00:1d.1: PCI device 8086:24c4
uhci-hcd 00:1d.1: irq 9, io base 00001820
uhci-hcd 00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
PCI: Setting latency timer of device 00:1d.2 to 64
uhci-hcd 00:1d.2: PCI device 8086:24c7
uhci-hcd 00:1d.2: irq 9, io base 00001840
uhci-hcd 00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
drivers/usb/core/usb.c: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
hub 1-0:0: debounce: port 5: delay 100ms stable 4 status 0x501
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda7, internal journal
Adding 522072k swap on /dev/hda10.  Priority:-1 extents:1
drivers/usb/core/message.c: usb_control/bulk_msg: timeout
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 938 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[d0202000-d02027ff]  Max Packet=[2048]
blk: queue c03a03fc, I/O limit 4095Mb (mask 0xffffffff)
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
ip_tables: (C) 2000-2002 Netfilter core team
sonypi: Sony Programmable I/O Controller Driver v1.18.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
Sony VAIO Jog Dial installed.
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000

--=-2W5KDqY5/8gNax7d1nkk
Content-Disposition: attachment; filename=2.5.70-noacpi.log
Content-Type: text/plain; name=2.5.70-noacpi.log; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux version 2.5.70-mm7 (michel@bushido) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 Thu Jun 12 16:11:11 BST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ff70000 (usable)
 BIOS-e820: 000000000ff70000 - 000000000ff7c000 (ACPI data)
 BIOS-e820: 000000000ff7c000 - 000000000ff80000 (ACPI NVS)
 BIOS-e820: 000000000ff80000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffff000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65392
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61296 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
Sony Vaio laptop detected.
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda7 acpi=off
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1290.084 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2575.56 BogoMIPS
Memory: 255344k/261568k available (2000k kernel code, 5476k reserved, 464k data, 128k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After generic, caps: a7e9f9bf 00000000 00000000 00000040
CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd9c3, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030522
ACPI: Disabled via command line (acpi=off)
Linux Plug and Play Support v0.96 (c) Adam Belay
pty: 256 Unix98 ptys configured
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - PCI device 8086:2448
PCI: Using IRQ router PIIX [8086/24cc] at 00:1f.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Initializing Cryptographic API
Real Time Clock Driver v1.11
Intel(R) PRO/100 Network Driver - version 2.3.13-k1
Copyright (c) 2003 Intel Corporation

PCI: Found IRQ 9 for device 02:08.0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: HITACHI_DK23EA-40, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/2048KiB Cache, CHS=77520/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
PCI: Found IRQ 3 for device 02:05.0
Yenta IRQ list 0cb0, PCI irq3
Socket status: 30000411
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.4 (Fri Jun 06 09:23:03 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cpufreq: No CPUs supporting ACPI performance management found.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: No IRQ known for interrupt pin D of device 00:1d.7. Please try using pci=biosirq.
drivers/usb/core/hcd-pci.c: Found HC with no IRQ.  Check BIOS/PCI 00:1d.7 setup!
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 9 for device 00:1d.0
PCI: Setting latency timer of device 00:1d.0 to 64
uhci-hcd 00:1d.0: PCI device 8086:24c2
uhci-hcd 00:1d.0: irq 9, io base 00001800
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PCI: Found IRQ 9 for device 00:1d.1
PCI: Sharing IRQ 9 with 02:0b.0
PCI: Setting latency timer of device 00:1d.1 to 64
uhci-hcd 00:1d.1: PCI device 8086:24c4
uhci-hcd 00:1d.1: irq 9, io base 00001820
uhci-hcd 00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PCI: No IRQ known for interrupt pin C of device 00:1d.2. Please try using pci=biosirq.
drivers/usb/core/hcd-pci.c: Found HC with no IRQ.  Check BIOS/PCI 00:1d.2 setup!
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
drivers/usb/core/usb.c: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
hub 1-1:0: USB hub found
hub 1-1:0: 3 ports detected
hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-1:0: new USB device on port 1, assigned address 3
input: USB HID v1.00 Keyboard [Chicony  PFU-65 USB Keyboard] on usb-00:1d.0-1.1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda7, internal journal
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
Adding 522072k swap on /dev/hda10.  Priority:-1 extents:1
hub 2-0:0: new USB device on port 1, assigned address 2
hub 2-1:0: USB hub found
hub 2-1:0: 4 ports detected
hub 2-1:0: debounce: port 4: delay 100ms stable 4 status 0x301
hub 2-1:0: new USB device on port 4, assigned address 3
input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-00:1d.1-1.4
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 938 $ Ben Collins <bcollins@debian.org>
PCI: No IRQ known for interrupt pin B of device 02:05.1. Please try using pci=biosirq.
ohci1394: Failed to allocate shared interrupt 0
blk: queue c03a03fc, I/O limit 4095Mb (mask 0xffffffff)
hub 2-1:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 2-1:0: new USB device on port 2, assigned address 4
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
ip_tables: (C) 2000-2002 Netfilter core team
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
anticipatory scheduling elevator
  Vendor: SanDisk   Model: ImageMate II      Rev: 1.30
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
anticipatory scheduling elevator
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
ec_write failed
ec_write failed
ec_write failed
sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 189)
sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 199)
sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 201)
sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 189)
sonypi: Sony Programmable I/O Controller Driver v1.18.
sonypi: detected type2 model, verbose = 0, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
Sony VAIO Jog Dial installed.
PCI: Setting latency timer of device 00:1f.5 to 64
intel8x0: clocking to 48000

--=-2W5KDqY5/8gNax7d1nkk--

