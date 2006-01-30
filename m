Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWA3Qtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWA3Qtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWA3Qtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:49:50 -0500
Received: from war.OCF.Berkeley.EDU ([192.58.221.244]:31893 "EHLO
	war.OCF.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932327AbWA3Qtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:49:49 -0500
Date: Mon, 30 Jan 2006 08:49:27 -0800 (PST)
From: chris <cperkins@OCF.Berkeley.EDU>
To: linux-kernel@vger.kernel.org
cc: cperkins@OCF.Berkeley.EDU
Subject: 2.6.15-rt16
Message-ID: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i'm trying to use ingo's 2.6.15-rt16 patch on an x86_64 machine but it 
keeps crashing in kmem_cache_init during bootup. i've tried older 
2.6.15-rtX patches and they all crash during startup but vanilla 2.6.15 
works fine for me. anyone else seen this happen with realtime-preempt 
patches? here's the message:

Bootdata ok (command line is ro root=LABEL=/ console=ttyS0,9600)
Linux version 2.6.15-rt16 (root@dh14.s88.bnl.gov) (gcc version 4.0.0 20050519 (Red Hat 4.0.0-8)) #1 SM
P PREEMPT Mon Jan 30 11:22:04 EST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 0000000000097400 (usable)
  BIOS-e820: 0000000000097400 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000aff20000 (usable)
  BIOS-e820: 00000000aff20000 - 00000000aff2d000 (ACPI data)
  BIOS-e820: 00000000aff2d000 - 00000000aff80000 (ACPI NVS)
  BIOS-e820: 00000000aff80000 - 00000000b0000000 (reserved)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 0000000200000000 (usable)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-b0000000
SRAT: Node 0 PXM 0 0-200000000
Bootmem setup node 0 0000000000000000-0000000200000000
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x8008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xd0000000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xd0000000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xd0001000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xd0001000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at b4000000 (gap: b0000000:30000000)
Checking aperture...
CPU 0: aperture @ 0 size 2048 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 18000000
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,9600
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2210.219 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 6645820k/8388608k available (3105k kernel code, 430752k reserved, 2121k data, 236k init)
Unable to handle kernel paging request at 0000000000001200 RIP: 
<ffffffff801606d3>{__alloc_pages+69}
PGD 0
Oops: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.15-rt16 #1
RIP: 0010:[<ffffffff801606d3>] <ffffffff801606d3>{__alloc_pages+69}
RSP: 0018:ffffffff806f7da0  EFLAGS: 00010293
RAX: ffffffff806f7fd8 RBX: 0000000000001200 RCX: 0000000000000003
RDX: 0000000000001200 RSI: 0000000000000385 RDI: ffffffff80439c64
RBP: ffffffff806f7e00 R08: 0000000000000000 R09: ffffffff806f7d40
R10: 0000000000000040 R11: 0000000000000028 R12: 00000000000000d0
R13: 00000000000000d0 R14: ffffffff8052e280 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff806d9b00(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000001200 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffffffff806f6000, task ffffffff8052e280)
Stack: ffffffff806f7db0 0000000000001200 ffffffff806f7dc0 ffffffff00000010
        ffffffff806f7df0 0000000000000246 0000000000000001 0000000000000001
        ffffffff80541f80 00000000000000d0
Call Trace:<ffffffff80178e5e>{cache_grow+355} <ffffffff80179287>{cache_alloc_refill+386}
        <ffffffff80178cb3>{kmem_cache_alloc+165} <ffffffff8014df70>{rt_down+60}
        <ffffffff8017a6b1>{kmem_cache_create+436} <ffffffff801500b3>{sub_preempt_count+29}
        <ffffffff8070d2e2>{kmem_cache_init+309} <ffffffff806f876b>{start_kernel+348}
        <ffffffff806f826f>{_sinittext+623}
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP: 
<ffffffff801501fa>{print_traces+13}
PGD 0
Oops: 0000 [2] PREEMPT SMP
CPU 0
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.15-rt16 #1
RIP: 0010:[<ffffffff801501fa>] <ffffffff801501fa>{print_traces+13}
RSP: 0018:ffffffff806f7ab8  EFLAGS: 00010092
RAX: 0000000000000001 RBX: ffffffff806f8000 RCX: 0000000000000003
RDX: ffffffff806846c0 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff806f7ad8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000023 R14: ffffffff8061fe00 R15: ffffffff80623dc0
FS:  0000000000000000(0000) GS:ffffffff806d9b00(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffffffff806f6000, task ffffffff8052e280)
Stack: ffffffff806f8000 ffffffff806f8000 0000000000000000 0000000000000023
        ffffffff806f7b28 ffffffff8010f449 0000000000000000 0000000000000000
        0000000000000000 ffffffff806f7df0
Call Trace:<ffffffff806f8000>{_sinittext+0} <ffffffff806f8000>{_sinittext+0}
        <ffffffff8010f449>{show_trace+572} <ffffffff8010f534>{show_stack+220}
        <ffffffff8010f5cc>{show_registers+137} <ffffffff8010f9c8>{__die+156}
        <ffffffff80404f62>{do_page_fault+1806} <ffffffff80150306>{add_preempt_count_ti+60}
        <ffffffff80150306>{add_preempt_count_ti+60} <ffffffff8010eaed>{error_exit+0}
        <ffffffff801606d3>{__alloc_pages+69} <ffffffff80178e5e>{cache_grow+355}
        <ffffffff80179287>{cache_alloc_refill+386} <ffffffff80178cb3>{kmem_cache_alloc+165}
        <ffffffff8014df70>{rt_down+60} <ffffffff8017a6b1>{kmem_cache_create+436}
        <ffffffff801500b3>{sub_preempt_count+29} <ffffffff8070d2e2>{kmem_cache_init+309}
        <ffffffff806f876b>{start_kernel+348} <ffffffff806f826f>{_sinittext+623}


