Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965040AbWJBQI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWJBQI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWJBQI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:08:26 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:41190
	"EHLO saville.com") by vger.kernel.org with ESMTP id S965040AbWJBQIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:08:24 -0400
Message-ID: <45213979.6070805@saville.com>
Date: Mon, 02 Oct 2006 09:08:25 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved with
 2.6.18 kernel
References: <45206777.7020405@saville.com> <p733ba7hwlh.fsf@verdi.suse.de> <45212BFB.3080708@saville.com> <200610021722.21987.ak@suse.de>
In-Reply-To: <200610021722.21987.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------060400010702090300020002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060400010702090300020002
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Andi,

I added video=nvidiafb:nomtrr but it failed as before, just didn't print 
out the:

[  107.214820] nvidiafb: MTRR set to ON

I then removed frame buffer support, which is log-3, it got farther, but 
I've got something wrong with my root setup. I'll try to figure that out 
later.

Later this evening I'll look up the nvidia maintainer and see what might 
be wrong there.

And thanks for the info and your work on firescope, I'm sure it will be 
useful in the near future!

Cheers,

Wink


--------------060400010702090300020002
Content-Type: text/plain;
 name="winkc2d1-log-3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="winkc2d1-log-3.txt"

[    0.000000] Linux version 2.6.18-w3 (wink@winkc2d1) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #2 SMP PREEMPT Mon Oct 2 08:53:22 PDT 200
6
[    0.000000] Command line: root=/dev/sda2 ro quiet splash initcall_debug console=ttyS0,115200n8 loglevel=7 video=nvidiafb:nomtrr
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
[    0.000000]  BIOS-e820: 000000007ff80000 - 000000007ff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 000000007ff8e000 - 000000007ffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   524160
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
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000e4000
[    0.000000] Nosave address range: 00000000000e4000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7fb00000)
[    0.000000] PERCPU: Allocating 31616 bytes of per cpu data
[    0.000000] Built 1 zonelists.  Total pages: 515101
[    0.000000] Kernel command line: root=/dev/sda2 ro quiet splash initcall_debug console=ttyS0,115200n8 loglevel=7 video=nvidiafb:nomtrr
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   97.450643] Console: colour VGA+ 80x25
[   97.709058] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[   97.717127] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   97.724293] Checking aperture...
[   97.747964] Memory: 2057068k/2096640k available (4150k kernel code, 39156k reserved, 2159k data, 260k init)
[   97.817763] Calibrating delay using timer specific routine.. 4810.28 BogoMIPS (lpj=2405141)
[   97.826147] Mount-cache hash table entries: 256
[   97.830776] CPU: L1 I cache: 32K, L1 D cache: 32K
[   97.835496] CPU: L2 cache: 4096K
[   97.838721] using mwait in idle threads.
[   97.842639] CPU: Physical Processor ID: 0
[   97.846641] CPU: Processor Core ID: 0
[   97.850303] CPU0: Thermal monitoring enabled (TM2)
[   97.855092] Freeing SMP alternatives: 36k freed
[   97.859629] ACPI: Core revision 20060707
[   97.890276] Using local APIC timer interrupts.
[   97.936216] result 16695612
[   97.939002] Detected 16.695 MHz APIC timer.
[   97.943553] Booting processor 1/2 APIC 0x1
[   97.958166] Initializing CPU#1
[   98.028192] Calibrating delay using timer specific routine.. 4807.61 BogoMIPS (lpj=2403806)
[   98.028198] CPU: L1 I cache: 32K, L1 D cache: 32K
[   98.028199] CPU: L2 cache: 4096K
[   98.028201] CPU: Physical Processor ID: 0
[   98.028202] CPU: Processor Core ID: 1
[   98.028207] CPU1: Thermal monitoring enabled (TM2)
[   98.028621] Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
[   98.029278] Brought up 2 CPUs
[   98.070544] testing NMI watchdog ... OK.
[   98.084466] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   98.090632] time.c: Detected 2404.168 MHz processor.
[   98.192225] migration_cost=21
[   98.195459] Calling initcall 0xffffffff80847ef0: cpufreq_tsc+0x0/0x70()
[   98.202098] Calling initcall 0xffffffff8084cca0: init_smp_flush+0x0/0x70()
[   98.209008] Calling initcall 0xffffffff80854b90: init_elf32_binfmt+0x0/0x20()
[   98.216176] Calling initcall 0xffffffff80856650: helper_init+0x0/0x40()
[   98.222825] Calling initcall 0xffffffff80856a80: pm_init+0x0/0x30()
[   98.229114] Calling initcall 0xffffffff80856b40: ksysfs_init+0x0/0x30()
[   98.235756] Calling initcall 0xffffffff808597d0: filelock_init+0x0/0x40()
[   98.242574] Calling initcall 0xffffffff8085a470: init_misc_binfmt+0x0/0x50()
[   98.249643] Calling initcall 0xffffffff8085a4c0: init_script_binfmt+0x0/0x20()
[   98.256892] Calling initcall 0xffffffff8085a4e0: init_elf_binfmt+0x0/0x20()
[   98.264301] Calling initcall 0xffffffff8085bf10: debugfs_init+0x0/0x50()
[   98.271029] Calling initcall 0xffffffff80867560: sock_init+0x0/0x60()<7>Losing some ticks... checking if CPU frequency changed.
[   98.282524] 
[   98.284037] Calling initcall 0xffffffff808680c0: netlink_proto_init+0x0/0x1b0()
[   98.291371] NET: Registered protocol family 16
[   98.295809] Calling initcall 0xffffffff8085ce50: kobject_uevent_init+0x0/0x40()
[   98.303147] Calling initcall 0xffffffff8085cfe0: pcibus_class_init+0x0/0x20()
[   98.310309] Calling initcall 0xffffffff8085d960: pci_driver_init+0x0/0x20()
[   98.317306] Calling initcall 0xffffffff8085e050: lcd_class_init+0x0/0x20()
[   98.324211] Calling initcall 0xffffffff8085e070: backlight_class_init+0x0/0x12()
[   98.331641] Calling initcall 0xffffffff8085f3a8: dock_init+0x0/0x42()
[   98.338155] Calling initcall 0xffffffff80860580: tty_class_init+0x0/0x30()
[   98.345053] Calling initcall 0xffffffff80860da0: vtconsole_class_init+0x0/0xc0()
[   98.352512] Calling initcall 0xffffffff8084ba60: mtrr_if_init+0x0/0x80()
[   98.359234] Calling initcall 0xffffffff8085e000: acpi_pci_init+0x0/0x30()
[   98.366048] ACPI: bus type pci registered
[   98.370053] Calling initcall 0xffffffff8085ec39: init_acpi_device_notify+0x0/0x4b()
[   98.377730] Calling initcall 0xffffffff808665c0: pci_access_init+0x0/0x40()
[   98.384713] PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
[   98.391135] PCI: Not using MMCONFIG.
[   98.394707] PCI: Using configuration type 1
[   98.398885] Calling initcall 0xffffffff8084b8a0: mtrr_init_finialize+0x0/0x40()
[   98.406224] Calling initcall 0xffffffff80852ed0: topology_init+0x0/0x50()
[   98.413075] Calling initcall 0xffffffff808563a0: param_sysfs_init+0x0/0x210()
[   98.421326] Calling initcall 0xffffffff80256820: pm_sysrq_init+0x0/0x20()
[   98.428137] Calling initcall 0xffffffff8085a000: init_bio+0x0/0x110()
[   98.434659] Calling initcall 0xffffffff8085cca0: genhd_device_init+0x0/0x60()
[   98.441860] Calling initcall 0xffffffff8085ea4f: acpi_init+0x0/0x1ea()
[   98.455925] ACPI: Interpreter enabled
[   98.459583] ACPI: Using IOAPIC for interrupt routing
[   98.464580] Calling initcall 0xffffffff8085ed6c: acpi_ec_init+0x0/0x61()
[   98.471310] Calling initcall 0xffffffff8085f665: acpi_pci_root_init+0x0/0x28()
[   98.478561] Calling initcall 0xffffffff8085f77a: acpi_pci_link_init+0x0/0x48()
[   98.485808] Calling initcall 0xffffffff8085f863: acpi_power_init+0x0/0x77()
[   98.492795] Calling initcall 0xffffffff8085f9b8: acpi_system_init+0x0/0xc6()
[   98.499861] Calling initcall 0xffffffff8085fa7e: acpi_event_init+0x0/0x3f()
[   98.506847] Calling initcall 0xffffffff8085fabd: acpi_scan_init+0x0/0x1a1()
[   98.514604] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   98.521526] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   98.528089] PCI: Transparent bridge - 0000:00:1e.0
[   98.539694] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   98.547150] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[   98.554582] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
[   98.562037] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   98.569481] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   98.576927] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   98.584364] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[   98.592968] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10 11 12 14 15)
[   98.600295] Calling initcall 0xffffffff8085fdd9: acpi_cm_sbs_init+0x0/0x17()
[   98.607367] Calling initcall 0xffffffff8085fdf0: pnp_init+0x0/0x20()
[   98.613749] Linux Plug and Play Support v0.97 (c) Adam Belay
[   98.619398] Calling initcall 0xffffffff8085fff0: pnpacpi_init+0x0/0x70()
[   98.626125] pnp: PnP ACPI init
[   98.631490] pnp: PnP ACPI: found 13 devices
[   98.635668] Calling initcall 0xffffffff80860a60: misc_init+0x0/0x90()
[   98.642136] Calling initcall 0xffffffff80861300: mod_init+0x0/0x280()
[   98.649984] intel_rng: FWH not detected
[   98.653816] Calling initcall 0xffffffff80861580: mod_init+0x0/0xd0()
[   98.660213] Calling initcall 0xffffffff80861650: mod_init+0x0/0xc0()
[   98.666590] Calling initcall 0xffffffff8049f700: cn_init+0x0/0xe0()
[   98.672922] Calling initcall 0xffffffff80863fe0: init_scsi+0x0/0xa0()
[   98.679497] SCSI subsystem initialized
[   98.683234] Calling initcall 0xffffffff80864740: init_pcmcia_cs+0x0/0x40()
[   98.690136] Calling initcall 0xffffffff80864890: usb_init+0x0/0x120()
[   98.696664] usbcore: registered new interface driver usbfs
[   98.702164] usbcore: registered new interface driver hub
[   98.707500] usbcore: registered new device driver usb
[   98.712543] Calling initcall 0xffffffff80864cd0: serio_init+0x0/0xf0()
[   98.719107] Calling initcall 0xffffffff80865190: gameport_init+0x0/0xe0()
[   98.725932] Calling initcall 0xffffffff80865270: input_init+0x0/0x130()
[   98.732585] Calling initcall 0xffffffff80865680: rtc_init+0x0/0x50()
[   98.738968] Calling initcall 0xffffffff808656d0: i2c_init+0x0/0x40()
[   98.745375] Calling initcall 0xffffffff80866600: pci_acpi_init+0x0/0xc0()
[   98.752180] PCI: Using ACPI for IRQ routing
[   98.756351] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   98.764590] Calling initcall 0xffffffff808666c0: pci_legacy_init+0x0/0x140()
[   98.771665] Calling initcall 0xffffffff80866c70: pcibios_irq_init+0x0/0x530()
[   98.779264] Calling initcall 0xffffffff808671a0: pcibios_init+0x0/0x70()
[   98.786042] Calling initcall 0xffffffff80867620: proto_init+0x0/0x40()
[   98.792601] Calling initcall 0xffffffff808677a0: net_dev_init+0x0/0x210()
[   98.799423] Calling initcall 0xffffffff808680a0: fib_rules_init+0x0/0x20()
[   98.806324] Calling initcall 0xffffffff80868270: genl_init+0x0/0xc0()
[   98.812785] Calling initcall 0xffffffff80848020: late_hpet_init+0x0/0xe0()
[   98.819684] Calling initcall 0xffffffff8084b270: pci_iommu_init+0x0/0x20()
[   98.826594] PCI-GART: No AMD northbridge found.
[   98.831117] Calling initcall 0xffffffff80859750: init_pipe_fs+0x0/0x50()
[   98.837847] Calling initcall 0xffffffff8085fca3: acpi_motherboard_init+0x0/0x136()
[   98.846035] Calling initcall 0xffffffff8085ff50: pnp_system_init+0x0/0x20()
[   98.853057] pnp: 00:06: ioport range 0x290-0x297 has been reserved
[   98.859236] Calling initcall 0xffffffff80860460: chr_dev_init+0x0/0x90()
[   98.866115] Calling initcall 0xffffffff808629b0: firmware_class_init+0x0/0x80()
[   98.873460] Calling initcall 0xffffffff80864780: init_pcmcia_bus+0x0/0x50()
[   98.880452] Calling initcall 0xffffffff80865890: cpufreq_gov_performance_init+0x0/0x20()
[   98.888571] Calling initcall 0xffffffff808658d0: cpufreq_gov_userspace_init+0x0/0x20()
[   98.896517] Calling initcall 0xffffffff80865fa0: pcibios_assign_resources+0x0/0x90()
[   98.904300] PCI: Bridge: 0000:00:01.0
[   98.907951]   IO window: c000-cfff
[   98.911351]   MEM window: faa00000-feafffff
[   98.915526]   PREFETCH window: cff00000-efefffff
[   98.920138] PCI: Bridge: 0000:00:1c.0
[   98.923794]   IO window: disabled.
[   98.927195]   MEM window: disabled.
[   98.930678]   PREFETCH window: cfe00000-cfefffff
[   98.935288] PCI: Bridge: 0000:00:1c.3
[   98.938944]   IO window: b000-bfff
[   98.942345]   MEM window: fa900000-fa9fffff
[   98.946521]   PREFETCH window: disabled.
[   98.950438] PCI: Bridge: 0000:00:1c.4
[   98.954095]   IO window: a000-afff
[   98.957495]   MEM window: fa800000-fa8fffff
[   98.961672]   PREFETCH window: disabled.
[   98.965593] PCI: Bridge: 0000:00:1e.0
[   98.969245]   IO window: disabled.
[   98.972646]   MEM window: fa700000-fa7fffff
[   98.976822]   PREFETCH window: disabled.
[   98.980750] GSI 16 sharing vector 0xA9 and IRQ 16
[   98.985443] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
[   98.992946] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
[   99.000436] GSI 17 sharing vector 0xB1 and IRQ 17
[   99.005134] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 177
[   99.012629] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 169
[   99.020123] Calling initcall 0xffffffff80868df0: inet_init+0x0/0x3f0()
[   99.026691] NET: Registered protocol family 2
[   99.040270] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[   99.047502] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[   99.056578] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   99.063795] TCP: Hash tables configured (established 262144 bind 65536)
[   99.070388] TCP reno registered
[   99.073569] Calling initcall 0xffffffff8020e340: time_init_device+0x0/0x30()
[   99.080708] Calling initcall 0xffffffff80848610: add_pcspkr+0x0/0x60()
[   99.087291] Calling initcall 0xffffffff80849570: init_timer_sysfs+0x0/0x30()
[   99.094380] Calling initcall 0xffffffff80849540: i8259A_init_sysfs+0x0/0x30()
[   99.101564] Calling initcall 0xffffffff80849a60: vsyscall_init+0x0/0xa0()
[   99.108389] Calling initcall 0xffffffff8084a170: sbf_init+0x0/0xe0()
[   99.114766] Calling initcall 0xffffffff8084afe0: i8237A_init_sysfs+0x0/0x30()
[   99.121953] Calling initcall 0xffffffff8084b520: mce_init_device+0x0/0x1a0()
[   99.129091] Calling initcall 0xffffffff8084b410: periodic_mcheck_init+0x0/0x30()
[   99.136514] Calling initcall 0xffffffff8084b730: thermal_throttle_init_device+0x0/0x60()
[   99.144632] Calling initcall 0xffffffff8084c990: msr_init+0x0/0x130()
[   99.151140] Calling initcall 0xffffffff8084cac0: microcode_init+0x0/0xb0()
[  119.111537] IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
[  119.118051] Calling initcall 0xffffffff8084cb70: cpuid_init+0x0/0x130()
[  119.124728] Calling initcall 0xffffffff8084dff0: init_lapic_sysfs+0x0/0x40()
[  119.131829] Calling initcall 0xffffffff8084ef20: ioapic_init_sysfs+0x0/0xf0()
[  119.139011] Calling initcall 0xffffffff80853ac0: cache_sysfs_init+0x0/0x60()
[  119.146244] Calling initcall 0xffffffff80853dc0: x8664_sysctl_init+0x0/0x20()
[  119.153410] Calling initcall 0xffffffff80854860: aes_init+0x0/0x330()
[  119.159904] Calling initcall 0xffffffff80854bb0: ia32_binfmt_init+0x0/0x20()
[  119.166971] Calling initcall 0xffffffff80854bd0: init_syscall32+0x0/0x80()
[  119.173872] Calling initcall 0xffffffff80854c50: init_aout_binfmt+0x0/0x20()
[  119.180936] Calling initcall 0xffffffff80855780: create_proc_profile+0x0/0x2a0()
[  119.188363] Calling initcall 0xffffffff80855bc0: ioresources_init+0x0/0x50()
[  119.195431] Calling initcall 0xffffffff80855d30: timekeeping_init_device+0x0/0x30()
[  119.203126] Calling initcall 0xffffffff80855fc0: uid_cache_init+0x0/0x90()
[  119.210472] Calling initcall 0xffffffff808565b0: init_posix_timers+0x0/0xa0()
[  119.217630] Calling initcall 0xffffffff80856690: init_posix_cpu_timers+0x0/0x70()
[  119.225132] Calling initcall 0xffffffff80856790: latency_init+0x0/0x30()
[  119.231843] Calling initcall 0xffffffff808567e0: init_clocksource_sysfs+0x0/0x60()
[  119.239450] Calling initcall 0xffffffff80856900: init_jiffies_clocksource+0x0/0x20()
[  119.247221] Calling initcall 0xffffffff80856920: init+0x0/0x90()
[  119.253266] Calling initcall 0xffffffff808569b0: proc_dma_init+0x0/0x30()
[  119.260079] Calling initcall 0xffffffff80250690: percpu_modinit+0x0/0x80()
[  119.266979] Calling initcall 0xffffffff80856a00: kallsyms_init+0x0/0x30()
[  119.273785] Calling initcall 0xffffffff80856ab0: crash_notes_memory_init+0x0/0x50()
[  119.281474] Calling initcall 0xffffffff80856b00: ikconfig_init+0x0/0x40()
[  119.288287] Calling initcall 0xffffffff808582f0: init_per_zone_pages_min+0x0/0x50()
[  119.295967] Calling initcall 0xffffffff80858dc0: pdflush_init+0x0/0x20()
[  119.302714] Calling initcall 0xffffffff80858e00: kswapd_init+0x0/0x20()
[  119.309359] Calling initcall 0xffffffff80858e20: setup_vmstat+0x0/0x20()
[  119.316071] Calling initcall 0xffffffff80858ec0: procswaps_init+0x0/0x30()
[  119.322963] Calling initcall 0xffffffff80858ef0: init_tmpfs+0x0/0xe0()
[  119.329518] Calling initcall 0xffffffff80858fd0: cpucache_init+0x0/0x50()
[  119.336332] Calling initcall 0xffffffff808597a0: fasync_init+0x0/0x30()
[  119.342968] Calling initcall 0xffffffff80859f30: aio_setup+0x0/0x70()
[  119.349457] Calling initcall 0xffffffff8085a1a0: inotify_setup+0x0/0x20()
[  119.356257] Calling initcall 0xffffffff8085a1c0: inotify_user_setup+0x0/0xc0()
[  119.363522] Calling initcall 0xffffffff8085a280: eventpoll_init+0x0/0xf0()
[  119.370429] Calling initcall 0xffffffff8085a370: init_sys32_ioctl+0x0/0x100()
[  119.377596] Calling initcall 0xffffffff8085a500: init_mbcache+0x0/0x20()
[  119.384318] Calling initcall 0xffffffff8085a520: dnotify_init+0x0/0x30()
[  119.391040] Calling initcall 0xffffffff8085aa10: configfs_init+0x0/0xa0()
[  119.397862] Calling initcall 0xffffffff8085aab0: init_devpts_fs+0x0/0x40()
[  119.404765] Calling initcall 0xffffffff8085aaf0: init_reiserfs_fs+0x0/0xb0()
[  119.411840] Calling initcall 0xffffffff8085acd0: init_ext3_fs+0x0/0x80()
[  119.418572] Calling initcall 0xffffffff8085ae10: journal_init+0x0/0xe0()
[  119.425312] Calling initcall 0xffffffff8085aef0: init_ext2_fs+0x0/0x80()
[  119.432042] Calling initcall 0xffffffff8085afb0: init_cramfs_fs+0x0/0x40()
[  119.438944] Calling initcall 0xffffffff8085aff0: init_ramfs_fs+0x0/0x20()
[  119.445750] Calling initcall 0xffffffff8085b030: init_minix_fs+0x0/0x70()
[  119.452559] Calling initcall 0xffffffff8085b0e0: init_fat_fs+0x0/0x60()
[  119.459202] Calling initcall 0xffffffff8085b140: init_msdos_fs+0x0/0x20()
[  119.466419] Calling initcall 0xffffffff8085b160: init_vfat_fs+0x0/0x20()
[  119.473147] Calling initcall 0xffffffff8085b180: init_iso9660_fs+0x0/0x80()
[  119.480139] Calling initcall 0xffffffff8085b350: init_nfs_fs+0x0/0xd0()
[  119.486808] Calling initcall 0xffffffff8085b610: init_nfsd+0x0/0xc0()
[  119.493259] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  119.499710] Calling initcall 0xffffffff8085b6d0: init_nlm+0x0/0x30()
[  119.506088] Calling initcall 0xffffffff8085b700: init_nls_ascii+0x0/0x20()
[  119.512986] Calling initcall 0xffffffff8085b720: init_nls_iso8859_1+0x0/0x20()
[  119.520232] Calling initcall 0xffffffff8085b740: init_smb_fs+0x0/0x80()
[  119.526872] Calling initcall 0xffffffff8085b7c0: init_ntfs_fs+0x0/0x200()
[  119.533671] NTFS driver 2.1.27 [Flags: R/W].
[  119.537952] Calling initcall 0xffffffff8085b9c0: init_romfs_fs+0x0/0x70()
[  119.544760] Calling initcall 0xffffffff8085ba30: init_autofs_fs+0x0/0x20()
[  119.551660] Calling initcall 0xffffffff8085ba50: init_autofs4_fs+0x0/0x20()
[  119.558646] initcall at 0xffffffff8085ba50: init_autofs4_fs+0x0/0x20(): returned with error code -16
[  119.567795] Calling initcall 0xffffffff8085bad0: fuse_init+0x0/0x130()
[  119.574339] fuse init (API version 7.7)
[  119.578197] Calling initcall 0xffffffff8085bc20: init_udf_fs+0x0/0x70()
[  119.584834] Calling initcall 0xffffffff8085bc90: init_jfs_fs+0x0/0x200()
[  119.591569] JFS: nTxBlock = 8192, nTxLock = 65536
[  119.599510] Calling initcall 0xffffffff8085bf60: ipc_init+0x0/0x20()
[  119.605895] Calling initcall 0xffffffff8085c1a0: init_mqueue_fs+0x0/0xf0()
[  119.612829] Calling initcall 0xffffffff8085c290: crypto_algapi_init+0x0/0x10()
[  119.620079] Calling initcall 0xffffffff8085c2d0: cryptomgr_init+0x0/0x20()
[  119.626979] Calling initcall 0xffffffff8085c2f0: hmac_module_init+0x0/0x20()
[  119.634061] Calling initcall 0xffffffff8085c310: init+0x0/0x60()
[  119.640091] Calling initcall 0xffffffff8085c370: init+0x0/0x20()
[  119.646116] Calling initcall 0xffffffff8085c390: init+0x0/0x20()
[  119.652153] Calling initcall 0xffffffff8085c3b0: init+0x0/0x20()
[  119.658180] Calling initcall 0xffffffff8085c3d0: init+0x0/0x20()
[  119.664216] Calling initcall 0xffffffff8085c3f0: init+0x0/0x50()
[  119.670244] Calling initcall 0xffffffff8085c440: init+0x0/0x80()
[  119.676290] Calling initcall 0xffffffff8085c4c0: init+0x0/0x80()
[  119.682317] Calling initcall 0xffffffff8085c540: crypto_ecb_module_init+0x0/0x20()
[  119.689906] Calling initcall 0xffffffff8085c560: crypto_cbc_module_init+0x0/0x20()
[  119.697500] Calling initcall 0xffffffff8085c580: init+0x0/0x50()
[  119.703529] Calling initcall 0xffffffff8085c5d0: init+0x0/0x20()
[  119.709563] Calling initcall 0xffffffff8085c5f0: init+0x0/0x20()
[  119.715600] Calling initcall 0xffffffff8085c610: init+0x0/0x50()
[  119.722043] Calling initcall 0xffffffff8085c660: aes_init+0x0/0x330()
[  119.728527] Calling initcall 0xffffffff8085c990: init+0x0/0x20()
[  119.734555] Calling initcall 0xffffffff8085c9b0: init+0x0/0x20()
[  119.740582] Calling initcall 0xffffffff8085c9d0: arc4_init+0x0/0x20()
[  119.747043] Calling initcall 0xffffffff8085c9f0: init+0x0/0x80()
[  119.753079] Calling initcall 0xffffffff8085ca70: init+0x0/0x20()
[  119.759114] Calling initcall 0xffffffff8085ca90: init+0x0/0x20()
[  119.765143] Calling initcall 0xffffffff8085cab0: init+0x0/0x20()
[  119.771178] Calling initcall 0xffffffff8085cad0: michael_mic_init+0x0/0x20()
[  119.778252] Calling initcall 0xffffffff8085caf0: init+0x0/0x20()
[  119.784280] Calling initcall 0xffffffff8085cd00: noop_init+0x0/0x20()
[  119.790754] io scheduler noop registered
[  119.794681] Calling initcall 0xffffffff8085cd20: as_init+0x0/0x20()
[  119.800969] io scheduler anticipatory registered (default)
[  119.806486] Calling initcall 0xffffffff8085cd40: deadline_init+0x0/0x20()
[  119.813291] io scheduler deadline registered
[  119.817581] Calling initcall 0xffffffff8085cd60: cfq_init+0x0/0xb0()
[  119.823965] io scheduler cfq registered
[  119.827810] Calling initcall 0xffffffff8085ce10: blk_trace_init+0x0/0x40()
[  119.834713] Calling initcall 0xffffffff80436340: pci_init+0x0/0x40()
[  119.842985] Calling initcall 0xffffffff8085d980: pci_sysfs_init+0x0/0x50()
[  119.849934] Calling initcall 0xffffffff8085d9d0: pci_proc_init+0x0/0x80()
[  119.856767] Calling initcall 0xffffffff8085da50: pcie_portdrv_init+0x0/0x50()
[  119.864012] assign_interrupt_mode Found MSI capability
[  119.869273] assign_interrupt_mode Found MSI capability
[  119.874552] assign_interrupt_mode Found MSI capability
[  119.879815] assign_interrupt_mode Found MSI capability
[  119.885041] Calling initcall 0xffffffff8085daa0: aer_service_init+0x0/0x20()
[  119.892132] Calling initcall 0xffffffff8085dac0: pci_hotplug_init+0x0/0x60()
[  119.899206] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[  119.904766] Calling initcall 0xffffffff8085db20: dummyphp_init+0x0/0x60()
[  119.911571] fakephp: Fake PCI Hot Plug Controller Driver
[  119.917195] Calling initcall 0xffffffff8085db80: acpiphp_init+0x0/0x60()
[  119.923918] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[  119.931784] Calling initcall 0xffffffff8085dde0: ibm_acpiphp_init+0x0/0x1a0()
[  119.939089] acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
[  119.965170] Calling initcall 0xffffffff8085ec84: acpi_ac_init+0x0/0x45()
[  119.971907] Calling initcall 0xffffffff8085ecc9: acpi_battery_init+0x0/0x45()
[  119.979070] Calling initcall 0xffffffff8085ed0e: acpi_button_init+0x0/0x5e()
[  119.986149] ACPI: Power Button (FF) [PWRF]
[  119.990257] ACPI: Power Button (CM) [PWRB]
[  119.994350] Calling initcall 0xffffffff8085f34a: acpi_fan_init+0x0/0x5e()
[  120.001164] Calling initcall 0xffffffff8085f3ea: acpi_video_init+0x0/0x5e()
[  120.008183] Calling initcall 0xffffffff8085f448: hotkey_init+0x0/0x21d()
[  120.014910] Using specific hotkey driver
[  120.018819] Calling initcall 0xffffffff8085f742: irqrouter_init_sysfs+0x0/0x38()
[  120.026268] Calling initcall 0xffffffff8085f8da: acpi_processor_init+0x0/0x80()
[  120.033674] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] (Node ffff810002f7bab0), AE_BAD_HEADER
[  120.045040] ACPI: Processor [CPU1] (supports 8 throttling states)
[  120.051209] ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] (Node ffff810002f7b9b0), AE_BAD_HEADER
[  120.062564] ACPI: Processor [CPU2] (supports 8 throttling states)
[  120.068682] ACPI: Getting cpuindex for acpiid 0x3
[  120.073380] ACPI: Getting cpuindex for acpiid 0x4
[  120.078077] Calling initcall 0xffffffff8085f95a: acpi_thermal_init+0x0/0x5e()
[  120.085237] Calling initcall 0xffffffff80860500: rand_initialize+0x0/0x30()
[  120.092233] Calling initcall 0xffffffff808605b0: tty_init+0x0/0x1f0()
[  120.100012] Calling initcall 0xffffffff808607a0: pty_init+0x0/0x2c0()
[  120.106492] Calling initcall 0xffffffff80861090: rtc_init+0x0/0x1d0()
[  120.113007] Real Time Clock Driver v1.12ac
[  120.117104] Calling initcall 0xffffffff80861260: hpet_init+0x0/0x80()
[  120.123603] Calling initcall 0xffffffff80861710: agp_init+0x0/0x30()
[  120.129983] Linux agpgart interface v0.101 (c) Dave Jones
[  120.135363] Calling initcall 0xffffffff80861890: drm_core_init+0x0/0x160()
[  120.142269] [drm] Initialized drm 1.0.1 20051102
[  120.146873] Calling initcall 0xffffffff80861ab0: hangcheck_init+0x0/0x90()
[  120.153773] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[  120.162706] Hangcheck: Using monotonic_clock().
[  120.167230] Calling initcall 0xffffffff80861b40: cn_proc_init+0x0/0x40()
[  120.173958] Calling initcall 0xffffffff808620d0: serial8250_init+0x0/0x170()
[  120.181030] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[  120.188843] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  120.194957] Calling initcall 0xffffffff80862240: serial8250_pnp_init+0x0/0x20()
[  120.202466] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[  120.208046] Calling initcall 0xffffffff80862260: serial8250_pci_init+0x0/0x20()
[  120.215414] Calling initcall 0xffffffff80862a80: topology_sysfs_init+0x0/0x60()
[  120.222762] Calling initcall 0xffffffff80862ae0: rd_init+0x0/0x1c0()
[  120.229499] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[  120.237043] Calling initcall 0xffffffff80862d10: loop_init+0x0/0x330()
[  120.243768] loop: loaded (max 8 devices)
[  120.247680] Calling initcall 0xffffffff80863040: pkt_init+0x0/0x100()
[  120.254171] Calling initcall 0xffffffff80863140: init_cryptoloop+0x0/0x40()
[  120.261152] Calling initcall 0xffffffff80863180: skge_init+0x0/0x20()
[  120.267641] Calling initcall 0xffffffff80863230: net_olddevs_init+0x0/0xc0()
[  120.274775] Calling initcall 0xffffffff808633a0: dummy_init_module+0x0/0xf0()
[  120.281975] Calling initcall 0xffffffff80863490: tun_init+0x0/0x70()
[  120.288355] tun: Universal TUN/TAP device driver, 1.6
[  120.293389] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  120.299572] Calling initcall 0xffffffff804d1390: init_netconsole+0x0/0x80()
[  120.306568] netconsole: not configured, aborting
[  120.311177] Calling initcall 0xffffffff804d1c20: amd74xx_ide_init+0x0/0x20()
[  120.318268] Calling initcall 0xffffffff804d3070: atiixp_ide_init+0x0/0x20()
[  120.325247] Calling initcall 0xffffffff804d3710: generic_ide_init+0x0/0x20()
[  120.332312] Calling initcall 0xffffffff80863dc0: ide_init+0x0/0x70()
[  120.338701] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[  120.345035] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[  120.353103] Calling initcall 0xffffffff80863f60: ide_generic_init+0x0/0x20()
[  121.153034] hda: TSSTcorpCD/DVDW SH-S162L, ATAPI CD/DVD-ROM drive
[  122.288020] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[  122.292592] Calling initcall 0xffffffff80863f80: idedisk_init+0x0/0x20()
[  122.299329] Calling initcall 0xffffffff80863fa0: ide_cdrom_init+0x0/0x20()
[  122.306927] hda: ATAPI CD-ROM drive, 0kB Cache
[  122.311453] Uniform CD-ROM driver Revision: 3.20
[  122.318797] Calling initcall 0xffffffff808642b0: spi_transport_init+0x0/0x30()
[  122.326058] Calling initcall 0xffffffff808642e0: fc_transport_init+0x0/0x50()
[  122.333227] Calling initcall 0xffffffff80864330: iscsi_transport_init+0x0/0x130()
[  122.340725] Loading iSCSI transport class v2.0-685.Calling initcall 0xffffffff80864460: sas_transport_init+0x0/0xc0()
[  122.351385] Calling initcall 0xffffffff80864520: init_idescsi_module+0x0/0x20()
[  122.358730] Calling initcall 0xffffffff80864540: init_sd+0x0/0x80()
[  122.365041] Calling initcall 0xffffffff808645c0: init_sr+0x0/0x30()
[  122.371355] Calling initcall 0xffffffff808645f0: init_sg+0x0/0x140()
[  122.377748] Calling initcall 0xffffffff80864730: cdrom_init+0x0/0x10()
[  122.384301] Calling initcall 0xffffffff80864850: nonstatic_sysfs_init+0x0/0x20()
[  122.391712] Calling initcall 0xffffffff80864870: yenta_socket_init+0x0/0x20()
[  122.398889] Calling initcall 0xffffffff80864b10: ehci_hcd_init+0x0/0x20()
[  122.405734] GSI 18 sharing vector 0xE1 and IRQ 18
[  122.410428] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 225
[  122.418604] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[  122.423882] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[  122.431284] ehci_hcd 0000:00:1d.7: debug port 1
[  122.435822] ehci_hcd 0000:00:1d.7: irq 225, io mem 0xfebfbc00
[  122.445408] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[  122.452972] usb usb1: configuration #1 chosen from 1 choice
[  122.458565] hub 1-0:1.0: USB hub found
[  122.462308] hub 1-0:1.0: 8 ports detected
[  122.566680] Calling initcall 0xffffffff80864b30: ohci_hcd_pci_init+0x0/0x40()
[  122.573867] Calling initcall 0xffffffff80864b70: uhci_hcd_init+0x0/0xa0()
[  122.580689] USB Universal Host Controller Interface driver v3.0
[  122.586632] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 225
[  122.594132] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[  122.599372] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[  122.606764] uhci_hcd 0000:00:1d.0: irq 225, io base 0x0000e480
[  122.612663] usb usb2: configuration #1 chosen from 1 choice
[  122.618246] hub 2-0:1.0: USB hub found
[  122.621997] hub 2-0:1.0: 2 ports detected
[  122.726336] GSI 19 sharing vector 0xE9 and IRQ 19
[  122.731030] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 233
[  122.738526] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[  122.743765] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[  122.751158] uhci_hcd 0000:00:1d.1: irq 233, io base 0x0000e800
[  122.757052] usb usb3: configuration #1 chosen from 1 choice
[  122.762633] hub 3-0:1.0: USB hub found
[  122.766376] hub 3-0:1.0: 2 ports detected
[  122.871033] GSI 20 sharing vector 0x32 and IRQ 20
[  122.875729] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 50
[  122.883311] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[  122.888545] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[  122.895940] uhci_hcd 0000:00:1d.2: irq 50, io base 0x0000e880
[  122.901755] usb usb4: configuration #1 chosen from 1 choice
[  122.907337] hub 4-0:1.0: USB hub found
[  122.911083] hub 4-0:1.0: 2 ports detected
[  122.931172] usb 1-7: new high speed USB device using ehci_hcd and address 3
[  123.015652] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 177
[  123.023140] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[  123.028377] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[  123.035772] uhci_hcd 0000:00:1d.3: irq 177, io base 0x0000ec00
[  123.041681] usb usb5: configuration #1 chosen from 1 choice
[  123.047273] hub 5-0:1.0: USB hub found
[  123.051024] hub 5-0:1.0: 2 ports detected
[  123.062886] usb 1-7: configuration #1 chosen from 1 choice
[  123.068600] hub 1-7:1.0: USB hub found
[  123.072683] hub 1-7:1.0: 4 ports detected
[  123.155177] Calling initcall 0xffffffff80864c10: usb_stor_init+0x0/0x50()
[  123.161997] Initializing USB Mass Storage driver...
[  123.383975] usb 2-2: new low speed USB device using uhci_hcd and address 2
[  123.554610] usb 2-2: configuration #1 chosen from 1 choice
[  123.837499] usb 1-7.3: new high speed USB device using ehci_hcd and address 4
[  123.927134] usb 1-7.3: configuration #1 chosen from 1 choice
[  123.934420] usbcore: registered new interface driver usb-storage
[  123.940420] USB Mass Storage support registered.
[  123.945027] Calling initcall 0xffffffff80864c60: hid_init+0x0/0x50()
[  123.951432] usbcore: registered new interface driver hiddev
[  123.970711] input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
[  123.977490] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-2
[  123.986127] usbcore: registered new interface driver usbhid
[  123.991686] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  123.997850] Calling initcall 0xffffffff80864dc0: i8042_init+0x0/0x350()
[  124.004549] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[  124.010711] PNP: PS/2 controller doesn't have AUX irq; using default 12
[  124.019412] serio: i8042 AUX port at 0x60,0x64 irq 12
[  124.024509] serio: i8042 KBD port at 0x60,0x64 irq 1
[  124.029461] Calling initcall 0xffffffff80865110: serport_init+0x0/0x40()
[  124.036184] Calling initcall 0xffffffff80865150: pcips2_init+0x0/0x20()
[  124.042855] Calling initcall 0xffffffff80865170: serio_raw_init+0x0/0x20()
[  124.049752] Calling initcall 0xffffffff808653a0: mousedev_init+0x0/0xc0()
[  124.056615] mice: PS/2 mouse device common for all mice
[  124.061828] Calling initcall 0xffffffff80865460: evdev_init+0x0/0x20()
[  124.068409] Calling initcall 0xffffffff80865480: atkbd_init+0x0/0x20()
[  124.074962] Calling initcall 0xffffffff808654a0: pcspkr_init+0x0/0x20()
[  124.081663] input: PC Speaker as /class/input/input1
[  124.121187] input: AT Translated Set 2 keyboard as /class/input/input2
[  124.127725] Calling initcall 0xffffffff808654c0: uinput_init+0x0/0x20()
[  124.134387] Calling initcall 0xffffffff80865710: amd756_init+0x0/0x20()
[  124.141058] Calling initcall 0xffffffff80865730: i2c_amd8111_init+0x0/0x20()
[  124.148147] Calling initcall 0xffffffff80865750: i2c_i801_init+0x0/0x20()
[  124.154989] GSI 21 sharing vector 0x3A and IRQ 21
[  124.159686] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 58
[  124.167125] Calling initcall 0xffffffff80865770: i2c_i810_init+0x0/0x20()
[  124.173953] Calling initcall 0xffffffff80865790: nforce2_init+0x0/0x20()
[  124.180698] Calling initcall 0xffffffff808657b0: i2c_piix4_init+0x0/0x20()
[  124.187626] Calling initcall 0xffffffff808657d0: cpufreq_stats_init+0x0/0xc0()
[  124.194868] Calling initcall 0xffffffff808658b0: cpufreq_gov_powersave_init+0x0/0x20()
[  124.202814] Calling initcall 0xffffffff808658f0: cpufreq_gov_dbs_init+0x0/0x20()
[  124.210225] Calling initcall 0xffffffff80865910: cpufreq_gov_dbs_init+0x0/0x20()
[  124.217636] Calling initcall 0xffffffff80867b20: flow_cache_init+0x0/0x1c0()
[  124.224711] Calling initcall 0xffffffff80867ce0: pg_init+0x0/0x3c0()
[  124.231102] pktgen v2.68: Packet Generator for packet performance testing.
[  124.237972] Calling initcall 0xffffffff80869580: ipip_init+0x0/0xa0()
[  124.244435] IPv4 over IPv4 tunneling driver
[  124.248652] Calling initcall 0xffffffff80869620: ipgre_init+0x0/0xb0()
[  124.255210] GRE over IPv4 tunneling driver
[  124.259332] Calling initcall 0xffffffff80869760: ah4_init+0x0/0x80()
[  124.265717] Calling initcall 0xffffffff808697e0: esp4_init+0x0/0x80()
[  124.272178] Calling initcall 0xffffffff80869860: ipcomp4_init+0x0/0x80()
[  124.278896] Calling initcall 0xffffffff808698e0: ipip_init+0x0/0x70()
[  124.285355] Calling initcall 0xffffffff80869950: tunnel4_init+0x0/0x40()
[  124.292076] Calling initcall 0xffffffff80869990: xfrm4_transport_init+0x0/0x20()
[  124.299496] Calling initcall 0xffffffff808699b0: xfrm4_tunnel_init+0x0/0x20()
[  124.306655] Calling initcall 0xffffffff8086b1b0: rr_init+0x0/0x20()
[  124.312943] Calling initcall 0xffffffff8086b1d0: random_init+0x0/0x20()
[  124.319583] Calling initcall 0xffffffff8086b1f0: wrandom_init+0x0/0x70()
[  124.326312] Calling initcall 0xffffffff8086b260: drr_init+0x0/0x50()
[  124.332710] Calling initcall 0xffffffff805d1e80: ipv4_netfilter_init+0x0/0x20()
[  124.340035] Calling initcall 0xffffffff8086b2b0: inet_diag_init+0x0/0x70()
[  124.346940] Calling initcall 0xffffffff8086b320: tcp_diag_init+0x0/0x20()
[  124.353751] Calling initcall 0xffffffff8086b340: cubictcp_register+0x0/0x90()
[  124.360910] TCP cubic registered
[  124.364129] Calling initcall 0xffffffff8086b610: xfrm_user_init+0x0/0x50()
[  124.371028] Initializing XFRM netlink socket
[  124.375287] Calling initcall 0xffffffff8086b660: af_unix_init+0x0/0x80()
[  124.382016] NET: Registered protocol family 1
[  124.386364] Calling initcall 0xffffffff8086b6e0: packet_init+0x0/0x60()
[  124.393003] NET: Registered protocol family 17
[  124.397439] Calling initcall 0xffffffff8086b740: ipsec_pfkey_init+0x0/0xa0()
[  124.404512] NET: Registered protocol family 15
[  124.408950] Calling initcall 0xffffffff8086b7e0: init_sunrpc+0x0/0x50()
[  124.415614] Calling initcall 0xffffffff8086b830: init_rpcsec_gss+0x0/0x40()
[  124.422596] Calling initcall 0xffffffff8086b870: init_kerberos_module+0x0/0x40()
[  124.430015] Calling initcall 0xffffffff8086b8b0: init_spkm3_module+0x0/0x26()
[  124.437183] Calling initcall 0xffffffff8084eaf0: init_lapic_nmi_sysfs+0x0/0x40()
[  124.444633] Calling initcall 0xffffffff808511e0: centrino_init+0x0/0xe0()
[  124.451451] Calling initcall 0xffffffff808512c0: acpi_cpufreq_init+0x0/0xd0()
[  124.458614] Calling initcall 0xffffffff808567c0: clocksource_done_booting+0x0/0x20()
[  124.466386] Calling initcall 0xffffffff80461d92: acpi_poweroff_init+0x0/0x56()
[  124.473660] Calling initcall 0xffffffff808604f0: seqgen_init+0x0/0x10()
[  124.480309] Calling initcall 0xffffffff808627a0: early_uart_console_switch+0x0/0x90()
[  124.488159] Calling initcall 0xffffffff80863fc0: init_ide_cs+0x0/0x20()
[  124.494817] Calling initcall 0xffffffff808654e0: rtc_hctosys+0x0/0x1a0()
[  124.501536] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[  124.507783] Calling initcall 0xffffffff8057cc30: net_random_reseed+0x0/0xa0()
[  124.514945] Calling initcall 0xffffffff80869240: tcp_congestion_default+0x0/0x20()
[  124.522533] Calling initcall 0xffffffff8086a3a0: ip_auto_config+0x0/0xe10()
[  124.529580] VFS: Cannot open root device "sda2" or unknown-block(0,0)
[  124.536000] Please append a correct "root=" boot option
[  124.541214] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[  124.549455]  
--------------060400010702090300020002--
