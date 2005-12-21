Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVLUUeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVLUUeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVLUUeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:34:09 -0500
Received: from math.ut.ee ([193.40.36.2]:51161 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932497AbVLUUeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:34:07 -0500
Date: Wed, 21 Dec 2005 22:33:37 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
In-Reply-To: <20051214172445.GF7124@flint.arm.linux.org.uk>
Message-ID: <Pine.SOC.4.61.0512212221310.651@math.ut.ee>
References: <1134573803.25663.35.camel@localhost.localdomain>
 <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, possibly, but could you apply this patch and provide the resulting
> messages please?  It'll probably cause some character loss when it
> decides to dump some debugging.

Here is the full dmesg with it, from ICH2. First messages are from 
serial port initialisation and the last ones are from running minicom at 
9600 as thje console for a cisco.

Linux version 2.6.15-rc6-g3e1ec1f4 (mroos@rhn) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #113 PREEMPT Wed Dec 21 20:14:15 EET 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
  BIOS-e820: 000000001ffc0000 - 000000001fff8000 (ACPI data)
  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131008
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 126912 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000ff980
ACPI: RSDT (v001 D815EA D815EEA2 0x20021106 MSFT 0x00001011) @ 0x1fff0000
ACPI: FADT (v001 D815EA EA81510A 0x20021106 MSFT 0x00001011) @ 0x1fff1000
ACPI: DSDT (v001 D815E2 EA81520A 0x00000023 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 30000000 (gap: 20000000:dfb80000)
Built 1 zonelists
Kernel command line: root=/dev/hda3 ro nmi_watchdog=1 lapic
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0414000 soft=c0413000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 897.209 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515136k/524032k available (2050k kernel code, 8424k reserved, 917k data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1795.99 BogoMIPS (lpj=3591986)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e00)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfda95, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0500-053f claimed by ICH4 GPIO
Boot video device is 0000:02:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 *10 11 12)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:01.0
   IO window: d000-dfff
   MEM window: ff900000-ff9fffff
   PREFETCH window: eea00000-f6afffff
PCI: Bridge: 0000:00:1e.0
   IO window: c000-cfff
   MEM window: ff800000-ff8fffff
   PREFETCH window: ee900000-ee9fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PBTN]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100
lp0: using parport0 (interrupt-driven).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 11 (level, low) -> IRQ 11
e100: eth0: e100_probe: addr 0xff8ff000, irq 11, MAC addr 00:03:47:A4:64:D5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST380011A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CDU5211, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2 hda3 hda4
hdc: ATAPI 52X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input1
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 5, 131072 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
ACPI wakeup devices: 
PBTN PCI1 UAR1  USB USB2  AC9  SMB 
ACPI: (supports S0 S1 S4 S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
kjournald starting.  Commit interval 5 seconds
logips2pp: Detected unknown logitech mouse model 99
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input2
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.2[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.2 to 64
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.2: irq 11, io base 0x0000ef40
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.4[C] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1f.4: irq 10, io base 0x0000ef80
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [LNKB] -> GSI 9 (level, low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 55398 usecs
intel8x0: clocking to 41147
Adding 1004052k swap on /dev/hda2.  Priority:-1 extents:1 across:1004052k
EXT3 FS on hda3, internal journal
NTFS driver 2.1.25 [Flags: R/W MODULE].
SCSI subsystem initialized
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
smsc47m1: Found SMSC LPC47M10x/LPC47M13x
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
lp0: ECP mode
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
1: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
2: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
3: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
4: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
5: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
6: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
7: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
8: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
9: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
10: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
11: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
12: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
13: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
14: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
15: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
16: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
17: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
18: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
19: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
20: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
21: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
22: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
23: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
24: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
25: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
26: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
27: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
28: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
29: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
30: jif=fffef262 type=00 num=00 iir=01 lsr=00 => iir=01 lsr=00
31: jif=fffef262 type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=fffef262 type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=fffef262 type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=fffef262 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=fffef262 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=fffef262 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=fffef262 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=fffef262 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=fffef262 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=fffef262 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=fffef262 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=fffef262 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=fffef262 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=fffef262 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=fffef262 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=fffef262 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=fffef262 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=fffef262 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=fffef262 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=fffef262 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=fffef262 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=fffef262 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=fffef262 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=fffef262 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=fffef262 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=fffef262 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=fffef262 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=fffef262 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=fffef262 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=fffef262 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=fffef262 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=fffef262 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=fffef262 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=fffef262 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
1: jif=fffef262 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
2: jif=fffef262 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
3: jif=fffef262 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
4: jif=fffef262 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
5: jif=fffef262 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
6: jif=fffef262 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
7: jif=fffef262 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
8: jif=fffef262 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
9: jif=fffef262 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
10: jif=fffef262 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
11: jif=fffef262 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
12: jif=fffef262 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
13: jif=fffef262 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
14: jif=fffef262 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
15: jif=fffef262 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
16: jif=fffef262 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
17: jif=fffef262 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
18: jif=fffef262 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
19: jif=fffef262 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
20: jif=fffef262 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
21: jif=fffef262 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
22: jif=fffef262 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
23: jif=fffef262 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
24: jif=fffef262 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
25: jif=fffef262 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
26: jif=fffef262 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
27: jif=fffef262 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
28: jif=fffef2c8 type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60
29: jif=fffef2c8 type=00 num=01 iir=c1 lsr=00 => iir=c1 lsr=00
30: jif=fffef307 type=00 num=00 iir=c1 lsr=00 => iir=c1 lsr=00
31: jif=fffef307 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=fffef307 type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=fffef307 type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=fffef307 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=fffef307 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=fffef307 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=fffef307 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=fffef307 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=fffef307 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=fffef307 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=fffef307 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=fffef307 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=fffef307 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=fffef307 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=fffef307 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=fffef307 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=fffef307 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=fffef307 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=fffef307 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=fffef307 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=fffef307 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=fffef307 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=fffef307 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=fffef307 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=fffef307 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=fffef307 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=fffef307 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=fffef307 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=fffef307 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=fffef307 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=fffef307 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=fffef307 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=fffef307 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=fffef307 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
1: jif=fffef307 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=fffef307 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
3: jif=fffef307 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=fffef307 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
5: jif=fffef307 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=fffef307 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
7: jif=fffef307 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=fffef307 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
9: jif=fffef307 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=fffef307 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
11: jif=fffef307 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=fffef307 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
13: jif=fffef307 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=fffef307 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
15: jif=fffef307 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=fffef307 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
17: jif=fffef307 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=fffef307 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
19: jif=fffef307 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=fffef307 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
21: jif=fffef307 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=fffef307 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
23: jif=fffef307 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=fffef307 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
25: jif=fffef307 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=fffef307 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
27: jif=fffef307 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=fffef307 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
29: jif=fffef307 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=fffef308 type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=fffef308 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=fffef308 type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=fffef308 type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=fffef308 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=fffef308 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=fffef308 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=fffef308 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=fffef308 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=fffef308 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=fffef308 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=fffef308 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=fffef308 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=fffef308 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=fffef308 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=fffef308 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=fffef308 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=fffef308 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=fffef308 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=fffef308 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=fffef308 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=fffef308 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=fffef308 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=fffef308 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=fffef308 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=fffef308 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=fffef308 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=fffef308 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=fffef308 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=fffef308 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=fffef308 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=fffef308 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=fffef308 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=fffef308 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
1: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
2: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
3: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
4: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
5: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
6: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
7: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
8: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
9: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
10: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
11: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
12: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
13: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
14: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
15: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
16: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
17: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
18: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
19: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
20: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
21: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
22: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
23: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
24: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
25: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
26: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
27: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
28: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
29: jif=00000000 type=00 num=00 iir=00 lsr=00 => iir=00 lsr=00
30: jif=fffef309 type=00 num=00 iir=01 lsr=00 => iir=01 lsr=00
31: jif=fffef309 type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=fffef309 type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=fffef309 type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=fffef309 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=fffef309 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=fffef309 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=fffef309 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=fffef309 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=fffef309 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=fffef309 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=fffef309 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=fffef309 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=fffef309 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=fffef309 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=fffef309 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=fffef309 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=fffef309 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=fffef309 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=fffef309 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=fffef309 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=fffef309 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=fffef309 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=fffef309 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=fffef309 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=fffef309 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=fffef309 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=fffef309 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=fffef309 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=fffef309 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=fffef309 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=fffef309 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=fffef309 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=fffef309 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=fffef309 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
1: jif=fffef309 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
2: jif=fffef309 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
3: jif=fffef309 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
4: jif=fffef309 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
5: jif=fffef309 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
6: jif=fffef309 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
7: jif=fffef309 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
8: jif=fffef309 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
9: jif=fffef309 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
10: jif=fffef309 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
11: jif=fffef309 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
12: jif=fffef309 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
13: jif=fffef309 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
14: jif=fffef309 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
15: jif=fffef309 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
16: jif=fffef309 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
17: jif=fffef309 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
18: jif=fffef309 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
19: jif=fffef309 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
20: jif=fffef309 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
21: jif=fffef309 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
22: jif=fffef309 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
23: jif=fffef309 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
24: jif=fffef309 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
25: jif=fffef309 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
26: jif=fffef309 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
27: jif=fffef309 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
28: jif=fffef309 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
29: jif=fffef309 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
30: jif=fffef30a type=00 num=00 iir=01 lsr=00 => iir=01 lsr=00
31: jif=fffef30a type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=fffef30a type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=fffef30a type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=fffef30a type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=fffef30a type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=fffef30a type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=fffef30a type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=fffef30a type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=fffef30a type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=fffef30a type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=fffef30a type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=fffef30a type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=fffef30a type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=fffef30a type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=fffef30a type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=fffef30a type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=fffef30a type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=fffef30a type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=fffef30a type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=fffef30a type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=fffef30a type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=fffef30a type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=fffef30a type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=fffef30a type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=fffef30a type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=fffef30a type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=fffef30a type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=fffef30a type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=fffef30a type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=fffef30a type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=fffef30a type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=fffef30a type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=fffef30a type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=fffef30a type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
1: jif=fffef30a type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
2: jif=fffef30a type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
3: jif=fffef30a type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
4: jif=fffef30a type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
5: jif=fffef30a type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
6: jif=fffef30a type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
7: jif=fffef30a type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
8: jif=fffef30a type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
9: jif=fffef30a type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
10: jif=fffef30a type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
11: jif=fffef30a type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
12: jif=fffef30a type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
13: jif=fffef30a type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
14: jif=fffef30a type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
15: jif=fffef30a type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
16: jif=fffef30a type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
17: jif=fffef30a type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
18: jif=fffef30a type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
19: jif=fffef30a type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
20: jif=fffef30a type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
21: jif=fffef30a type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
22: jif=fffef30a type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
23: jif=fffef30a type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
24: jif=fffef30a type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
25: jif=fffef30a type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
26: jif=fffef30a type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
27: jif=fffef30a type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
28: jif=fffef371 type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60
29: jif=fffef371 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=fffef3b0 type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=fffef3b0 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=fffef3b0 type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=fffef3b0 type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=fffef3b0 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=fffef3b0 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=fffef3b0 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=fffef3b0 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=fffef3b0 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=fffef3b0 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=fffef3b0 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=fffef3b0 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=fffef3b0 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=fffef3b0 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=fffef3b0 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=fffef3b0 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=fffef3b0 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=fffef3b0 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=fffef3b0 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=fffef3b0 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=fffef3b0 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=fffef3b0 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=fffef3b0 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=fffef3b0 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=fffef3b0 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=fffef3b0 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=fffef3b0 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=fffef3b0 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=fffef3b0 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=fffef3b0 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=fffef3b0 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=fffef3b0 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=fffef3b0 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=fffef3b0 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=fffef3b0 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
1: jif=fffef3b0 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=fffef3b0 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
3: jif=fffef3b0 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=fffef3b0 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
5: jif=fffef3b0 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=fffef3b0 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
7: jif=fffef3b0 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=fffef3b0 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
9: jif=fffef3b0 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=fffef3b0 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
11: jif=fffef3b0 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=fffef3b0 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
13: jif=fffef3b0 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=fffef3b0 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
15: jif=fffef3b0 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=fffef3b0 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
17: jif=fffef3b0 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=fffef3b0 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
19: jif=fffef3b0 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=fffef3b0 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
21: jif=fffef3b0 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=fffef3b0 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
23: jif=fffef3b0 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=fffef3b0 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
25: jif=fffef3b0 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=fffef3b0 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
27: jif=fffef3b0 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=fffef3b0 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
29: jif=fffef3b0 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=fffef3b0 type=00 num=00 iir=01 lsr=60 => iir=01 lsr=60
31: jif=fffef3b0 type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=fffef3b0 type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=fffef3b0 type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=fffef3b0 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=fffef3b0 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=fffef3b0 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=fffef3b0 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=fffef3b0 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=fffef3b0 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=fffef3b0 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=fffef3b0 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=fffef3b0 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=fffef3b0 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=fffef3b0 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=fffef3b0 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=fffef3b0 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=fffef3b0 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=fffef3b1 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=fffef3b1 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=fffef3b1 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=fffef3b1 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=fffef3b1 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=fffef3b1 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=fffef3b1 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=fffef3b1 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=fffef3b1 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=fffef3b1 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=fffef3b1 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=fffef3b1 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=fffef3b1 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=fffef3b1 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=fffef3b1 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=fffef3b1 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq3
serial8250: port c0453034(1)
0: jif=fffef3b0 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
1: jif=fffef3b0 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
2: jif=fffef3b0 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
3: jif=fffef3b0 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
4: jif=fffef3b0 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
5: jif=fffef3b0 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
6: jif=fffef3b0 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
7: jif=fffef3b0 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
8: jif=fffef3b0 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
9: jif=fffef3b0 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
10: jif=fffef3b0 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
11: jif=fffef3b0 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
12: jif=fffef3b0 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
13: jif=fffef3b0 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
14: jif=fffef3b1 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
15: jif=fffef3b1 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
16: jif=fffef3b1 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
17: jif=fffef3b1 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
18: jif=fffef3b1 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
19: jif=fffef3b1 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
20: jif=fffef3b1 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
21: jif=fffef3b1 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
22: jif=fffef3b1 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
23: jif=fffef3b1 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
24: jif=fffef3b1 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
25: jif=fffef3b1 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
26: jif=fffef3b1 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
27: jif=fffef3b1 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
28: jif=fffef3b1 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
29: jif=fffef3b1 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
30: jif=fffef3b1 type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=fffef3b1 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=fffef3b1 type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=fffef3b1 type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=fffef3b1 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=fffef3b1 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=fffef3b1 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=fffef3b1 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=fffef3b1 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=fffef3b1 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=fffef3b1 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=fffef3b1 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=fffef3b1 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=fffef3b1 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=fffef3b1 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=fffef3b1 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=fffef3b1 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=fffef3b1 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=fffef3b1 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=fffef3b1 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=fffef3b1 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=fffef3b1 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=fffef3b1 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=fffef3b1 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=fffef3b1 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=fffef3b1 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=fffef3b1 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=fffef3b1 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=fffef3b1 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=fffef3b1 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=fffef3b1 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=fffef3b1 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=fffef3b1 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=fffef3b1 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
lp0: ECP mode
lp0: ECP mode
lp0: ECP mode
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
eth0: no IPv6 routers present
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized r128 2.5.0 20030725 on minor 0: 
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:02:00.0 into 2x mode
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=fffef308 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
1: jif=fffef308 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=fffef308 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
3: jif=fffef308 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=fffef308 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
5: jif=fffef308 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=fffef308 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
7: jif=fffef308 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=fffef308 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
9: jif=fffef308 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=fffef308 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
11: jif=fffef308 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=fffef308 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
13: jif=fffef308 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=fffef308 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
15: jif=fffef308 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=fffef308 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
17: jif=fffef308 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=fffef308 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
19: jif=fffef308 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=fffef308 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
21: jif=fffef308 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=fffef308 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
23: jif=fffef308 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=fffef308 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
25: jif=fffef308 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=fffef308 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
27: jif=fffef308 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=fffef308 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
29: jif=fffef308 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=ffff388a type=00 num=00 iir=01 lsr=60 => iir=01 lsr=60
31: jif=ffff388a type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=ffff388a type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=ffff388a type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=ffff388a type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=ffff388a type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=ffff388a type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=ffff388a type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=ffff388a type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=ffff388a type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=ffff388a type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=ffff388a type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=ffff388a type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=ffff388a type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=ffff388a type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=ffff388a type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=ffff388a type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=ffff388a type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=ffff388a type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=ffff388a type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=ffff388a type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=ffff388a type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=ffff388a type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=ffff388a type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=ffff388a type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=ffff388a type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=ffff388a type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=ffff388a type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=ffff388a type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=ffff388a type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=ffff388a type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=ffff388a type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=ffff388a type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=ffff388a type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=ffff7fc9 type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60
1: jif=ffff7fc9 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=ffff834e type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
3: jif=ffff834e type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=ffff8350 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
5: jif=ffff8350 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=ffff8352 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
7: jif=ffff8352 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=ffff8354 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
9: jif=ffff8354 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=ffff8356 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
11: jif=ffff8356 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=ffff8358 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
13: jif=ffff8358 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=ffff835a type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
15: jif=ffff835a type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=ffff835c type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
17: jif=ffff835c type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=ffff835e type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
19: jif=ffff835e type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=ffff8360 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
21: jif=ffff8360 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=ffff8362 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
23: jif=ffff8362 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=ffff8364 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
25: jif=ffff8364 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=ffff8366 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
27: jif=ffff8366 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=ffff8369 type=00 num=00 iir=c4 lsr=61 => iir=c1 lsr=60
29: jif=ffff8369 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=ffff836a type=00 num=00 iir=c1 lsr=61 => iir=c1 lsr=60
31: jif=ffff836a type=00 num=01 iir=c1 lsr=61 => iir=c1 lsr=60
32: jif=ffff836a type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=ffff836a type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=ffff836a type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=ffff836a type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=ffff836a type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=ffff836a type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=ffff836a type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=ffff836a type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=ffff836a type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=ffff836a type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=ffff836a type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=ffff836a type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=ffff836a type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=ffff836a type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=ffff836a type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=ffff836a type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=ffff836a type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=ffff836a type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=ffff836a type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=ffff836a type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=ffff836a type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=ffff836a type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=ffff836a type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=ffff836a type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=ffff836a type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=ffff836a type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=ffff836a type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=ffff836a type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=ffff836a type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=ffff836a type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=ffff836a type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=ffff836a type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=ffff836a type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
1: jif=ffff836a type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=ffff836a type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
3: jif=ffff836a type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=ffff836a type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
5: jif=ffff836a type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=ffff836a type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
7: jif=ffff836a type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=ffff836a type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
9: jif=ffff836a type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=ffff836a type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
11: jif=ffff836a type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=ffff836a type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
13: jif=ffff836a type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=ffff836a type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
15: jif=ffff836a type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=ffff836a type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
17: jif=ffff836a type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=ffff836a type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
19: jif=ffff836a type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=ffff836a type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
21: jif=ffff836a type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=ffff836a type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
23: jif=ffff836a type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=ffff836a type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
25: jif=ffff836a type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=ffff836a type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
27: jif=ffff836a type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=ffff836a type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
29: jif=ffff836a type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=ffff836b type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=ffff836b type=00 num=01 iir=c1 lsr=61 => iir=c1 lsr=60
32: jif=ffff836b type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=ffff836b type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=ffff836b type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=ffff836b type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=ffff836b type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=ffff836b type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=ffff836b type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=ffff836b type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=ffff836b type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=ffff836b type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=ffff836b type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=ffff836b type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=ffff836b type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=ffff836b type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=ffff836b type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=ffff836b type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=ffff836b type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=ffff836b type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=ffff836b type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=ffff836b type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=ffff836b type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=ffff836b type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=ffff836b type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=ffff836b type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=ffff836b type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=ffff836b type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=ffff836b type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=ffff836b type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=ffff836b type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=ffff836b type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=ffff836b type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=ffff836b type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=ffff836b type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
1: jif=ffff836b type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
2: jif=ffff836b type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
3: jif=ffff836b type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
4: jif=ffff836b type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
5: jif=ffff836b type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
6: jif=ffff836b type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
7: jif=ffff836b type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
8: jif=ffff836b type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
9: jif=ffff836b type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
10: jif=ffff836b type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
11: jif=ffff836b type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
12: jif=ffff836b type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
13: jif=ffff836b type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
14: jif=ffff836b type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
15: jif=ffff836b type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
16: jif=ffff836b type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
17: jif=ffff836b type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
18: jif=ffff836b type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
19: jif=ffff836b type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=ffff836b type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
21: jif=ffff836b type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=ffff836b type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
23: jif=ffff836b type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=ffff836b type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
25: jif=ffff836b type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=ffff836b type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
27: jif=ffff836b type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=ffff836b type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
29: jif=ffff836b type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=ffff84f3 type=00 num=00 iir=01 lsr=60 => iir=01 lsr=60
31: jif=ffff84f3 type=00 num=01 iir=01 lsr=60 => iir=01 lsr=60
32: jif=ffff84f3 type=00 num=02 iir=01 lsr=60 => iir=01 lsr=60
33: jif=ffff84f3 type=00 num=03 iir=01 lsr=60 => iir=01 lsr=60
34: jif=ffff84f3 type=00 num=04 iir=01 lsr=60 => iir=01 lsr=60
35: jif=ffff84f3 type=00 num=05 iir=01 lsr=60 => iir=01 lsr=60
36: jif=ffff84f3 type=00 num=06 iir=01 lsr=60 => iir=01 lsr=60
37: jif=ffff84f3 type=00 num=07 iir=01 lsr=60 => iir=01 lsr=60
38: jif=ffff84f3 type=00 num=08 iir=01 lsr=60 => iir=01 lsr=60
39: jif=ffff84f3 type=00 num=09 iir=01 lsr=60 => iir=01 lsr=60
40: jif=ffff84f3 type=00 num=0a iir=01 lsr=60 => iir=01 lsr=60
41: jif=ffff84f3 type=00 num=0b iir=01 lsr=60 => iir=01 lsr=60
42: jif=ffff84f3 type=00 num=0c iir=01 lsr=60 => iir=01 lsr=60
43: jif=ffff84f3 type=00 num=0d iir=01 lsr=60 => iir=01 lsr=60
44: jif=ffff84f3 type=00 num=0e iir=01 lsr=60 => iir=01 lsr=60
45: jif=ffff84f3 type=00 num=0f iir=01 lsr=60 => iir=01 lsr=60
46: jif=ffff84f3 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
47: jif=ffff84f3 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
48: jif=ffff84f3 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
49: jif=ffff84f3 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
50: jif=ffff84f3 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
51: jif=ffff84f3 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
52: jif=ffff84f3 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
53: jif=ffff84f3 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
54: jif=ffff84f3 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
55: jif=ffff84f3 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
56: jif=ffff84f3 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
57: jif=ffff84f3 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
58: jif=ffff84f3 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
59: jif=ffff84f3 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
60: jif=ffff84f3 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
61: jif=ffff84f3 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
62: jif=ffff84f3 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
63: jif=ffff84f3 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
serial8250: too much work for irq4
serial8250: port c0452c80(0)
0: jif=ffff84f3 type=00 num=10 iir=01 lsr=60 => iir=01 lsr=60
1: jif=ffff84f3 type=00 num=11 iir=01 lsr=60 => iir=01 lsr=60
2: jif=ffff84f3 type=00 num=12 iir=01 lsr=60 => iir=01 lsr=60
3: jif=ffff84f3 type=00 num=13 iir=01 lsr=60 => iir=01 lsr=60
4: jif=ffff84f3 type=00 num=14 iir=01 lsr=60 => iir=01 lsr=60
5: jif=ffff84f3 type=00 num=15 iir=01 lsr=60 => iir=01 lsr=60
6: jif=ffff84f3 type=00 num=16 iir=01 lsr=60 => iir=01 lsr=60
7: jif=ffff84f3 type=00 num=17 iir=01 lsr=60 => iir=01 lsr=60
8: jif=ffff84f3 type=00 num=18 iir=01 lsr=60 => iir=01 lsr=60
9: jif=ffff84f3 type=00 num=19 iir=01 lsr=60 => iir=01 lsr=60
10: jif=ffff84f3 type=00 num=1a iir=01 lsr=60 => iir=01 lsr=60
11: jif=ffff84f3 type=00 num=1b iir=01 lsr=60 => iir=01 lsr=60
12: jif=ffff84f3 type=00 num=1c iir=01 lsr=60 => iir=01 lsr=60
13: jif=ffff84f3 type=00 num=1d iir=01 lsr=60 => iir=01 lsr=60
14: jif=ffff84f3 type=00 num=1e iir=01 lsr=60 => iir=01 lsr=60
15: jif=ffff84f3 type=00 num=1f iir=01 lsr=60 => iir=01 lsr=60
16: jif=ffff84f3 type=00 num=20 iir=01 lsr=60 => iir=01 lsr=60
17: jif=ffff84f3 type=00 num=21 iir=01 lsr=60 => iir=01 lsr=60
18: jif=ffff86eb type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60
19: jif=ffff86eb type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
20: jif=ffff86eb type=00 num=00 iir=cc lsr=e1 => iir=c1 lsr=60
21: jif=ffff86eb type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
22: jif=ffff87e6 type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60
23: jif=ffff87e6 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
24: jif=ffff87e6 type=00 num=00 iir=c2 lsr=60 => iir=c1 lsr=60
25: jif=ffff87e6 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
26: jif=ffff87e6 type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
27: jif=ffff87e6 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
28: jif=ffff87e6 type=00 num=00 iir=c0 lsr=60 => iir=c1 lsr=60
29: jif=ffff87e6 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
30: jif=ffff88e1 type=00 num=00 iir=c1 lsr=60 => iir=c1 lsr=60
31: jif=ffff88e1 type=00 num=01 iir=c1 lsr=60 => iir=c1 lsr=60
32: jif=ffff88e1 type=00 num=02 iir=c1 lsr=60 => iir=c1 lsr=60
33: jif=ffff88e1 type=00 num=03 iir=c1 lsr=60 => iir=c1 lsr=60
34: jif=ffff88e1 type=00 num=04 iir=c1 lsr=60 => iir=c1 lsr=60
35: jif=ffff88e1 type=00 num=05 iir=c1 lsr=60 => iir=c1 lsr=60
36: jif=ffff88e1 type=00 num=06 iir=c1 lsr=60 => iir=c1 lsr=60
37: jif=ffff88e1 type=00 num=07 iir=c1 lsr=60 => iir=c1 lsr=60
38: jif=ffff88e1 type=00 num=08 iir=c1 lsr=60 => iir=c1 lsr=60
39: jif=ffff88e1 type=00 num=09 iir=c1 lsr=60 => iir=c1 lsr=60
40: jif=ffff88e1 type=00 num=0a iir=c1 lsr=60 => iir=c1 lsr=60
41: jif=ffff88e1 type=00 num=0b iir=c1 lsr=60 => iir=c1 lsr=60
42: jif=ffff88e1 type=00 num=0c iir=c1 lsr=60 => iir=c1 lsr=60
43: jif=ffff88e1 type=00 num=0d iir=c1 lsr=60 => iir=c1 lsr=60
44: jif=ffff88e1 type=00 num=0e iir=c1 lsr=60 => iir=c1 lsr=60
45: jif=ffff88e1 type=00 num=0f iir=c1 lsr=60 => iir=c1 lsr=60
46: jif=ffff88e1 type=00 num=10 iir=c1 lsr=60 => iir=c1 lsr=60
47: jif=ffff88e1 type=00 num=11 iir=c1 lsr=60 => iir=c1 lsr=60
48: jif=ffff88e1 type=00 num=12 iir=c1 lsr=60 => iir=c1 lsr=60
49: jif=ffff88e1 type=00 num=13 iir=c1 lsr=60 => iir=c1 lsr=60
50: jif=ffff88e1 type=00 num=14 iir=c1 lsr=60 => iir=c1 lsr=60
51: jif=ffff88e1 type=00 num=15 iir=c1 lsr=60 => iir=c1 lsr=60
52: jif=ffff88e1 type=00 num=16 iir=c1 lsr=60 => iir=c1 lsr=60
53: jif=ffff88e1 type=00 num=17 iir=c1 lsr=60 => iir=c1 lsr=60
54: jif=ffff88e1 type=00 num=18 iir=c1 lsr=60 => iir=c1 lsr=60
55: jif=ffff88e1 type=00 num=19 iir=c1 lsr=60 => iir=c1 lsr=60
56: jif=ffff88e1 type=00 num=1a iir=c1 lsr=60 => iir=c1 lsr=60
57: jif=ffff88e1 type=00 num=1b iir=c1 lsr=60 => iir=c1 lsr=60
58: jif=ffff88e1 type=00 num=1c iir=c1 lsr=60 => iir=c1 lsr=60
59: jif=ffff88e1 type=00 num=1d iir=c1 lsr=60 => iir=c1 lsr=60
60: jif=ffff88e1 type=00 num=1e iir=c1 lsr=60 => iir=c1 lsr=60
61: jif=ffff88e1 type=00 num=1f iir=c1 lsr=60 => iir=c1 lsr=60
62: jif=ffff88e1 type=00 num=20 iir=c1 lsr=60 => iir=c1 lsr=60
63: jif=ffff88e1 type=00 num=21 iir=c1 lsr=60 => iir=c1 lsr=60

-- 
Meelis Roos (mroos@linux.ee)
