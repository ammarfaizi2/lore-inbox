Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVDEIoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVDEIoC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDEIoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:44:02 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:60642 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261635AbVDEIkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:40:12 -0400
Message-ID: <42524EE2.5010703@ens-lyon.org>
Date: Tue, 05 Apr 2005 10:40:02 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org> <425240C5.1050706@ens-lyon.org> <20050405083001.GA28068@elte.hu>
In-Reply-To: <20050405083001.GA28068@elte.hu>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010903010001090101090302"
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903010001090101090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Ingo Molnar a écrit :
> * Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> 
> 
>>Andrew Morton a écrit :
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
>>
>>Hi Andrew,
>>
>>printk timing seems broken.
>>It always shows [ 0.000000] on my Compaq Evo N600c.
> 
> 
> could you send the full bootlog (starting at the 'gcc...' line)? I'm not 
> sure whether TSC calibration was done on your CPU. If cyc2ns_scale is 
> not set up then sched_clock() will return 0, and this could result in 
> that printk symptom.

Here you are.

Brice

--------------010903010001090101090302
Content-Type: text/plain;
 name="dmesg.full"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.full"

1.4.1#16: restart.
klogd 1.4.1#16, log source = /proc/kmsg started.
Cannot find map file.
No module symbols loaded - kernel modules not enabled. 
[4294667.296000] Linux version 2.6.12-rc2-mm1=LoulousMobile (bgoglin@puligny) (version gcc 3.3.5 (Debian 1:3.3.5-8)) #9 PREEMPT Tue Apr 5 09:28:57 CEST 2005
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000027fd0000 (usable)
[    0.000000]  BIOS-e820: 0000000027fd0000 - 0000000027ff0c00 (reserved)
[    0.000000]  BIOS-e820: 0000000027ff0c00 - 0000000027ffc000 (ACPI NVS)
[    0.000000]  BIOS-e820: 0000000027ffc000 - 0000000028000000 (reserved)
[    0.000000] 639MB LOWMEM available.
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] Allocating PCI resources starting at 28000000 (gap: 28000000:d8000000)
[    0.000000] Built 1 zonelists
[    0.000000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[    0.000000] Initializing CPU#0
[    0.000000] Kernel command line: root=/dev/hda2 ro 
[    0.000000] CPU 0 irqstacks, hard=c04a0000 soft=c049f000
[    0.000000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[    0.000000] Detected 730.935 MHz processor.
[    0.000000] Using pmtmr for high-res timesource
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 644672k/655168k available (2314k kernel code, 9976k reserved, 1191k data, 176k init, 0k highmem)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: L1 I cache: 16K, L1 D cache: 16K
[    0.000000] CPU: L2 cache: 512K
[    0.000000] Intel machine check architecture supported.
[    0.000000] Intel machine check reporting enabled on CPU#0.
[    0.000000] CPU: Intel(R) Pentium(R) III Mobile CPU      1000MHz stepping 01
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Checking 'hlt' instruction... OK.
[    0.000000]  tbxface-0118 [02] acpi_load_tables      : ACPI Tables successfully acquired
[    0.000000] Parsing all Control Methods:..........................................................................................................................................................................................................................................................................
[    0.000000] Table [DSDT](id F006) - 833 Objects with 89 Devices 266 Methods 26 Regions
[    0.000000] Parsing all Control Methods:.
[    0.000000] Table [SSDT](id F003) - 3 Objects with 0 Devices 1 Methods 0 Regions
[    0.000000] Parsing all Control Methods:..
[    0.000000] Table [SSDT](id F004) - 4 Objects with 0 Devices 2 Methods 0 Regions
[    0.000000] ACPI Namespace successfully loaded at root c04d56c0
[    0.000000] ACPI: setting ELCR to 0200 (from 0800)
[    0.000000] evxfevnt-0094 [03] acpi_enable           : Transition to ACPI mode successful
[    0.000000] softlockup thread 0 started up.
[    0.000000] NET: Registered protocol family 16
[    0.000000] PCI: PCI BIOS revision 2.10 entry at 0xf04dd, last bus=4
[    0.000000] PCI: Using configuration type 1
[    0.000000] mtrr: v2.0 (20020519)
[    0.000000] ACPI: Subsystem revision 20050309
[    0.000000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C13E (name not of form _Lxx or _Exx)
[    0.000000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C18F (name not of form _Lxx or _Exx)
[    0.000000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C1DC (name not of form _Lxx or _Exx)
[    0.000000] evgpeblk-0979 [06] ev_create_gpe_block   : GPE 00 to 0F [_GPE] 2 regs on int 0x9
[    0.000000] evgpeblk-0987 [06] ev_create_gpe_block   : Found 3 Wake, Enabled 1 Runtime GPEs in this block
[    0.000000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C13E (name not of form _Lxx or _Exx)
[    0.000000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C18F (name not of form _Lxx or _Exx)
[    0.000000] evgpeblk-0275 [08] ev_save_method_info   : Unknown GPE method type: C1DC (name not of form _Lxx or _Exx)
[    0.000000] evgpeblk-0979 [06] ev_create_gpe_block   : GPE 10 to 1F [_GPE] 2 regs on int 0x9
[    0.000000] evgpeblk-0987 [06] ev_create_gpe_block   : Found 2 Wake, Enabled 5 Runtime GPEs in this block
[    0.000000] Completing Region/Field/Buffer/Package initialization:..................................................................................................
[    0.000000] Initialized 25/26 Regions 0/0 Fields 26/26 Buffers 47/56 Packages (849 nodes)
[    0.000000] Executing all Device _STA and_INI methods:...........................................................................................
[    0.000000] 91 Devices found containing: 91 _STA, 8 _INI methods
[    0.000000] ACPI: Interpreter enabled
[    0.000000] ACPI: Using PIC for interrupt routing
[    0.000000] ACPI: PCI Root Bridge [C03E] (0000:00)
[    0.000000] PCI: Probing PCI hardware (bus 00)
[    0.000000] ACPI: Assume root bridge [\_SB_.C03E] segment is 0
[    0.000000] ACPI: Assume root bridge [\_SB_.C03E] bus is 0
[    0.000000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[    0.000000] ACPI: Can't get handler for 0000:02:08.0
[    0.000000] ACPI: Power Resource [C14E] (on)
[    0.000000] ACPI: Power Resource [C167] (on)
[    0.000000] ACPI: Power Resource [C16B] (on)
[    0.000000] ACPI: Power Resource [C174] (on)
[    0.000000] ACPI: PCI Interrupt Link [C0BA] (IRQs 5 10 *11)
[    0.000000] ACPI: PCI Interrupt Link [C0BB] (IRQs 5 10 *11)
[    0.000000] ACPI: PCI Interrupt Link [C0BC] (IRQs 5 10 *11)
[    0.000000] ACPI: PCI Interrupt Link [C0BD] (IRQs 5 10 *11)
[    0.000000] ACPI: PCI Interrupt Link [C0BE] (IRQs 5 10 *11)
[    0.000000] ACPI: PCI Interrupt Link [C0BF] (IRQs 5 10 *11)
[    0.000000] ACPI: PCI Interrupt Link [C0C0] (IRQs 5 10 *11)
[    0.000000] ACPI: PCI Interrupt Link [C0C1] (IRQs 5 10 11) *0, disabled.
[    0.000000] ACPI: Power Resource [C1F3] (off)
[    0.000000] ACPI: Power Resource [C1F4] (off)
[    0.000000] ACPI: Power Resource [C1F5] (off)
[    0.000000] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.000000] pnp: PnP ACPI init
[    0.000000] ACPI: No ACPI bus support for 00:00
[    0.000000] ACPI: No ACPI bus support for 00:01
[    0.000000] ACPI: No ACPI bus support for 00:02
[    0.000000] ACPI: No ACPI bus support for 00:03
[    0.000000] ACPI: No ACPI bus support for 00:04
[    0.000000] ACPI: No ACPI bus support for 00:05
[    0.000000] ACPI: No ACPI bus support for 00:06
[    0.000000] ACPI: No ACPI bus support for 00:07
[    0.000000] ACPI: No ACPI bus support for 00:08
[    0.000000] ACPI: No ACPI bus support for 00:09
[    0.000000] ACPI: No ACPI bus support for 00:0a
[    0.000000] ACPI: No ACPI bus support for 00:0b
[    0.000000] ACPI: No ACPI bus support for 00:0c
[    0.000000] ACPI: No ACPI bus support for 00:0d
[    0.000000] pnp: PnP ACPI: found 14 devices
[    0.000000] PnPBIOS: Disabled by ACPI PNP
[    0.000000] SCSI subsystem initialized
[    0.000000] PCI: Using ACPI for IRQ routing
[    0.000000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.000000] pnp: 00:0b: ioport range 0x140-0x14f has been reserved
[    0.000000] pnp: 00:0c: ioport range 0x4d0-0x4d1 has been reserved
[    0.000000] pnp: 00:0c: ioport range 0x1000-0x1087 could not be reserved
[    0.000000] pnp: 00:0c: ioport range 0x1100-0x113f has been reserved
[    0.000000] pnp: 00:0c: ioport range 0x1200-0x121f has been reserved
[    0.000000] Machine check exception polling timer started.
[    0.000000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[    0.000000] apm: overridden by ACPI.
[    0.000000] inotify device minor=63
[    0.000000] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
[    0.000000] devfs: boot_options: 0x0
[    0.000000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.000000] fakephp: Fake PCI Hot Plug Controller Driver
[    0.000000] cpqphp: Compaq Hot Plug PCI Controller Driver version: 0.9.8
[    0.000000] acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
[    0.000000] ACPI: PCI Interrupt Link [C0BB] enabled at IRQ 11
[    0.000000] PCI: setting IRQ 11 as level-triggered
[    0.000000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0BB] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] radeonfb: Retreived PLL infos from BIOS
[    0.000000] radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=166.00 Mhz, System=166.00 MHz
[    0.000000] radeonfb: PLL min 12000 max 35000
[    0.000000] Non-DDC laptop panel detected
[    0.000000] radeonfb: Monitor 1 type LCD found
[    0.000000] radeonfb: Monitor 2 type no found
[    0.000000] radeonfb: panel ID string: 1024x768                
[    0.000000] radeonfb: detected LVDS panel size from BIOS: 1024x768
[    0.000000] radeondb: BIOS provided dividers will be used
[    0.000000] radeonfb: Dynamic Clock Power Management enabled
[    0.000000] Console: switching to colour frame buffer device 128x48
[    0.000000] radeonfb (0000:01:00.0): ATI Radeon LY 
[    0.000000] ACPI: AC Adapter [C1A2] (off-line)
[    0.000000] ACPI: Battery Slot [C19F] (battery present)
[    0.000000] ACPI: Battery Slot [C1A0] (battery absent)
[    0.000000] ACPI: Power Button (FF) [PWRF]
[    0.000000] ACPI: Sleep Button (CM) [C1A3]
[    0.000000] ACPI: Lid Switch [C1A4]
[    0.000000] ACPI: Fan [C1F6] (off)
[    0.000000] ACPI: Fan [C1F7] (off)
[    0.000000] ACPI: Fan [C1F8] (off)
[    0.000000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[    0.000000] ACPI: Thermal Zone [TZ1] (57 C)
[    0.000000] Linux agpgart interface v0.101 (c) Dave Jones
[    0.000000] agpgart: Detected an Intel 830M Chipset.
[    0.000000] agpgart: AGP aperture is 256M @ 0x60000000
[    0.000000] [drm] Initialized drm 1.0.0 20040925
[    0.000000] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0BB] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc Radeon Mobility M6 LY
[    0.000000] PNP: PS/2 Controller [PNP0303:C171,PNP0f0e:C172] at 0x60,0x64 irq 1,12
[    0.000000] i8042: probe of i8042 failed with error 0
[    0.000000] ACPI: No ACPI bus support for i8042
[    0.000000] i8042.c: Detected active multiplexing controller, rev 1.1.
[    0.000000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    0.000000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    0.000000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    0.000000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    0.000000] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.000000] Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
[    0.000000] i8042: probe of serial8250 failed with error -19
[    0.000000] ACPI: No ACPI bus support for serial8250
[    0.000000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.000000] ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[    0.000000] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.000000] io scheduler noop registered
[    0.000000] io scheduler anticipatory registered
[    0.000000] io scheduler deadline registered
[    0.000000] io scheduler cfq registered
[    0.000000] e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
[    0.000000] e100: Copyright(c) 1999-2004 Intel Corporation
[    0.000000] ACPI: PCI Interrupt Link [C0BE] enabled at IRQ 11
[    0.000000] ACPI: PCI Interrupt 0000:02:08.0[A] -> Link [C0BE] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] e100: eth0: e100_probe: addr 0x40100000, irq 11, MAC addr 00:02:A5:B5:03:7C
[    0.000000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    0.000000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    0.000000] ICH3M: IDE controller at PCI slot 0000:00:1f.1
[    0.000000] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[    0.000000] ACPI: PCI Interrupt Link [C0BC] enabled at IRQ 11
[    0.000000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0BC] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] ICH3M: chipset revision 1
[    0.000000] ICH3M: not 100%% native mode: will probe irqs later
[    0.000000]     ide0: BM-DMA at 0x4060-0x4067, BIOS settings: hda:DMA, hdb:pio
[    0.000000]     ide1: BM-DMA at 0x4068-0x406f, BIOS settings: hdc:DMA, hdd:pio
[    0.000000] ACPI: No ACPI bus support for serio0
[    0.000000] ACPI: No ACPI bus support for serio1
[    0.000000] ACPI: No ACPI bus support for serio2
[    0.000000] ACPI: No ACPI bus support for serio3
[    0.000000] ACPI: No ACPI bus support for serio4
[    0.000000] hda: IC25N020ATDA04-0, ATA DISK drive
[    0.000000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    0.000000] ACPI: No ACPI bus support for 0.0
[    0.000000] hdc: Compaq DVD-ROM SD-C2402, ATAPI CD/DVD-ROM drive
[    0.000000] ide1 at 0x170-0x177,0x376 on irq 15
[    0.000000] ACPI: No ACPI bus support for 1.0
[    0.000000] hda: max request size: 128KiB
[    0.000000] hda: 39070080 sectors (20003 MB) w/1806KiB Cache, CHS=38760/16/63, UDMA(100)
[    0.000000] hda: cache flushes not supported
[    0.000000]  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
[    0.000000] hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, DMA
[    0.000000] Uniform CD-ROM driver Revision: 3.20
[    0.000000] mice: PS/2 mouse device common for all mice
[    0.000000] NET: Registered protocol family 2
[    0.000000] IP: routing cache hash table of 8192 buckets, 64Kbytes
[    0.000000] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] TCP: Hash tables configured (established 131072 bind 65536)
[    0.000000] NET: Registered protocol family 1
[    0.000000] NET: Registered protocol family 17
[    0.000000] ACPI wakeup devices: 
[    0.000000] C052 C17E C185 C0A4 C0AA C19F C1A0 C1A3 C1A4 
[    0.000000] ACPI: (supports S0 S1 S3 S4 S4bios S5)
[    0.000000] input: AT Translated Set 2 keyboard on isa0060/serio0
[    0.000000] kjournald starting.  Commit interval 5 seconds
[    0.000000] EXT3-fs: hda2: orphan cleanup on readonly fs
[    0.000000] EXT3-fs: hda2: 2 orphan inodes deleted
[    0.000000] EXT3-fs: recovery complete.
[    0.000000] EXT3-fs: mounted filesystem with ordered data mode.
[    0.000000] VFS: Mounted root (ext3 filesystem) readonly.
[    0.000000] Freeing unused kernel memory: 176k freed
[    0.000000] Synaptics Touchpad, model: 1
[    0.000000]  Firmware: 5.8
[    0.000000]  180 degree mounted touchpad
[    0.000000]  Sensor: 27
[    0.000000]  new absolute packet format
[    0.000000]  Touchpad has extended capability bits
[    0.000000]  -> multifinger detection
[    0.000000]  -> palm detection
[    0.000000]  -> pass-through port
[    0.000000] serio: Synaptics pass-through port at isa0060/serio4/input0
[    0.000000] input: SynPS/2 Synaptics TouchPad on isa0060/serio4
[    0.000000] atkbd: probe of serio5 failed with error -19
[    0.000000] Adding 665272k swap on /dev/hda4.  Priority:-1 extents:1
[    0.000000] EXT3 FS on hda2, internal journal
[    0.000000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[    0.000000] input: PS/2 Generic Mouse on synaptics-pt/serio0
[    0.000000] psmouse: probe of serio5 failed with error 0
[    0.000000] ACPI: No ACPI bus support for serio5
[    0.000000] kjournald starting.  Commit interval 5 seconds
[    0.000000] EXT3 FS on hda3, internal journal
[    0.000000] EXT3-fs: mounted filesystem with ordered data mode.
[    0.000000] acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
[    0.000000] ACPI: PCI Interrupt Link [C0C0] enabled at IRQ 11
[    0.000000] ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [C0C0] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] Yenta: CardBus bridge found at 0000:02:03.0 [0e11:004e]
[    0.000000] Yenta: Enabling burst memory read transactions
[    0.000000] Yenta: Using CSCINT to route CSC interrupts to PCI
[    0.000000] Yenta: Routing CardBus interrupts to PCI
[    0.000000] Yenta TI: socket 0000:02:03.0, mfunc 0x01001002, devctl 0x64
[    0.000000] Yenta: ISA IRQ mask 0x04f8, PCI irq 11
[    0.000000] Socket status: 30000006
[    0.000000] pcmcia: I/O behind socket: 0x2000 - 0x2fff
[    0.000000] cs: IO port probe 0x2000-0x2fff: clean.
[    0.000000] pcmcia: Memory behind socket: 0x40000000 - 0x401fffff
[    0.000000] acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
[    0.000000] ACPI: PCI Interrupt 0000:02:03.1[A] -> Link [C0C0] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] Yenta: CardBus bridge found at 0000:02:03.1 [0e11:004e]
[    0.000000] Yenta: Using CSCINT to route CSC interrupts to PCI
[    0.000000] Yenta: Routing CardBus interrupts to PCI
[    0.000000] Yenta TI: socket 0000:02:03.1, mfunc 0x01001002, devctl 0x64
[    0.000000] Yenta: ISA IRQ mask 0x04f8, PCI irq 11
[    0.000000] Socket status: 30000010
[    0.000000] pcmcia: I/O behind socket: 0x2000 - 0x2fff
[    0.000000] cs: IO port probe 0x2000-0x2fff: clean.
[    0.000000] pcmcia: Memory behind socket: 0x40000000 - 0x401fffff
[    0.000000] acpi_bus-0212 [01] acpi_bus_set_power    : Device is not power manageable
[    0.000000] ACPI: PCI Interrupt Link [C0BA] enabled at IRQ 11
[    0.000000] ACPI: PCI Interrupt 0000:02:09.0[A] -> Link [C0BA] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] usbcore: registered new driver usbfs
[    0.000000] usbcore: registered new driver hub
[    0.000000] USB Universal Host Controller Interface driver v2.2
[    0.000000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0BA] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] uhci_hcd 0000:00:1d.0: Intel Corporation 82801CA/CAM USB (Hub #1)
[    0.000000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    0.000000] uhci_hcd 0000:00:1d.0: irq 11, io base 0x00004000
[    0.000000] ACPI: No ACPI bus support for usb1
[    0.000000] usbfs: probe of 1-0:1.0 failed with error -19
[    0.000000] hub 1-0:1.0: USB hub found
[    0.000000] hub 1-0:1.0: 2 ports detected
[    0.000000] hub: probe of 1-0:1.0 failed with error 0
[    0.000000] usb: probe of 1-0:1.0 failed with error -19
[    0.000000] ACPI: No ACPI bus support for 1-0:1.0
[    0.000000] ACPI: PCI Interrupt Link [C0BD] enabled at IRQ 11
[    0.000000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0BD] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] uhci_hcd 0000:00:1d.1: Intel Corporation 82801CA/CAM USB (Hub #2)
[    0.000000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[    0.000000] uhci_hcd 0000:00:1d.1: irq 11, io base 0x00004020
[    0.000000] ACPI: No ACPI bus support for usb2
[    0.000000] usbfs: probe of 2-0:1.0 failed with error -19
[    0.000000] hub 2-0:1.0: USB hub found
[    0.000000] hub 2-0:1.0: 2 ports detected
[    0.000000] hub: probe of 2-0:1.0 failed with error 0
[    0.000000] usb: probe of 2-0:1.0 failed with error -19
[    0.000000] ACPI: No ACPI bus support for 2-0:1.0
[    0.000000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0BC] -> GSI 11 (level, low) -> IRQ 11
[    0.000000] uhci_hcd 0000:00:1d.2: Intel Corporation 82801CA/CAM USB (Hub #3)
[    0.000000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[    0.000000] uhci_hcd 0000:00:1d.2: irq 11, io base 0x00004040
[    0.000000] ACPI: No ACPI bus support for usb3
[    0.000000] usbfs: probe of 3-0:1.0 failed with error -19
[    0.000000] hub 3-0:1.0: USB hub found
[    0.000000] hub 3-0:1.0: 2 ports detected
[    0.000000] hub: probe of 3-0:1.0 failed with error 0
[    0.000000] usb: probe of 3-0:1.0 failed with error -19
[    0.000000] ACPI: No ACPI bus support for 3-0:1.0
[    0.000000] hw_random hardware driver 1.0.0 loaded
[    0.000000] NET: Registered protocol family 23
[    0.000000] parport: PnPBIOS parport detected.
[    0.000000] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
[    0.000000] input: PC Speaker
[    0.000000] Real Time Clock Driver v1.12
[    0.000000] cs: memory probe 0x40000000-0x401fffff: excluding 0x40000000-0x4001ffff 0x40040000-0x4009ffff 0x400c0000-0x4011ffff 0x40140000-0x4019ffff 0x401c0000-0x401fffff
[    0.000000] ACPI: No ACPI bus support for 1.0
[    0.000000] cs: IO port probe 0x100-0x4ff: excluding 0x100-0x107 0x200-0x207
[    0.000000] cs: IO port probe 0x100-0x4ff: excluding 0x100-0x107 0x200-0x207
[    0.000000] cs: IO port probe 0x800-0x8ff: clean.
[    0.000000] cs: IO port probe 0x800-0x8ff: clean.
[    0.000000] cs: IO port probe 0xc00-0xcff: clean.
[    0.000000] cs: IO port probe 0xc00-0xcff: clean.
[    0.000000] cs: IO port probe 0xa00-0xaff: clean.
[    0.000000] cs: IO port probe 0xa00-0xaff: clean.
[    0.000000] eth1: New link status: Connected (0001)
[    0.000000] agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
[    0.000000] agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
[    0.000000] agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode

--------------010903010001090101090302--
