Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVJDIph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVJDIph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 04:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVJDIph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 04:45:37 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:4108 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964791AbVJDIpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 04:45:36 -0400
Date: Tue, 4 Oct 2005 10:45:33 +0200
From: Olivier Galibert <galibert@pobox.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20051004084533.GA59492@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org> <1127919909.4852.7.camel@mulgrave> <20050928160744.GA37975@dspnet.fr.eu.org> <1127924686.4852.11.camel@mulgrave> <20050928171052.GA45082@dspnet.fr.eu.org> <1127929909.4852.34.camel@mulgrave> <20050928183324.GA51793@dspnet.fr.eu.org> <1128175434.4921.9.camel@mulgrave> <20051003134210.GA10641@dspnet.fr.eu.org> <1128356144.4606.11.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128356144.4606.11.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 12:15:44PM -0400, James Bottomley wrote:
> What type of array is this, by the way?  I don't recognise the vendor.

Fibrenetix VP-1252-U4

Controller:           FB951223
Firmware version:     V1.36 2005-3-17
BOOT ROM version:     V1.35 2005-3-3
MPT firmware version: 1.3.39.0
Main processor:       400MHz IOP321
System memory:        256MB / 200MHz

Voltages are within 5% of reference, temperatures are 37-42C.

> But anyway, let's proceed on the theory that the array is having a hard
> time.  What I need you to do is lower the speed of the array target in
> the aic bios.  Unfortunately, the driver won't honour that setting at
> the moment:  I'll see if I can work up the code that will do it.  The
> attached patch will perform this artificially (for every device on every
> aic79xx).

The mounts worked with your patch.  I'm going to start actually using
the raid, that's going to tell us how stable it actually is.  I have
no problems with doing other tests.


Oct  4 10:32:43 m82 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct  4 10:32:43 m82 kernel: Bootdata ok (command line is ro root=/dev/sda1 rhgb)
Oct  4 10:32:43 m82 kernel: Linux version 2.6.14-rc2-g95001ee9 (galibert@m82.limsi.fr) (gcc version 3.4.3 20050227 (Red Hat 3.4.3-22.fc3)) #1 SMP Wed Sep 28 20:12:23 CEST 2005
Oct  4 10:32:43 m82 kernel: BIOS-provided physical RAM map:
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 0000000000000000 - 000000000009b400 (usable)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 000000000009b400 - 00000000000a0000 (reserved)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 0000000000100000 - 00000000bff70000 (usable)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000bff70000 - 00000000bff78000 (ACPI data)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000bff78000 - 00000000bff80000 (ACPI NVS)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
Oct  4 10:32:43 m82 kernel:  BIOS-e820: 0000000100000000 - 00000001c0000000 (usable)
Oct  4 10:32:43 m82 kernel: No NUMA configuration found
Oct  4 10:32:43 m82 kernel: Faking a node at 0000000000000000-00000001c0000000
Oct  4 10:32:43 m82 kernel: Bootmem setup node 0 0000000000000000-00000001c0000000
Oct  4 10:32:43 m82 kernel: ACPI: PM-Timer IO Port: 0x1008
Oct  4 10:32:43 m82 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Oct  4 10:32:43 m82 kernel: Processor #0 15:4 APIC version 20
Oct  4 10:32:43 m82 kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Oct  4 10:32:43 m82 kernel: Processor #6 15:4 APIC version 20
Oct  4 10:32:43 m82 kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Oct  4 10:32:43 m82 kernel: Processor #1 15:4 APIC version 20
Oct  4 10:32:43 m82 kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Oct  4 10:32:43 m82 kernel: Processor #7 15:4 APIC version 20
Oct  4 10:32:43 m82 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Oct  4 10:32:43 m82 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Oct  4 10:32:43 m82 kernel: ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
Oct  4 10:32:43 m82 kernel: ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
Oct  4 10:32:43 m82 kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Oct  4 10:32:43 m82 kernel: IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
Oct  4 10:32:43 m82 kernel: ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
Oct  4 10:32:43 m82 kernel: IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
Oct  4 10:32:44 m82 kernel: ACPI: IOAPIC (id[0x04] address[0xfec80400] gsi_base[48])
Oct  4 10:32:44 m82 kernel: IOAPIC[2]: apic_id 4, version 32, address 0xfec80400, GSI 48-71
Oct  4 10:32:44 m82 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Oct  4 10:32:44 m82 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Oct  4 10:32:44 m82 kernel: Setting APIC routing to flat
Oct  4 10:32:44 m82 kernel: Using ACPI (MADT) for SMP configuration information
Oct  4 10:32:44 m82 kernel: Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
Oct  4 10:32:44 m82 kernel: Checking aperture...
Oct  4 10:32:44 m82 kernel: Built 1 zonelists
Oct  4 10:32:44 m82 kernel: Kernel command line: ro root=/dev/sda1 rhgb
Oct  4 10:32:44 m82 kernel: Initializing CPU#0
Oct  4 10:32:44 m82 kernel: PID hash table entries: 4096 (order: 12, 131072 bytes)
Oct  4 10:32:44 m82 kernel: time.c: Using 3.579545 MHz PM timer.
Oct  4 10:32:44 m82 kernel: time.c: Detected 3400.295 MHz processor.
Oct  4 10:32:44 m82 kernel: Console: colour VGA+ 80x25
Oct  4 10:32:44 m82 kernel: Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Oct  4 10:32:44 m82 kernel: Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Oct  4 10:32:44 m82 kernel: Placing software IO TLB between 0x7e5d000 - 0xbe5d000
Oct  4 10:32:44 m82 kernel: Memory: 6105160k/7340032k available (3441k kernel code, 185316k reserved, 2051k data, 224k init)
Oct  4 10:32:44 m82 kernel: Calibrating delay using timer specific routine.. 6806.66 BogoMIPS (lpj=3403331)
Oct  4 10:32:44 m82 kernel: Mount-cache hash table entries: 256
Oct  4 10:32:44 m82 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Oct  4 10:32:44 m82 kernel: CPU: L2 cache: 2048K
Oct  4 10:32:44 m82 kernel: using mwait in idle threads.
Oct  4 10:32:44 m82 kernel: CPU: Physical Processor ID: 0
Oct  4 10:32:44 m82 kernel: CPU0: Thermal monitoring enabled (TM1)
Oct  4 10:32:44 m82 kernel: mtrr: v2.0 (20020519)
Oct  4 10:32:44 m82 kernel: Using local APIC timer interrupts.
Oct  4 10:32:44 m82 kernel: Detected 12.501 MHz APIC timer.
Oct  4 10:32:44 m82 kernel: Booting processor 1/4 APIC 0x6
Oct  4 10:32:44 m82 kernel: Initializing CPU#1
Oct  4 10:32:44 m82 kernel: Calibrating delay using timer specific routine.. 6799.06 BogoMIPS (lpj=3399533)
Oct  4 10:32:44 m82 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Oct  4 10:32:44 m82 kernel: CPU: L2 cache: 2048K
Oct  4 10:32:44 m82 kernel: CPU: Physical Processor ID: 3
Oct  4 10:32:44 m82 kernel: CPU1: Thermal monitoring enabled (TM1)
Oct  4 10:32:44 m82 kernel:                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Oct  4 10:32:44 m82 kernel: CPU 1: Syncing TSC to CPU 0.
Oct  4 10:32:44 m82 kernel: CPU 1: synchronized TSC with CPU 0 (last diff -6 cycles, maxerr 1581 cycles)
Oct  4 10:32:44 m82 kernel: Booting processor 2/4 APIC 0x1
Oct  4 10:32:44 m82 kernel: Initializing CPU#2
Oct  4 10:32:44 m82 kernel: Calibrating delay using timer specific routine.. 6799.24 BogoMIPS (lpj=3399624)
Oct  4 10:32:44 m82 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Oct  4 10:32:44 m82 kernel: CPU: L2 cache: 2048K
Oct  4 10:32:44 m82 kernel: CPU: Physical Processor ID: 0
Oct  4 10:32:44 m82 kernel: CPU2: Thermal monitoring enabled (TM1)
Oct  4 10:32:44 m82 kernel:                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Oct  4 10:32:44 m82 kernel: CPU 2: Syncing TSC to CPU 0.
Oct  4 10:32:44 m82 kernel: CPU 2: synchronized TSC with CPU 0 (last diff -12 cycles, maxerr 867 cycles)
Oct  4 10:32:44 m82 kernel: Booting processor 3/4 APIC 0x7
Oct  4 10:32:44 m82 kernel: Initializing CPU#3
Oct  4 10:32:44 m82 kernel: Calibrating delay using timer specific routine.. 6799.42 BogoMIPS (lpj=3399711)
Oct  4 10:32:44 m82 kernel: CPU: Trace cache: 12K uops, L1 D cache: 16K
Oct  4 10:32:44 m82 kernel: CPU: L2 cache: 2048K
Oct  4 10:32:44 m82 kernel: CPU: Physical Processor ID: 3
Oct  4 10:32:44 m82 kernel: CPU3: Thermal monitoring enabled (TM1)
Oct  4 10:32:44 m82 kernel:                   Intel(R) Xeon(TM) CPU 3.40GHz stepping 03
Oct  4 10:32:44 m82 kernel: CPU 3: Syncing TSC to CPU 0.
Oct  4 10:32:44 m82 kernel: CPU 3: synchronized TSC with CPU 0 (last diff 77 cycles, maxerr 1581 cycles)
Oct  4 10:32:44 m82 kernel: Brought up 4 CPUs
Oct  4 10:32:44 m82 kernel: time.c: Using PIT/TSC based timekeeping.
Oct  4 10:32:44 m82 kernel: testing NMI watchdog ... OK.
Oct  4 10:32:44 m82 kernel: NET: Registered protocol family 16
Oct  4 10:32:44 m82 kernel: ACPI: bus type pci registered
Oct  4 10:32:44 m82 kernel: PCI: Using configuration type 1
Oct  4 10:32:44 m82 kernel: PCI: Using MMCONFIG at e0000000
Oct  4 10:32:44 m82 kernel: ACPI: Subsystem revision 20050902
Oct  4 10:32:44 m82 kernel: ACPI: Interpreter enabled
Oct  4 10:32:44 m82 kernel: ACPI: Using IOAPIC for interrupt routing
Oct  4 10:32:44 m82 kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Oct  4 10:32:44 m82 kernel: PCI: Probing PCI hardware (bus 00)
Oct  4 10:32:44 m82 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Oct  4 10:32:44 m82 kernel: PCI: PXH quirk detected, disabling MSI for SHPC device
Oct  4 10:32:44 m82 kernel: PCI: PXH quirk detected, disabling MSI for SHPC device
Oct  4 10:32:44 m82 kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct  4 10:32:44 m82 kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
Oct  4 10:32:44 m82 kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
Oct  4 10:32:44 m82 kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 14 15)
Oct  4 10:32:44 m82 kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
Oct  4 10:32:44 m82 kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
Oct  4 10:32:44 m82 kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *0, disabled.
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
Oct  4 10:32:45 m82 kernel: ACPI: Device [PRT] status [0000000c]: functional but not present; setting present
Oct  4 10:32:45 m82 kernel: SCSI subsystem initialized
Oct  4 10:32:45 m82 kernel: usbcore: registered new driver usbfs
Oct  4 10:32:45 m82 kernel: usbcore: registered new driver hub
Oct  4 10:32:45 m82 kernel: PCI: Using ACPI for IRQ routing
Oct  4 10:32:45 m82 kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Oct  4 10:32:45 m82 kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Oct  4 10:32:45 m82 kernel: PCI: Bridge: 0000:01:00.0
Oct  4 10:32:45 m82 kernel:   IO window: 2000-2fff
Oct  4 10:32:45 m82 kernel:   MEM window: dd200000-dd2fffff
Oct  4 10:32:45 m82 kernel:   PREFETCH window: c2000000-c20fffff
Oct  4 10:32:45 m82 kernel: PCI: Bridge: 0000:01:00.2
Oct  4 10:32:45 m82 kernel:   IO window: 3000-3fff
Oct  4 10:32:45 m82 kernel:   MEM window: dd300000-dd3fffff
Oct  4 10:32:45 m82 kernel:   PREFETCH window: disabled.
Oct  4 10:32:45 m82 kernel: PCI: Bridge: 0000:00:02.0
Oct  4 10:32:45 m82 kernel:   IO window: 2000-3fff
Oct  4 10:32:45 m82 kernel:   MEM window: dd100000-dd3fffff
Oct  4 10:32:45 m82 kernel:   PREFETCH window: c2000000-c20fffff
Oct  4 10:32:45 m82 kernel: PCI: Bridge: 0000:00:04.0
Oct  4 10:32:45 m82 kernel:   IO window: disabled.
Oct  4 10:32:45 m82 kernel:   MEM window: disabled.
Oct  4 10:32:45 m82 kernel:   PREFETCH window: disabled.
Oct  4 10:32:45 m82 kernel: PCI: Bridge: 0000:00:06.0
Oct  4 10:32:45 m82 kernel:   IO window: disabled.
Oct  4 10:32:45 m82 kernel:   MEM window: disabled.
Oct  4 10:32:45 m82 kernel:   PREFETCH window: disabled.
Oct  4 10:32:45 m82 kernel: PCI: Bridge: 0000:00:1e.0
Oct  4 10:32:45 m82 kernel:   IO window: 4000-4fff
Oct  4 10:32:45 m82 kernel:   MEM window: dd400000-deffffff
Oct  4 10:32:45 m82 kernel:   PREFETCH window: c2100000-c21fffff
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Oct  4 10:32:45 m82 kernel: Simple Boot Flag at 0x39 set to 0x1
Oct  4 10:32:45 m82 kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
Oct  4 10:32:45 m82 kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Oct  4 10:32:45 m82 kernel: audit: initializing netlink socket (disabled)
Oct  4 10:32:45 m82 kernel: audit(1128414700.536:1): initialized
Oct  4 10:32:45 m82 kernel: Total HugeTLB memory allocated, 0
Oct  4 10:32:45 m82 kernel: VFS: Disk quotas dquot_6.5.1
Oct  4 10:32:45 m82 kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Oct  4 10:32:45 m82 kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Oct  4 10:32:45 m82 kernel: Initializing Cryptographic API
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 16 (level, low) -> IRQ 169
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 16 (level, low) -> IRQ 169
Oct  4 10:32:45 m82 kernel: ACPI: Power Button (FF) [PWRF]
Oct  4 10:32:45 m82 kernel: ACPI: Power Button (CM) [PWRB]
Oct  4 10:32:45 m82 kernel: ACPI: CPU0 (power states: C1[C1])
Oct  4 10:32:45 m82 kernel: ACPI: CPU1 (power states: C1[C1])
Oct  4 10:32:45 m82 kernel: ACPI: CPU2 (power states: C1[C1])
Oct  4 10:32:45 m82 kernel: ACPI: CPU3 (power states: C1[C1])
Oct  4 10:32:45 m82 kernel: Real Time Clock Driver v1.12
Oct  4 10:32:45 m82 kernel: hw_random: RNG not detected
Oct  4 10:32:45 m82 kernel: Linux agpgart interface v0.101 (c) Dave Jones
Oct  4 10:32:45 m82 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct  4 10:32:45 m82 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct  4 10:32:45 m82 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
Oct  4 10:32:45 m82 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct  4 10:32:45 m82 kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Oct  4 10:32:45 m82 kernel: io scheduler noop registered
Oct  4 10:32:45 m82 kernel: io scheduler anticipatory registered
Oct  4 10:32:45 m82 kernel: io scheduler deadline registered
Oct  4 10:32:45 m82 kernel: io scheduler cfq registered
Oct  4 10:32:45 m82 kernel: Floppy drive(s): fd0 is 1.44M
Oct  4 10:32:45 m82 kernel: FDC 0 is a National Semiconductor PC87306
Oct  4 10:32:45 m82 kernel: loop: loaded (max 8 devices)
Oct  4 10:32:45 m82 kernel: Intel(R) PRO/1000 Network Driver - version 6.0.60-k2-NAPI
Oct  4 10:32:45 m82 kernel: Copyright (c) 1999-2005 Intel Corporation.
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 54 (level, low) -> IRQ 177
Oct  4 10:32:45 m82 kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:03:02.1[B] -> GSI 55 (level, low) -> IRQ 185
Oct  4 10:32:45 m82 kernel: e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Oct  4 10:32:45 m82 kernel: tun: Universal TUN/TAP device driver, 1.6
Oct  4 10:32:45 m82 kernel: tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Oct  4 10:32:45 m82 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct  4 10:32:45 m82 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct  4 10:32:45 m82 kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 193
Oct  4 10:32:45 m82 kernel: ICH5: chipset revision 2
Oct  4 10:32:45 m82 kernel: ICH5: not 100% native mode: will probe irqs later
Oct  4 10:32:45 m82 kernel:     ide0: BM-DMA at 0x14a0-0x14a7, BIOS settings: hda:pio, hdb:pio
Oct  4 10:32:45 m82 kernel:     ide1: BM-DMA at 0x14a8-0x14af, BIOS settings: hdc:pio, hdd:DMA
Oct  4 10:32:45 m82 kernel: hdd: MATSHITADVD-ROM SR-8178, ATAPI CD/DVD-ROM drive
Oct  4 10:32:45 m82 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct  4 10:32:45 m82 kernel: hdd: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(33)
Oct  4 10:32:45 m82 kernel: Uniform CD-ROM driver Revision: 3.20
Oct  4 10:32:45 m82 kernel: ide-floppy driver 0.99.newide
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:02:02.0[A] -> GSI 32 (level, low) -> IRQ 201
Oct  4 10:32:45 m82 kernel: scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
Oct  4 10:32:45 m82 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Oct  4 10:32:45 m82 kernel:         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Oct  4 10:32:45 m82 kernel: 
Oct  4 10:32:45 m82 kernel:   Vendor: SEAGATE   Model: ST373207LC        Rev: 0003
Oct  4 10:32:45 m82 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Oct  4 10:32:45 m82 kernel:  target0:0:0: asynchronous.
Oct  4 10:32:45 m82 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
Oct  4 10:32:45 m82 kernel:  target0:0:0: Beginning Domain Validation
Oct  4 10:32:45 m82 kernel:  target0:0:0: wide asynchronous.
Oct  4 10:32:45 m82 kernel:  target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
Oct  4 10:32:45 m82 kernel:  target0:0:0: Ending Domain Validation
Oct  4 10:32:45 m82 kernel:   Vendor: SUPER     Model: GEM318            Rev: 0   
Oct  4 10:32:45 m82 kernel:   Type:   Processor                          ANSI SCSI revision: 02
Oct  4 10:32:45 m82 kernel:  target0:0:6: asynchronous.
Oct  4 10:32:45 m82 kernel:  target0:0:6: Beginning Domain Validation
Oct  4 10:32:45 m82 kernel:  target0:0:6: Ending Domain Validation
Oct  4 10:32:45 m82 kernel: ACPI: PCI Interrupt 0000:02:02.1[B] -> GSI 33 (level, low) -> IRQ 209
Oct  4 10:32:45 m82 kernel: scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
Oct  4 10:32:45 m82 kernel:         <Adaptec AIC7902 Ultra320 SCSI adapter>
Oct  4 10:32:45 m82 kernel:         aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs
Oct  4 10:32:45 m82 kernel: 
Oct  4 10:32:46 m82 kernel:   Vendor: VP-1252-  Model: FB951223-VOL#00   Rev: R001
Oct  4 10:32:46 m82 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Oct  4 10:32:46 m82 kernel:  target1:0:0: asynchronous.
Oct  4 10:32:46 m82 kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 4
Oct  4 10:32:46 m82 kernel:  target1:0:0: Beginning Domain Validation
Oct  4 10:32:46 m82 kernel:  target1:0:0: wide asynchronous.
Oct  4 10:32:46 m82 kernel:  target1:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
Oct  4 10:32:46 m82 kernel:  target1:0:0: Ending Domain Validation
Oct  4 10:32:46 m82 kernel:   Vendor: VP-1252-  Model: FB951223-VOL#01   Rev: R001
Oct  4 10:32:46 m82 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Oct  4 10:32:46 m82 kernel: scsi1:A:0:1: Tagged Queuing enabled.  Depth 4
Oct  4 10:32:46 m82 kernel: st: Version 20050830, fixed bufsize 32768, s/g segs 256
Oct  4 10:32:46 m82 kernel: SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Oct  4 10:32:46 m82 kernel: SCSI device sda: drive cache: write back
Oct  4 10:32:46 m82 kernel: SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Oct  4 10:32:46 m82 kernel: SCSI device sda: drive cache: write back
Oct  4 10:32:46 m82 kernel:  sda: sda1 sda2 sda3 sda4
Oct  4 10:32:46 m82 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Oct  4 10:32:46 m82 kernel: SCSI device sdb: 3906247680 512-byte hdwr sectors (1999999 MB)
Oct  4 10:32:46 m82 kernel: SCSI device sdb: drive cache: write back
Oct  4 10:32:46 m82 kernel: SCSI device sdb: 3906247680 512-byte hdwr sectors (1999999 MB)
Oct  4 10:32:46 m82 kernel: SCSI device sdb: drive cache: write back
Oct  4 10:32:46 m82 kernel:  sdb: sdb1
Oct  4 10:32:46 m82 kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Oct  4 10:32:46 m82 kernel: SCSI device sdc: 3906242560 512-byte hdwr sectors (1999996 MB)
Oct  4 10:32:46 m82 kernel: SCSI device sdc: drive cache: write back
Oct  4 10:32:46 m82 kernel: SCSI device sdc: 3906242560 512-byte hdwr sectors (1999996 MB)
Oct  4 10:32:46 m82 kernel: SCSI device sdc: drive cache: write back
Oct  4 10:32:46 m82 kernel:  sdc: sdc1
Oct  4 10:32:46 m82 kernel: Attached scsi disk sdc at scsi1, channel 0, id 0, lun 1
Oct  4 10:32:46 m82 kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Oct  4 10:32:46 m82 kernel: Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 3
Oct  4 10:32:46 m82 kernel: Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
Oct  4 10:32:46 m82 kernel: Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 1,  type 0
Oct  4 10:32:47 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 217
Oct  4 10:32:48 m82 kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Oct  4 10:32:48 m82 kernel: ehci_hcd 0000:00:1d.7: debug port 1
Oct  4 10:32:48 m82 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Oct  4 10:32:48 m82 kernel: ehci_hcd 0000:00:1d.7: irq 217, io mem 0xdd000000
Oct  4 10:32:48 m82 kernel: ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
Oct  4 10:32:48 m82 kernel: hub 1-0:1.0: USB hub found
Oct  4 10:32:48 m82 kernel: hub 1-0:1.0: 8 ports detected
Oct  4 10:32:48 m82 kernel: USB Universal Host Controller Interface driver v2.3
Oct  4 10:32:48 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.0: irq 169, io base 0x00001400
Oct  4 10:32:48 m82 kernel: hub 2-0:1.0: USB hub found
Oct  4 10:32:48 m82 kernel: hub 2-0:1.0: 2 ports detected
Oct  4 10:32:48 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 225
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.1: irq 225, io base 0x00001420
Oct  4 10:32:48 m82 kernel: hub 3-0:1.0: USB hub found
Oct  4 10:32:48 m82 kernel: hub 3-0:1.0: 2 ports detected
Oct  4 10:32:48 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 193
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.2: irq 193, io base 0x00001440
Oct  4 10:32:48 m82 kernel: hub 4-0:1.0: USB hub found
Oct  4 10:32:48 m82 kernel: hub 4-0:1.0: 2 ports detected
Oct  4 10:32:48 m82 kernel: ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 169
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Oct  4 10:32:48 m82 kernel: uhci_hcd 0000:00:1d.3: irq 169, io base 0x00001460
Oct  4 10:32:48 m82 kernel: hub 5-0:1.0: USB hub found
Oct  4 10:32:48 m82 kernel: hub 5-0:1.0: 2 ports detected
Oct  4 10:32:48 m82 kernel: Initializing USB Mass Storage driver...
Oct  4 10:32:48 m82 kernel: usbcore: registered new driver usb-storage
Oct  4 10:32:48 m82 kernel: USB Mass Storage support registered.
Oct  4 10:32:48 m82 kernel: usbcore: registered new driver hiddev
Oct  4 10:32:48 m82 kernel: usbcore: registered new driver usbhid
Oct  4 10:32:48 m82 kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Oct  4 10:32:48 m82 kernel: mice: PS/2 mouse device common for all mice
Oct  4 10:32:48 m82 kernel: i2c /dev entries driver
Oct  4 10:32:48 m82 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct  4 10:32:48 m82 kernel: i2c_adapter i2c-0: Unsupported chip (man_id=0x01, chip_id=0x73).
Oct  4 10:32:48 m82 kernel: i2c_adapter i2c-0: detect fail: address match, 0x2e
Oct  4 10:32:49 m82 kernel: hdaps: supported laptop not found!
Oct  4 10:32:49 m82 kernel: hdaps: driver init failed (ret=-6)!
Oct  4 10:32:49 m82 kernel: Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6eb1, caps: 0xa84793/0x554755
Oct  4 10:32:49 m82 kernel: serio: Synaptics pass-through port at isa0060/serio1/input0
Oct  4 10:32:49 m82 kernel: input: SynPS/2 Synaptics TouchPad on isa0060/serio1
Oct  4 10:32:49 m82 kernel: pc87360: PC8736x not detected, module not inserted.
Oct  4 10:32:49 m82 kernel: NET: Registered protocol family 2
Oct  4 10:32:49 m82 kernel: IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
Oct  4 10:32:49 m82 kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Oct  4 10:32:49 m82 kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Oct  4 10:32:49 m82 kernel: TCP: Hash tables configured (established 262144 bind 65536)
Oct  4 10:32:49 m82 kernel: TCP reno registered
Oct  4 10:32:49 m82 kernel: ip_conntrack version 2.3 (8192 buckets, 65536 max) - 344 bytes per conntrack
Oct  4 10:32:49 m82 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct  4 10:32:49 m82 kernel: ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Oct  4 10:32:49 m82 kernel: ClusterIP Version 0.8 loaded successfully
Oct  4 10:32:49 m82 kernel: arp_tables: (C) 2002 David S. Miller
Oct  4 10:32:49 m82 kernel: TCP bic registered
Oct  4 10:32:49 m82 kernel: Initializing IPsec netlink socket
Oct  4 10:32:49 m82 kernel: NET: Registered protocol family 1
Oct  4 10:32:49 m82 kernel: NET: Registered protocol family 17
Oct  4 10:32:49 m82 kernel: NET: Registered protocol family 15
Oct  4 10:32:49 m82 kernel: ReiserFS: sda1: found reiserfs format "3.6" with standard journal
Oct  4 10:32:49 m82 kernel: ReiserFS: sda1: using ordered data mode
Oct  4 10:32:49 m82 kernel: ReiserFS: sda1: journal params: device sda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct  4 10:32:49 m82 kernel: ReiserFS: sda1: checking transaction log (sda1)
Oct  4 10:32:49 m82 kernel: ReiserFS: sda1: Using r5 hash to sort names
Oct  4 10:32:49 m82 kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Oct  4 10:32:49 m82 kernel: Freeing unused kernel memory: 224k freed
Oct  4 10:32:49 m82 kernel: kmodule[1398]: segfault at ffffffffffffffff rip 0000003257d70313 rsp 00007fffffc4c288 error 4
Oct  4 10:32:49 m82 kernel: ReiserFS: sda4: found reiserfs format "3.6" with standard journal
Oct  4 10:32:49 m82 kernel: ReiserFS: sda4: using ordered data mode
Oct  4 10:32:49 m82 kernel: ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct  4 10:32:49 m82 kernel: ReiserFS: sda4: checking transaction log (sda4)
Oct  4 10:32:49 m82 kernel: ReiserFS: sda4: Using r5 hash to sort names
Oct  4 10:32:49 m82 kernel: ReiserFS: sda2: found reiserfs format "3.6" with standard journal
Oct  4 10:32:49 m82 kernel: ReiserFS: sda2: using ordered data mode
Oct  4 10:32:49 m82 kernel: ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct  4 10:32:49 m82 kernel: ReiserFS: sda2: checking transaction log (sda2)
Oct  4 10:32:49 m82 kernel: ReiserFS: sda2: Using r5 hash to sort names
Oct  4 10:32:49 m82 kernel: Adding 1959920k swap on /dev/sda3.  Priority:-1 extents:1 across:1959920k
Oct  4 10:32:49 m82 kernel: e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
Oct  4 10:34:41 m82 kernel: ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
Oct  4 10:35:25 m82 kernel: ReiserFS: sdb1: using ordered data mode
Oct  4 10:35:25 m82 kernel: ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct  4 10:35:25 m82 kernel: ReiserFS: sdb1: checking transaction log (sdb1)
Oct  4 10:35:25 m82 kernel: ReiserFS: sdb1: Using r5 hash to sort names
Oct  4 10:35:39 m82 kernel: ReiserFS: sdc1: found reiserfs format "3.6" with standard journal
Oct  4 10:36:26 m82 kernel: ReiserFS: sdc1: using ordered data mode
Oct  4 10:36:26 m82 kernel: ReiserFS: sdc1: journal params: device sdc1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct  4 10:36:26 m82 kernel: ReiserFS: sdc1: checking transaction log (sdc1)
Oct  4 10:36:26 m82 kernel: ReiserFS: sdc1: Using r5 hash to sort names
