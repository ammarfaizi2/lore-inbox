Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbUKHG6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUKHG6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 01:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbUKHG6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 01:58:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17597 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261760AbUKHG5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 01:57:40 -0500
Date: Mon, 8 Nov 2004 08:59:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       diffie@blazebox.homeip.net
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041108075934.GA4602@elte.hu>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041107024841.402c16ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107024841.402c16ed.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Paul Blazejowski <diffie@gmail.com> wrote:
> >
> > Andrew, 
> > 
> > mm3 oopses right at the startup, below is the captured output from
> > serial console.
> 
> Weird.  Can you send me the .config?

reproducible here too with Paul's .config.

	Ingo

Linux version 2.6.10-rc1-mm3-RT-V0.7.18 (mingo@jupiter) (gcc version 3.4.1 20040831 (Red Hat 3.4.1-10)) #21 Mon Nov 8 08:49:12 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 261936
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32560 pages, LIFO batch:7
early console enabled
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000fa8b0
ACPI: XSDT (v001 A M I  OEMXSDT  0x01000415 MSFT 0x00000097) @ 0x3ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x01000415 MSFT 0x00000097) @ 0x3ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x01000415 MSFT 0x00000097) @ 0x3ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x01000415 MSFT 0x00000097) @ 0x3ff40040
ACPI: DSDT (v001  K8V__ K8V__086 0x00000086 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Real-Time Preemption Support (c) Ingo Molnar
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hdb1 3 earlyprintk=serial,ttyS0,38400 console=ttyS0,38400 console=tty0 nmi_watchdog=2 profile=0 debug
kernel profiling enabled (shift: 0)
CPU 0 irqstacks, hard=c0460000 soft=c045f000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2040.350 MHz processor.
Using tsc for high-res timesource
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024808k/1047744k available (2426k kernel code, 22548k reserved, 816k data, 184k init, 130240k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4022.27 BogoMIPS (lpj=2011136)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU: After vendor identify, caps:  078bfbff e1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: After all inits, caps:        078bfbff e1d3fbff 00000000 00000010
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
spawn_desched_task(00000000)
desched cpu_callback 3/00000000
ksoftirqd started up.
softirq RT prio: 24.
desched cpu_callback 2/00000000
testing NMI watchdog ... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
desched thread 0 started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041015
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SGI XFS with ACLs, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
vesafb: probe of vesafb0 failed with error -6
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0298e0a
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in:
CPU:    0
EIP:    0060:[<c0298e0a>]    Not tainted VLI
EFLAGS: 00010296   (2.6.10-rc1-mm3-RT-V0.7.18) 
EIP is at class_hotplug_name+0xa/0x10
eax: 00000000   ebx: c03ebc20   ecx: 0000007d   edx: c0298e00
esi: c03ebc10   edi: f7d93180   ebp: f7d93100   esp: c2281e74
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process swapper (pid: 1, threadinfo=c2281000 task=c2283770)
Stack: c023a258 c03ebc20 f7d93114 000041ed 00000002 f7d93114 f7d93114 f7d32800 
       c0371e1f c01a4fd8 00000000 c22a1858 f7d93118 00000000 f7d93114 f7d9315a 
       f7d93114 c22ae4e8 00000000 c22ae4d4 c02399c3 f7d93114 00000001 f7d93114 
Call Trace:
 [<c023a258>] kobject_hotplug+0x2b8/0x2d0 (4)
 [<c01a4fd8>] sysfs_create_dir+0x38/0xa0 (36)
 [<c02399c3>] kobject_add+0xf3/0x110 (44)
 [<c0299167>] class_device_add+0x87/0x150 (24)
 [<c02990ca>] class_device_initialize+0x1a/0x30 (16)
 [<c0299757>] class_simple_device_add+0xa7/0x130 (24)
 [<c027b558>] tty_register_device+0x68/0xd0 (40)
 [<c029a115>] kobj_map+0x125/0x130 (32)
 [<c01702e6>] cdev_add+0x46/0x50 (32)
 [<c0170270>] exact_match+0x0/0x10 (20)
 [<c027b885>] tty_register_driver+0x165/0x250 (12)
 [<c0443b13>] legacy_pty_init+0x293/0x2d0 (40)
 [<c0443e25>] pty_init+0x5/0x10 (12)
 [<c042c924>] do_initcalls+0x54/0xd0 (4)
 [<c0100430>] init+0x0/0x130 (16)
 [<c0100465>] init+0x35/0x130 (12)
 [<c01042f0>] kernel_thread_helper+0x0/0x10 (12)
 [<c01042f5>] kernel_thread_helper+0x5/0x10 (4)
Code: c0 75 03 8b 42 2c 3d 04 bc 3e c0 74 04 31 c0 f3 c3 8b 52 34 b8 01 00 00 00 85 d2 75 f2 31 c0 eb ee 8b 44 24 08 83 e8 08 8b 40 3c <8b> 00 c3 8d 76 00 83 ec 3c 89 7c 24 34 8b 7c 24 44 89 6c 24 38 
 <0>Kernel panic - not syncing: Attempted to kill init!
 
