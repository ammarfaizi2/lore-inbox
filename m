Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWFZHoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWFZHoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 03:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWFZHoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 03:44:44 -0400
Received: from mail.charite.de ([160.45.207.131]:45460 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751042AbWFZHom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 03:44:42 -0400
Date: Mon, 26 Jun 2006 09:44:32 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Thomas Gleixner <tglx@linutronix.de>, logcheck@knarzkiste.dyndns.org
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, root@knarzkiste.dyndns.org
Subject: Re: Problem with 2.6.17-mm2
Message-ID: <20060626074432.GR4052@charite.de>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	logcheck@knarzkiste.dyndns.org, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	root@knarzkiste.dyndns.org
References: <20060626074226.7B251E0035AE@knarzkiste.dyndns.org> <20060626063706.38642E006A89@knarzkiste.dyndns.org> <20060625103523.GY27143@charite.de> <20060625034913.315755ae.akpm@osdl.org> <20060625105512.GZ27143@charite.de> <1151250115.25491.384.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060626074226.7B251E0035AE@knarzkiste.dyndns.org> <20060626063706.38642E006A89@knarzkiste.dyndns.org> <1151250115.25491.384.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de>:

> Can you please provide the boot log from 2.6.17 and one with the
> following patch on top of 2.6.17-mm2 applied:
> http://www.tglx.de/private/tglx/linux-2.6.17-mm2-revert-genirq.diff

See the two logs below.
 
> It reverts the genirq changes. When the unexpected IRQ trap messages
> persist, we know that it's unrelated to genirq. Otherwise, sigh

They seem to be gone...

2.6.17.1:
=========
> Jun 26 08:36:35 knarzkiste kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
> Jun 26 08:36:35 knarzkiste kernel: Linux version 2.6.17.1 (root@knarzkiste) (gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #1 PREEMPT Tue Jun 20 23:25:20 CEST 2006
> Jun 26 08:36:35 knarzkiste kernel: BIOS-provided physical RAM map:
> Jun 26 08:36:35 knarzkiste kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> Jun 26 08:36:35 knarzkiste kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> Jun 26 08:36:35 knarzkiste kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
> Jun 26 08:36:35 knarzkiste kernel:  BIOS-e820: 0000000000100000 - 000000001bf40000 (usable)
> Jun 26 08:36:35 knarzkiste kernel:  BIOS-e820: 000000001bf40000 - 000000001bf50000 (ACPI data)
> Jun 26 08:36:35 knarzkiste kernel:  BIOS-e820: 000000001bf50000 - 000000001c000000 (ACPI NVS)
> Jun 26 08:36:35 knarzkiste kernel:  BIOS-e820: 000000001c000000 - 0000000020000000 (reserved)
> Jun 26 08:36:35 knarzkiste kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> Jun 26 08:36:35 knarzkiste kernel: 447MB LOWMEM available.
> Jun 26 08:36:35 knarzkiste kernel: On node 0 totalpages: 114496
> Jun 26 08:36:35 knarzkiste kernel:   DMA zone: 4096 pages, LIFO batch:0
> Jun 26 08:36:35 knarzkiste kernel:   Normal zone: 110400 pages, LIFO batch:31
> Jun 26 08:36:35 knarzkiste kernel: DMI 2.3 present.
> Jun 26 08:36:35 knarzkiste kernel: ACPI: RSDP (v000 MSI                                   ) @ 0x000f8350
> Jun 26 08:36:35 knarzkiste kernel: ACPI: RSDT (v001 MSI    1013     0x08242005 MSFT 0x00000097) @ 0x1bf40000
> Jun 26 08:36:35 knarzkiste kernel: ACPI: FADT (v002 MSI    1013     0x08242005 MSFT 0x00000097) @ 0x1bf40200
> Jun 26 08:36:35 knarzkiste kernel: ACPI: MADT (v001 MSI    OEMAPIC  0x08242005 MSFT 0x00000097) @ 0x1bf40300
> Jun 26 08:36:35 knarzkiste kernel: ACPI: WDRT (v001 MSI    MSI_OEM  0x08242005 MSFT 0x00000097) @ 0x1bf40360
> Jun 26 08:36:35 knarzkiste kernel: ACPI: MCFG (v001 MSI    OEMMCFG  0x08242005 MSFT 0x00000097) @ 0x1bf403b0
> Jun 26 08:36:35 knarzkiste kernel: ACPI: SSDT (v001 OEM_ID OEMTBLID 0x00000001 INTL 0x02002026) @ 0x1bf43620
> Jun 26 08:36:35 knarzkiste kernel: ACPI: OEMB (v001 MSI    MSI_OEM  0x08242005 MSFT 0x00000097) @ 0x1bf50040
> Jun 26 08:36:35 knarzkiste kernel: ACPI: DSDT (v001    MSI     1013 0x08242005 INTL 0x02002026) @ 0x00000000
> Jun 26 08:36:35 knarzkiste kernel: ATI board detected. Disabling timer routing over 8254.
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PM-Timer IO Port: 0x4008
> Jun 26 08:36:35 knarzkiste kernel: ACPI: Local APIC address 0xfee00000
> Jun 26 08:36:35 knarzkiste kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Jun 26 08:36:35 knarzkiste kernel: Processor #0 15:4 APIC version 16
> Jun 26 08:36:35 knarzkiste kernel: ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> Jun 26 08:36:35 knarzkiste kernel: IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI 0-23
> Jun 26 08:36:35 knarzkiste kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: IRQ0 used by override.
> Jun 26 08:36:35 knarzkiste kernel: ACPI: IRQ2 used by override.
> Jun 26 08:36:35 knarzkiste kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Jun 26 08:36:35 knarzkiste kernel: Using ACPI (MADT) for SMP configuration information
> Jun 26 08:36:35 knarzkiste kernel: Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
> Jun 26 08:36:35 knarzkiste kernel: Built 1 zonelists
> Jun 26 08:36:35 knarzkiste kernel: Kernel command line: BOOT_IMAGE=LinuxOLD ro root=301 video=vesafb:ywrap,mtrr:4 pci=assign-busses lapic panic=15
> Jun 26 08:36:35 knarzkiste kernel: mapped APIC to ffffd000 (fee00000)
> Jun 26 08:36:35 knarzkiste kernel: mapped IOAPIC to ffffc000 (fec00000)
> Jun 26 08:36:35 knarzkiste kernel: Enabling fast FPU save and restore... done.
> Jun 26 08:36:35 knarzkiste kernel: Enabling unmasked SIMD FPU exception support... done.
> Jun 26 08:36:35 knarzkiste kernel: Initializing CPU#0
> Jun 26 08:36:35 knarzkiste kernel: CPU 0 irqstacks, hard=c03a2000 soft=c03a1000
> Jun 26 08:36:35 knarzkiste kernel: PID hash table entries: 2048 (order: 11, 8192 bytes)
> Jun 26 08:36:35 knarzkiste kernel: Detected 1592.238 MHz processor.
> Jun 26 08:36:35 knarzkiste kernel: Using pmtmr for high-res timesource
> Jun 26 08:36:35 knarzkiste kernel: Console: colour dummy device 80x25
> Jun 26 08:36:35 knarzkiste kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Jun 26 08:36:35 knarzkiste kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Jun 26 08:36:35 knarzkiste kernel: Memory: 450624k/457984k available (1974k kernel code, 6872k reserved, 520k data, 172k init, 0k highmem)
> Jun 26 08:36:35 knarzkiste kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Jun 26 08:36:35 knarzkiste kernel: Calibrating delay using timer specific routine.. 3188.92 BogoMIPS (lpj=6377855)
> Jun 26 08:36:35 knarzkiste kernel: Mount-cache hash table entries: 512
> Jun 26 08:36:35 knarzkiste kernel: CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
> Jun 26 08:36:35 knarzkiste kernel: CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
> Jun 26 08:36:35 knarzkiste kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> Jun 26 08:36:35 knarzkiste kernel: CPU: L2 Cache: 1024K (64 bytes/line)
> Jun 26 08:36:35 knarzkiste kernel: CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000410 00000001 00000000 00000001
> Jun 26 08:36:35 knarzkiste kernel: Intel machine check architecture supported.
> Jun 26 08:36:35 knarzkiste kernel: Intel machine check reporting enabled on CPU#0.
> Jun 26 08:36:35 knarzkiste kernel: CPU: AMD Turion(tm) 64 Mobile Technology ML-30 stepping 02
> Jun 26 08:36:35 knarzkiste kernel: Checking 'hlt' instruction... OK.
> Jun 26 08:36:35 knarzkiste kernel: SMP alternatives: switching to UP code
> Jun 26 08:36:35 knarzkiste kernel: Freeing SMP alternatives: 0k freed
> Jun 26 08:36:35 knarzkiste kernel: ENABLING IO-APIC IRQs
> Jun 26 08:36:35 knarzkiste kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> Jun 26 08:36:35 knarzkiste kernel: ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> Jun 26 08:36:35 knarzkiste kernel: ...trying to set up timer as Virtual Wire IRQ... works.
> Jun 26 08:36:35 knarzkiste kernel: NET: Registered protocol family 16
> Jun 26 08:36:35 knarzkiste kernel: ACPI: bus type pci registered
> Jun 26 08:36:35 knarzkiste kernel: PCI: BIOS Bug: MCFG area is not E820-reserved
> Jun 26 08:36:35 knarzkiste kernel: PCI: Not using MMCONFIG.
> Jun 26 08:36:35 knarzkiste kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
> Jun 26 08:36:35 knarzkiste kernel: Setting up standard PCI resources
> Jun 26 08:36:35 knarzkiste kernel: ACPI: Subsystem revision 20060127
> Jun 26 08:36:35 knarzkiste kernel: ACPI: Interpreter enabled
> Jun 26 08:36:35 knarzkiste kernel: ACPI: Using IOAPIC for interrupt routing
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
> Jun 26 08:36:35 knarzkiste kernel: PCI: Probing PCI hardware (bus 00)
> Jun 26 08:36:35 knarzkiste kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
> Jun 26 08:36:35 knarzkiste kernel: Boot video device is 0000:01:05.0
> Jun 26 08:36:35 knarzkiste kernel: PCI: Transparent bridge - 0000:00:14.4
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
> Jun 26 08:36:35 knarzkiste kernel: ACPI: Embedded Controller [EC] (gpe 6) interrupt mode.
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POP2._PRT]
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 6 7 *10 11 12 14 15)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *5 6 7 10 11 12 14 15)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 6 7 10 *11 12 14 15)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *6 7 10 11 12 14 15)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 5 6 *7 10 11 12 14 15)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs *5 6 7 10 11 12 14 15)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
> Jun 26 08:36:35 knarzkiste kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
> Jun 26 08:36:35 knarzkiste kernel: pnp: PnP ACPI init
> Jun 26 08:36:35 knarzkiste kernel: pnp: PnP ACPI: found 11 devices
> Jun 26 08:36:35 knarzkiste kernel: PCI: Using ACPI for IRQ routing
> Jun 26 08:36:35 knarzkiste kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> Jun 26 08:36:35 knarzkiste kernel: PCI: Device 0000:02:03.0 not found by BIOS
> Jun 26 08:36:35 knarzkiste kernel: PCI: Device 0000:02:04.0 not found by BIOS
> Jun 26 08:36:35 knarzkiste kernel: PCI: Device 0000:02:04.1 not found by BIOS
> Jun 26 08:36:35 knarzkiste kernel: PCI: Device 0000:02:04.2 not found by BIOS
> Jun 26 08:36:35 knarzkiste kernel: PCI: Device 0000:02:09.0 not found by BIOS
> Jun 26 08:36:35 knarzkiste kernel: PCI: Bridge: 0000:00:01.0
> Jun 26 08:36:35 knarzkiste kernel:   IO window: d000-dfff
> Jun 26 08:36:35 knarzkiste kernel:   MEM window: fbe00000-fbefffff
> Jun 26 08:36:35 knarzkiste kernel:   PREFETCH window: f0000000-faffffff
> Jun 26 08:36:35 knarzkiste kernel: PCI: Bus 3, cardbus bridge: 0000:02:04.0
> Jun 26 08:36:35 knarzkiste kernel:   IO window: 0000e000-0000e0ff
> Jun 26 08:36:35 knarzkiste kernel:   IO window: 0000e400-0000e4ff
> Jun 26 08:36:35 knarzkiste kernel:   PREFETCH window: 30000000-31ffffff
> Jun 26 08:36:35 knarzkiste kernel:   MEM window: 36000000-37ffffff
> Jun 26 08:36:35 knarzkiste kernel: PCI: Bus 7, cardbus bridge: 0000:02:04.1
> Jun 26 08:36:35 knarzkiste kernel:   IO window: 0000ec00-0000ecff
> Jun 26 08:36:35 knarzkiste kernel:   IO window: 00001000-000010ff
> Jun 26 08:36:35 knarzkiste kernel:   PREFETCH window: 32000000-33ffffff
> Jun 26 08:36:35 knarzkiste kernel:   MEM window: 38000000-39ffffff
> Jun 26 08:36:35 knarzkiste kernel: PCI: Bridge: 0000:00:14.4
> Jun 26 08:36:35 knarzkiste kernel:   IO window: e000-efff
> Jun 26 08:36:35 knarzkiste kernel:   MEM window: fbf00000-fbffffff
> Jun 26 08:36:35 knarzkiste kernel:   PREFETCH window: 30000000-34ffffff
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 20 (level, low) -> IRQ 17
> Jun 26 08:36:35 knarzkiste kernel: NET: Registered protocol family 2
> Jun 26 08:36:35 knarzkiste kernel: IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> Jun 26 08:36:35 knarzkiste kernel: TCP established hash table entries: 16384 (order: 4, 65536 bytes)
> Jun 26 08:36:35 knarzkiste kernel: TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> Jun 26 08:36:35 knarzkiste kernel: TCP: Hash tables configured (established 16384 bind 8192)
> Jun 26 08:36:35 knarzkiste kernel: TCP reno registered
> Jun 26 08:36:35 knarzkiste kernel: Initializing Cryptographic API
> Jun 26 08:36:35 knarzkiste kernel: io scheduler noop registered
> Jun 26 08:36:35 knarzkiste kernel: io scheduler anticipatory registered
> Jun 26 08:36:35 knarzkiste kernel: io scheduler deadline registered
> Jun 26 08:36:35 knarzkiste kernel: io scheduler cfq registered (default)
> Jun 26 08:36:35 knarzkiste kernel: vesafb: framebuffer at 0xf0000000, mapped to 0xdc880000, using 3072k, total 65536k
> Jun 26 08:36:35 knarzkiste kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=41
> Jun 26 08:36:35 knarzkiste kernel: vesafb: protected mode interface info at c000:52f9
> Jun 26 08:36:35 knarzkiste kernel: vesafb: pmi: set display start = c00c5367, set palette = c00c53a1
> Jun 26 08:36:35 knarzkiste kernel: vesafb: pmi: ports = d810 d816 d854 d838 d83c d85c d800 d804 d8b0 d8b2 d8b4
> Jun 26 08:36:35 knarzkiste kernel: vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
> Jun 26 08:36:35 knarzkiste kernel: vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> Jun 26 08:36:35 knarzkiste kernel: Console: switching to colour frame buffer device 128x48
> Jun 26 08:36:35 knarzkiste kernel: fb0: VESA VGA frame buffer device
> Jun 26 08:36:35 knarzkiste kernel: lp: driver loaded but no devices found
> Jun 26 08:36:35 knarzkiste kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> Jun 26 08:36:35 knarzkiste kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> Jun 26 08:36:35 knarzkiste kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Jun 26 08:36:35 knarzkiste kernel: ATIIXP: IDE controller at PCI slot 0000:00:14.1
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 18
> Jun 26 08:36:35 knarzkiste kernel: ATIIXP: chipset revision 0
> Jun 26 08:36:35 knarzkiste kernel: ATIIXP: not 100%% native mode: will probe irqs later
> Jun 26 08:36:35 knarzkiste kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
> Jun 26 08:36:35 knarzkiste kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
> Jun 26 08:36:35 knarzkiste kernel: Probing IDE interface ide0...
> Jun 26 08:36:35 knarzkiste kernel: hda: WDC WD600VE-00HDT0, ATA DISK drive
> Jun 26 08:36:35 knarzkiste kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Jun 26 08:36:35 knarzkiste kernel: Probing IDE interface ide1...
> Jun 26 08:36:35 knarzkiste kernel: hdc: MATSHITADVD-RAM UJ-841S, ATAPI CD/DVD-ROM drive
> Jun 26 08:36:35 knarzkiste kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Jun 26 08:36:35 knarzkiste kernel: hda: max request size: 128KiB
> Jun 26 08:36:35 knarzkiste kernel: hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
> Jun 26 08:36:35 knarzkiste kernel: hda: cache flushes supported
> Jun 26 08:36:35 knarzkiste kernel:  hda: hda1 hda2 < hda5 >
> Jun 26 08:36:35 knarzkiste kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> Jun 26 08:36:35 knarzkiste kernel: i8042.c: Detected active multiplexing controller, rev 1.1.
> Jun 26 08:36:35 knarzkiste kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
> Jun 26 08:36:35 knarzkiste kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
> Jun 26 08:36:35 knarzkiste kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
> Jun 26 08:36:35 knarzkiste kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
> Jun 26 08:36:35 knarzkiste kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> Jun 26 08:36:35 knarzkiste kernel: mice: PS/2 mouse device common for all mice
> Jun 26 08:36:35 knarzkiste kernel: TCP bic registered
> Jun 26 08:36:35 knarzkiste kernel: Using IPI Shortcut mode
> Jun 26 08:36:35 knarzkiste kernel: ACPI wakeup devices:
> Jun 26 08:36:35 knarzkiste kernel: POP2  RTL USB1 USB2 EUSB AC97 MC97
> Jun 26 08:36:35 knarzkiste kernel: ACPI: (supports S0 S1 S3 S4 S5)
> Jun 26 08:36:35 knarzkiste kernel: XFS mounting filesystem hda1
> Jun 26 08:36:35 knarzkiste kernel: Ending clean XFS mount for filesystem: hda1
> Jun 26 08:36:35 knarzkiste kernel: VFS: Mounted root (xfs filesystem) readonly.
> Jun 26 08:36:35 knarzkiste kernel: Freeing unused kernel memory: 172k freed
> Jun 26 08:36:35 knarzkiste kernel: input: AT Translated Set 2 keyboard as /class/input/input0
> Jun 26 08:36:35 knarzkiste kernel: NET: Registered protocol family 1
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 08:36:35 knarzkiste kernel: Yenta: CardBus bridge found at 0000:02:04.0 [1462:0131]
> Jun 26 08:36:35 knarzkiste kernel: 8139too Fast Ethernet driver 0.9.27
> Jun 26 08:36:35 knarzkiste kernel: Yenta: ISA IRQ mask 0x04b8, PCI irq 16
> Jun 26 08:36:35 knarzkiste kernel: Socket status: 30000810
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0xe000-0xefff: clean.
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 20 (level, low) -> IRQ 17
> Jun 26 08:36:35 knarzkiste kernel: Yenta: CardBus bridge found at 0000:02:04.1 [1462:0131]
> Jun 26 08:36:35 knarzkiste kernel: usbcore: registered new driver usbfs
> Jun 26 08:36:35 knarzkiste kernel: usbcore: registered new driver hub
> Jun 26 08:36:35 knarzkiste kernel: Yenta: ISA IRQ mask 0x04b8, PCI irq 17
> Jun 26 08:36:35 knarzkiste kernel: Socket status: 30000006
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0xe000-0xefff: clean.
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 22 (level, low) -> IRQ 19
> Jun 26 08:36:35 knarzkiste kernel: rt2500 1.1.0 CVS 2005/07/10 http://rt2x00.serialmonkey.com
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 18 (level, low) -> IRQ 20
> Jun 26 08:36:35 knarzkiste kernel: eth1: RealTek RTL8139 at 0xdc83cc00, 00:10:dc:e8:c8:4f, IRQ 20
> Jun 26 08:36:35 knarzkiste kernel: eth1:  Identified 8139 chip type 'RTL-8101'
> Jun 26 08:36:35 knarzkiste kernel: hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Jun 26 08:36:35 knarzkiste kernel: Uniform CD-ROM driver Revision: 3.20
> Jun 26 08:36:35 knarzkiste kernel: ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 08:36:35 knarzkiste kernel: ohci_hcd 0000:00:13.0: OHCI Host Controller
> Jun 26 08:36:35 knarzkiste kernel: ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
> Jun 26 08:36:35 knarzkiste kernel: ohci_hcd 0000:00:13.0: irq 16, io mem 0xfbdfd000
> Jun 26 08:36:35 knarzkiste kernel: Synaptics Touchpad, model: 1, fw: 5.9, id: 0x116eb1, caps: 0xa04713/0x0
> Jun 26 08:36:35 knarzkiste kernel: Linux agpgart interface v0.101 (c) Dave Jones
> Jun 26 08:36:35 knarzkiste kernel: usb usb1: configuration #1 chosen from 1 choice
> Jun 26 08:36:35 knarzkiste kernel: hub 1-0:1.0: USB hub found
> Jun 26 08:36:35 knarzkiste kernel: hub 1-0:1.0: 4 ports detected
> Jun 26 08:36:35 knarzkiste kernel: input: SynPS/2 Synaptics TouchPad as /class/input/input1
> Jun 26 08:36:35 knarzkiste kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 08:36:35 knarzkiste kernel: ohci_hcd 0000:00:13.1: OHCI Host Controller
> Jun 26 08:36:35 knarzkiste kernel: ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
> Jun 26 08:36:35 knarzkiste kernel: ohci_hcd 0000:00:13.1: irq 16, io mem 0xfbdfe000
> Jun 26 08:36:35 knarzkiste kernel: hda: cache flushes supported
> Jun 26 08:36:35 knarzkiste kernel: pccard: PCMCIA card inserted into slot 0
> Jun 26 08:36:35 knarzkiste kernel: usb usb2: configuration #1 chosen from 1 choice
> Jun 26 08:36:35 knarzkiste kernel: hub 2-0:1.0: USB hub found
> Jun 26 08:36:35 knarzkiste kernel: hub 2-0:1.0: 4 ports detected
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 08:36:35 knarzkiste kernel: ehci_hcd 0000:00:13.2: EHCI Host Controller
> Jun 26 08:36:35 knarzkiste kernel: ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
> Jun 26 08:36:35 knarzkiste kernel: ehci_hcd 0000:00:13.2: irq 16, io mem 0xfbdff000
> Jun 26 08:36:35 knarzkiste kernel: ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> Jun 26 08:36:35 knarzkiste kernel: usb usb3: configuration #1 chosen from 1 choice
> Jun 26 08:36:35 knarzkiste kernel: hub 3-0:1.0: USB hub found
> Jun 26 08:36:35 knarzkiste kernel: hub 3-0:1.0: 8 ports detected
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 22
> Jun 26 08:36:35 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 22
> Jun 26 08:36:35 knarzkiste kernel: ts: Compaq touchscreen protocol output
> Jun 26 08:36:35 knarzkiste kernel: cs: memory probe 0xfbf00000-0xfbffffff: excluding 0xfbf00000-0xfbf0ffff 0xfbff0000-0xfbffffff
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: registering new device pcmcia0.0
> Jun 26 08:36:35 knarzkiste kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> Jun 26 08:36:35 knarzkiste kernel: usb 2-1: new low speed USB device using ohci_hcd and address 2
> Jun 26 08:36:35 knarzkiste kernel: usb 2-1: configuration #1 chosen from 1 choice
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x4d0-0x4d7
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0x800-0x8ff: clean.
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0xc00-0xcff: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0xa00-0xaff: clean.
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x4d0-0x4d7
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0x800-0x8ff: clean.
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0xc00-0xcff: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
> Jun 26 08:36:35 knarzkiste kernel: cs: IO port probe 0xa00-0xaff: clean.
> Jun 26 08:36:35 knarzkiste kernel: input: Logitech USB Optical Mouse as /class/input/input2
> Jun 26 08:36:35 knarzkiste kernel: usbcore: registered new driver usbmouse
> Jun 26 08:36:35 knarzkiste kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
> Jun 26 08:36:35 knarzkiste kernel: usbcore: registered new driver hiddev
> Jun 26 08:36:35 knarzkiste kernel: usbcore: registered new driver usbhid
> Jun 26 08:36:35 knarzkiste kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> Jun 26 08:36:35 knarzkiste kernel: hda: cache flushes supported
> Jun 26 08:36:35 knarzkiste kernel: Adding 1349420k swap on /dev/hda5.  Priority:-1 extents:1 across:1349420k
> Jun 26 08:36:35 knarzkiste kernel: Linux video capture interface: v1.00
> Jun 26 08:36:35 knarzkiste kernel: saa7130/34: v4l2 driver version 0.2.14 loaded
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
> Jun 26 08:36:35 knarzkiste kernel: pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
> Jun 26 08:36:35 knarzkiste kernel: NET: Registered protocol family 17
> Jun 26 08:36:36 knarzkiste kernel: ACPI: Battery Slot [BAT1] (battery present)
> Jun 26 08:36:36 knarzkiste kernel: ACPI: AC Adapter [ADP1] (on-line)
> Jun 26 08:36:36 knarzkiste kernel: ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> Jun 26 08:36:36 knarzkiste kernel: ACPI: Power Button (FF) [PWRF]
> Jun 26 08:36:36 knarzkiste kernel: ACPI: Lid Switch [LID0]
> Jun 26 08:36:36 knarzkiste kernel: ACPI: Sleep Button (CM) [SLPB]
> Jun 26 08:36:36 knarzkiste kernel: ACPI: Power Button (CM) [PWRB]
> Jun 26 08:36:36 knarzkiste kernel: ACPI: Thermal Zone [THRM] (57 C)
> Jun 26 08:36:43 knarzkiste /usr/sbin/gpm[4004]: Detected EXPS/2 protocol mouse.
> Jun 26 08:36:46 knarzkiste smartd[4072]: smartd version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Jun 26 08:36:46 knarzkiste smartd[4072]: Home page is http://smartmontools.sourceforge.net/
> Jun 26 08:36:46 knarzkiste smartd[4072]: Opened configuration file /etc/smartd.conf
> Jun 26 08:36:46 knarzkiste smartd[4072]: Configuration file /etc/smartd.conf parsed.
> Jun 26 08:36:46 knarzkiste smartd[4072]: Device: /dev/hda, opened
> Jun 26 08:36:46 knarzkiste smartd[4072]: Device: /dev/hda, not found in smartd database.
> Jun 26 08:36:46 knarzkiste smartd[4072]: Device: /dev/hda, enabled SMART Attribute Autosave.
> Jun 26 08:36:46 knarzkiste smartd[4072]: Device: /dev/hda, enabled SMART Automatic Offline Testing.
> Jun 26 08:36:46 knarzkiste smartd[4072]: Device: /dev/hda, is SMART capable. Adding to "monitor" list.
> Jun 26 08:36:46 knarzkiste smartd[4072]: Monitoring 1 ATA and 0 SCSI devices
> Jun 26 08:36:46 knarzkiste smartd[4074]: smartd has fork()ed into background mode. New PID=4074.
> Jun 26 08:36:47 knarzkiste sshd[4082]: Server listening on 0.0.0.0 port 22222.
> Jun 26 08:36:47 knarzkiste smartd[4074]: file /var/run/smartd.pid written containing PID 4074
> Jun 26 08:36:49 knarzkiste ntpd[4185]: ntpd 4.2.0a@1:4.2.0a+stable-8-r Sun Jun 18 14:43:31 UTC 2006 (1)
> Jun 26 08:36:50 knarzkiste ntpd[4185]: Listening on interface wildcard, 0.0.0.0#123
> Jun 26 08:36:50 knarzkiste ntpd[4185]: Listening on interface lo, 127.0.0.1#123
> Jun 26 08:36:50 knarzkiste ntpd[4185]: Listening on interface eth1, 192.168.1.106#123
> Jun 26 08:36:50 knarzkiste ntpd[4185]: kernel time sync status 0040
> Jun 26 08:36:50 knarzkiste ntpd[4185]: frequency initialized 10.061 PPM from /var/lib/ntp/ntp.drift
> Jun 26 08:36:50 knarzkiste kernel: powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
> Jun 26 08:36:50 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
> Jun 26 08:36:50 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
> Jun 26 08:36:50 knarzkiste kernel: cpu_init done, current fid 0x8, vid 0x2
> Jun 26 08:36:50 knarzkiste kernel: powernow-k8: ph2 null fid transition 0x8
> Jun 26 08:36:50 knarzkiste powersaved: Starting powersaved with ACPI support
> Jun 26 08:36:54 knarzkiste kernel: [drm] Initialized drm 1.0.1 20051102

2.6.17-mm2 with reverted patch:
===============================

> Jun 26 09:41:57 knarzkiste kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
> Jun 26 09:41:57 knarzkiste kernel: Linux version 2.6.17-mm2 (root@knarzkiste) (gcc version 4.1.2 20060613 (prerelease) (Debian 4.1.1-5)) #1 PREEMPT Mon Jun 26 09:30:44 CEST 2006
> Jun 26 09:41:57 knarzkiste kernel: BIOS-provided physical RAM map:
> Jun 26 09:41:57 knarzkiste kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> Jun 26 09:41:57 knarzkiste kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> Jun 26 09:41:57 knarzkiste kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
> Jun 26 09:41:57 knarzkiste kernel:  BIOS-e820: 0000000000100000 - 000000001bf40000 (usable)
> Jun 26 09:41:57 knarzkiste kernel:  BIOS-e820: 000000001bf40000 - 000000001bf50000 (ACPI data)
> Jun 26 09:41:57 knarzkiste kernel:  BIOS-e820: 000000001bf50000 - 000000001c000000 (ACPI NVS)
> Jun 26 09:41:57 knarzkiste kernel:  BIOS-e820: 000000001c000000 - 0000000020000000 (reserved)
> Jun 26 09:41:57 knarzkiste kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> Jun 26 09:41:57 knarzkiste kernel: 447MB LOWMEM available.
> Jun 26 09:41:57 knarzkiste kernel: On node 0 totalpages: 114496
> Jun 26 09:41:57 knarzkiste kernel:   DMA zone: 4096 pages, LIFO batch:0
> Jun 26 09:41:57 knarzkiste kernel:   Normal zone: 110400 pages, LIFO batch:31
> Jun 26 09:41:57 knarzkiste kernel: DMI 2.3 present.
> Jun 26 09:41:57 knarzkiste kernel: ACPI: RSDP (v000 MSI                                   ) @ 0x000f8350
> Jun 26 09:41:57 knarzkiste kernel: ACPI: RSDT (v001 MSI    1013     0x08242005 MSFT 0x00000097) @ 0x1bf40000
> Jun 26 09:41:57 knarzkiste kernel: ACPI: FADT (v002 MSI    1013     0x08242005 MSFT 0x00000097) @ 0x1bf40200
> Jun 26 09:41:57 knarzkiste kernel: ACPI: MADT (v001 MSI    OEMAPIC  0x08242005 MSFT 0x00000097) @ 0x1bf40300
> Jun 26 09:41:57 knarzkiste kernel: ACPI: WDRT (v001 MSI    MSI_OEM  0x08242005 MSFT 0x00000097) @ 0x1bf40360
> Jun 26 09:41:57 knarzkiste kernel: ACPI: MCFG (v001 MSI    OEMMCFG  0x08242005 MSFT 0x00000097) @ 0x1bf403b0
> Jun 26 09:41:57 knarzkiste kernel: ACPI: SSDT (v001 OEM_ID OEMTBLID 0x00000001 INTL 0x02002026) @ 0x1bf43620
> Jun 26 09:41:57 knarzkiste kernel: ACPI: OEMB (v001 MSI    MSI_OEM  0x08242005 MSFT 0x00000097) @ 0x1bf50040
> Jun 26 09:41:57 knarzkiste kernel: ACPI: DSDT (v001    MSI     1013 0x08242005 INTL 0x02002026) @ 0x00000000
> Jun 26 09:41:57 knarzkiste kernel: ATI board detected. Disabling timer routing over 8254.
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PM-Timer IO Port: 0x4008
> Jun 26 09:41:57 knarzkiste kernel: ACPI: Local APIC address 0xfee00000
> Jun 26 09:41:57 knarzkiste kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Jun 26 09:41:57 knarzkiste kernel: Processor #0 15:4 APIC version 16
> Jun 26 09:41:57 knarzkiste kernel: ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> Jun 26 09:41:57 knarzkiste kernel: IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI 0-23
> Jun 26 09:41:57 knarzkiste kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: IRQ0 used by override.
> Jun 26 09:41:57 knarzkiste kernel: ACPI: IRQ2 used by override.
> Jun 26 09:41:57 knarzkiste kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Jun 26 09:41:57 knarzkiste kernel: Using ACPI (MADT) for SMP configuration information
> Jun 26 09:41:57 knarzkiste kernel: Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
> Jun 26 09:41:57 knarzkiste kernel: Detected 1591.964 MHz processor.
> Jun 26 09:41:57 knarzkiste kernel: Built 1 zonelists.  Total pages: 114496
> Jun 26 09:41:57 knarzkiste kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=301 hdc=noprobe hdc=cdrom video=vesafb:ywrap,mtrr:4 pci=assign-busses lapic panic=15
> Jun 26 09:41:57 knarzkiste kernel: ide_setup: hdc=noprobe
> Jun 26 09:41:57 knarzkiste kernel: ide_setup: hdc=cdrom
> Jun 26 09:41:57 knarzkiste kernel: mapped APIC to ffffd000 (fee00000)
> Jun 26 09:41:57 knarzkiste kernel: mapped IOAPIC to ffffc000 (fec00000)
> Jun 26 09:41:57 knarzkiste kernel: Enabling fast FPU save and restore... done.
> Jun 26 09:41:57 knarzkiste kernel: Enabling unmasked SIMD FPU exception support... done.
> Jun 26 09:41:57 knarzkiste kernel: Initializing CPU#0
> Jun 26 09:41:57 knarzkiste kernel: CPU 0 irqstacks, hard=c03b7000 soft=c03b6000
> Jun 26 09:41:57 knarzkiste kernel: PID hash table entries: 2048 (order: 11, 8192 bytes)
> Jun 26 09:41:57 knarzkiste kernel: Console: colour dummy device 80x25
> Jun 26 09:41:57 knarzkiste kernel: Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Jun 26 09:41:57 knarzkiste kernel: Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Jun 26 09:41:57 knarzkiste kernel: Memory: 450532k/457984k available (2020k kernel code, 6964k reserved, 534k data, 196k init, 0k highmem)
> Jun 26 09:41:57 knarzkiste kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Jun 26 09:41:57 knarzkiste kernel: Calibrating delay using timer specific routine.. 3186.92 BogoMIPS (lpj=6373855)
> Jun 26 09:41:57 knarzkiste kernel: Mount-cache hash table entries: 512
> Jun 26 09:41:57 knarzkiste kernel: CPU: After generic identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
> Jun 26 09:41:57 knarzkiste kernel: CPU: After vendor identify, caps: 078bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000001
> Jun 26 09:41:57 knarzkiste kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> Jun 26 09:41:57 knarzkiste kernel: CPU: L2 Cache: 1024K (64 bytes/line)
> Jun 26 09:41:57 knarzkiste kernel: CPU: After all inits, caps: 078bfbff e3d3fbff 00000000 00000410 00000001 00000000 00000001
> Jun 26 09:41:57 knarzkiste kernel: Intel machine check architecture supported.
> Jun 26 09:41:57 knarzkiste kernel: Intel machine check reporting enabled on CPU#0.
> Jun 26 09:41:57 knarzkiste kernel: Compat vDSO mapped to ffffe000.
> Jun 26 09:41:57 knarzkiste kernel: CPU: AMD Turion(tm) 64 Mobile Technology ML-30 stepping 02
> Jun 26 09:41:57 knarzkiste kernel: Checking 'hlt' instruction... OK.
> Jun 26 09:41:57 knarzkiste kernel: SMP alternatives: switching to UP code
> Jun 26 09:41:57 knarzkiste kernel: Freeing SMP alternatives: 0k freed
> Jun 26 09:41:57 knarzkiste kernel: ACPI: Core revision 20060608
> Jun 26 09:41:57 knarzkiste kernel: ENABLING IO-APIC IRQs
> Jun 26 09:41:57 knarzkiste kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> Jun 26 09:41:57 knarzkiste kernel: ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> Jun 26 09:41:57 knarzkiste kernel: ...trying to set up timer as Virtual Wire IRQ... works.
> Jun 26 09:41:57 knarzkiste kernel: NET: Registered protocol family 16
> Jun 26 09:41:57 knarzkiste kernel: ACPI: bus type pci registered
> Jun 26 09:41:57 knarzkiste kernel: PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
> Jun 26 09:41:57 knarzkiste kernel: PCI: Not using MMCONFIG.
> Jun 26 09:41:57 knarzkiste kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
> Jun 26 09:41:57 knarzkiste kernel: Setting up standard PCI resources
> Jun 26 09:41:57 knarzkiste kernel: ACPI: Interpreter enabled
> Jun 26 09:41:57 knarzkiste kernel: ACPI: Using IOAPIC for interrupt routing
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
> Jun 26 09:41:57 knarzkiste kernel: PCI: Probing PCI hardware (bus 00)
> Jun 26 09:41:57 knarzkiste kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
> Jun 26 09:41:57 knarzkiste kernel: Boot video device is 0000:01:05.0
> Jun 26 09:41:57 knarzkiste kernel: PCI: Transparent bridge - 0000:00:14.4
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
> Jun 26 09:41:57 knarzkiste kernel: ACPI: Embedded Controller [EC] (gpe 6) interrupt mode.
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.POP2._PRT]
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 5 6 7 *10 11 12 14 15)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs *5 6 7 10 11 12 14 15)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 5 6 7 10 *11 12 14 15)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *6 7 10 11 12 14 15)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 5 6 *7 10 11 12 14 15)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs *5 6 7 10 11 12 14 15)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 5 6 7 10 11 12 14 15) *0, disabled.
> Jun 26 09:41:57 knarzkiste kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
> Jun 26 09:41:57 knarzkiste kernel: pnp: PnP ACPI init
> Jun 26 09:41:57 knarzkiste kernel: pnp: PnP ACPI: found 11 devices
> Jun 26 09:41:57 knarzkiste kernel: PCI: Using ACPI for IRQ routing
> Jun 26 09:41:57 knarzkiste kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
> Jun 26 09:41:57 knarzkiste kernel: PCI: Device 0000:02:03.0 not found by BIOS
> Jun 26 09:41:57 knarzkiste kernel: PCI: Device 0000:02:04.0 not found by BIOS
> Jun 26 09:41:57 knarzkiste kernel: PCI: Device 0000:02:04.1 not found by BIOS
> Jun 26 09:41:57 knarzkiste kernel: PCI: Device 0000:02:04.2 not found by BIOS
> Jun 26 09:41:57 knarzkiste kernel: PCI: Device 0000:02:09.0 not found by BIOS
> Jun 26 09:41:57 knarzkiste kernel: PCI: Bridge: 0000:00:01.0
> Jun 26 09:41:57 knarzkiste kernel:   IO window: d000-dfff
> Jun 26 09:41:57 knarzkiste kernel:   MEM window: fbe00000-fbefffff
> Jun 26 09:41:57 knarzkiste kernel:   PREFETCH window: f0000000-faffffff
> Jun 26 09:41:57 knarzkiste kernel: PCI: Bus 3, cardbus bridge: 0000:02:04.0
> Jun 26 09:41:57 knarzkiste kernel:   IO window: 0000e000-0000e0ff
> Jun 26 09:41:57 knarzkiste kernel:   IO window: 0000e400-0000e4ff
> Jun 26 09:41:57 knarzkiste kernel:   PREFETCH window: 30000000-31ffffff
> Jun 26 09:41:57 knarzkiste kernel:   MEM window: 36000000-37ffffff
> Jun 26 09:41:57 knarzkiste kernel: PCI: Bus 7, cardbus bridge: 0000:02:04.1
> Jun 26 09:41:57 knarzkiste kernel:   IO window: 0000ec00-0000ecff
> Jun 26 09:41:57 knarzkiste kernel:   IO window: 00001000-000010ff
> Jun 26 09:41:57 knarzkiste kernel:   PREFETCH window: 32000000-33ffffff
> Jun 26 09:41:57 knarzkiste kernel:   MEM window: 38000000-39ffffff
> Jun 26 09:41:57 knarzkiste kernel: PCI: Bridge: 0000:00:14.4
> Jun 26 09:41:57 knarzkiste kernel:   IO window: e000-efff
> Jun 26 09:41:57 knarzkiste kernel:   MEM window: fbf00000-fbffffff
> Jun 26 09:41:57 knarzkiste kernel:   PREFETCH window: 30000000-34ffffff
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 20 (level, low) -> IRQ 17
> Jun 26 09:41:57 knarzkiste kernel: NET: Registered protocol family 2
> Jun 26 09:41:57 knarzkiste kernel: IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> Jun 26 09:41:57 knarzkiste kernel: TCP established hash table entries: 16384 (order: 4, 65536 bytes)
> Jun 26 09:41:57 knarzkiste kernel: TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> Jun 26 09:41:57 knarzkiste kernel: TCP: Hash tables configured (established 16384 bind 8192)
> Jun 26 09:41:57 knarzkiste kernel: TCP reno registered
> Jun 26 09:41:57 knarzkiste kernel: Initializing Cryptographic API
> Jun 26 09:41:57 knarzkiste kernel: io scheduler noop registered
> Jun 26 09:41:57 knarzkiste kernel: io scheduler anticipatory registered
> Jun 26 09:41:57 knarzkiste kernel: io scheduler deadline registered
> Jun 26 09:41:57 knarzkiste kernel: io scheduler cfq registered (default)
> Jun 26 09:41:57 knarzkiste kernel: vesafb: framebuffer at 0xf0000000, mapped to 0xdc880000, using 3072k, total 65536k
> Jun 26 09:41:57 knarzkiste kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=41
> Jun 26 09:41:57 knarzkiste kernel: vesafb: protected mode interface info at c000:52f9
> Jun 26 09:41:57 knarzkiste kernel: vesafb: pmi: set display start = c00c5367, set palette = c00c53a1
> Jun 26 09:41:57 knarzkiste kernel: vesafb: pmi: ports = d810 d816 d854 d838 d83c d85c d800 d804 d8b0 d8b2 d8b4
> Jun 26 09:41:57 knarzkiste kernel: vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
> Jun 26 09:41:57 knarzkiste kernel: vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> Jun 26 09:41:57 knarzkiste kernel: Console: switching to colour frame buffer device 128x48
> Jun 26 09:41:57 knarzkiste kernel: fb0: VESA VGA frame buffer device
> Jun 26 09:41:57 knarzkiste kernel: lp: driver loaded but no devices found
> Jun 26 09:41:57 knarzkiste kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> Jun 26 09:41:57 knarzkiste kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> Jun 26 09:41:57 knarzkiste kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Jun 26 09:41:57 knarzkiste kernel: ATIIXP: IDE controller at PCI slot 0000:00:14.1
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 18
> Jun 26 09:41:57 knarzkiste kernel: ATIIXP: chipset revision 0
> Jun 26 09:41:57 knarzkiste kernel: ATIIXP: not 100%% native mode: will probe irqs later
> Jun 26 09:41:57 knarzkiste kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
> Jun 26 09:41:57 knarzkiste kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
> Jun 26 09:41:57 knarzkiste kernel: Probing IDE interface ide0...
> Jun 26 09:41:57 knarzkiste kernel: hda: WDC WD600VE-00HDT0, ATA DISK drive
> Jun 26 09:41:57 knarzkiste kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Jun 26 09:41:57 knarzkiste kernel: Probing IDE interface ide1...
> Jun 26 09:41:57 knarzkiste kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Jun 26 09:41:57 knarzkiste kernel: hda: max request size: 128KiB
> Jun 26 09:41:57 knarzkiste kernel: hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
> Jun 26 09:41:57 knarzkiste kernel: hda: cache flushes supported
> Jun 26 09:41:57 knarzkiste kernel:  hda: hda1 hda2 < hda5 >
> Jun 26 09:41:57 knarzkiste kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
> Jun 26 09:41:57 knarzkiste kernel: i8042.c: Detected active multiplexing controller, rev 1.1.
> Jun 26 09:41:57 knarzkiste kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
> Jun 26 09:41:57 knarzkiste kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
> Jun 26 09:41:57 knarzkiste kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
> Jun 26 09:41:57 knarzkiste kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
> Jun 26 09:41:57 knarzkiste kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> Jun 26 09:41:57 knarzkiste kernel: mice: PS/2 mouse device common for all mice
> Jun 26 09:41:57 knarzkiste kernel: TCP bic registered
> Jun 26 09:41:57 knarzkiste kernel: Using IPI Shortcut mode
> Jun 26 09:41:57 knarzkiste kernel: ACPI: (supports S0 S1 S3 S4 S5)
> Jun 26 09:41:57 knarzkiste kernel: Time: tsc clocksource has been installed.
> Jun 26 09:41:57 knarzkiste kernel: Freeing unused kernel memory: 196k freed
> Jun 26 09:41:57 knarzkiste kernel: XFS mounting filesystem hda1
> Jun 26 09:41:57 knarzkiste kernel: Ending clean XFS mount for filesystem: hda1
> Jun 26 09:41:57 knarzkiste kernel: input: AT Translated Set 2 keyboard as /class/input/input0
> Jun 26 09:41:57 knarzkiste kernel: NET: Registered protocol family 1
> Jun 26 09:41:57 knarzkiste kernel: hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
> Jun 26 09:41:57 knarzkiste kernel: Uniform CD-ROM driver Revision: 3.20
> Jun 26 09:41:57 knarzkiste kernel: Yenta: CardBus bridge found at 0000:02:04.0 [1462:0131]
> Jun 26 09:41:57 knarzkiste kernel: 8139too Fast Ethernet driver 0.9.27
> Jun 26 09:41:57 knarzkiste kernel: Synaptics Touchpad, model: 1, fw: 5.9, id: 0x116eb1, caps: 0xa04713/0x0
> Jun 26 09:41:57 knarzkiste kernel: Yenta: ISA IRQ mask 0x04b8, PCI irq 16
> Jun 26 09:41:57 knarzkiste kernel: Socket status: 30000810
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0xe000-0xefff: clean.
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
> Jun 26 09:41:57 knarzkiste kernel: usbcore: registered new driver usbfs
> Jun 26 09:41:57 knarzkiste kernel: usbcore: registered new driver hub
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 18 (level, low) -> IRQ 19
> Jun 26 09:41:57 knarzkiste kernel: eth0: RealTek RTL8139 at 0xdc83cc00, 00:10:dc:e8:c8:4f, IRQ 19
> Jun 26 09:41:57 knarzkiste kernel: eth0:  Identified 8139 chip type 'RTL-8101'
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 22 (level, low) -> IRQ 20
> Jun 26 09:41:57 knarzkiste kernel: rt2500 1.1.0 CVS 2005/07/10 http://rt2x00.serialmonkey.com
> Jun 26 09:41:57 knarzkiste kernel: piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
> Jun 26 09:41:57 knarzkiste kernel: input: SynPS/2 Synaptics TouchPad as /class/input/input1
> Jun 26 09:41:57 knarzkiste kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
> Jun 26 09:41:57 knarzkiste kernel: Yenta: CardBus bridge found at 0000:02:04.1 [1462:0131]
> Jun 26 09:41:57 knarzkiste kernel: Linux agpgart interface v0.101 (c) Dave Jones
> Jun 26 09:41:57 knarzkiste kernel: Yenta: ISA IRQ mask 0x0cb8, PCI irq 17
> Jun 26 09:41:57 knarzkiste kernel: Socket status: 30000006
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: parent PCI bridge I/O window: 0xe000 - 0xefff
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0xe000-0xefff: clean.
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: parent PCI bridge Memory window: 0xfbf00000 - 0xfbffffff
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x34ffffff
> Jun 26 09:41:57 knarzkiste kernel: ts: Compaq touchscreen protocol output
> Jun 26 09:41:57 knarzkiste kernel: ohci_hcd: 2006 May 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 09:41:57 knarzkiste kernel: ohci_hcd 0000:00:13.0: OHCI Host Controller
> Jun 26 09:41:57 knarzkiste kernel: ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
> Jun 26 09:41:57 knarzkiste kernel: ohci_hcd 0000:00:13.0: irq 16, io mem 0xfbdfd000
> Jun 26 09:41:57 knarzkiste kernel: usb usb1: new device found, idVendor=0000, idProduct=0000
> Jun 26 09:41:57 knarzkiste kernel: usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
> Jun 26 09:41:57 knarzkiste kernel: usb usb1: Product: OHCI Host Controller
> Jun 26 09:41:57 knarzkiste kernel: usb usb1: Manufacturer: Linux 2.6.17-mm2 ohci_hcd
> Jun 26 09:41:57 knarzkiste kernel: usb usb1: SerialNumber: 0000:00:13.0
> Jun 26 09:41:57 knarzkiste kernel: usb usb1: configuration #1 chosen from 1 choice
> Jun 26 09:41:57 knarzkiste kernel: pccard: PCMCIA card inserted into slot 0
> Jun 26 09:41:57 knarzkiste kernel: hub 1-0:1.0: USB hub found
> Jun 26 09:41:57 knarzkiste kernel: hub 1-0:1.0: 4 ports detected
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 09:41:57 knarzkiste kernel: ohci_hcd 0000:00:13.1: OHCI Host Controller
> Jun 26 09:41:57 knarzkiste kernel: ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
> Jun 26 09:41:57 knarzkiste kernel: ohci_hcd 0000:00:13.1: irq 16, io mem 0xfbdfe000
> Jun 26 09:41:57 knarzkiste kernel: hda: cache flushes supported
> Jun 26 09:41:57 knarzkiste kernel: usb usb2: new device found, idVendor=0000, idProduct=0000
> Jun 26 09:41:57 knarzkiste kernel: usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
> Jun 26 09:41:57 knarzkiste kernel: usb usb2: Product: OHCI Host Controller
> Jun 26 09:41:57 knarzkiste kernel: usb usb2: Manufacturer: Linux 2.6.17-mm2 ohci_hcd
> Jun 26 09:41:57 knarzkiste kernel: usb usb2: SerialNumber: 0000:00:13.1
> Jun 26 09:41:57 knarzkiste kernel: usb usb2: configuration #1 chosen from 1 choice
> Jun 26 09:41:57 knarzkiste kernel: hub 2-0:1.0: USB hub found
> Jun 26 09:41:57 knarzkiste kernel: hub 2-0:1.0: 4 ports detected
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 22
> Jun 26 09:41:57 knarzkiste kernel: cs: memory probe 0xfbf00000-0xfbffffff: excluding 0xfbf00000-0xfbf0ffff 0xfbff0000-0xfbffffff
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: registering new device pcmcia0.0
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: new low speed USB device using ohci_hcd and address 2
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x4d0-0x4d7
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0x800-0x8ff: clean.
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0xc00-0xcff: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0xa00-0xaff: clean.
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0x100-0x4ff: excluding 0x408-0x40f 0x4d0-0x4d7
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0x800-0x8ff:<6>ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 16
> Jun 26 09:41:57 knarzkiste kernel: ehci_hcd 0000:00:13.2: EHCI Host Controller
> Jun 26 09:41:57 knarzkiste kernel: ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
> Jun 26 09:41:57 knarzkiste kernel: ehci_hcd 0000:00:13.2: irq 16, io mem 0xfbdff000
> Jun 26 09:41:57 knarzkiste kernel: ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> Jun 26 09:41:57 knarzkiste kernel: usb usb3: new device found, idVendor=0000, idProduct=0000
> Jun 26 09:41:57 knarzkiste kernel: usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
> Jun 26 09:41:57 knarzkiste kernel: usb usb3: Product: EHCI Host Controller
> Jun 26 09:41:57 knarzkiste kernel: usb usb3: Manufacturer: Linux 2.6.17-mm2 ehci_hcd
> Jun 26 09:41:57 knarzkiste kernel: usb usb3: SerialNumber: 0000:00:13.2
> Jun 26 09:41:57 knarzkiste kernel: usb usb3: configuration #1 chosen from 1 choice
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: new device found, idVendor=046d, idProduct=c00c
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: configuration #1 chosen from 1 choice
> Jun 26 09:41:57 knarzkiste kernel: hub 3-0:1.0: USB hub found
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: can't set config #1, error -110
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: USB disconnect, address 2
> Jun 26 09:41:57 knarzkiste kernel: hub 3-0:1.0: 8 ports detected
> Jun 26 09:41:57 knarzkiste kernel:  clean.
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0xc00-0xcff: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf 0xcf8-0xcff
> Jun 26 09:41:57 knarzkiste kernel: cs: IO port probe 0xa00-0xaff: clean.
> Jun 26 09:41:57 knarzkiste kernel: ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 22
> Jun 26 09:41:57 knarzkiste kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> Jun 26 09:41:57 knarzkiste kernel: ohci_hcd 0000:00:13.1: wakeup
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: new low speed USB device using ohci_hcd and address 3
> Jun 26 09:41:57 knarzkiste kernel: APIC error on CPU0: 00(40)
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: new device found, idVendor=046d, idProduct=c00c
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: Product: USB Optical Mouse
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: Manufacturer: Logitech
> Jun 26 09:41:57 knarzkiste kernel: usb 2-1: configuration #1 chosen from 1 choice
> Jun 26 09:41:57 knarzkiste kernel: input: Logitech USB Optical Mouse as /class/input/input2
> Jun 26 09:41:57 knarzkiste kernel: usbcore: registered new driver usbmouse
> Jun 26 09:41:57 knarzkiste kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
> Jun 26 09:41:57 knarzkiste kernel: usbcore: registered new driver hiddev
> Jun 26 09:41:57 knarzkiste kernel: usbcore: registered new driver usbhid
> Jun 26 09:41:57 knarzkiste kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> Jun 26 09:41:57 knarzkiste kernel: hda: cache flushes supported
> Jun 26 09:41:57 knarzkiste kernel: Adding 1349420k swap on /dev/hda5.  Priority:-1 extents:1 across:1349420k
> Jun 26 09:41:57 knarzkiste kernel: Linux video capture interface: v2.00
> Jun 26 09:41:57 knarzkiste kernel: saa7130/34: v4l2 driver version 0.2.14 loaded
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
> Jun 26 09:41:57 knarzkiste kernel: pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
> Jun 26 09:41:57 knarzkiste kernel: NET: Registered protocol family 17
> Jun 26 09:41:58 knarzkiste kernel: ACPI: Battery Slot [BAT1] (battery present)
> Jun 26 09:41:58 knarzkiste kernel: ACPI: AC Adapter [ADP1] (on-line)
> Jun 26 09:41:58 knarzkiste kernel: ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> Jun 26 09:41:58 knarzkiste kernel: ACPI: Power Button (FF) [PWRF]
> Jun 26 09:41:58 knarzkiste kernel: ACPI: Lid Switch [LID0]
> Jun 26 09:41:58 knarzkiste kernel: ACPI: Sleep Button (CM) [SLPB]
> Jun 26 09:41:58 knarzkiste kernel: ACPI: Power Button (CM) [PWRB]
> Jun 26 09:41:58 knarzkiste kernel: Time: acpi_pm clocksource has been installed.
> Jun 26 09:41:58 knarzkiste kernel: ACPI: Thermal Zone [THRM] (62 C)
> Jun 26 09:42:05 knarzkiste /usr/sbin/gpm[3992]: Detected EXPS/2 protocol mouse.
> Jun 26 09:42:07 knarzkiste sshd[4070]: Server listening on 0.0.0.0 port 22222.
> Jun 26 09:42:07 knarzkiste smartd[4060]: smartd version 5.36 [i686-pc-linux-gnu] Copyright (C) 2002-6 Bruce Allen
> Jun 26 09:42:07 knarzkiste smartd[4060]: Home page is http://smartmontools.sourceforge.net/
> Jun 26 09:42:07 knarzkiste smartd[4060]: Opened configuration file /etc/smartd.conf
> Jun 26 09:42:07 knarzkiste smartd[4060]: Configuration file /etc/smartd.conf parsed.
> Jun 26 09:42:07 knarzkiste smartd[4060]: Device: /dev/hda, opened
> Jun 26 09:42:07 knarzkiste smartd[4060]: Device: /dev/hda, not found in smartd database.
> Jun 26 09:42:07 knarzkiste smartd[4060]: Device: /dev/hda, enabled SMART Attribute Autosave.
> Jun 26 09:42:07 knarzkiste smartd[4060]: Device: /dev/hda, enabled SMART Automatic Offline Testing.
> Jun 26 09:42:07 knarzkiste smartd[4060]: Device: /dev/hda, is SMART capable. Adding to "monitor" list.
> Jun 26 09:42:07 knarzkiste smartd[4060]: Monitoring 1 ATA and 0 SCSI devices
> Jun 26 09:42:07 knarzkiste smartd[4062]: smartd has fork()ed into background mode. New PID=4062.
> Jun 26 09:42:07 knarzkiste smartd[4062]: file /var/run/smartd.pid written containing PID 4062
> Jun 26 09:42:10 knarzkiste ntpd[4173]: ntpd 4.2.0a@1:4.2.0a+stable-8-r Sun Jun 18 14:43:31 UTC 2006 (1)
> Jun 26 09:42:10 knarzkiste ntpd[4173]: Listening on interface wildcard, 0.0.0.0#123
> Jun 26 09:42:10 knarzkiste ntpd[4173]: Listening on interface lo, 127.0.0.1#123
> Jun 26 09:42:10 knarzkiste ntpd[4173]: Listening on interface eth1, 192.168.1.106#123
> Jun 26 09:42:10 knarzkiste ntpd[4173]: kernel time sync status 0040
> Jun 26 09:42:10 knarzkiste ntpd[4173]: frequency initialized 10.061 PPM from /var/lib/ntp/ntp.drift
> Jun 26 09:42:10 knarzkiste kernel: powernow-k8: Found 1 AMD Turion(tm) 64 Mobile Technology ML-30 processors (version 2.00.00)
> Jun 26 09:42:10 knarzkiste kernel: powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12
> Jun 26 09:42:10 knarzkiste kernel: powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4
> Jun 26 09:42:10 knarzkiste kernel: powernow-k8: ph2 null fid transition 0x8
> Jun 26 09:42:11 knarzkiste powersaved: Starting powersaved with ACPI support
> Jun 26 09:42:14 knarzkiste kernel: [drm] Initialized drm 1.0.1 20051102

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
