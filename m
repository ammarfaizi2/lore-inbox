Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWCNQno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWCNQno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWCNQnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:43:43 -0500
Received: from mxsf17.cluster1.charter.net ([209.225.28.217]:26028 "EHLO
	mxsf17.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751911AbWCNQnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:43:43 -0500
Message-ID: <4416F14E.1040708@cybsft.com>
Date: Tue, 14 Mar 2006 10:37:34 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>
Subject: Re: 2.6.16-rc6-rt3
References: <20060314084658.GA28947@elte.hu> <4416C6DD.80209@cybsft.com> <20060314142458.GA21796@elte.hu>
In-Reply-To: <20060314142458.GA21796@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------000205000907030901050406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000205000907030901050406
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
>> This one doesn't want to boot on the old SMP box. Log and config attached.
> 
>>  [<c0111e19>] do_page_fault+0x36f/0x48a (88)
>>  [<c010357f>] error_code+0x4f/0x54 (76)
>>  [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
>>  [<c013321c>] simplify_symbols+0x81/0xf4 (40)
>>  [<c0133e2d>] load_module+0x637/0x968 (168)
>>  [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
>>  [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
> 
> hm, this seems to suggest some module building mismatch. Could you 
> double-check that by doing a full rebuild?
> 
> 	Ingo
> 

OK. Still having problems. This time I started from scratch with 2.6.15
then patch-2.6.16-rc6 then patch-2.6.16-rc6-rt3. Log and config attached.

-- 
   kr

--------------000205000907030901050406
Content-Type: text/plain;
 name="2.6.16-rc6-rt3-3.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.16-rc6-rt3-3.cap"

Linux version 2.6.16-rc6-rt3 (kr@porky.cybersoft.int) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 SMP PREEMPT Tue Mar 14 09:44:24 CST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff9e000 (usable)
 BIOS-e820: 000000001ff9e000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 930.992 MHz processor.
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,38400 console=tty0 nmi_watchdog=1 
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 2048 (order: 11, 32768 bytes)
requested: 50000000  calculated 49992350 ns 50 cyc error: 7650
Event source pit installed with caps set: 01
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 506304k/523896k available (1785k kernel code, 17208k reserved, 921k data, 280k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1862.57 BogoMIPS (lpj=931289)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1861.67 BogoMIPS (lpj=930836)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3724.25 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Event source lapic installed with caps set: 04
checking TSC synchronization across 2 CPUs: passed.
Event source lapic installed with caps set: 04
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 433k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfc03e, last bus=4
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 0880-08bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:0d: ioport range 0x800-0x85f could not be reserved
pnp: 00:0d: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0d: ioport range 0x860-0x8ff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc000000-fdffffff
  PREFETCH window: f4000000-f5ffffff
PCI: Bridge: 0000:02:1f.0
  IO window: disabled.
  MEM window: fb000000-fb0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: fb000000-fbffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: f9000000-faffffff
  PREFETCH window: 30000000-300fffff
No per-cpu room for modules.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
nvidiafb: PCI id - 10de002d
nvidiafb: Actual id - 10de002d
nvidiafb: nVidia device/chipset 10DE002D
nvidiafb: HW is currently programmed for CRT
nvidiafb: Using CRT on CRTC 0
nvidiafb: MTRR set to ON
nvidiafb: PCI nVidia NV2 framebuffer (32MB @ 0xF4000000)
ACPI: Power Button (FF) [PWRF]
ibm_acpi: ec object not found
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 0000:00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG CD-R/RW SW-248F, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 9, 2490368 bytes)
TCP bind hash table entries: 32768 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Testing NMI watchdog ... OK.
Starting balanced_irq
Using IPI Shortcut mode
*****************************************************************************
*                                                                           *
requested: 50000000  calculated 49999999 ns 46549597 cyc error: 1
Time: tsc clocksource has been installed.
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_RT_MUTEXES                                             *
*        CONFIG_DEBUG_PREEMPT                                               *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************
Freeing unused kernel memory: 280k freed
Could not allocate 8 bytes percpu data
BUG: Unable to handle kernel paging request at virtual address f3010000
 printing eip:
c0131c79
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c0131c79>]    Not tainted VLI
EFLAGS: 00010297   (2.6.16-rc6-rt3 #1) 
EIP is at __find_symbol+0x37/0x1da
eax: ffffffff   ebx: 000004b0   ecx: c02fe964   edx: c02fab00
esi: f3010000   edi: e08255d0   ebp: c1eafe9c   esp: c1eafe8c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process insmod (pid: 804, threadinfo=c1eae000 task=c1e91150 stack_left=7768 worst_left=-1)
Stack: <0>000004b0 e082adc0 e082bc80 e08255d0 c1eafec8 c0132cc6 e08255d0 c1eafeb4 
       c1eafeb8 00000001 00000000 e082adc0 e082adc0 00000370 00000032 c1eafef0 
       c013321c e0824930 0000000b e08255d0 e082bc80 00000000 e0824930 e082bc8d 
Call Trace:
 [<c01038fb>] show_stack_log_lvl+0xa5/0xad (44)
 [<c0103a67>] show_registers+0x137/0x1a0 (44)
 [<c0103c3b>] die+0xf3/0x16f (56)
 [<c0111e19>] do_page_fault+0x36f/0x48a (88)
 [<c010357f>] error_code+0x4f/0x54 (76)
 [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
 [<c013321c>] simplify_symbols+0x81/0xf4 (40)
 [<c0133e2d>] load_module+0x637/0x968 (168)
 [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
 [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02bd871>] .... _raw_spin_lock_irqsave+0x11/0x33
.....[<c0103b87>] ..   ( <= die+0x3f/0x16f)

------------------------------
| showing all locks held by: |  (insmod/804 [c1e91150, 119]):
------------------------------

#001:             [c0311f24] {module_mutex.lock}
... acquired at:               rt_down_interruptible+0x15/0x32

Code: 00 00 00 00 b8 80 85 2f c0 3d 04 cb 2f c0 c7 45 f0 00 00 00 00 73 4a 89 c2 b9 a4 d6 2f c0 8b 5d f0 8b 7d 08 8b 34 dd 84 85 2f c0 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 11 8b 
 BUG: nonzero lock count 1 at exit time?
          insmod:  804 [c1e91150, 119]
 [<c0103854>] show_trace+0x13/0x15 (20)
 [<c010392e>] dump_stack+0x16/0x18 (20)
 [<c013067f>] rt_mutex_debug_check_no_locks_held+0x60/0x227 (44)
 [<c011c837>] do_exit+0x3e3/0x45b (32)
 [<c0103cb7>] do_trap+0x0/0x97 (52)
 [<c0111e19>] do_page_fault+0x36f/0x48a (88)
 [<c010357f>] error_code+0x4f/0x54 (76)
 [<c0132cc6>] resolve_symbol+0x22/0x5d (44)
 [<c013321c>] simplify_symbols+0x81/0xf4 (40)
 [<c0133e2d>] load_module+0x637/0x968 (168)
 [<c01341c1>] sys_init_module+0x3d/0x1d3 (28)
 [<c0102a1b>] sysenter_past_esp+0x54/0x75 (-8116)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (insmod/804 [c1e91150, 120]):
------------------------------

#001:             [c0311f24] {module_mutex.lock}
... acquired at:               rt_down_interruptible+0x15/0x32

BUG: insmod/804, lock held at task exit time!
 [c0311f24] {module_mutex.lock}
.. ->owner: c1e91152
.. held by:            insmod:  804 [c1e91150, 120]
... acquired at:               rt_down_interruptible+0x15/0x32
hm, PI interest held at exit time? Task:
          insmod:  804 [c1e91150, 120]-------------------------
| waiter struct dfd6ff2c:
| w->list_entry: [DP:c0311f2c/c0311f2c|SP:c0311f34/c0311f34|PRI:117]
| w->pi_list_entry: [DP:c1e916a0/c1e916a0|SP:c1e916a8/c1e916a8|PRI:117]

| lock:
 [c0311f24] {module_mutex.lock}
.. ->owner: c1e91152
.. held by:            insmod:  804 [c1e91150, 120]
... acquired at:               rt_down_interruptible+0x15/0x32
| w->ti->task:
          insmod:  805 [c1eac070, 117]| blocked at:  0x11111111
-------------------------
softirq-tasklet/8[CPU#0]: BUG in rt_mutex_debug_task_free at kernel/rtmutex-debug.c:387
 [<c0103854>] show_trace+0x13/0x15 (20)
 [<c010392e>] dump_stack+0x16/0x18 (20)
 [<c011ab8e>] __WARN_ON+0x41/0x57 (40)
 [<c01309c1>] rt_mutex_debug_task_free+0x29/0x96 (24)
 [<c0117227>] free_task+0x15/0x26 (20)
 [<c011730e>] __put_task_struct_cb+0xd6/0xdc (16)
 [<c013c3ea>] rcu_process_callbacks+0x60/0x75 (20)
 [<c011ed93>] __tasklet_action+0xab/0xe1 (24)
 [<c011edff>] tasklet_action+0x36/0x3e (28)
 [<c011efbb>] ksoftirqd+0xfb/0x18a (32)
 [<c012aea8>] kthread+0x7e/0xa7 (40)
 [<c01010d1>] kernel_thread_helper+0x5/0xb (1043021852)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02bd871>] .... _raw_spin_lock_irqsave+0x11/0x33
.....[<c011ab5b>] ..   ( <= __WARN_ON+0xe/0x57)


--------------000205000907030901050406
Content-Type: application/x-gzip;
 name="config.porky.2.6.16-rc6-rt3.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.porky.2.6.16-rc6-rt3.gz"

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
--------------000205000907030901050406--
