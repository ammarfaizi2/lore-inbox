Return-Path: <linux-kernel-owner+w=401wt.eu-S1757101AbWLIVas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbWLIVas (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757214AbWLIVas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:30:48 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:18386 "EHLO
	exch01smtp09.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757101AbWLIVar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:30:47 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAFq6ekVZmGJA/2dsb2JhbAA
Message-ID: <60535.192.168.1.8.1165699722.squirrel@www.rncbc.org>
Date: Sat, 9 Dec 2006 21:28:42 -0000 (WET)
Subject: 2.6.19-rt11 boot failure  
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
User-Agent: SquirrelMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 09 Dec 2006 21:30:45.0340 (UTC) FILETIME=[4934D1C0:01C71BD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Sorry for the interrupt, but all my 2.6.19-rt11 builds very fail early on
boot. It doesn't matter if its UP or SMP. This is a sample of what I could
capture on one case via serial console:

Linux version 2.6.19-rt11.0-smp (root@gamma-suse1) (gcc version 4.1.0
(SUSE Linux)) #1 SMP PREEMPT Sat Dec 9 20:04:19 WET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Entering add_active_range(0, 0, 261936) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   261936
early_node_map[1] active PFN ranges
    0:        0 ->   261936
On node 0 totalpages: 261936
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 254 pages used for memmap
  HighMem zone: 32306 pages, LIFO batch:7
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9e60
ACPI: XSDT (v001 A M I  OEMXSDT  0x08000320 MSFT 0x00000097) @ 0x3ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x08000320 MSFT 0x00000097) @ 0x3ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x08000320 MSFT 0x00000097) @ 0x3ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000320 MSFT 0x00000097) @ 0x3ff40040
ACPI: DSDT (v001  P4P81 P4P81086 0x00000086 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb80000)
Detected 3361.012 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists.  Total pages: 259890
Kernel command line: root=/dev/hda1 vga=0x31a resume=/dev/hda3
splash=silent console=tty0 console=ttyS0,115200n8 debug
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1031124k/1047744k available (1715k kernel code, 15880k reserved,
964k data, 216k init, 130240k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9c000 - 0xfffff000   ( 396 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc03a5000 - 0xc03db000   ( 216 kB)
      .data : 0xc02acf84 - 0xc039e094   ( 964 kB)
      .text : 0xc0100000 - 0xc02acf84   (1715 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
BUG: unable to handle kernel paging request at virtual address fffffffc
 printing eip:
f000fea7
*pde = 00003067
stopped custom tracer.
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<f000fea7>]    Not tainted VLI
EFLAGS: 00010083   (2.6.19-rt11.0-smp #1)
EIP is at 0xf000fea7
eax: c03a1f78   ebx: c034b9a0   ecx: c0160cfe   edx: 00000000
esi: 00010001   edi: c034b9a0   ebp: 00000000   esp: c03a1f0c
ds: 007b   es: 007b   ss: 0068   preempt: 00010002
Process swapper (pid: 0, ti=c03a0000 task=c03484c0 task.ti=c03a0000)
Stack: c0106cb3 c0142a1a dffff6c0 00000000 00000086 00000000 00000000
c0392280
       00000000 c034b9a0 c03922dc c014418e 00000000 c03a1f78 c03da7f8
00000000
       c0105ecf c03a1f74 00000001 00000078 00000000 c0392280 c0392280
c03dafe4
Call Trace:
 [<c0106cb3>] timer_interrupt+0x46/0x4c
 [<c0142a1a>] handle_IRQ_event+0x41/0xb7
 [<c014418e>] handle_level_irq+0xa4/0xee
 [<c0105ecf>] do_IRQ+0xcd/0xf6
 [<c01048ea>] common_interrupt+0x1a/0x20
 [<c02a9d24>] __spin_unlock_irqrestore+0xf/0x23
 [<c01430c4>] setup_irq+0x14a/0x1cf
 [<c03a55f7>] start_kernel+0x227/0x3c4
 [<c03a51ae>] unknown_bootoption+0x0/0x222
 =======================
Code: 11 fd ff eb ec eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5
83 ec 18 89 5d f8 8b 4d 0c e8 92 0e fd ff 81 c3 37 45 01 00 <89> 75 fc 8b
83 d8 ff ff ff 8b 30 8b 46 04 c7 00 14 00 63 10 8b
EIP: [<f000fea7>] 0xf000fea7 SS:ESP 0068:c03a1f0c
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 [<c011cc0f>] panic+0x50/0xf1
 [<c010528c>] die+0x2a2/0x2d6
 [<c02ab7e9>] do_page_fault+0x440/0x513
 [<c014b223>] __alloc_pages+0x55/0x284
 [<c02ab3a9>] do_page_fault+0x0/0x513
 [<c02a9ed1>] error_code+0x39/0x40
 [<c0160cfe>] __kmalloc+0x8a/0x95
 [<c0106cb3>] timer_interrupt+0x46/0x4c
 [<c0142a1a>] handle_IRQ_event+0x41/0xb7
 [<c014418e>] handle_level_irq+0xa4/0xee
 [<c0105ecf>] do_IRQ+0xcd/0xf6
 [<c01048ea>] common_interrupt+0x1a/0x20
 [<c02a9d24>] __spin_unlock_irqrestore+0xf/0x23
 [<c01430c4>] setup_irq+0x14a/0x1cf
 [<c03a55f7>] start_kernel+0x227/0x3c4
 [<c03a51ae>] unknown_bootoption+0x0/0x222
 =======================


Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
