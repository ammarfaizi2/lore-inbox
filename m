Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUHTQiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUHTQiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267171AbUHTQiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:38:23 -0400
Received: from pop.gmx.net ([213.165.64.20]:34454 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267195AbUHTQga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:36:30 -0400
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Reply-To: stefandoesinger@gmx.at
To: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
Date: Fri, 20 Aug 2004 18:36:11 +0200
User-Agent: KMail/1.6.2
Cc: acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>
References: <41103F22.4090303@optonline.net> <200408201250.55025.stefandoesinger@gmx.at> <4125EC0C.5090006@optonline.net>
In-Reply-To: <4125EC0C.5090006@optonline.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7hiJBdvKGrVBm0Y"
Message-Id: <200408201836.11241.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_7hiJBdvKGrVBm0Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Freitag, 20. August 2004 14:18 schrieb Nathan Bryant:
> Stefan -
>
> Can you please attach 'cat /proc/interrupts' from a system that has all
> possible drivers for your hardware loaded. From before suspend.
           CPU0
  0:    3589865          XT-PIC  timer
  1:       1562          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      50381          XT-PIC  uhci_hcd, eth0
  8:          2          XT-PIC  rtc
  9:       2618          XT-PIC  acpi
 10:     233286          XT-PIC  ehci_hcd, uhci_hcd, uhci_hcd, Intel 
82801DB-ICH4, radeon@PCI:1:0:0
 11:      23148          XT-PIC  wlan0
 12:       1746          XT-PIC  i8042
 14:      13521          XT-PIC  ide0
 15:         24          XT-PIC  ide1
NMI:          0
LOC:    3589814
ERR:          0
MIS:          0

> Also - did suspend/resume for the ipw2100 ever work under any kernel
> version?
Yes, it works with acpi=noirq at least up to 2.6.7(not tested with later 
versions, but I'm sure it does)
It works with 2.6.8-rc2 and 2.6.8-rc4 and 2.6.8.1 with acpi IRQs and a 
modified dsdt which forces LNKE to IRQ 10. I attached a dmesg output of a 
successful resume.

Cheers,
Stefan

--Boundary-00=_7hiJBdvKGrVBm0Y
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.8.1 (root@laptop) (gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #5 Fri Aug 20 18:28:21 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
 BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                      ) @ 0x000f60c0
ACPI: RSDT (v001 ACER   Cardinal 0x20020302  LTP 0x00000000) @ 0x1ff74c20
ACPI: FADT (v001 ACER   Cardinal 0x20020302 PTL  0x0000001e) @ 0x1ff7af64
ACPI: BOOT (v001 ACER   Cardinal 0x20020302  LTP 0x00000001) @ 0x1ff7afd8
ACPI: DSDT (v001 ACER   Cardinal 0x20020302 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: root=/dev/hda8 rootfstype=ext3 resume=/dev/hda5
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1599.421 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515488k/523712k available (1522k kernel code, 7456k reserved, 691k data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3170.30 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: After vendor identify, caps:  a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
    ACPI-0291: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Edge set to Level Trigger.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1598.0393 MHz.
..... host bus clock speed is 99.0899 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd732, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040715
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:06.2[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
Simple Boot Flag at 0x37 set to 0x1
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p3 < p5 p6 p7 p8 p9 >
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max frequency: 1600000kHz
Resume Machine: resuming from /dev/hda5
Resuming from device unknown-block(3,5)
Resume Machine: This is normal swap space
ACPI: (supports S0 S3 S4 S5)
ACPI wakeup devices: 
MDM0 GLAN USB1 USB2 USB3 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
NET: Registered protocol family 1
Adding 1052216k swap on /dev/hda5.  Priority:-1 extents:1
EXT3 FS on hda8, internal journal
SCSI subsystem initialized
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Real Time Clock Driver v1.12
Acer Travelmate hotkey driver v0.5.13
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():0, irqs_disabled():1
 [<c011ad27>] __might_sleep+0xb7/0xe0
 [<c0134041>] sys_init_module+0x161/0x280
 [<c010615b>] syscall_call+0x7/0xb
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:1d.7: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e0946000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.0: Intel Corp. 82801DB (ICH4) USB UHCI #1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 10, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 5 (level, low) -> IRQ 5
uhci_hcd 0000:00:1d.1: Intel Corp. 82801DB (ICH4) USB UHCI #2
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 5, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 10 (level, low) -> IRQ 10
uhci_hcd 0000:00:1d.2: Intel Corp. 82801DB (ICH4) USB UHCI #3
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.3
Bluetooth: L2CAP socket layer initialized
lp: driver loaded but no devices found
b44.c:v0.94 (May 4, 2004)
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 5 (level, low) -> IRQ 5
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:27:ea:5a
ieee80211_crypt: registered algorithm 'NULL'
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.53
ipw2100: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 10 (level, low) -> IRQ 10
ipw2100: 0000:02:04.0: Detected at mem: 0xD0206000-0xD0206FFF -> e09ab000, irq: 10
wlan0: Using hotplug firmware load.
wlan0: Bound to 0000:02:04.0
NET: Registered protocol family 17
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THRM] (76 C)
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
b44: eth0: Link is down.
ieee80211_crypt: registered algorithm 'WEP'
wlan0: Associated with 'doesikl' at 11Mbps, channel 9
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49595 usecs
intel8x0: clocking to 48000
ehci_hcd 0000:00:1d.7: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:1d.7: USB bus 1 deregistered
PM: Preparing system for suspend
Stopping tasks: =========================================================|
wlan0: Going into suspend...
PM: Entering state.
Back to C!
Warning: CPU frequency out of sync: cpufreq and timingcore thinks of 600000, is 1600000 kHz.
Warning: CPU frequency out of sync: cpufreq and timing core thinks of 600000, is 1600000 kHz.
PM: Finishing up.
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000135
wlan0: Coming out of suspend...
wlan0: Using hotplug firmware load.
Restarting tasks...<6>wlan0: Associated with 'doesikl' at 11Mbps, channel 9
 done
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
Acer Travelmate hotkey driver v0.5.13
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():0, irqs_disabled():1
 [<c011ad27>] __might_sleep+0xb7/0xe0
 [<c0134041>] sys_init_module+0x161/0x280
 [<c010615b>] syscall_call+0x7/0xb
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.

--Boundary-00=_7hiJBdvKGrVBm0Y--
