Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbULEWGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbULEWGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 17:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbULEWGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 17:06:46 -0500
Received: from got80-74-137-2.ch-meta.net ([80.74.137.2]:61346 "EHLO
	gothicus.metanet.ch") by vger.kernel.org with ESMTP id S261329AbULEWGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 17:06:14 -0500
From: Thomas Bettler <bettlert@student.ethz.ch>
To: linux-kernel@vger.kernel.org
Subject: cpufreq: shouldn't scaling_min_freq be lower?
Date: Sun, 5 Dec 2004 23:06:06 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PZ4sBXDMTBqV2nE"
Message-Id: <200412052306.07460.bettlert@student.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PZ4sBXDMTBqV2nE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm running a two year old Thinkpad R32. P4-M 1.8 GHz.

In the beginning there was a Windoze on it. The cpufreq varied from 1800 to 
120MHz

When I didn't run X, I also observed sometimes (don't know why) the freq 
dropping down to 200MHz on Linux 2.6 kernel some months ago.

Anyway ACPI works like that:
/sys/devices/system/cpu/cpu0/cpu_min_freq: 1200000 (1.2G)
/sys/devices/system/cpu/cpu0/cpu_max_freq: 1800000 (1.8G)

How can I control the cpufreq below cpu_min_freq
I would like to get this feature handy, for longer battery runtime. Is there 
an possibility to manage this?

Thanks for all you help.

Infos in the Attachment. Need more? Just ask.

Thomas Bettler

--Boundary-00=_PZ4sBXDMTBqV2nE
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.9-gentoo-r9+win4lin (root@debox) (gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #2 Sat Dec 4 10:55:32 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7e000 (ACPI data)
 BIOS-e820: 000000001ff7e000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f7120
ACPI: XSDT (v001 IBM    TP-1M    0x00002110  LTP 0x00000000) @ 0x1ff7745f
ACPI: FADT (v001 IBM    TP-1M    0x00002110 IBM  0x00000001) @ 0x1ff774ab
ACPI: SSDT (v001 IBM    TP-1M    0x00002110 MSFT 0x0100000d) @ 0x1ff7755f
ACPI: ECDT (v001 IBM    TP-1M    0x00002110 IBM  0x00000001) @ 0x1ff7df54
ACPI: TCPA (v001 IBM    TP-1M    0x00002110 PTL  0x00000001) @ 0x1ff7dfa6
ACPI: BOOT (v001 IBM    TP-1M    0x00002110  LTP 0x00000001) @ 0x1ff7dfd8
ACPI: DSDT (v001 IBM    TP-1M    0x00002110 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Built 1 zonelists
Kernel command line: root=/dev/hda2 video=vesafb:ywrap,mtrr vga=0x317 splash=silent,theme:emergence resume=/dev/hda3 ide0=dma ide1=dma ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe
fbsplash: silent
fbsplash: theme emergence
ide_setup: ide0=dma
ide_setup: ide1=dma
ide_setup: ide2=noprobe
ide_setup: ide3=noprobe
ide_setup: ide4=noprobe
ide_setup: ide5=noprobe
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1800.005 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 512792k/523712k available (3259k kernel code, 10332k reserved, 1049k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3563.52 BogoMIPS (lpj=1781760)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebf9ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs... it is
Freeing initrd memory: 588k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd91e, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7150
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x9f4b, dseg 0x400
PnPBIOS: 19 nodes reported by PnP BIOS; 19 recorded by driver
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.3[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:09.0[A] -> GSI 11 (level, low) -> IRQ 11
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x1000-0x105f could not be reserved
pnp: 00:0b: ioport range 0x1060-0x107f has been reserved
pnp: 00:0b: ioport range 0x1180-0x11bf has been reserved
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with large block numbers, no debug enabled
Initializing Cryptographic API
inotify init: minor=63
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i845 Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe0000000
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon Mobility M6 LY
vesafb: framebuffer at 0xe8000000, mapped to 0xe0900000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:530f
vesafb: pmi: set display start = c00c53a3, set palette = c00c53ef
vesafb: pmi: ports = 3010 3016 3054 3038 303c 305c 3000 3004 30b0 30b2 30b4 
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fbsplash: console 0 using theme 'emergence'
fbsplash: switched splash state to 'on' on console 0
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (60 C)
ACPI: Thermal Zone [THM1] (50 C)
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
fbsplash: switching to verbose mode
input: PS/2 Generic Mouse on isa0060/serio4
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.0.27-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xd0200000, irq 11, MAC addr 00:00:E2:97:DB:71
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3M: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N040ATMR04-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (4091 buckets, 32728 max) - 176 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ACPI wakeup devices: 
 LID SLPB PCI0 UART OBLN USB0 USB1 USB2 AC97 
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 168k freed
Adding 498952k swap on /dev/hda3.  Priority:-1 extents:1
ibm_acpi: IBM ThinkPad ACPI Extras v0.7
ibm_acpi: http://ibm-acpi.sf.net/
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc (0x7bc), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ub: sizeof ub_scsi_cmd 60 ub_dev 924
usbcore: registered new driver ub
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: Intel Corp. 82801CA/CAM USB (Hub #2)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: Intel Corp. 82801CA/CAM USB (Hub #3)
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 2-1: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:1d.1-1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1d.1-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64

--Boundary-00=_PZ4sBXDMTBqV2nE
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 04)
0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 Mobile PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)
0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
0000:02:07.0 Network controller: Intersil Corporation Prism 2.5 Wavelan chipset (rev 01)
0000:02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 42)
0000:02:09.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)

--Boundary-00=_PZ4sBXDMTBqV2nE
Content-Type: text/plain;
  charset="us-ascii";
  name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpuinfo"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz
stepping	: 7
cpu MHz		: 1800.005
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 3563.52


--Boundary-00=_PZ4sBXDMTBqV2nE
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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
IkxhHsjBy4Ug9C9/bmy924gAAA==

--Boundary-00=_PZ4sBXDMTBqV2nE
Content-Type: text/plain;
  charset="us-ascii";
  name="x86info"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="x86info"

x86info v1.12b.  Dave Jones 2001-2003
Feedback to <davej@redhat.com>.

Found 1 CPU
--------------------------------------------------------------------------
eax in: 0x00000000, eax = 00000002 ebx = 756e6547 ecx = 6c65746e edx = 49656e69
eax in: 0x00000001, eax = 00000f27 ebx = 0001080e ecx = 00000400 edx = bfebf9ff
eax in: 0x00000002, eax = 665b5101 ebx = 00000000 ecx = 00000000 edx = 007b7040

eax in: 0x80000000, eax = 80000004 ebx = 00000000 ecx = 00000000 edx = 00000000
eax in: 0x80000001, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 00000000
eax in: 0x80000002, eax = 4d202020 ebx = 6c69626f ecx = 6e492065 edx = 286c6574
eax in: 0x80000003, eax = 50202952 ebx = 69746e65 ecx = 52286d75 edx = 20342029
eax in: 0x80000004, eax = 204d202d ebx = 20555043 ecx = 30382e31 edx = 007a4847

Family: 15 Model: 2 Stepping: 7 Type: 0 Brand: 14
CPU Model: Pentium 4 (Northwood) [C1] Original OEM
Processor name string: Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz

Feature flags:
	Onboard FPU
	Virtual Mode Extensions
	Debugging Extensions
	Page Size Extensions
	Time Stamp Counter
	Model-Specific Registers
	Physical Address Extensions
	Machine Check Architecture
	CMPXCHG8 instruction
	SYSENTER/SYSEXIT
	Memory Type Range Registers
	Page Global Enable
	Machine Check Architecture
	CMOV instruction
	Page Attribute Table
	36-bit PSEs
	CLFLUSH instruction
	Debug Trace Store
	ACPI via MSR
	MMX support
	FXSAVE and FXRESTORE instructions
	SSE support
	SSE2 support
	CPU self snoop
	Hyper-Threading
	Automatic clock Control
	Pending Break Enable

Extended feature flags:
 cntx-id
Pentium 4 specific MSRs:
IA32_PLATFORM_ID=000e000000000000
System bus in order queue depth=12
MSR_EBC_FREQUENCY_ID=000000000c300612
IA32_BIOS_SIGN_ID=0000002600000000
Processor serial number is enabled
Fast strings are enabled
x87 FPU Fopcode compatability mode is disabled
Thermal monitor is enabled
Split lock is enabled

Instruction TLB: 4K, 2MB or 4MB pages, fully associative, 128 entries.
Data TLB: 4KB or 4MB pages, fully associative, 64 entries.
L1 Data cache:
	Size: 8KB	Sectored, 4-way associative.
	line size=64 bytes.
No level 2 cache or no level 3 cache if valid 2nd level cache.
Instruction trace cache:
	Size: 12K uOps	8-way associative.
L2 unified cache:
	Size: 512KB	Sectored, 8-way associative.
	line size=64 bytes.

Number of reporting banks : 4

Number of extended MC registers : 12


Bank: 0 (0x400)
MC0CTL:    00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC0STATUS: 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC0ADDR:   00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000

Bank: 1 (0x404)
MC1CTL:    00000000 00000000 00000000 00000000
           00000000 00000011 10000000 00000000
MC1STATUS: 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC1ADDR:   00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000

Bank: 2 (0x408)
MC2CTL:    00000000 00000000 00000000 00000000
           00000000 00000000 00000000 10000000
MC2STATUS: 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC2ADDR:   Couldn't read MSR 0x40a

Bank: 3 (0x40c)
MC3CTL:    00000000 00000000 00000000 00000000
           00000000 00000000 00000000 01111110
MC3STATUS: 00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000
MC3ADDR:   00000000 00000000 00000000 00000000
           00000000 00000000 00000000 00000000

Number of logical processors supported within the physical package: 0

Microcode version: 0x0000000000000026

Connector type: Socket478 (PGA478 Socket)

Datasheet: http://developer.intel.com/design/pentium4/datashts/24988703.pdf
	http://developer.intel.com/design/pentium4/datashts/29864304.pdf
Errata: http://developer.intel.com/design/pentium4/specupdt/24919928.pdf

MTRR registers:
MTRRcap (0xfe): 0x0000000000000508
MTRRphysBase0 (0x200): 0x0000000000000006
MTRRphysMask0 (0x201): 0x0000000fe0000800
MTRRphysBase1 (0x202): 0x000000001ff80000
MTRRphysMask1 (0x203): 0x0000000ffff80800
MTRRphysBase2 (0x204): 0x00000000e0000001
MTRRphysMask2 (0x205): 0x0000000ffc000800
MTRRphysBase3 (0x206): 0x00000000e8000001
MTRRphysMask3 (0x207): 0x0000000fffe00800
MTRRphysBase4 (0x208): 0x0000000000000000
MTRRphysMask4 (0x209): 0x0000000000000000
MTRRphysBase5 (0x20a): 0x0000000000000000
MTRRphysMask5 (0x20b): 0x0000000000000000
MTRRphysBase6 (0x20c): 0x0000000000000000
MTRRphysMask6 (0x20d): 0x0000000000000000
MTRRphysBase7 (0x20e): 0x0000000000000000
MTRRphysMask7 (0x20f): 0x0000000000000000
MTRRfix64K_00000 (0x250): 0x0606060606060606
MTRRfix16K_80000 (0x258): 0x0606060606060606
MTRRfix16K_A0000 (0x259): 0x0000000000000000
MTRRfix4K_C8000 (0x269): 0x0505050505050505
MTRRfix4K_D0000 0x26a: 0x0000000000000000
MTRRfix4K_D8000 0x26b: 0x0606060600000000
MTRRfix4K_E0000 0x26c: 0x0505050505050505
MTRRfix4K_E8000 0x26d: 0x0505050505050505
MTRRfix4K_F0000 0x26e: 0x0505050505050505
MTRRfix4K_F8000 0x26f: 0x0505050505050505
MTRRdefType (0x2ff): 0x0000000000000c00


1.2Ghz processor (estimate).


--Boundary-00=_PZ4sBXDMTBqV2nE--
