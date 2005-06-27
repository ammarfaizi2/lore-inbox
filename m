Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVF0Gwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVF0Gwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVF0Gtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:49:36 -0400
Received: from tornado.reub.net ([60.234.136.108]:51603 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261887AbVF0Got (ORCPT
	<rfc822;<linux-kernel@vger.kernel.org>>);
	Mon, 27 Jun 2005 02:44:49 -0400
Message-ID: <42BFA05B.1090208@reub.net>
Date: Mon, 27 Jun 2005 18:44:43 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050624)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
References: <fa.h6rvsi4.j68fhk@ifi.uio.no>
In-Reply-To: <fa.h6rvsi4.j68fhk@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/06/2005 11:12 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm2/
> 
> 
> - A reminder that there is a vger mailing list for tracking patches which
>   are added to -mm.  Do
> 
>     `echo subscribe mm-commits | mail majordomo@vger.kernel.org'
> 
> - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
>   the recent PCI breakage sorted out.
> 
> - Big arch/cris update.

Some bad stuff seems to be happening here (this is new to -mm2; -mm1 did not 
have this problem).

It's 100% reproduceable, although seems to happen at slightly different places 
in the bootup, especially at the end.  Did I miss a patch for this?

reuben




Linux version 2.6.12-mm2 (root@tornado) (gcc version 4.0.0 20050622 (Red Hat 
4.0.0-13)) #1 SMP Mon Jun 27 01:19:41 NZST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f52e0
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/md2 console=ttyS1,57600
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2813.906 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515240k/524224k available (2133k kernel code, 8504k reserved, 920k 
data, 204k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5635.43 BogoMIPS (lpj=11270866)
Mount-cache hash table entries: 512
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5627.52 BogoMIPS (lpj=11255052)

monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 03
Total of 2 processors activated (11262.95 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
softlockup thread 0 started up.
Brought up 2 CPUs
softlockup thread 1 started up.
-> [0][1][ 524288]   0.0 [  0.0] (0): (   30446    15223)
-> [0][1][ 551882]   0.0 [  0.0] (0): (   12568    16550)
-> [0][1][ 580928]   0.0 [  0.0] (0): (   -2456    15787)
-> [0][1][ 611503]   0.0 [  0.0] (0): (   -4468     8899)
-> [0][1][ 643687]   0.0 [  0.0] (0): (  -10064     7247)
-> [0][1][ 677565]   0.0 [  0.0] (0): (    6817    12064)
-> [0][1][ 713226]   0.0 [  0.0] (0): (   15269    10258)
-> [0][1][ 750764]   0.0 [  0.0] (0): (   16819     5904)
-> found max.
[0][1] working set size found: 524288, cost: 30446
---------------------
| migration cost matrix (max_cache_size: 1048576, cpu: 2813 MHz):
---------------------
           [00]    [01]
[00]:     -     0.0(0)
[01]:   0.0(0)    -
--------------------------------
| cacheflush times [1]: 0.0 (60892)
| calibration delay: 0 seconds
--------------------------------
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb440, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Machine check exception polling timer started.
inotify device minor=63
Initializing Cryptographic API
Real Time Clock Driver v1.12
hw_random: RNG not detected
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 
seconds).
Hangcheck: Using monotonic_clock().
cn_fork is registered
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
  [<c0103ad0>] dump_stack+0x17/0x19
  [<c01cab4b>] spin_bug+0x5b/0x67
  [<c01cac9c>] _raw_spin_lock+0x78/0x7a
  [<c0314ad9>] _spin_lock+0x8/0xa
  [<c0313370>] schedule+0x6c0/0xd68
  [<c0100d31>] cpu_idle+0x64/0x66
  [<c01002c5>] rest_init+0x25/0x27
  [<c03fe8af>] start_kernel+0x154/0x167
  [<c010020f>] 0xc010020f
Kernel panic - not syncing: bad locking
  Badness in smp_call_function at arch/i386/kernel/smp.c:553
  [<c0103ad0>] dump_stack+0x17/0x19
  [<c010f980>] smp_call_function+0x137/0x13c
  [<c010fb49>] smp_send_stop+0x1e/0x27
  [<c011c2cf>] panic+0x4c/0x102
  [<c01cab57>] __spin_lock_debug+0x0/0xcd
  [<c01cac9c>] _raw_spin_lock+0x78/0x7a
  [<c0314ad9>] _spin_lock+0x8/0xa
  [<c0313370>] schedule+0x6c0/0xd68
  [<c0100d31>] cpu_idle+0x64/0x66
  [<c01002c5>] rest_init+0x25/0x27
  [<c03fe8af>] start_kernel+0x154/0x167
  [<c010020f>] 0xc010020f


