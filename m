Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422875AbWJaIYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWJaIYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422972AbWJaIYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:24:04 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:41898 "EHLO
	mail.pixelized.ch") by vger.kernel.org with ESMTP id S1422875AbWJaIYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:24:01 -0500
Message-ID: <45470810.4040905@cateee.net>
Date: Tue, 31 Oct 2006 09:23:44 +0100
From: Giacomo Catenazzi <cate@cateee.net>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Panic with 2.6.19-rc3-ga7aacdf9: Invalid opcode at acpi_os_read_pci_configuration
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since few days I have this bug (not sure if it
caused by changed configuration or if it is a regretion).
The fololowing trace is from last git.
Captured with serial console, so I see some extra empty lines.

ciao
	cate




[    0.000000] Linux version 2.6.19-rc3-ga7aacdf9 (cate@catee) (gcc
version 4.1.2 20061028 (prerelease) (Debian 4.1.1
-19)) #4 SMP Tue Oct 31 08:29:37 CET 2006

[    0.000000] BIOS-provided physical RAM map:

[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)

[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)

[    0.000000]  BIOS-e820: 000000003ffc0000 - 000000003ffd0000 (ACPI data)

[    0.000000]  BIOS-e820: 000000003ffd0000 - 0000000040000000 (ACPI NVS)

[    0.000000]  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)

[    0.000000] 127MB HIGHMEM available.

[    0.000000] 896MB LOWMEM available.

[    0.000000] found SMP MP-table at 000ff780

[    0.000000] Zone PFN ranges:

[    0.000000]   DMA             0 ->     4096

[    0.000000]   Normal       4096 ->   229376

[    0.000000]   HighMem    229376 ->   262080

[    0.000000] early_node_map[1] active PFN ranges

[    0.000000]     0:        0 ->   262080

[    0.000000] DMI 2.3 present.

[    0.000000] ACPI: PM-Timer IO Port: 0x408

[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)

[    0.000000] Processor #0 15:2 APIC version 20

[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)

[    0.000000] Processor #6 15:2 APIC version 20

[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)

[    0.000000] Processor #1 15:2 APIC version 20

[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)

[    0.000000] Processor #7 15:2 APIC version 20

[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])

[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI
0-23

[    0.000000] ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])

[    0.000000] IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI
24-47

[    0.000000] ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])

[    0.000000] IOAPIC[2]: apic_id 10, version 32, address 0xfec80400,
GSI 48-71

[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)

[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)

[    0.000000] Enabling APIC mode:  Flat.  Using 3 I/O APICs

[    0.000000] Using ACPI (MADT) for SMP configuration information

[    0.000000] Allocating PCI resources starting at 50000000 (gap:
40000000:bfb80000)

[    0.000000] Detected 2399.444 MHz processor.

[   35.153234] Built 1 zonelists.  Total pages: 260033

[   35.153237] Kernel command line: BOOT_IMAGE=Linux ro root=303
console=ttyS0

[   35.153518] Enabling fast FPU save and restore... done.

[   35.153521] Enabling unmasked SIMD FPU exception support... done.

[   35.153525] Initializing CPU#0

[   35.153589] CPU 0 irqstacks, hard=c048f000 soft=c048b000

[   35.153593] PID hash table entries: 4096 (order: 12, 16384 bytes)

[   35.154982] Console: colour VGA+ 80x25

[   38.301285] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)

[   38.386287] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)

[   38.496810] Memory: 1034532k/1048320k available (2188k kernel code,
13148k reserved, 850k data, 180k init, 130816k hig
hmem)

[   38.629810] virtual kernel memory layout:

[   38.629811]     fixmap  : 0xfff83000 - 0xfffff000   ( 496 kB)

[   38.629813]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)

[   38.629814]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)

[   38.629816]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)

[   38.629817]       .init : 0xc0459000 - 0xc0486000   ( 180 kB)

[   38.629819]       .data : 0xc0323199 - 0xc03f7ae4   ( 850 kB)

[   38.629820]       .text : 0xc0100000 - 0xc0323199   (2188 kB)

[   39.157983] Checking if this processor honours the WP bit even in
supervisor mode... Ok.

[   39.314263] Calibrating delay using timer specific routine.. 4800.85
BogoMIPS (lpj=2400425)

[   39.414191] Mount-cache hash table entries: 512

[   39.468472] CPU: Trace cache: 12K uops, L1 D cache: 8K

[   39.529968] CPU: L2 cache: 512K

[   39.567439] CPU: Physical Processor ID: 0

[   39.615295] Intel machine check architecture supported.

[   39.677666] Intel machine check reporting enabled on CPU#0.

[   39.744194] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available

[   39.815914] CPU0: Thermal monitoring enabled

[   39.866893] Checking 'hlt' instruction... OK.

[   39.922556] Freeing SMP alternatives: 16k freed

[   39.976686] ACPI: Core revision 20060707

[   40.025724] CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07

[   40.092539] Booting processor 1/1 eip 2000

[   40.141505] CPU 1 irqstacks, hard=c0490000 soft=c048c000

[   40.215259] Initializing CPU#1

[   40.275337] Calibrating delay using timer specific routine.. 4797.94
BogoMIPS (lpj=2398972)

[   40.275360] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   40.275363] CPU: L2 cache: 512K

[   40.275366] CPU: Physical Processor ID: 0

[   40.275379] Intel machine check architecture supported.

[   40.275386] Intel machine check reporting enabled on CPU#1.

[   40.275389] CPU1: Intel P4/Xeon Extended MCE MSRs (12) available

[   40.275394] CPU1: Thermal monitoring enabled

[   40.275558] CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07

[   40.876778] Booting processor 2/6 eip 2000

[   40.925750] CPU 2 irqstacks, hard=c0491000 soft=c048d000

[   40.999414] Initializing CPU#2

[   41.059766] Calibrating delay using timer specific routine.. 4798.03
BogoMIPS (lpj=2399019)

[   41.059786] CPU: Trace cache: 12K uops, L1 D cache: 8K

[   41.059788] CPU: L2 cache: 512K

[   41.059790] CPU: Physical Processor ID: 3

[   41.059799] Intel machine check architecture supported.

[   41.059805] Intel machine check reporting enabled on CPU#2.

[   41.059808] CPU2: Intel P4/Xeon Extended MCE MSRs (12) available

[   41.059811] CPU2: Thermal monitoring enabled

[   41.059942] CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07

[   41.661114] Booting processor 3/7 eip 2000

[   41.709991] CPU 3 irqstacks, hard=c0492000 soft=c048e000

[   41.783657] Initializing CPU#3

[   41.844196] Calibrating delay using timer specific routine.. 4798.01
BogoMIPS (lpj=2399008)

[   41.844218] CPU: Trace cache: 12K uops, L1 D cache: 8K

[   41.844221] CPU: L2 cache: 512K

[   41.844224] CPU: Physical Processor ID: 3
[   41.844235] Intel machine check architecture supported.

[   41.844242] Intel machine check reporting enabled on CPU#3.

[   41.844245] CPU3: Intel P4/Xeon Extended MCE MSRs (12) available

[   41.844250] CPU3: Thermal monitoring enabled

[   41.844390] CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07

[   42.445561] Total of 4 processors activated (19194.84 BogoMIPS).

[   42.517564] ENABLING IO-APIC IRQs

[   42.557309] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1

[   42.740413] checking TSC synchronization across 4 CPUs: passed.

[    0.012497] Brought up 4 CPUs

[    0.174941] migration_cost=19,713

[    0.215588] NET: Registered protocol family 16

[    0.268807] ACPI: bus type pci registered

[    0.316660] PCI: Fatal: No config space access function found

[    0.385262] Setting up standard PCI resources

[    0.452566] ACPI: Access to PCI configuration space unavailable

[    0.527856] ACPI: Interpreter enabled

[    0.571564] ACPI: Using IOAPIC for interrupt routing

[    0.631370] ACPI: PCI Root Bridge [PCI0] (0000:00)

[    0.690684] ------------[ cut here ]------------

[    0.745825] kernel BUG at drivers/acpi/osl.c:461!

[    0.801975] invalid opcode: 0000 [#1]

[    0.845671] SMP

[    0.867778] Modules linked in:

[    0.904316] CPU:    1

[    0.904317] EIP:    0060:[<c01cc441>]    Not tainted VLI
[    0.904318] EFLAGS: 00010246   (2.6.19-rc3-ga7aacdf9 #4)

[    1.058241] EIP is at acpi_os_read_pci_configuration+0x4e/0x91

[    1.127879] eax: 00000001   ebx: c1a7baa0   ecx: c193ca53   edx: 00000008

[    1.208940] esi: 00000001   edi: 00000000   ebp: c193ca53   esp: c193ca14

[    1.289999] ds: 007b   es: 007b   ss: 0068

[    1.338886] Process swapper (pid: 1, ti=c193c000 task=c193ba70
task.ti=c193c000)

[    1.425134] Stack: c193ca1c c192cfcc 00000010 0000000e c193ca53
c193ca6c c193ca73 c192c4b4

[    1.525811]        c01cc547 00000008 c193ca73 00000006 001f0000
c1a7baa0 c192cfcc 00000000

[    1.626486]        c193ca6c c193caa3 c03509c4 c01cc5e2 c193ca6c
c193ca73 00000001 0093caa4

[    1.727163] Call Trace:

[    1.758516]  [<c01cc547>] acpi_os_derive_pci_id_2+0xc3/0x134

[    1.826182]  [<c01cc5e2>] acpi_os_derive_pci_id+0x2a/0x2f

[    1.890742]  [<c01d1d45>] acpi_ev_pci_config_region_setup+0x1f1/0x207

[    1.967755]  [<c01d0db8>] acpi_ev_address_space_dispatch+0xcc/0x1b9

[    2.042692]  [<c01d4e95>] acpi_ex_access_region+0x224/0x23c

[    2.109324]  [<c01d4fc0>] acpi_ex_field_datum_io+0x113/0x1a7

[    2.176995]  [<c01d50fd>] acpi_ex_extract_from_field+0xa9/0x236

[    2.247781]  [<c01d3970>] acpi_ex_read_data_from_field+0x104/0x134

[    2.321679]  [<c01d8caa>] acpi_ex_resolve_node_to_value+0x17a/0x220

[    2.396618]  [<c01d45d8>] acpi_ex_resolve_to_value+0x228/0x234

[    2.466364]  [<c01cf606>] acpi_ds_resolve_operands+0x18/0x2e

[    2.534036]  [<c01ce625>] acpi_ds_exec_end_op+0x1e4/0x3cf

[    2.598594]  [<c01dd43c>] acpi_ps_parse_loop+0x5b0/0x8cc

[    2.662113]  [<c01dca9e>] acpi_ps_parse_aml+0x60/0x1ff

[    2.723558]  [<c01ddb82>] acpi_ps_execute_pass+0x7d/0x90

[    2.787077]  [<c01ddc8d>] acpi_ps_execute_method+0xc8/0x157

[    2.853711]  [<c01db0b9>] acpi_ns_evaluate+0x9d/0xfc

[    2.913079]  [<c01e100b>] acpi_ut_evaluate_object+0x51/0x187

[    2.980752]  [<c01e11b9>] acpi_ut_execute_STA+0x1d/0x47

[    3.043232]  [<c01dab12>] acpi_ns_get_device_callback+0x5d/0x14f

[    3.115055]  [<c01dc298>] acpi_ns_walk_namespace+0xf8/0x110

[    3.181690]  [<c01daa2e>] acpi_get_devices+0x58/0x6b

[    3.241058]  [<c01e3fd1>] acpi_get_pci_rootbridge_handle+0x2d/0x35

[    3.314956]  [<c01c9fab>] acpi_pci_find_root_bridge+0x3d/0x51

[    3.383666]  [<c01e3dba>] acpi_platform_notify+0x39/0x10b

[    3.448224]  [<c021f29f>] device_add+0xb4/0x451

[    3.502404]  [<c01c3b22>] pci_create_bus+0xc7/0x1bd

[    3.560734]  [<c01c4925>] pci_scan_bus_parented+0x10/0x23

[    3.625288]  [<c02bae5c>] pcibios_scan_root+0x4e/0x56

[    3.685696]  [<c01e5a2e>] acpi_pci_root_add+0x20e/0x2b4

[    3.748179]  [<c01ea0a9>] acpi_bus_driver_init+0x28/0x4b

[    3.811699]  [<c01eae49>] acpi_add_single_object+0x74c/0x7d5

[    3.879369]  [<c01eafe7>] acpi_bus_scan+0x115/0x184

[    3.937700]  [<c046d4f1>] acpi_scan_init+0x16b/0x18d

[    3.997069]  [<c0100499>] init+0x121/0x2c5

[    4.046060]  [<c010367b>] kernel_thread_helper+0x7/0x10

[    4.108540] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

[    4.182436]

[    4.200184] Leftover inexact backtrace:

[    4.200186]

[    4.263704]  =======================

[    4.306361] Code: 20 74 12 66 b8 01 00 83 fa 08 75 5a eb 0e be 02 00
00 00 eb 0c be 04 00 00 00 eb 05 be 01 00 00 00 8
b 3d d0 2d 4c c0 85 ff 75 08 <0f> 0b cd 01 f8 10 35 c0 0f b7 4b 04 83 e1
1f c1 e1 03 0f b7 43





