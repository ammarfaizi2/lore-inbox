Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVCUXyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVCUXyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVCUXyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:54:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:23008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261936AbVCUXq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:46:57 -0500
Date: Mon, 21 Mar 2005 15:46:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Florian Leuthner" <florian_leuthner@hotmail.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: toshiba ACPI /proc interface nonresponsive (>2.6.9)
Message-Id: <20050321154652.48431aa3.akpm@osdl.org>
In-Reply-To: <BAY15-F123671672BFDAC384CDD02F8520@phx.gbl>
References: <BAY15-F123671672BFDAC384CDD02F8520@phx.gbl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Florian Leuthner" <florian_leuthner@hotmail.com> wrote:
>
> Hi,
> 
> I can cat e.g. /proc/acpi/toshiba/lcd, but I cannot echo into it, there is 
> no error message or log entry whatsoever (not a permissions issue, other ppl 
> are experiencing the same btw). It's a toshiba satellite 5200-701 (european 
> model, AFAIK) with a more-or-less bleeding edge gentoo install.
> 
> With the 2.6.9-mm1 kernel it's working, but not with any later version 
> (tried 2.6.10-mm1, 2.6.11-mm1).

Florian, could you please test 2.6.12-rc1-mm1?

btw, what do you mena by "I cannot echo into it"?  You mean that you _can_
echo into it, but that now has no effect?

> Please cc me, thanks.
> 
> ------------------------
> ver_linux says:
> ------------------------
> 
> Version: 1.4 (14 Feb 2002)
> If version fields appear unusual you may have an old version. Compare to the
> current minimal requirements in linux/Documentation/Changes. Please double
> check lines that say "error getting version, try manually" for validity.
> Libc 4 is not detected with this script.  Please report problems to
> <david@blue-labs.org>
> 
> Linux pc1900 2.6.9-mm1 #1 Sat Oct 23 12:47:29 CEST 2004 i686 Mobile Intel(R) 
> Pentium(R) 4 - M CPU 1.90GHz GenuineIntel GNU/Linux
> Kernel command line: root=/dev/hda3 video=vesa:ywrap,mtrr vga=791
> 
> Gnu C compiler                    gcc (GCC) 3.3.5  (Gentoo Linux 3.3.5-r1, 
> ssp-3.3.2-3, pie-8.7.7.1)
> Copyright (C) 2003 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> Kernel compiled with              gcc 3.3.3
> GNU make                          error getting version, try manually
> binutils                          2.15.92.0.2
> mount/util-linux                  2.12i
> modutils                          error getting version, try manually
> e2fsprogs                         1.35
> help me please, is this check for isdnlegitimate?
> GNU Library                       20041021
> Dynamic linker (ldd)              2.3.4
> procps                            3.2.3
> net-tools                         1.60
> kbd (forked with console-tools)   error getting version, try manually
> console-tools (fork from kbd)     error getting version, try manually
> loaded modules                    [nvidia]
> [ntfs]
> [ide_scsi]
> [sd_mod]
> [fat]
> [usb_storage]
> [snd_intel8x0]
> [snd_ac97_codec]
> [e100]
> [mii]
> [ide_cd]
> [sr_mod]
> [cdrom]
> 
> TCP option: ECN                   enabled
> 
> 
> 
> 
> ------------------------
> here's dmesg:
> ------------------------
> 
> 
> 
> Linux version 2.6.9-mm1 (root@pc1900) (gcc version 3.3.3 20040412 (Gentoo 
> Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #1 Sat Oct 23 12:47:29 CEST 2004
> BIOS-provided physical RAM map:
> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
> BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
> BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
> BIOS-e820: 0000000000100000 - 000000001ffcc000 (usable)
> BIOS-e820: 000000001ffcc000 - 000000001ffd0000 (reserved)
> BIOS-e820: 000000001ffd0000 - 000000001ffe0000 (ACPI data)
> BIOS-e820: 000000001ffe0000 - 0000000020000000 (reserved)
> BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
> BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> 511MB LOWMEM available.
> On node 0 totalpages: 131020
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 126924 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.3 present.
> ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f0180
> ACPI: RSDT (v001 TOSHIB 5200     0x20020926 TASM 0x04010000) @ 0x1ffd0000
> ACPI: FADT (v002 TOSHIB 5200     0x20020926 TASM 0x04010000) @ 0x1ffd0058
> ACPI: DBGP (v001 TOSHIB 5200     0x20020926 TASM 0x04010000) @ 0x1ffd00dc
> ACPI: BOOT (v001 TOSHIB 5200     0x20020926 TASM 0x04010000) @ 0x1ffd0030
> ACPI: DSDT (v001 TOSHIB 5200     0x20020926 MSFT 0x0100000a) @ 0x00000000
> Built 1 zonelists
> Initializing CPU#0
> Kernel command line: root=/dev/hda3 video=vesa:ywrap,mtrr vga=791
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Detected 1894.301 MHz processor.
> Using tsc for high-res timesource
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 514536k/524080k available (2670k kernel code, 9000k reserved, 1053k 
> data, 156k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay loop... 3743.74 BogoMIPS (lpj=1871872)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000
> CPU: After vendor identify, caps:  bfebf9ff 00000000 00000000 00000000
> CPU: Trace cache: 12K uops, L1 D cache: 8K
> CPU: L2 cache: 512K
> CPU: After all inits, caps:        bfebf9ff 00000000 00000000 00000080
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
> CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.90GHz stepping 07
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> ACPI: IRQ9 SCI: Level Trigger.
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfcebc, last bus=4
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040816
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 11 12) *0, disabled.
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 11 12) *0, disabled.
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 10 *11 12)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *6 7 10 11 12)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 6 7 10 11 12)
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs *5)
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 6 7 10 11 12) *0, disabled.
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
> ACPI: Power Resource [PFN0] (off)
> ACPI: Power Resource [PFN1] (off)
> Toshiba System Managment Mode driver v1.11 26/9/2001
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> ** PCI interrupts are no longer routed automatically.  If this
> ** causes a device to stop working, it is probably because the
> ** driver failed to call pci_enable_device().  As a temporary
> ** workaround, the "pci=routeirq" argument restores the old
> ** behavior.  If this argument makes the device work again,
> ** please email the output of "lspci" to bjorn.helgaas@hp.com
> ** so I can fix the driver.
> Simple Boot Flag at 0x7c set to 0x1
> Machine check exception polling timer started.
> devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x1
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Initializing Cryptographic API
> vesafb: framebuffer at 0xd8000000, mapped to 0xe0880000, using 3072k, total 
> 32768k
> vesafb: mode is 1024x768x16, linelength=2048, pages=18
> vesafb: protected mode interface info at c000:f460
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> Console: switching to colour frame buffer device 128x48
> fb0: VESA VGA frame buffer device
> ACPI: AC Adapter [ADP1] (on-line)
> ACPI: Battery Slot [BAT1] (battery present)
> ACPI: Battery Slot [BAT2] (battery absent)
> ACPI: Power Button (FF) [PWRF]
> ACPI: Lid Switch [LID]
> ACPI: Fan [FAN0] (off)
> ACPI: Fan [FAN1] (off)
> ACPI: Processor [CPU0] (supports C1 C2 C3)
> ACPI: Thermal Zone [THRM] (55 C)
> toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
> toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected an Intel i845 Chipset.
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: AGP aperture is 256M @ 0xe0000000
> ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x64, irq 1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH3M: IDE controller at PCI slot 0000:00:1f.1
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> PCI: setting IRQ 11 as level-triggered
> ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
> ICH3M: chipset revision 2
> ICH3M: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xcfa0-0xcfa7, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xcfa8-0xcfaf, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: TOSHIBA MK4018GAS, ATA DISK drive
> hdb: DW-224E, ATAPI CD/DVD-ROM drive
> elevator: using anticipatory as default io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: IC25N040ATCS05-0, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
> hda: cache flushes supported
> /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> hdc: max request size: 128KiB
> hdc: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
> hdc: cache flushes not supported
> /dev/ide/host0/bus1/target0/lun0: p1
> PCI: Enabling device 0000:02:06.2 (0000 -> 0002)
> ACPI: PCI interrupt 0000:02:06.2[C] -> GSI 11 (level, low) -> IRQ 11
> ehci_hcd 0000:02:06.2: NEC Corporation USB 2.0
> ehci_hcd 0000:02:06.2: irq 11, pci mem 0x20000400
> ehci_hcd 0000:02:06.2: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:02:06.2: USB 2.0 enabled, EHCI 0.95, driver 2004-May-10
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 5 ports detected
> ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 6
> PCI: setting IRQ 6 as level-triggered
> ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 6 (level, low) -> IRQ 6
> ohci_hcd 0000:02:06.0: NEC Corporation USB
> ohci_hcd 0000:02:06.0: irq 6, pci mem 0xfceff000
> ohci_hcd 0000:02:06.0: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 4
> PCI: setting IRQ 4 as level-triggered
> ACPI: PCI interrupt 0000:02:06.1[B] -> GSI 4 (level, low) -> IRQ 4
> ohci_hcd 0000:02:06.1: NEC Corporation USB (#2)
> ohci_hcd 0000:02:06.1: irq 4, pci mem 0xfcefe000
> ohci_hcd 0000:02:06.1: new USB bus registered, assigned bus number 3
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> USB Universal Host Controller Interface driver v2.2
> PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
> ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 10 (level, low) -> IRQ 10
> uhci_hcd 0000:00:1d.0: Intel Corp. 82801CA/CAM USB (Hub #1)
> PCI: Setting latency timer of device 0000:00:1d.0 to 64
> uhci_hcd 0000:00:1d.0: irq 10, io base 0x1000
> uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 1-2: new high speed USB device using address 3
> usb 1-3: new high speed USB device using address 4
> hub 1-3:1.0: USB hub found
> hub 1-3:1.0: 4 ports detected
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> Please email the following PERFCTR INIT lines to mikpe@csd.uu.se
> To remove this message, rebuild the driver with CONFIG_PERFCTR_INIT_TESTS=n
> PERFCTR INIT: vendor 0, family 15, model 2, stepping 7, clock 1894301 kHz
> PERFCTR INIT: NITER == 64
> PERFCTR INIT: loop overhead is 512 cycles
> PERFCTR INIT: rdtsc cost is 78.6 cycles (5544 total)
> PERFCTR INIT: rdpmc cost is 146.7 cycles (9904 total)
> PERFCTR INIT: rdmsr (counter) cost is 255.5 cycles (16864 total)
> PERFCTR INIT: rdmsr (escr) cost is 166.6 cycles (11180 total)
> PERFCTR INIT: wrmsr (counter) cost is 795.8 cycles (51448 total)
> PERFCTR INIT: wrmsr (escr) cost is 874.7 cycles (56496 total)
> PERFCTR INIT: read cr4 cost is 5.3 cycles (852 total)
> PERFCTR INIT: write cr4 cost is 253.8 cycles (16756 total)
> PERFCTR INIT: rdpmc (fast) cost is 63.3 cycles (4564 total)
> PERFCTR INIT: rdmsr (cccr) cost is 167.5 cycles (11232 total)
> PERFCTR INIT: wrmsr (cccr) cost is 834.8 cycles (53940 total)
> PERFCTR INIT: sync_core cost is 265.0 cycles (17472 total)
> perfctr: driver 2.7.5, cpu type Intel P4 at 1894301 kHz
> Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 
> 2004 UTC).
> ALSA device list:
>   No soundcards found.
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
> ACPI: (supports S0 S3 S4 S5)
> ACPI wakeup devices:
> LAN CBC0 USB2 USB3 USB4 AMDM  LID
> usb 2-1: new full speed USB device using address 2
> hub 2-1:1.0: USB hub found
> hub 2-1:1.0: 3 ports detected
> usb 2-3: new low speed USB device using address 3
> input: USB HID v1.00 Mouse [Synaptics Inc. Synaptics WheelPad] on 
> usb-0000:02:06.0-3
> usb 1-3.1: new low speed USB device using address 6
> input: USB HID v1.00 Keyboard [Compaq Compaq Internet Keyboard] on 
> usb-0000:02:06.2-3.1
> input: USB HID v1.00 Device [Compaq Compaq Internet Keyboard] on 
> usb-0000:02:06.2-3.1
> usb 1-3.2: new low speed USB device using address 7
> input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with 
> IntelliEye(TM)] on usb-0000:02:06.2-3.2
> usb 2-1.1: new full speed USB device using address 4
> VFS: Mounted root (reiser4 filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 156k freed
> Adding 506036k swap on /dev/hda2.  Priority:-1 extents:1
> hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 1658kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> nvidia: module license 'NVIDIA' taints kernel.
> ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 5
> PCI: setting IRQ 5 as level-triggered
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 5 (level, low) -> IRQ 5
> NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6111  Tue Jul 27 
> 07:55:38 PDT 2004
> e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
> e100: Copyright(c) 1999-2004 Intel Corporation
> ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 4 (level, low) -> IRQ 4
> e100: eth0: e100_probe: addr 0xfcefd000, irq 4, MAC addr 00:00:39:DC:2B:DB
> PCI: Enabling device 0000:00:1f.5 (0000 -> 0001)
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
> ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:1f.5 to 64
> intel8x0_measure_ac97_clock: measured 49414 usecs
> intel8x0: clocking to 48000
> Initializing USB Mass Storage driver...
> scsi0 : SCSI emulation for USB Mass Storage devices
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usb-storage: device found at 3
> usb-storage: waiting for device to settle before scanning
> NTFS driver 2.1.21 [Flags: R/O MODULE].
> NTFS volume version 3.1.
>   Vendor: TOSHIBA   Model: MK4025GAS         Rev: 0811
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
> sda: assuming drive cache: write through
> /dev/scsi/host0/bus0/target0/lun0: p1 p2
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> usb-storage: device scan complete
> e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> ide: failed opcode was: unknown
> hda: CHECK for good STATUS
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> NVRM: client supports wrong rm api version!!
> NVRM:    aborting to avoid catastrophe!
> NVRM: client supports wrong rm api version!!
> NVRM:    aborting to avoid catastrophe!
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 5 (level, low) -> IRQ 5
> NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 
> 13:12:51 PST 2004
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
> drivers/usb/input/hid-input.c: event field not found
> drivers/usb/input/hid-input.c: event field not found
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
