Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWFAJei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFAJei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWFAJei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:34:38 -0400
Received: from tornado.reub.net ([202.89.145.182]:17316 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750823AbWFAJeh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:34:37 -0400
Message-ID: <447EB4AD.4060101@reub.net>
Date: Thu, 01 Jun 2006 21:34:37 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060531)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
References: <20060601014806.e86b3cc0.akpm@osdl.org>
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/06/2006 8:48 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> 
> 
> - A cfq bug was fixed in mainline, so the git-cfq tree has been restored.
> 
> - Various lock-validator and genirq fixes have been added.  Should be
>   slightly less oopsy than 2.6.17-rc5-mm1.
> 
> - I just realised that I've been accidentally not updating the PCI tree for
>   a while.  Will be restored in next -mm.
> 
> - Has been booted and has passed various stress-tests on quad x86_64,
>   quad ancient-Xeon, quad power4, quad ia64, dual old-PIII and a modern
>   pentium-M laptop.  So if it breaks, it's your fault.

What an optimist if ever I've seen one ;)

Bootdata ok (command line is ro root=/dev/md0 panic=60 console=ttyS0,57600 single)
Linux version 2.6.17-rc5-mm2 (root@tornado.reub.net) (gcc version 4.1.1 20060525 
(Red Hat 4.1.1-1)) #2 SMP Thu Jun 1 21:17:50 NZST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003f670000 (usable)
  BIOS-e820: 000000003f670000 - 000000003f6e9000 (ACPI NVS)
  BIOS-e820: 000000003f6e9000 - 000000003f6ec000 (usable)
  BIOS-e820: 000000003f6ec000 - 000000003f6ff000 (ACPI data)
  BIOS-e820: 000000003f6ff000 - 000000003f700000 (usable)
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3f700000:c0900000)
Built 1 zonelists
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600 single
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBTYPES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... TYPEHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
  memory used by lock dependency info: 1120 kB
  per task-struct memory footprint: 1440 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                  | spin |wlock |rlock |mutex | wsem | rsem |
   --------------------------------------------------------------------------
                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
   --------------------------------------------------------------------------
               recursive read-lock:             |  ok  |             |  ok  |
   --------------------------------------------------------------------------
                 non-nested unlock:  ok  |  ok  |  ok  |  ok  |
   ------------------------------------------------------------
      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
       hard-irq read-recursion/123:  ok  |
       soft-irq read-recursion/123:  ok  |
       hard-irq read-recursion/132:  ok  |
       soft-irq read-recursion/132:  ok  |
       hard-irq read-recursion/213:  ok  |
       soft-irq read-recursion/213:  ok  |
       hard-irq read-recursion/231:  ok  |
       soft-irq read-recursion/231:  ok  |
       hard-irq read-recursion/312:  ok  |
       soft-irq read-recursion/312:  ok  |
       hard-irq read-recursion/321:  ok  |
       soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 210 testcases passed! |
---------------------------------
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
Memory: 1012508k/1039360k available (2694k kernel code, 25420k reserved, 1766k 
data, 216k init)
Calibrating delay using timer specific routine.. 6009.49 BogoMIPS (lpj=12018986)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
Freeing SMP alternatives: 28k freed
lockdep: disabled NMI watchdog.
Using local APIC timer interrupts.
result 12500192
Detected 12.500 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
lockdep: disabled NMI watchdog.
Calibrating delay using timer specific routine.. 6000.27 BogoMIPS (lpj=12000551)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU1: Thermal monitoring enabled (TM1)
               Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
Brought up 2 CPUs
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3000.062 MHz processor.
migration_cost=6
checking if image is initramfs... it is
Freeing initrd memory: 876k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Subsystem revision 20060310
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11 12)
Intel 82802 RNG detected
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
PCI-GART: No AMD northbridge found.
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
   IO window: 2000-2fff
   MEM window: 48000000-480fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.3
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
   IO window: 1000-1fff
   MEM window: disabled.
   PREFETCH window: disabled.
ACPI (acpi_bus-0192): Device `PEX0]is not power manageable [20060310]
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
ACPI (acpi_bus-0192): Device `PEX2]is not power manageable [20060310]
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 177
ACPI (acpi_bus-0192): Device `PEX3]is not power manageable [20060310]
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 185
ACPI (acpi_bus-0192): Device `PEX4]is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 169
ACPI (acpi_bus-0192): Device `PEX5]is not power manageable [20060310]
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 193
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 32768 (order: 9, 3670016 bytes)
TCP bind hash table entries: 16384 (order: 8, 1835008 bytes)
TCP: Hash tables configured (established 32768 bind 16384)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1149153727.584:1): initialized
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 169
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 177
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 185
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 169
assign_interrupt_mode Found MSI capability
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 193
assign_interrupt_mode Found MSI capability
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI Error (acpi_processor-0474): Getting cpuindex for acpiid 0x3 [20060310]
ACPI Error (acpi_processor-0474): Getting cpuindex for acpiid 0x4 [20060310]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 19 (level, low) -> IRQ 185
0000:06:03.0: ttyS1 at I/O 0x1000 (irq = 185) is a 16550A
0000:06:03.0: ttyS2 at I/O 0x1008 (irq = 185) is a 16550A
isa bounce pool size: 16 pages
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 4 RAM disks of 16384K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.0.38-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
e1000: 0000:01:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:13:20:60:b4:23
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 177
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings: hda:DMA, hdb:pio
hda: PIONEER DVD-RW DVR-111D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ACPI (acpi_bus-0192): Device `IDES]is not power manageable [20060310]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 185
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
ata1: SATA max UDMA/133 cmd 0xFFFFC20000016100 ctl 0x0 bmdma 0x0 irq 58
ata2: SATA max UDMA/133 cmd 0xFFFFC20000016180 ctl 0x0 bmdma 0x0 irq 58
ata3: SATA max UDMA/133 cmd 0xFFFFC20000016200 ctl 0x0 bmdma 0x0 irq 58
ata4: SATA max UDMA/133 cmd 0xFFFFC20000016280 ctl 0x0 bmdma 0x0 irq 58
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
  [<0000000000000000>]
PGD 0
Oops: 0010 [1] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm2 #2
RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
RSP: 0000:ffffffff80660f98  EFLAGS: 00010006
RAX: 0000000000003a00 RBX: ffffffff8090dec8 RCX: 0000000000000000
RDX: ffffffff8090dec8 RSI: ffffffff808fe100 RDI: 000000000000003a
RBP: ffffffff80660fb0 R08: 0000000000000001 R09: ffffffff802676aa
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000003a
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff808fa000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process idle (pid: 0, threadinfo ffffffff8090c000, task ffffffff80593760)
Stack: ffffffff80270132 ffffffff8025dbb1 ffffffff8094e084 ffffffff8090def0
        ffffffff802641a9  <EOI> ff6500005d4be8fa 65c900000020250c 00000010250c8b48
        f700001fd8e98148 7400000003582444
Call Trace:


Code:  Bad RIP value.
RIP  [<0000000000000000>] RSP <ffffffff80660f98>
CR2: 0000000000000000
  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
  BUG: warning at kernel/lockdep.c:1853/trace_hardirqs_on()

Call Trace:
   [<ffffffff8026e6ed>] show_trace+0xad/0x225
         [<ffffffff8026e87a>] dump_stack+0x15/0x1b  [<ffffffff802a05da>] 
trace_hardirqs_on+0xa1/0x124
         [<ffffffff80276fec>] smp_send_stop+0x4c/0x68
         [<ffffffff8028a491>] panic+0xa7/0x220  [<ffffffff80216376>] 
do_exit+0x74/0x94f
         [<ffffffff8020b195>] do_page_fault+0x895/0x9c4
         [<ffffffff802649dd>] error_exit+0x0/0x8e
Rebooting in 60 seconds..BUG: warning at kernel/panic.c:114/panic()

Call Trace:
   [<ffffffff8026e6ed>] show_trace+0xad/0x225
         [<ffffffff8026e87a>] dump_stack+0x15/0x1b  [<ffffffff8028a55e>] 
panic+0x174/0x220
         [<ffffffff80216376>] do_exit+0x74/0x94f  [<ffffffff8020b195>] 
do_page_fault+0x895/0x9c4
         [<ffffffff802649dd>] error_exit+0x0/0x8e

Hardware posted at http://www.reub.net/files/kernel/system-hardware

Box has MSI capabilities and MSI compiled in.

Reuben

