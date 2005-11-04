Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVKDRWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKDRWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKDRWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:22:50 -0500
Received: from mail.portrix.net ([212.202.157.208]:5544 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S1750747AbVKDRWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:22:50 -0500
Message-ID: <436B98E0.3010501@ppp0.net>
Date: Fri, 04 Nov 2005 18:22:40 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050602 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: different oops' on xeon with smp kernel
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mainboard came back from warranty repair recently and since
then SMP kernels oops very early at boot at different places.
Uniprocessor kernels work fine for extended periods of time.
Can this be software related or is this a hardware bug? If
hardware more likely the motherboard or the cpu? I tested
different kernels as old as 2.6.11.9 and as new as 2.6.14 here
are some oopses (one full boot log, the others trimmed):

Linux version 2.6.11.9 (jdittmer@ds666) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #9 SMP Fri May 13 11:36:22 CEST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffc0000 (usable)
 BIOS-e820: 000000007ffc0000 - 000000007ffd0000 (ACPI data)
 BIOS-e820: 000000007ffd0000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x07] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 7, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x08] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 8, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x09] address[0xfec80400] gsi_base[48])
IOAPIC[2]: apic_id 9, version 32, address 0xfec80400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7fb80000)
Built 1 zonelists
Kernel command line: root=/dev/md7 ro netconsole=@/,514@192.168.2.134/ console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2800.514 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074672k/2096896k available (2415k kernel code, 21420k reserved, 953k data, 220k init, 1179392k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 05
per-CPU timeslice cutoff: 1462.65 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/6 eip 3000
Initializing CPU#1
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 05
Total of 2 processors activated (11075.58 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
Unable to handle kernel paging request at virtual address 8528244c
 printing eip:
c030bab0
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in:
CPU:    1
EIP:    0060:[<c030bab0>]    Not tainted VLI
EFLAGS: 00010282   (2.6.11.9)
EIP is at netlink_broadcast+0x1f0/0x390
eax: c21c6e80   ebx: 00000000   ecx: 00000001   edx: c21c6e80
esi: 00000000   edi: 00000000   ebp: c2160c80   esp: c2181ecc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c2180000 task=c2151aa0)
Stack: 00000000 00000000 fffffbe6 000000d0 c21c6e80 c2160c80 00000000 00000001
       00000000 00000000 00000000 000000d0 c21c6e80 00000000 3de4a000 c037fcae
       c2181f34 c21c6e80 c21a6449 00000000 00000000 c01f64b5 c2160c80 c21c6e80
Call Trace:
 [<c01f64b5>] send_uevent+0x145/0x1a0
 [<c01f68e6>] kobject_hotplug+0x266/0x2f0
 [<c01f5cf1>] kobject_add+0xe1/0x100
 [<c0466385>] acpi_scan_init+0x18/0x68
 [<c044e9eb>] do_initcalls+0x2b/0xc0
 [<c01003a4>] init+0x84/0x1a0
 [<c0100320>] init+0x0/0x1a0
 [<c0101375>] kernel_thread_helper+0x5/0x10
Code: ae e8 8d 76 00 89 14 24 e8 2e 69 fe ff 8b 54 24 10 8b 82 a0 00 00 00 48 75 51 0f ae e8 8d 76 00 8b 44 24 10 89 00 24 e8 0f 69 fe <ff> 8b 4c 24
28 85 c9 74 22 8b 54 24 24 85 d2 74 07 f6 44 24 68
 <0>Kernel panic - not syncing: Attempted to kill init!


[17179569.184000] Linux version 2.6.14-xeon (jdittmer@ds666) (gcc version 4.0.2 (Debian 4.0.2-2)) #5 SMP Thu Nov 3 21:36:26 CET 2005

<snip>

[17179571.468000] ICH4: not 100% native mode: will probe irqs later
[17179571.476000]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
[17179571.484000]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
[17179572.472000] hdc: SONY CD-RW CRX175E2, ATAPI CD/DVD-ROM drive
[17179572.816000] ide1 at 0x170-0x177,0x376 on irq 15
[17179572.820000] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[17179572.832000]  printing eip:
[17179572.832000] c0366e8a
[17179572.836000] *pde = 00000000
[17179572.840000] Oops: 0002 [#1]
[17179572.844000] SMP
[17179572.848000] Modules linked in:
[17179572.852000] CPU:    1
[17179572.852000] EIP:    0060:[<c0366e8a>]    Not tainted VLI
[17179572.852000] EFLAGS: 00010082   (2.6.14-xeon)
[17179572.864000] EIP is at _spin_lock_irqsave+0x5/0x1d
[17179572.872000] eax: 00000282   ebx: 00000000   ecx: c238e38c   edx: 00000004
[17179572.880000] esi: 00000004   edi: 00000000   ebp: f7d95fb8   esp: f7d95f94
[17179572.888000] ds: 007b   es: 007b   ss: 0068
[17179572.892000] Process khelper (pid: 766, threadinfo=f7d94000 task=c2390550)
[17179572.900000] Stack: c011869b 00000000 00000000 00000000 c0120625 000002ff c213debc 00000000
[17179572.912000]        00000000 00000000 c012c59b 000002ff c213ded4 00000000 00000000 00000001
[17179572.924000]        00000000 0000007b 00010000 00000000 c012c507 c0101161 c213debc 00000000
[17179572.932000] Call Trace:
[17179572.936000]  [<c011869b>] complete+0x15/0x52
[17179572.940000]  [<c0120625>] sys_wait4+0x43/0x47
[17179572.948000]  [<c012c59b>] wait_for_helper+0x94/0xac
[17179572.952000]  [<c012c507>] wait_for_helper+0x0/0xac
[17179572.960000]  [<c0101161>] kernel_thread_helper+0x5/0xb
[17179572.964000] Code: 00 01 0f 94 c0 b9 01 00 00 00 84 c0 75 09 f0 81 02 00 00 00 01 30 c9 89 c8 c3 f0 83 28 01 79 05 e8 04 e3 ff ff c3 89 c2 9c 58
fa <f0> fe 0a 79 12 a9 00 02 00 00 74 01 fb f3 90 80 3a 00 7e f9 fa


[17179572.988000]  [17179569.184000] Linux version 2.6.14-xeon (jdittmer@ds666) (gcc version 4.0.2 (Debian 4.0.2-2)) #5 SMP Thu Nov 3 21:36:26 CET 2005

<snip>

[17179570.764000] nvidiafb: PCI nVidia NV25 framebuffer (64MB @ 0xD0000000)
[17179570.772000] isapnp: Scanning for PnP cards...
[17179571.132000] isapnp: No Plug & Play device found
[17179571.156000] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[17179571.164000]  printing eip:
[17179571.168000] c0145e46
[17179571.172000] *pde = 00000000
[17179571.176000] Oops: 0002 [#1]
[17179571.176000] SMP
[17179571.180000] Modules linked in:
[17179571.184000] CPU:    1
[17179571.184000] EIP:    0060:[<c0145e46>]    Not tainted VLI
[17179571.184000] EFLAGS: 00010046   (2.6.14-xeon)
[17179571.200000] EIP is at cache_alloc_refill+0x17e/0x26f
[17179571.204000] eax: 00000000   ebx: 00000008   ecx: c20ff500   edx: 00000000
[17179571.216000] esi: c20bd2c0   edi: 00000008   ebp: c2127780   esp: f7cb9f20
[17179571.224000] ds: 007b   es: 007b   ss: 0068
[17179571.228000] Process khelper (pid: 704, threadinfo=f7cb8000 task=c213f550)
[17179571.236000] Stack: c20f0b80 000000d0 00000000 c20fd2e8 c20fd2c0 c20bd2dc 0000000f 00000286
[17179571.248000]        c2391000 c2391000 f7cb8000 c0146136 c20ff500 000000d0 c2391000 c0167bd5
[17179571.256000]        c20ff500 000000d0 00001000 c03ccf60 c2391000 c2391000 f7cb8000 c0101a35
[17179571.268000] Call Trace:
[17179571.272000]  [<c0146136>] kmem_cache_alloc+0x49/0x4b
[17179571.276000]  [<c0167bd5>] do_execve+0x20/0x229
[17179571.284000]  [<c0101a35>] sys_execve+0x3d/0x8a
[17179571.288000]  [<c0102d3d>] syscall_call+0x7/0xb
[17179571.292000]  [<c012c4de>] ____call_usermodehelper+0xcb/0xf4
[17179571.300000]  [<c012c413>] ____call_usermodehelper+0x0/0xf4
[17179571.308000]  [<c0101161>] kernel_thread_helper+0x5/0xb
[17179571.316000] Code: 48 01 89 4d 00 8b 46 10 83 c0 01 89 46 10 8b 56 14 8b 4c 24 14 8b 14 91 89 56 14 8b 4c 24 30 39 41 20 77 b9 89 fb 8b 16 8b 46
04 <89> 42 04 89 10 c7 06 00 01 10 00 c7 46 04 00 02 20 00 83 7e 14
[17179571.336000]  <6>PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[17179571.348000] PNP: PS/2 controller doesn't have AUX irq; using default 12
[17179571.356000] serio: i8042 AUX port at 0x60,0x64 irq 12
[17179571.364000] serio: i8042 KBD port at 0x60,0x64 irq 1
[17179571.372000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled


[17179569.184000] Linux version 2.6.14-xeon (jdittmer@ds666) (gcc version 4.0.2 (Debian 4.0.2-2)) #5 SMP Thu Nov 3 21:36:26 CET 2005

<snip>

[17179572.916000] nvidiafb: PCI nVidia NV25 framebuffer (64MB @ 0xD0000000)
[17179572.924000] isapnp: Scanning for PnP cards...
[17179573.284000] isapnp: No Plug & Play device found
[17179573.304000] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[17179573.308000]  printing eip:
[17179573.308000] c0145d67
[17179573.308000] *pde = 00000000
[17179573.308000] Oops: 0002 [#1]
[17179573.308000] SMP
[17179573.308000] Modules linked in:
[17179573.308000] CPU:    1
[17179573.308000] EIP:    0060:[<c0145d67>]    Not tainted VLI
[17179573.308000] EFLAGS: 00010046   (2.6.14-xeon)
[17179573.308000] EIP is at cache_alloc_refill+0x9f/0x26f
[17179573.308000] eax: 00000000   ebx: ffffffff   ecx: c20f0a80   edx: 00000000
[17179573.308000] esi: c20ace00   edi: ffffffff   ebp: c2126800   esp: c217dda0
[17179573.308000] ds: 007b   es: 007b   ss: 0068
[17179573.308000] Process swapper (pid: 1, threadinfo=c217c000 task=c2121a70)
[17179573.308000] Stack: 13ad0f81 c217c000 c01185f0 c20ece28 c20ece00 c20ace1c 0000000f 00000282
[17179573.308000]        c2107a64 c213dde0 c217de38 c0146136 c20f0a80 000000d0 00000000 c0173ecd
[17179573.308000]        c20f0a80 000000d0 c2107a64 00000000 c2107a64 c213dde0 00000000 c016b5a3
[17179573.308000] Call Trace:
[17179573.308000]  [<c01185f0>] __wake_up+0x3a/0x4b
[17179573.308000]  [<c0146136>] kmem_cache_alloc+0x49/0x4b
[17179573.308000]  [<c0173ecd>] d_alloc+0x20/0x198
[17179573.308000]  [<c016b5a3>] __lookup_hash+0x81/0xb4
[17179573.308000]  [<c016b5f5>] lookup_hash+0x1f/0x23
[17179573.308000]  [<c016b68d>] lookup_one_len+0x94/0x9c
[17179573.308000]  [<c0193155>] create_dir+0x42/0x1b0
[17179573.308000]  [<c0193325>] sysfs_create_dir+0x38/0x75
[17179573.308000]  [<c01f34d2>] create_dir+0x19/0x45
[17179573.308000]  [<c01f36e1>] kobject_add+0x70/0xb5
[17179573.308000]  [<c025cee0>] class_device_add+0xb0/0x223
[17179573.308000]  [<c025cd71>] class_device_initialize+0x1a/0x24
[17179573.308000]  [<c025d0e9>] class_device_create+0x79/0x9b
[17179573.308000]  [<c0241d7a>] tty_register_device+0x68/0xcc
[17179573.308000]  [<c016590d>] cdev_add+0x46/0x4a
[17179573.308000]  [<c01658aa>] exact_match+0x0/0x5
[17179573.308000]  [<c02420f7>] tty_register_driver+0x1e0/0x258
[17179573.308000]  [<c043d3f2>] legacy_pty_init+0x1fb/0x236
[17179573.308000]  [<c043d65f>] pty_init+0x5/0xd
[17179573.308000]  [<c0426978>] do_initcalls+0x54/0xb6
[17179573.308000]  [<c04443e5>] netfilter_init+0x55/0x85
[17179573.308000]  [<c0100375>] init+0x69/0x1f4
[17179573.308000]  [<c010030c>] init+0x0/0x1f4
[17179573.308000]  [<c0101161>] kernel_thread_helper+0x5/0xb
[17179573.308000] Code: 85 c0 0f 85 5a 01 00 00 85 db 7e 4f 8b 44 24 10 8b 30 39 c6 0f 84 2a 01 00 00 8b 46 10 8b 54 24 30 39 42 20 77 6f 8b 16 8b 46
04 <89> 42 04 89 10 c7 06 00 01 10 00 c7 46 04 00 02 20 00 83 7e 14
[17179573.308000]  <0>Kernel panic - not syncing: Attempted to kill init!
[17179573.308000]

I can provide .config and lspci on demand. But I fear it is a hardware
bug :(.

Thanks for any hints,

Jan
