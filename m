Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757484AbWK0I6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757484AbWK0I6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757488AbWK0I6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:58:20 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:44356 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1757484AbWK0I6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:58:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=APY53IIS3O3OGYqMJWBtDZvCWDgYhCiuZu6wjq+W6+eJb71RaogcFdl5Tau910WJD+r5SgsW1cX9XO6nCFCjmcPsM0ekqKB72W60ujPchxMjtd8L24BY6DZStqEk3tvfT9bw5JFpoe8U+uTTCM93m0vqXPCl8g2iQjq9lat/luE=
Message-ID: <456AA89C.909@gmail.com>
Date: Mon, 27 Nov 2006 01:58:04 -0700
From: "Berck E. Nash" <flyboy@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061124)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org>
In-Reply-To: <20061127033550.GB11250@htj.dyndns.org>
Content-Type: multipart/mixed;
 boundary="------------090208070805070006070002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208070805070006070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:

> Yeah, I did and forgot about this thread too.  Sorry.  This is on the
> top of my to-do list now.  I'm attaching the patch.  TIA.

That didn't fix the problem, but did change the messages.  I've attached 
the entire log, including the weird errors on power-off from the same 
device that gives problems on boot, which I suspect are related.

Berck

--------------090208070805070006070002
Content-Type: text/plain;
 name="ahcilog"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ahcilog"

[    0.000000] Linux version 2.6.19-rc6-mm1 (root@luna) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)) #3 SMP PREEMPT Sun Nov 26 21:25:59 MST 2006
[    0.000000] Command line: root=/dev/sdc1 ro console=tty0 console=ttyS0,115200n8 BOOT_IMAGE=vmlinuz
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
[    0.000000]  BIOS-e820: 000000003ff80000 - 000000003ff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003ff8e000 - 000000003ffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003ffe0000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.4 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   262016
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bfb00000)
[    0.000000] PERCPU: Allocating 32512 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 257375
[    0.000000] Kernel command line: root=/dev/sdc1 ro console=tty0 console=ttyS0,115200n8 BOOT_IMAGE=vmlinuz
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   57.369381] Console: colour VGA+ 80x25
[   57.632610] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   57.639997] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   57.646956] Checking aperture...
[   57.657752] Memory: 1027700k/1048064k available (2281k kernel code, 19860k reserved, 999k data, 196k init)
[   57.726521] Calibrating delay using timer specific routine.. 5800.15 BogoMIPS (lpj=2900075)
[   57.734992] Mount-cache hash table entries: 256
[   57.739636] CPU: L1 I cache: 32K, L1 D cache: 32K
[   57.744433] CPU: L2 cache: 2048K
[   57.747699] using mwait in idle threads.
[   57.751657] CPU: Physical Processor ID: 0
[   57.755701] CPU: Processor Core ID: 0
[   57.759400] CPU0: Thermal monitoring enabled (TM2)
[   57.764238] Freeing SMP alternatives: 24k freed
[   57.768811] ACPI: Core revision 20060707
[   57.797724] Using local APIC timer interrupts.
[   57.836680] result 25877185
[   57.839512] Detected 25.877 MHz APIC timer.
[   57.844463] Booting processor 1/2 APIC 0x1
[   57.858937] Initializing CPU#1
[   57.919341] Calibrating delay using timer specific routine.. 5796.44 BogoMIPS (lpj=2898222)
[   57.919345] CPU: L1 I cache: 32K, L1 D cache: 32K
[   57.919346] CPU: L2 cache: 2048K
[   57.919348] CPU: Physical Processor ID: 0
[   57.919348] CPU: Processor Core ID: 1
[   57.919352] CPU1: Thermal monitoring enabled (TM2)
[   57.919543] Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 06
[   57.920346] Brought up 2 CPUs
[   57.962055] testing NMI watchdog ... OK.
[   57.996481] time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
[   58.003041] time.c: Detected 2898.247 MHz processor.
[   58.095698] migration_cost=22
[   58.099005] NET: Registered protocol family 16
[   58.103489] wait_for_probes: waiting for 0 threads
[   58.108353] wait_for_probes: waiting for 0 threads
[   58.113184] ACPI: bus type pci registered
[   58.117236] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
[   58.123713] PCI: Not using MMCONFIG.
[   58.127328] PCI: Using configuration type 1
[   58.131544] wait_for_probes: waiting for 0 threads
[   58.144443] ACPI: Interpreter enabled
[   58.148145] ACPI: Using IOAPIC for interrupt routing
[   58.153867] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   58.159174] PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
[   58.165654] PCI quirk: region 0480-04bf claimed by ICH6 GPIO
[   58.171805] PCI: Transparent bridge - 0000:00:1e.0
[   58.183676] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   58.191454] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[   58.199230] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
[   58.207003] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   58.214779] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   58.222892] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   58.230668] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   58.238444] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   58.246113] Linux Plug and Play Support v0.97 (c) Adam Belay
[   58.251804] pnp: PnP ACPI init
[   58.257367] pnp: PnP ACPI: found 15 devices
[   58.261613] intel_rng: FWH not detected
[   58.265571] SCSI subsystem initialized
[   58.269400] PCI: Using ACPI for IRQ routing
[   58.273619] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   58.281970] wait_for_probes: waiting for 0 threads
[   58.286792] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   58.291874] hpet0: 3 64-bit timers, 14318180 Hz
[   58.297442] PCI-GART: No AMD northbridge found.
[   58.302523] pnp: 00:07: ioport range 0x290-0x297 has been reserved
[   58.308910] PCI: Bridge: 0000:00:01.0
[   58.312610]   IO window: disabled.
[   58.316047]   MEM window: faa00000-feafffff
[   58.320263]   PREFETCH window: cff00000-efefffff
[   58.324915] PCI: Bridge: 0000:00:1c.0
[   58.328610]   IO window: disabled.
[   58.332050]   MEM window: disabled.
[   58.335573]   PREFETCH window: cfe00000-cfefffff
[   58.340226] PCI: Bridge: 0000:00:1c.3
[   58.343919]   IO window: c000-cfff
[   58.347359]   MEM window: fa900000-fa9fffff
[   58.351575]   PREFETCH window: disabled.
[   58.355533] PCI: Bridge: 0000:00:1e.0
[   58.359229]   IO window: b000-bfff
[   58.362668]   MEM window: fa700000-fa8fffff
[   58.366885]   PREFETCH window: 50000000-500fffff
[   58.371541] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   58.379035] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   58.386523] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   58.394027] NET: Registered protocol family 2
[   58.410079] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   58.417339] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[   58.425423] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   58.432657] TCP: Hash tables configured (established 131072 bind 65536)
[   58.439300] TCP reno registered
[   58.446108] wait_for_probes: waiting for 0 threads
[   58.451398] audit: initializing netlink socket (disabled)
[   58.456838] audit(1164581690.592:1): initialized
[   58.466875] Loading Reiser4. See www.namesys.com for a description of Reiser4.
[   58.474192] io scheduler noop registered
[   58.478542] io scheduler anticipatory registered (default)
[   58.484336] assign_interrupt_mode Found MSI capability
[   58.489590] assign_interrupt_mode Found MSI capability
[   58.494852] assign_interrupt_mode Found MSI capability
[   58.500163] input: Power Button (FF) as /class/input/input0
[   58.505766] ACPI: Power Button (FF) [PWRF]
[   58.509935] input: Power Button (CM) as /class/input/input1
[   58.515541] ACPI: Power Button (CM) [PWRB]
[   58.519974] ACPI: Processor [CPU1] (supports 8 throttling states)
[   58.526417] ACPI: Processor [CPU2] (supports 8 throttling states)
[   58.532636] ACPI: Getting cpuindex for acpiid 0x3
[   58.537377] ACPI: Getting cpuindex for acpiid 0x4
[   58.543441] Real Time Clock Driver v1.12ac
[   58.547651] Linux agpgart interface v0.101 (c) Dave Jones
[   58.553087] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   58.561039] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   58.567369] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   58.573106] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   58.579491] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   58.587557] ICH7: IDE controller at PCI slot 0000:00:1f.1
[   58.592994] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
[   58.600476] ICH7: chipset revision 1
[   58.604083] ICH7: not 100% native mode: will probe irqs later
[   58.609868]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
[   58.617226]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio<7>Losing some ticks... checking if CPU frequency changed.
[   58.629616] 
[   59.303006] hda: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
[   60.022548] hdb: _NEC DVD_RW ND-3520AW, ATAPI CD/DVD-ROM drive
[   60.082411] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   60.605720] SiI680: IDE controller at PCI slot 0000:01:00.0
[   60.611332] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 21 (level, low) -> IRQ 21
[   60.618815] SiI680: chipset revision 2
[   60.622608] SiI680: BASE CLOCK == 133
[   60.626351] SiI680: 100% native mode on irq 21
[   60.630835]     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
[   60.636968]     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
[   60.908838] hde: SAMSUNG WN316025A (1.6 GB), ATA DISK drive
[   61.525676] ide2 at 0xffffc20000006c80-0xffffc20000006c87,0xffffc20000006c8a on irq 21
[   61.797585] hdg: MAXTOR 6L040J2, ATA DISK drive
[   62.413451] ide3 at 0xffffc20000006cc0-0xffffc20000006cc7,0xffffc20000006cca on irq 21
[   62.421565] hde: max request size: 64KiB
[   62.425521] hde: 3145968 sectors (1610 MB) w/109KiB Cache, CHS=3121/16/63, DMA
[   62.432984]  hde: hde1
[   62.448439] hdg: max request size: 64KiB
[   62.453350] hdg: 78198750 sectors (40037 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(133)
[   62.461826] hdg: cache flushes supported
[   62.465792]  hdg: hdg1
[   62.484633] hda: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   62.491607] Uniform CD-ROM driver Revision: 3.20
[   62.535733] hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[   62.556615] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 22
[   62.564736] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
[   62.572472] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   62.578688] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   62.587929] serio: i8042 KBD port at 0x60,0x64 irq 1
[   62.592943] serio: i8042 AUX port at 0x60,0x64 irq 12
[   62.598095] mice: PS/2 mouse device common for all mice
[   62.603362] EDAC MC: Ver: 2.0.1 Nov 25 2006
[   62.607686] TCP cubic registered
[   62.610950] Initializing XFRM netlink socket
[   62.615263] NET: Registered protocol family 1
[   62.619657] NET: Registered protocol family 17
[   62.624147] NET: Registered protocol family 15
[   62.628628] wait_for_probes: waiting for 3 threads
[   62.636844] input: AT Translated Set 2 keyboard as /class/input/input2
[   62.773700] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   62.773701]         <Adaptec 2940 Ultra2 SCSI adapter>
[   62.773702]         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   62.773702] 
[   63.054114] scsi 0:0:1:0: Direct-Access     IBM-PCCO ST39102LC     !# B219 PQ: 0 ANSI: 2
[   63.062248] scsi0:A:1:0: Tagged Queuing enabled.  Depth 8
[   63.067731]  target0:0:1: Beginning Domain Validation
[   63.079230]  target0:0:1: wide asynchronous
[   63.088137]  target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
[   63.099356]  target0:0:1: Domain Validation skipping write tests
[   63.105399]  target0:0:1: Ending Domain Validation
[   63.113209] scsi 0:0:2:0: Direct-Access     SGI      SEAGATE ST39102L 2702 PQ: 0 ANSI: 2
[   63.121334] scsi0:A:2:0: Tagged Queuing enabled.  Depth 8
[   63.126818]  target0:0:2: Beginning Domain Validation
[   63.137168]  target0:0:2: wide asynchronous
[   63.145241]  target0:0:2: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
[   63.155644]  target0:0:2: Domain Validation skipping write tests
[   63.161682]  target0:0:2: Ending Domain Validation
[   63.577105] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[   63.585232] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[   63.592092] ata1: SATA max UDMA/133 cmd 0xFFFFC2000000E900 ctl 0x0 bmdma 0x0 irq 316
[   63.599913] ata2: SATA max UDMA/133 cmd 0xFFFFC2000000E980 ctl 0x0 bmdma 0x0 irq 316
[   63.607731] ata3: SATA max UDMA/133 cmd 0xFFFFC2000000EA00 ctl 0x0 bmdma 0x0 irq 316
[   63.615549] ata4: SATA max UDMA/133 cmd 0xFFFFC2000000EA80 ctl 0x0 bmdma 0x0 irq 316
[   63.623332] scsi1 : ahci
[   63.927590] SATA PHY: stable DET=3
[   64.031995] SATA PHY: stable DET=3
[   64.136570] SATA PHY: stable DET=3
[   64.241067] SATA PHY: stable DET=3
[   64.344525] SATA PHY: stable DET=3
[   64.449101] SATA PHY: stable DET=3
[   64.553506] SATA PHY: stable DET=3
[   64.658081] SATA PHY: stable DET=3
[   64.762552] SATA PHY: stable DET=3
[   64.866036] SATA PHY: stable DET=3
[   64.970612] SATA PHY: stable DET=3
[   65.075017] SATA PHY: stable DET=3
[   65.179592] SATA PHY: stable DET=3
[   65.284037] SATA PHY: stable DET=3
[   65.387534] SATA PHY: stable DET=3
[   65.492109] SATA PHY: stable DET=3
[   65.596515] SATA PHY: stable DET=3
[   65.701089] SATA PHY: stable DET=3
[   65.805534] SATA PHY: stable DET=3
[   65.909045] SATA PHY: stable DET=3
[   65.912479] SATA PHY: debounced
[   66.070326] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   66.083463] ata1.00: ATA-6, max UDMA/133, 72303840 sectors: LBA48 
[   66.089681] ata1.00: ata1: dev 0 multi count 16
[   66.102173] ata1.00: configured for UDMA/133
[   66.106487] scsi2 : ahci
[   66.240954] SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
[   66.249392] sda: Write Protect is off
[   66.254682] SCSI device sda: write cache: enabled, read cache: enabled, supports DPO and FUA
[   66.263935] SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
[   66.272374] sda: Write Protect is off
[   66.277646] SCSI device sda: write cache: enabled, read cache: enabled, supports DPO and FUA
[   66.286123]  sda: sda1 sda2
[   66.295437] sd 0:0:1:0: Attached scsi disk sda
[   66.299945] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   66.306160] SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
[   66.316003] sdb: Write Protect is off
[   66.323489] SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO and FUA
[   66.332780] SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
[   66.342624] sdb: Write Protect is off
[   66.350085] SCSI device sdb: write cache: enabled, read cache: enabled, supports DPO and FUA
[   66.358564]  sdb: sdb1
[   66.367085] sd 0:0:2:0: Attached scsi disk sdb
[   66.371597] sd 0:0:2:0: Attached scsi generic sg1 type 0
[   66.413576] SATA PHY: stable DET=3
[   66.518137] SATA PHY: stable DET=3
[   66.622543] SATA PHY: stable DET=3
[   66.727118] SATA PHY: stable DET=3
[   66.831523] SATA PHY: stable DET=3
[   66.936098] SATA PHY: stable DET=3
[   67.040660] SATA PHY: stable DET=3
[   67.145065] SATA PHY: stable DET=3
[   67.249640] SATA PHY: stable DET=3
[   67.354046] SATA PHY: stable DET=3
[   67.458621] SATA PHY: stable DET=3
[   67.563183] SATA PHY: stable DET=3
[   67.667589] SATA PHY: stable DET=3
[   67.772164] SATA PHY: stable DET=3
[   67.876570] SATA PHY: stable DET=3
[   67.981144] SATA PHY: stable DET=3
[   68.085707] SATA PHY: stable DET=3
[   68.190099] SATA PHY: stable DET=3
[   68.294674] SATA PHY: stable DET=3
[   68.404075] SATA PHY: stable DET=3
[   68.407512] SATA PHY: debounced
[   68.565486] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   98.544548] ata2.00: qc timeout (cmd 0xec)
[   98.548679] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[   99.358514] SATA PHY: stable DET=3
[   99.463089] SATA PHY: stable DET=3
[   99.567495] SATA PHY: stable DET=3
[   99.672070] SATA PHY: stable DET=3
[   99.776515] SATA PHY: stable DET=3
[   99.880026] SATA PHY: stable DET=3
[   99.984601] SATA PHY: stable DET=3
[  100.089006] SATA PHY: stable DET=3
[  100.193581] SATA PHY: stable DET=3
[  100.298013] SATA PHY: stable DET=3
[  100.401537] SATA PHY: stable DET=3
[  100.506112] SATA PHY: stable DET=3
[  100.610517] SATA PHY: stable DET=3
[  100.715092] SATA PHY: stable DET=3
[  100.819511] SATA PHY: stable DET=3
[  100.924060] SATA PHY: stable DET=3
[  101.028635] SATA PHY: stable DET=3
[  101.133040] SATA PHY: stable DET=3
[  101.237615] SATA PHY: stable DET=3
[  101.342034] SATA PHY: stable DET=3
[  101.345474] SATA PHY: debounced
[  108.385331] ata2: port is slow to respond, please be patient (Status 0x80)
[  131.326177] ata2: port failed to respond (30 secs, Status 0x80)
[  131.332131] ata2: COMRESET failed (device not ready)
[  131.337127] ata2: hardreset failed, retrying in 5 secs
[  136.642653] SATA PHY: stable DET=3
[  136.747228] SATA PHY: stable DET=3
[  136.851699] SATA PHY: stable DET=3
[  136.955170] SATA PHY: stable DET=3
[  137.059746] SATA PHY: stable DET=3
[  137.164151] SATA PHY: stable DET=3
[  137.268726] SATA PHY: stable DET=3
[  137.373184] SATA PHY: stable DET=3
[  137.476682] SATA PHY: stable DET=3
[  137.581257] SATA PHY: stable DET=3
[  137.685662] SATA PHY: stable DET=3
[  137.790237] SATA PHY: stable DET=3
[  137.894682] SATA PHY: stable DET=3
[  137.998193] SATA PHY: stable DET=3
[  138.102768] SATA PHY: stable DET=3
[  138.207173] SATA PHY: stable DET=3
[  138.311748] SATA PHY: stable DET=3
[  138.416180] SATA PHY: stable DET=3
[  138.519704] SATA PHY: stable DET=3
[  138.624279] SATA PHY: stable DET=3
[  138.627716] SATA PHY: debounced
[  138.630908] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  138.641746] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA 
[  138.647349] ata2.00: ata2: dev 0 multi count 1
[  138.656446] ata2.00: configured for UDMA/133
[  138.660753] scsi3 : ahci
[  138.964628] SATA PHY: stable DET=3
[  139.069190] SATA PHY: stable DET=3
[  139.173752] SATA PHY: stable DET=3
[  139.278157] SATA PHY: stable DET=3
[  139.382733] SATA PHY: stable DET=3
[  139.487138] SATA PHY: stable DET=3
[  139.591713] SATA PHY: stable DET=3
[  139.696275] SATA PHY: stable DET=3
[  139.800681] SATA PHY: stable DET=3
[  139.905256] SATA PHY: stable DET=3
[  140.009661] SATA PHY: stable DET=3
[  140.114237] SATA PHY: stable DET=3
[  140.218799] SATA PHY: stable DET=3
[  140.323204] SATA PHY: stable DET=3
[  140.427779] SATA PHY: stable DET=3
[  140.532185] SATA PHY: stable DET=3
[  140.636760] SATA PHY: stable DET=3
[  140.741322] SATA PHY: stable DET=3
[  140.845727] SATA PHY: stable DET=3
[  140.950302] SATA PHY: stable DET=3
[  140.953737] SATA PHY: debounced
[  141.111543] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  141.123065] ata3.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
[  141.130844] ata3.00: ata3: dev 0 multi count 16
[  141.140769] ata3.00: configured for UDMA/133
[  141.145078] scsi4 : ahci
[  141.449052] SATA PHY: stable DET=0
[  141.553626] SATA PHY: stable DET=0
[  141.658032] SATA PHY: stable DET=0
[  141.762607] SATA PHY: stable DET=0
[  141.867052] SATA PHY: stable DET=0
[  141.970563] SATA PHY: stable DET=0
[  142.075138] SATA PHY: stable DET=0
[  142.179543] SATA PHY: stable DET=0
[  142.284118] SATA PHY: stable DET=0
[  142.388550] SATA PHY: stable DET=0
[  142.492074] SATA PHY: stable DET=0
[  142.596649] SATA PHY: stable DET=0
[  142.701048] SATA PHY: stable DET=0
[  142.805617] SATA PHY: stable DET=0
[  142.910022] SATA PHY: stable DET=0
[  143.014584] SATA PHY: stable DET=0
[  143.119146] SATA PHY: stable DET=0
[  143.223552] SATA PHY: stable DET=0
[  143.328127] SATA PHY: stable DET=0
[  143.432532] SATA PHY: stable DET=0
[  143.435965] SATA PHY: debounced
[  143.439146] ata4: SATA link down (SStatus 0 SControl 300)
[  143.444617] scsi 1:0:0:0: Direct-Access     ATA      WDC WD360GD-00FL 31.0 PQ: 0 ANSI: 5
[  143.452786] SCSI device sdc: 72303840 512-byte hdwr sectors (37020 MB)
[  143.459353] sdc: Write Protect is off
[  143.463061] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  143.472081] SCSI device sdc: 72303840 512-byte hdwr sectors (37020 MB)
[  143.478649] sdc: Write Protect is off
[  143.482352] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  143.491347]  sdc: sdc1 sdc2
[  143.502458] sd 1:0:0:0: Attached scsi disk sdc
[  143.506968] sd 1:0:0:0: Attached scsi generic sg2 type 0
[  143.512352] scsi 2:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
[  143.520525] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  143.526313] sdd: Write Protect is off
[  143.530021] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  143.539123] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[  143.544915] sdd: Write Protect is off
[  143.548618] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  143.557700]  sdd: unknown partition table
[  143.561965] sd 2:0:0:0: Attached scsi disk sdd
[  143.566471] sd 2:0:0:0: Attached scsi generic sg3 type 0
[  143.571856] scsi 3:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
[  143.580033] SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
[  143.586770] sde: Write Protect is off
[  143.590476] SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  143.599487] SCSI device sde: 488397168 512-byte hdwr sectors (250059 MB)
[  143.606226] sde: Write Protect is off
[  143.609938] SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  143.618935]  sde: sde1 sde2
[  143.628705] sd 3:0:0:0: Attached scsi disk sde
[  143.633214] sd 3:0:0:0: Attached scsi generic sg4 type 0
[  143.638621] wait_for_probes: waiting for 0 threads
[  143.644027] reiser4: sdc1: found disk format 4.0.0.
[  144.852704] VFS: Mounted root (reiser4 filesystem) readonly.
[  144.858424] Freeing unused kernel memory: 196k freed
INIT: version 2.86 booting
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...[  147.094500] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[  147.102175] sky2 v1.10 addr 0xfa9fc000 irq 19 Yukon-EC (0xb6) rev 2
[  147.108722] sky2 eth0: addr 00:18:f3:3d:1b:06
[  147.113659] Floppy drive(s): fd0 is 1.44M
[  147.132226] FDC 0 is a post-1991 82077
[  147.140641] usbcore: registered new interface driver usbfs
[  147.146253] usbcore: registr4en1ew interface driver hub
[  147.151727] usbcore: registered new device driver usb
[  147.176300] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
[  147.194214] USB Universal Host Controller Interface driver v3.0
[  147.200314] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
[  147.205440] ACPI: PCI Interrupt 000070:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
[  147.205450] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[  147.205525] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 1
[  147.2054P] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
[  147.206118] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
[  147.206126] uhci_hcd 0000:00:1d.2: UHCI Hosodnraoeir
[  147.206158] usb usb1: new device found, idVendor=0000, idProduct=0000
[  147.206159] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.206161] usb usb1: Product: UHCI Host ContrlUer
[  147.206162] usb usb1: Manufacturer: Linux 2.6.19-rc6-mm1 uhci_hcd
[  147.206163] usb usb1: SerialNumber: 0000:00:1d.1
[  147.206204] usb usb1: configuration #1 chosen fro 21 choice
[  147.206218] hub 1-0:1.0: USB hub found
[  147.206221] hub 1-0:1.0: 2 ports detected
[  147.206233] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 2
[  147.206261] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
[  147.206292] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
[  147.206299] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[  147.206320] usb usb2: new device found, idVendor=0000, idProduct=0000
[  147.206322] usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.206323] usb usb2: Product: UHCI Host Controller
[  147.206324] usb usb2: Manufacturer: Linux 2.6.19-rc6-mm1 uhci_hcd
[  147.206326] usb usb2: SerialNumber: 0000:00:1d.2
[  147.206354] usb usb2: configuration #1 chosen from 1 choice
[  147.206367] hub 2-0:1.0: USB hub found
[  147.206370] hub 2-0:1.0: 2 ports detected
[  147.206382] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 3
[  147.206408] uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
[  147.206446] usb usb3: new device found, idVendor=0000, idProduct=0000
[  147.206447] usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.206448] usb usb3: Product: UHCI Host Controller
[  147.206450] usb usb3: Manufacturer: Linux 2.6.19-rc6-mm1 uhci_hcd
[  147.206451] usb usb3: SerialNumber: 0000:00:1d.3
[  147.206477] usb usb3: configuration #1 chosen from 1 choice
[  147.206489] hub 3-0:1.0: USB hub found
[  147.206492] hub 3-0:1.0: 2 ports detected
[  147.421598] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[  147.427070] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4
[  147.434751] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
[  147.440796] usb usb4: new device found, idVendor=0000, idProduct=0000
[  147.448538] usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.455593] usb usb4: Product: UHCI Host Controller
[  147.460591] usb usb4: Manufacturer: Linux 2.6.19-rc6-mm1 uhci_hcd
[  147.469255] usb usb4: SerialNumber: 0000:00:1d.0
[  147.474562] usb usb4: configuration #1 chosen from 1 choice
[  147.480258] hub 4-0:1.0: USB hub found
[  147.484115] hub 4-0:1.0: 2 ports detected
[  147.517639] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
[  147.525681] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[  147.531082] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[  147.538724] ehci_hcd 0000:00:1d.7: debug port 1
[  147.543386] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfebfbc00
[  147.553056] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[  147.560798] usb usb5: new device found, idVendor=0000, idProduct=0000
[  147.567356] usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.574394] usb usb5: Product: EHCI Host Controller
[  147.579382] usb usb5: Manufacturer: Linux 2.6.19-rc6-mm1 ehci_hcd
[  147.585609] usb usb5: SerialNumber: 0000:00:1d.7
[  147.590675] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
[  147.598091] usb usb5: configuration #1 chosen from 1 choice
[  147.598111] hub 5-0:1.0: USB hub found
[  147.598115] hub 5-0:1.0: 8 ports detected
[  147.664579] hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
done.
Setting parameters of disc: (none).
Activating swap:swapon on /dev/sdc2
[  148.501685] Adding 1959920k swap on /dev/sdc2.  Priority:-1 extents:1 across:1959920k
.
Will now check root file system:fsck 1.40-WIP (14-Nov-2006)
[/sbin/fsck.reiser4 (1) -- /] fsck.reiser4 -a /dev/sdc1 
fsck.reiser4 /dev/sdc1 
.
Setting the system clock again..
[  148.846087] usb 5-7: new high speed USB device using ehci_hcd and address 6
[  148.971198] usb 5-7: new device found, idVendor=05e3, idProduct=0606
[  148.977871] usb 5-7: new device strings: Mfr=0, Product=1, SerialNumber=0
[  148.985141] usb 5-7: Product: USB2.0 Hub
[  148.989440] usb 5-7: configuration #1 chosen from 1 choice
[  148.995552] hub 5-7:1.0: USB hub found
[  148.999907] hub 5-7:1.0: 4 ports detected
[  149.179768] usb 4-1: new low speed USB device using uhci_hcd and address 2
[  149.359046] usb 4-1: new device found, idVendor=045e, idProduct=001e
[  149.365905] usb 4-1: new device strings: Mfr=1, Product=2, SerialNumber=0
[  149.373212] usb 4-1: Product: Microsoft IntelliMouse® Explorer
[  149.379456] usb 4-1: Manufacturer: Microsoft
[  149.384122] usb 4-1: configuration #1 chosen from 1 choice
System Clock set. Local time: Sun Nov 26 22:56:23 MST 2006.
Cleaning up ifupdown....
Loading kernel module nvidia.
[  149.527299] usb 4-2: new low speed USB device using uhci_hcd and address 3
[  149.664808] usbcore: registered new interface driver hiddev
[  149.691745] usb 4-2: new device found, idVendor=0d3d, idProduct=0001
[  149.698254] usb 4-2: new device strings: Mfr=0, Product=2, SerialNumber=0
[  149.705179] usb 4-2: Product: USBPS2
[  149.708899] usb 4-2: configuration #1 chosen from 1 choice
[  149.870517] usb 2-1: new full speed USB device using uhci_hcd and address 3
[  149.990442] usb 2-1: device descriptor read/64, error -71
[  150.209320] usb 2-1: device descriptor read/64, error -71
[  150.257283] nvidia: module license 'NVIDIA' taints kernel.
[  150.416927] usb 2-1: new full speed USB device using uhci_hcd and address 4
[  150.515873] NVRM: The NVIDIA probe routine was not called for 1 device(s).
[  150.515890] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[  150.530441] NVRM: This can occur when a driver such as rivafb, nvidiafb or
[  150.530442] NVRM: rivatv was loaded and obtained ownership of the NVIDIA
[  150.530443] NVRM: device(s).
[  150.536819] usb 2-1: device descriptor read/64, error -71
[  150.552801] NVRM: Try unloading the rivafb, nvidiafb or rivatv kernel module
[  150.552802] NVRM: (and/or reconfigure your kernel without rivafb/nvidiafb
[  150.552803] NVRM: support), then try loading the NVIDIA kernel module again.
[  150.574122] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-9629  Wed Nov  1 19:27:33 PST 2006
Loading kernel module loop.
FATAL: Module loop not found.
Loading kernel module i2c-i801.
Loading kernel module i2c-isa.
Loading kernel module eeprom.
Loading kernel module w83627ehf.
Loading kernel module usb-storage.
[  150.655320] Initializing USB Mass Storage driver...
[  150.752226] usb 2-1: device descriptor read/64, error -71
[  150.961220] usb 2-1: new full speed USB device using uhci_hcd and address 5
[  151.376260] usb 2-1: device not accepting address 5, error -71
[  151.484845] usb 2-1: new full speed USB device using uhci_hcd and address 6
[  151.899912] usb 2-1: device not accepting address 6, error -71
[  152.112034] usb 2-2: new full speed USB device using uhci_hcd and address 7
[  152.419953] usb 5-7.3: new high speed USB device using ehci_hcd and address 7
[  152.511368] usb 5-7.3: new device found, idVendor=0bda, idProduct=8187
[  152.518346] usb 5-7.3: new device strings: Mfr=1, Product=2, SerialNumber=3
[  152.525398] usb 5-7.3: Product: RTL8187_Wireless
[  152.530085] usb 5-7.3: Manufacturer: Manufacturer_Realtek_RTL8187_
[  152.531240] input: Microsoft Microsoft IntelliMouse® Explorer as /class/input/input3
[  152.531376] input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.0-1
[  152.553989] usb 5-7.3: SerialNumber: 0015AF05C9DE
[  152.558883] usb 5-7.3: configuration #1 chosen from 1 choice
[  152.564748] input: USBPS2 as /class/input/input4
[  152.569559] input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:1d.0-2
[  152.598228] input: USBPS2 as /class/input/input5
[  152.603008] input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:1d.0-2
[  152.609682] usbcore: registered new interface driver usbhid
[  152.612079] usbcore: registered new interface driver usb-storage
[  152.612081] USB Mass Storage support registered.
[  152.626231] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Loading kernel module snd-rtctimer.
Loading kernel module uhci-hcd.
Loading kernel module acpi-cpufreq.
FATAL: Error inserting acpi_cpuf[  152.674231] usbcore: registered new interface driver cdc_acm
req (/lib/module[  152.680227] drivers/usb/class/cdc-acm.c: v0.25:USB Abstract Control Model driver for USB modems and ISDN adapters
s/2.6.19-rc6-mm1/kernel/arch/x86_64/kernel/cpufreq/acpi-cpufreq.ko): No such device
Loading kernel module cdc-acm.
Loading device-mapper support.
Will now check all file systems.
fsck 1.40-WIP (14-Nov-2006)
Checking all file systems.
Done checking file systems. 
A log is being saved in /var/log/fsck/checkfs if that location is writable.
Setting kernel variables...done.
Will now mount local filesystems:[  152.853692] ReiserFS: sde1: found reiserfs format "3.6" with standard journal
[  152.860994] ReiserFS: sde1: using ordered data mode
[  152.875751] ReiserFS: sde1: journal params: device sde1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  152.890838] ReiserFS: sde1: checking transaction log (sde1)
[  152.968048] ReiserFS: sde1: Using r5 hash to sort names
[  153.035606] reiser4: sda1: found disk format 4.0.0.
.
Will now activate swapfile swap:done.
Cleaning /tmp...done.
Cleaning /var/run...done.
Cleaning /var/lock...done.
Setting up networking....
Configuring network interfaces...done.
Starting portmap daemon....
[  154.803119] sky2 eth0: enabling interface
Setting sensors limits: done.
Setting console screen modes and fonts.
Setting up ALSA...done.
Initializing random number generator...done.
Recovering nvi editor sessions...none found.
Setting up X server socket directory /tmp/.X11-unix....
Setting up ICE socket directory /tmp/.ICE-unix....
Recovering schroot sessions... done.
INIT: Entering runlevel: 2
Starting system log daemon....
Starting kernel log daemon....
Loading ACPI modules:
Starting Advanced Configuration and Power Interface daemon: acpid.
Starting Common Unix Printing System: cupsd[  157.299194] usb 2-2: new device found, idVendor=03f0, idProduct=0401
[  157.305711] usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=3
[  157.312652] usb 2-2: Product: HP ScanJet 5200C
[  157.317694] sky2 eth0: Link is up at 1000 Mbps, full duplex, flow control both
[  157.325090] usb 2-2: Manufacturer: Hewlett-Packard
[  157.329976] usb 2-2: SerialNumber: SG91U161Z2HT
[  157.334680] usb 2-2: configuration #1 chosen from 1 choice
.
Starting system message bus: dbus.
Starting Hardware abstraction layer: hald.
Starting DirMngr: dirmngr.
Starting mouse interface server: gpm.
Starting internet superserver: inetd.
Starting Postfix Mail Transport Agent: postfix.
Starting Samba daemons: nmbd smbd.
Starting sensor daemon: sensord.
Starting OpenBSD Secure Shell server: sshd.
Setting up X font server socket directory /tmp/.font-unix...done.
Starting X font server: xfs.
Starting NFS common utilities: statd.
Starting NTP server: ntpd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: crond.
Starting K Display Manager: kdm.
Running local boot scripts (/etc/rc.local).

Debian GNU/Linux 4.0 luna ttyS0

luna login: INIT:Stopping K Display Manager: kdm.
Stopping deferred execution scheduler: atd.
Stopping periodic command scheduler: crond.
Stopping Samba daemons: nmbd smbd.
Stopping Advanced Configuration and Power Interface daemon: acpid.
Stopping Common Unix Printing System: cupsd.
Stopping Hardware abstraction layer: hald.
Stopping system message bus: dbus.
Stopping DirMngr: dirmngr.
Stopping mouse interface server: gpm.
Stopping internet superserver: inetd.
Stopping Postfix Mail Transport Agent: postfix.
Stopping sensor daemon: sensord.
Stopping OpenBSD Secure Shell server: sshd.
Stopping X font server: xfs.
Stopping NTP server: ntpd.
Saving the system clock..
Hardware Clock updated to Mon Nov 27 01:30:01 MST 2006.
Shutting down ALSA...done.
Stopping NFS common utilities: statd.
Stopping kernel log daemon....
Stopping system log daemon....
Saving random seed...done.
Asking non-system processes to terminate...done.
Unmounting remote and non-toplevel virtual filesystems...done.
Stopping portmap daemon....
Deconfiguring network interfaces...[ 9363.903564] sky2 eth0: disabling interface
done.
Cleaning up ifupdown....
Asking all remaining processes to terminate...done.
Killing all remaining processes...done.
Will now unmount temporary filesystems:/dev umounted
.
Will now deactivate swap:swapoff on /dev/sdc2
.
Will now unmount local filesystems:/backup umounted
/home umounted
/tmp umounted
/dev/sde1 umounted
/dev/sda1 umounted
/dev/hde1 umounted
.
Mounting root filesystem read-only...done.
Will now halt.
[ 9371.896444] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9371.903036] ata2.00: (irq_stat 0x40000001)
[ 9371.907228] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9371.907229]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9371.931688] ata2.00: configured for UDMA/133
[ 9371.936073] ata2: EH complete
[ 9371.939137] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9371.945702] ata2.00: (irq_stat 0x40000001)
[ 9371.949899] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9371.949900]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9371.974319] ata2.00: configured for UDMA/133
[ 9371.978701] ata2: EH complete
[ 9371.981763] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9371.988346] ata2.00: (irq_stat 0x40000001)
[ 9371.992543] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9371.992544]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.016961] ata2.00: configured for UDMA/133
[ 9372.021345] ata2: EH complete
[ 9372.024417] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.030990] ata2.00: (irq_stat 0x40000001)
[ 9372.035190] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.035191]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.059604] ata2.00: configured for UDMA/133
[ 9372.063981] ata2: EH complete
[ 9372.067053] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.073634] ata2.00: (irq_stat 0x40000001)
[ 9372.077834] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.077835]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.102259] ata2.00: configured for UDMA/133
[ 9372.106633] ata2: EH complete
[ 9372.109702] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.116280] ata2.00: (irq_stat 0x40000001)
[ 9372.120471] ata2.00: cmd e0/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.120472]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.144866] ata2.00: configured for UDMA/133
[ 9372.149237] ata2: EH complete
[ 9372.152310] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.158882] ata2.00: (irq_stat 0x40000001)
[ 9372.163079] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.163080]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.187505] ata2.00: configured for UDMA/133
[ 9372.191891] ata2: EH complete
[ 9372.194954] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.201528] ata2.00: (irq_stat 0x40000001)
[ 9372.205725] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.205726]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.230150] ata2.00: configured for UDMA/133
[ 9372.234525] ata2: EH complete
[ 9372.237590] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.244171] ata2.00: (irq_stat 0x40000001)
[ 9372.248370] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.248371]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.272791] ata2.00: configured for UDMA/133
[ 9372.277161] ata2: EH complete
[ 9372.280236] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.286818] ata2.00: (irq_stat 0x40000001)
[ 9372.291015] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.291016]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.315408] ata2.00: configured for UDMA/133
[ 9372.319772] ata2: EH complete
[ 9372.322838] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.329410] ata2.00: (irq_stat 0x40000001)
[ 9372.333607] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.333608]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.358023] ata2.00: configured for UDMA/133
[ 9372.362390] ata2: EH complete
[ 9372.365463] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[ 9372.372036] ata2.00: (irq_stat 0x40000001)
[ 9372.376236] ata2.00: cmd 94/00:00:00:00:00/00:00:00:00:00/00 tag 0 data 0 in
[ 9372.376237]          res 51/04:00:01:01:80/00:00:00:00:00/a0 Emask 0x1 (device error)
[ 9372.400648] ata2.00: configured for UDMA/133
[ 9372.405018] ata2: EH complete
[ 9372.408077] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[ 9372.410277] Synchronizing SCSI cache for disk sde: 
[ 9372.418928] sdd: Write Protect is off
[ 9372.422679] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 9372.431950] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
[ 9372.437839] sdd: Write Protect is off
[ 9372.441609] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 9372.450324] Synchronizing SCSI cache for disk sdc: 
[ 9372.450480] Synchronizing SCSI cache for disk sdb: 
[ 9372.450732] Synchronizing SCSI cache for disk sda: 
[ 9372.942537] Shutdown: hdg
[ 9372.945441] Shutdown: hde
[ 9372.948690] Power down.
[ 9372.951278] acpi_power_off called

--------------090208070805070006070002--
