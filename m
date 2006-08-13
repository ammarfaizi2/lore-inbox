Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWHMUM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWHMUM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 16:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWHMUM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 16:12:29 -0400
Received: from lucidpixels.com ([66.45.37.187]:10894 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751402AbWHMUM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 16:12:28 -0400
Date: Sun, 13 Aug 2006 16:12:26 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
cc: apiszcz@solarrain.com
Subject: Linux 2.6.17.6 Kernel Oops: kmem_cache_create: duplicate cache
 scsi_cmd_cache
Message-ID: <Pine.LNX.4.64.0608131608460.20462@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Executing the following commands:

# --------------- #

rmmod sym53c8xx scsi_transport_spi st scsi_mod

modprobe scsi_mod
modprobe st
modprobe scsi_transport_spi
modprobe sym53c8xx

scsiadd -s

# --------------- #

Then I got this, see dmesg below:

There are 4 tape drives attached to this card, please let me know if any 
more info is needed, thanks.

# --------------- #


[4376051.543000]  target0:0:2: Beginning Domain Validation
[4376051.547000]  target0:0:2: asynchronous
[4376051.628000]  target0:0:2: FAST-5 SCSI 5.0 MB/s ST (200 ns, offset 11)
[4376051.670000]  target0:0:2: Domain Validation skipping write tests
[4376051.670000]  target0:0:2: Ending Domain Validation
[4376051.830000] st 0:0:2:0: Attached scsi tape st2
[4376051.830000] st2: try direct i/o: yes (alignment 512 B)
[4376051.983000]  target0:0:3: Multiple LUNs disabled in NVRAM
[4376051.998000]   Vendor: EXABYTE   Model: EXB-8500 myqanx0  Rev: 04S0
[4376051.999000]   Type:   Sequential-Access                  ANSI SCSI revision: 02
[4376051.999000]  target0:0:3: Beginning Domain Validation
[4376052.003000]  target0:0:3: asynchronous
[4376052.054000]  target0:0:3: FAST-5 SCSI 4.0 MB/s ST (248 ns, offset 11)
[4376052.089000]  target0:0:3: Domain Validation skipping write tests
[4376052.089000]  target0:0:3: Ending Domain Validation
[4376052.345000] st 0:0:3:0: Attached scsi tape st3
[4376052.346000] st3: try direct i/o: yes (alignment 512 B)
[4376052.708000]  target0:0:5: Multiple LUNs disabled in NVRAM
[4376053.458000]  target0:0:8: Multiple LUNs disabled in NVRAM
[4376053.826000]  target0:0:9: Multiple LUNs disabled in NVRAM
[4376054.196000]  target0:0:10: Multiple LUNs disabled in NVRAM
[4376054.566000]  target0:0:11: Multiple LUNs disabled in NVRAM
[4376054.934000]  target0:0:12: Multiple LUNs disabled in NVRAM
[4376055.302000]  target0:0:13: Multiple LUNs disabled in NVRAM
[4376055.672000]  target0:0:14: Multiple LUNs disabled in NVRAM
[4376092.107000] st0: Block limits 1 - 245760 bytes.
[4376095.657000] st1: Block limits 1 - 245760 bytes.
[4376098.016000] st2: Block limits 1 - 245760 bytes.
[4376099.343000] st3: Block limits 1 - 245760 bytes.
[4390397.980000] eth2: Setting promiscuous mode.
[4390397.980000] device eth2 entered promiscuous mode
[4390505.473000] device eth0 entered promiscuous mode
[4390529.771000] eth1: Setting promiscuous mode.
[4390529.771000] device eth1 entered promiscuous mode
[4390530.385000] device eth0 left promiscuous mode
[4390531.044000] device eth0 entered promiscuous mode
[4390532.167000] device eth2 left promiscuous mode
[4390533.029000] eth2: Setting promiscuous mode.
[4390533.029000] device eth2 entered promiscuous mode
[4390543.480000] eth3: Setting promiscuous mode.
[4390543.480000] device eth3 entered promiscuous mode
[4390555.618000] device eth3 left promiscuous mode
[4390569.807000] device eth2 left promiscuous mode
[4390571.450000] device eth1 left promiscuous mode
[4390571.972000] device eth0 left promiscuous mode
[4444839.616000] sym0: unexpected disconnect
[4444839.616000] st0: Error 70002 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
[4444839.921000] sym0: SCSI BUS reset detected.
[4444839.921000] sym0: SCSI BUS has been reset.
[4444839.926000] st3: Error 80000 (sugg. bt 0x0, driver bt 0x0, host bt 0x8).
[4444843.352000] st3: Error 100ff (sugg. bt 0x0, driver bt 0x0, host bt 0x1).
[4444843.352000] st3: Error on write filemark.
[4448423.983000] sym0: detaching ...
[4448423.983000] sym0: resetting chip
[4448423.983000] ACPI: PCI interrupt for device 0000:01:0b.0 disabled
[4448424.294000] st: Unloaded.
[4448424.659000] SCSI subsystem initialized
[4448424.735000] st: Version 20050830, fixed bufsize 32768, s/g segs 256
[4448424.900000] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[4448425.053000] sym0: <875> rev 0x3 at pci 0000:01:0b.0 irq 9
[4448425.140000] sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4448425.140000] sym0: open drain IRQ line driver, using on-chip SRAM
[4448425.141000] sym0: using LOAD/STORE-based firmware.
[4448425.141000] sym0: SCSI BUS has been reset.
[4448425.147000] scsi0 : sym-2.2.3
[4448425.166000]  target0:0:0: Scan at boot disabled in NVRAM
[4448425.259000]  target0:0:1: Scan at boot disabled in NVRAM
[4448425.317000]  target0:0:2: Scan at boot disabled in NVRAM
[4448425.371000]  target0:0:3: Scan at boot disabled in NVRAM
[4448425.425000]  target0:0:4: Scan at boot disabled in NVRAM
[4448425.479000]  target0:0:5: Scan at boot disabled in NVRAM
[4448428.479000]  target0:0:8: Scan at boot disabled in NVRAM
[4448428.533000]  target0:0:9: Scan at boot disabled in NVRAM
[4448428.587000]  target0:0:10: Scan at boot disabled in NVRAM
[4448428.615000]  target0:0:11: Scan at boot disabled in NVRAM
[4448428.642000]  target0:0:12: Scan at boot disabled in NVRAM
[4448428.655000]  target0:0:13: Scan at boot disabled in NVRAM
[4448428.731000]  target0:0:14: Scan at boot disabled in NVRAM
[4448428.803000]  target0:0:15: Scan at boot disabled in NVRAM
[4448428.881000]  target0:0:0: Multiple LUNs disabled in NVRAM
[4448429.190000]  target0:0:1: Multiple LUNs disabled in NVRAM
[4448429.513000]  target0:0:2: Multiple LUNs disabled in NVRAM
[4448429.881000]  target0:0:3: Multiple LUNs disabled in NVRAM
[4448430.618000]  target0:0:5: Multiple LUNs disabled in NVRAM
[4448431.343000]  target0:0:8: Multiple LUNs disabled in NVRAM
[4448431.724000]  target0:0:9: Multiple LUNs disabled in NVRAM
[4448432.093000]  target0:0:10: Multiple LUNs disabled in NVRAM
[4448432.461000]  target0:0:11: Multiple LUNs disabled in NVRAM
[4448432.830000]  target0:0:12: Multiple LUNs disabled in NVRAM
[4448433.198000]  target0:0:13: Multiple LUNs disabled in NVRAM
[4448433.567000]  target0:0:14: Multiple LUNs disabled in NVRAM
[4448570.615000] sym0: detaching ...
[4448570.615000] sym0: resetting chip
[4448570.615000] ACPI: PCI interrupt for device 0000:01:0b.0 disabled
[4448570.818000] st: Unloaded.
[4448571.026000] SCSI subsystem initialized
[4448571.120000] st: Version 20050830, fixed bufsize 32768, s/g segs 256
[4448571.265000] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[4448571.419000] sym0: <875> rev 0x3 at pci 0000:01:0b.0 irq 9
[4448571.506000] sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4448571.506000] sym0: open drain IRQ line driver, using on-chip SRAM
[4448571.506000] sym0: using LOAD/STORE-based firmware.
[4448571.506000] sym0: SCSI BUS has been reset.
[4448571.513000] scsi0 : sym-2.2.3
[4448571.593000]  target0:0:0: Scan at boot disabled in NVRAM
[4448571.648000]  target0:0:1: Scan at boot disabled in NVRAM
[4448571.702000]  target0:0:2: Scan at boot disabled in NVRAM
[4448571.756000]  target0:0:3: Scan at boot disabled in NVRAM
[4448571.808000]  target0:0:4: Scan at boot disabled in NVRAM
[4448571.831000]  target0:0:5: Scan at boot disabled in NVRAM
[4448574.848000]  target0:0:8: Scan at boot disabled in NVRAM
[4448574.903000]  target0:0:9: Scan at boot disabled in NVRAM
[4448574.932000]  target0:0:10: Scan at boot disabled in NVRAM
[4448574.987000]  target0:0:11: Scan at boot disabled in NVRAM
[4448575.042000]  target0:0:12: Scan at boot disabled in NVRAM
[4448575.098000]  target0:0:13: Scan at boot disabled in NVRAM
[4448575.126000]  target0:0:14: Scan at boot disabled in NVRAM
[4448575.182000]  target0:0:15: Scan at boot disabled in NVRAM
[4448575.267000]  target0:0:0: Multiple LUNs disabled in NVRAM
[4448575.549000]   Vendor: EXABYTE   Model: EXB-8500SMBANXH1  Rev: 0458
[4448575.550000]   Type:   Sequential-Access                  ANSI SCSI revision: 02
[4448575.550000]  target0:0:0: Beginning Domain Validation
[4448575.568000]  target0:0:0: asynchronous
[4448576.394000]  target0:0:0: FAST-5 SCSI 4.0 MB/s ST (248 ns, offset 11)
[4448576.475000]  target0:0:0: Domain Validation skipping write tests
[4448576.475000]  target0:0:0: Ending Domain Validation
[4448576.744000] st 0:0:0:0: Attached scsi tape st0
[4448576.744000] st0: try direct i/o: yes (alignment 512 B)
[4448576.772000]  target0:0:1: Multiple LUNs disabled in NVRAM
[4448576.791000]   Vendor: EXABYTE   Model: EXB8505xDGBANXS4  Rev: 07T0
[4448576.792000]   Type:   Sequential-Access                  ANSI SCSI revision: 02
[4448576.792000]  target0:0:1: Beginning Domain Validation
[4448576.796000]  target0:0:1: asynchronous
[4448576.857000]  target0:0:1: FAST-5 SCSI 5.0 MB/s ST (200 ns, offset 11)
[4448576.900000]  target0:0:1: Domain Validation skipping write tests
[4448576.900000]  target0:0:1: Ending Domain Validation
[4448577.110000] st 0:0:1:0: Attached scsi tape st1
[4448577.111000] st1: try direct i/o: yes (alignment 512 B)
[4448577.129000]  target0:0:2: Multiple LUNs disabled in NVRAM
[4448577.148000]   Vendor: EXABYTE   Model: EXB8505xDGBANXS4  Rev: 07T0
[4448577.149000]   Type:   Sequential-Access                  ANSI SCSI revision: 02
[4448577.149000]  target0:0:2: Beginning Domain Validation
[4448577.153000]  target0:0:2: asynchronous
[4448577.213000]  target0:0:2: FAST-5 SCSI 5.0 MB/s ST (200 ns, offset 11)
[4448577.256000]  target0:0:2: Domain Validation skipping write tests
[4448577.257000]  target0:0:2: Ending Domain Validation
[4448577.497000] st 0:0:2:0: Attached scsi tape st2
[4448577.497000] st2: try direct i/o: yes (alignment 512 B)
[4448577.575000]  target0:0:3: Multiple LUNs disabled in NVRAM
[4448577.590000]   Vendor: EXABYTE   Model: EXB-8500 myqanx0  Rev: 04S0
[4448577.590000]   Type:   Sequential-Access                  ANSI SCSI revision: 02
[4448577.590000]  target0:0:3: Beginning Domain Validation
[4448577.595000]  target0:0:3: asynchronous
[4448577.647000]  target0:0:3: FAST-5 SCSI 4.0 MB/s ST (248 ns, offset 11)
[4448577.682000]  target0:0:3: Domain Validation skipping write tests
[4448577.683000]  target0:0:3: Ending Domain Validation
[4448577.878000] st 0:0:3:0: Attached scsi tape st3
[4448577.878000] st3: try direct i/o: yes (alignment 512 B)
[4448578.212000]  target0:0:5: Multiple LUNs disabled in NVRAM
[4448578.905000]  target0:0:8: Multiple LUNs disabled in NVRAM
[4448579.273000]  target0:0:9: Multiple LUNs disabled in NVRAM
[4448579.635000]  target0:0:10: Multiple LUNs disabled in NVRAM
[4448579.994000]  target0:0:11: Multiple LUNs disabled in NVRAM
[4448580.377000]  target0:0:12: Multiple LUNs disabled in NVRAM
[4448580.745000]  target0:0:13: Multiple LUNs disabled in NVRAM
[4448581.113000]  target0:0:14: Multiple LUNs disabled in NVRAM
[4451017.584000] st0: Error 100ff (sugg. bt 0x0, driver bt 0x0, host bt 0x1).
[4484058.730000]  target0:0:5: Multiple LUNs disabled in NVRAM
[4484059.467000]  target0:0:8: Multiple LUNs disabled in NVRAM
[4484059.836000]  target0:0:9: Multiple LUNs disabled in NVRAM
[4484060.204000]  target0:0:10: Multiple LUNs disabled in NVRAM
[4484060.574000]  target0:0:11: Multiple LUNs disabled in NVRAM
[4484060.941000]  target0:0:12: Multiple LUNs disabled in NVRAM
[4484061.311000]  target0:0:13: Multiple LUNs disabled in NVRAM
[4484061.679000]  target0:0:14: Multiple LUNs disabled in NVRAM
[4489187.602000] sym0: unexpected disconnect
[4489187.602000] st0: Error 70002 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
[4489187.875000] st3: Error 100ff (sugg. bt 0x0, driver bt 0x0, host bt 0x1).
[4489188.172000] sym0: SCSI BUS reset detected.
[4489188.172000] sym0: SCSI BUS has been reset.
[4489188.177000] st0: Error 80000 (sugg. bt 0x0, driver bt 0x0, host bt 0x8).
[4489188.178000] st3: Error 80000 (sugg. bt 0x0, driver bt 0x0, host bt 0x8).
[4489191.824000] st3: Error 100ff (sugg. bt 0x0, driver bt 0x0, host bt 0x1).
[4489192.119000] st0: Error 100ff (sugg. bt 0x0, driver bt 0x0, host bt 0x1).
[4489211.916000] sym0: detaching ...
[4489211.916000] sym0: resetting chip
[4489211.916000] ACPI: PCI interrupt for device 0000:01:0b.0 disabled
[4489212.108000] st: Unloaded.
[4489212.607000] SCSI subsystem initialized
[4489212.655000] st: Version 20050830, fixed bufsize 32768, s/g segs 256
[4489212.976000] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[4489213.170000] sym0: <875> rev 0x3 at pci 0000:01:0b.0 irq 9
[4489213.171000] kmem_cache_create: duplicate cache scsi_cmd_cache
[4489213.171000]  <c0156b40> kmem_cache_create+0x310/0x550  <e0861a95> scsi_setup_command_freelist+0x65/0xf0 [scsi_mod]
[4489213.171000]  <e0862838> scsi_host_alloc+0x168/0x290 [scsi_mod]  <c011990b> printk+0x1b/0x20
[4489213.171000]  <e0a28abc> sym2_probe+0x44c/0xaa0 [sym53c8xx]  <c02fe90c> ide_build_sglist+0x3c/0x110
[4489213.171000]  <c027e823> pci_device_probe+0x63/0x80  <c02cad44> driver_probe_device+0x54/0xf0
[4489213.172000]  <c02cae60> __driver_attach+0x0/0x70  <c02caec7> __driver_attach+0x67/0x70
[4489213.172000]  <c02ca05d> bus_for_each_dev+0x5d/0x80  <c02cabc5> driver_attach+0x25/0x30
[4489213.172000]  <c02cae60> __driver_attach+0x0/0x70  <c02ca42c> bus_add_driver+0x8c/0x180
[4489213.172000]  <c02cb31e> driver_register+0x4e/0xa0  <c027e350> __pci_register_driver+0x40/0x70
[4489213.172000]  <e083106f> sym2_init+0x6f/0x11c [sym53c8xx]  <c01335ad> sys_init_module+0x16d/0x1680
[4489213.172000]  <c0279610> pci_bus_read_config_byte+0x0/0x90  <c0102df7> syscall_call+0x7/0xb
[4489213.172000] ACPI: PCI interrupt for device 0000:01:0b.0 disabled
[4489347.949000] st: Unloaded.
[4489348.154000] SCSI subsystem initialized
[4489348.232000] st: Version 20050830, fixed bufsize 32768, s/g segs 256
[4489348.334000] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[4489348.504000] sym0: <875> rev 0x3 at pci 0000:01:0b.0 irq 9
[4489348.504000] kmem_cache_create: duplicate cache scsi_cmd_cache
[4489348.504000]  <c0156b40> kmem_cache_create+0x310/0x550  <e0861a95> scsi_setup_command_freelist+0x65/0xf0 [scsi_mod]
[4489348.505000]  <e0862838> scsi_host_alloc+0x168/0x290 [scsi_mod]  <c011990b> printk+0x1b/0x20
[4489348.505000]  <e0a28abc> sym2_probe+0x44c/0xaa0 [sym53c8xx]  <c027e823> pci_device_probe+0x63/0x80
[4489348.505000]  <c02cad44> driver_probe_device+0x54/0xf0  <c02cae60> __driver_attach+0x0/0x70
[4489348.505000]  <c02caec7> __driver_attach+0x67/0x70  <c02ca05d> bus_for_each_dev+0x5d/0x80
[4489348.505000]  <c02cabc5> driver_attach+0x25/0x30  <c02cae60> __driver_attach+0x0/0x70
[4489348.506000]  <c02ca42c> bus_add_driver+0x8c/0x180  <c02cb31e> driver_register+0x4e/0xa0
[4489348.506000]  <c027e350> __pci_register_driver+0x40/0x70  <e083106f> sym2_init+0x6f/0x11c [sym53c8xx]
[4489348.506000]  <c01335ad> sys_init_module+0x16d/0x1680  <c0279610> pci_bus_read_config_byte+0x0/0x90
[4489348.506000]  <c0102df7> syscall_call+0x7/0xb 
[4489348.506000] ACPI: PCI interrupt for device 0000:01:0b.0 disabled
[4489366.492000] st: Unloaded.
[4489366.671000] SCSI subsystem initialized
[4489366.823000] st: Version 20050830, fixed bufsize 32768, s/g segs 256
[4489366.939000] ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [LNKA] -> GSI 9 (level, low) -> IRQ 9
[4489367.092000] sym0: <875> rev 0x3 at pci 0000:01:0b.0 irq 9
[4489367.093000] kmem_cache_create: duplicate cache scsi_cmd_cache
[4489367.093000]  <c0156b40> kmem_cache_create+0x310/0x550  <e0861a95> scsi_setup_command_freelist+0x65/0xf0 [scsi_mod]
[4489367.093000]  <e0862838> scsi_host_alloc+0x168/0x290 [scsi_mod]  <c011990b> printk+0x1b/0x20
[4489367.093000]  <e0a28abc> sym2_probe+0x44c/0xaa0 [sym53c8xx]  <c027e823> pci_device_probe+0x63/0x80
[4489367.093000]  <c02cad44> driver_probe_device+0x54/0xf0  <c02cae60> __driver_attach+0x0/0x70
[4489367.094000]  <c02caec7> __driver_attach+0x67/0x70  <c02ca05d> bus_for_each_dev+0x5d/0x80
[4489367.094000]  <c02cabc5> driver_attach+0x25/0x30  <c02cae60> __driver_attach+0x0/0x70
[4489367.094000]  <c02ca42c> bus_add_driver+0x8c/0x180  <c02cb31e> driver_register+0x4e/0xa0
[4489367.094000]  <c027e350> __pci_register_driver+0x40/0x70  <e083106f> sym2_init+0x6f/0x11c [sym53c8xx]
[4489367.094000]  <c01335ad> sys_init_module+0x16d/0x1680  <c0279610> pci_bus_read_config_byte+0x0/0x90
[4489367.094000]  <c0102df7> syscall_call+0x7/0xb 
[4489367.095000] ACPI: PCI interrupt for device 0000:01:0b.0 disabled
