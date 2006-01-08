Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752614AbWAHJkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbWAHJkS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbWAHJkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:40:18 -0500
Received: from tornado.reub.net ([202.89.145.182]:18864 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1752614AbWAHJkR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:40:17 -0500
Message-ID: <43C0DDFB.6050806@reub.net>
Date: Sun, 08 Jan 2006 22:40:11 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060107)
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.15-mm2
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348B@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A1348B@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/01/2006 9:19 p.m., Brown, Len wrote:
>  
>>> 2. Notice above how the sky2 driver is being bailed out:
>>>
>>> ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
>>> sky2 Cannot find PowerManagement capability, aborting.
>>> sky2: probe of 0000:04:00.0 failed with error -5
>>>
>>> ...so I'm not sure if it's the driver or something else 
>>> like ACPI that is the root cause.
>> Could be acpi, yes.
> 
> Any difference if you boot with "acpi=off" or "pci=noacpi"?
> If that fixes it, then ACPI is shomehow involved in the problem.
> If it doesn't fix it, then ACPI is not involved.

Big difference, but probably not the sort of difference you were hoping for ;)


kernel /vmlinuz-2.6.15-mm2 ro root=/dev/md0 panic=60 console=ttyS0,57600 single
  acpi=off
    [Linux-bzImage, setup=0x1400, size=0x1842ed]

Linux version 2.6.15-mm2 (root@tornado.reub.net) (gcc version 4.1.0 20051222 
(Red Hat 4.1.0-0.12)) #1 SMP Sun Jan 8 11:50:13 NZDT 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fe2f800 (usable)
  BIOS-e820: 000000003fe2f800 - 000000003fe3f8e3 (ACPI NVS)
  BIOS-e820: 000000003ff2f800 - 000000003ff30000 (ACPI NVS)
  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fed13000 - 00000000fed1a000 (reserved)
  BIOS-e820: 00000000fed1c000 - 00000000feda0000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID:  Product ID: Grantsdale-G APIC at: 0xFEE00000
Processor #0 15:3 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Detected 2800.280 MHz processor.
Built 1 zonelists
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
Kernel command line: ro root=/dev/md0 panic=60 console=ttyS0,57600 single acpi=off
CPU 0 irqstacks, hard=c0405000 soft=c0403000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033572k/1046716k available (2142k kernel code, 12480k reserved, 715k 
data, 200k init, 129212k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5607.11 BogoMIPS (lpj=11214232)
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
mtrr: v2.0 (20020519)
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 04
Total of 1 processors activated (5607.11 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
Brought up 1 CPUs
migration_cost=0
NET: Registered protocol family 16
PCI: Using configuration type 1
ACPI: Subsystem revision 20051216
ACPI: Interpreter disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 209
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 193
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 185
PCI->APIC IRQ transform: 0000:00:1d.3[D] -> IRQ 169
PCI->APIC IRQ transform: 0000:00:1d.7[A] -> IRQ 209
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 185
PCI->APIC IRQ transform: 0000:00:1f.2[B] -> IRQ 193
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 193
PCI->APIC IRQ transform: 0000:04:00.0[A] -> IRQ 177
PCI->APIC IRQ transform: 0000:06:00.0[A] -> IRQ 201
PCI->APIC IRQ transform: 0000:06:02.0[A] -> IRQ 185
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: ffa00000-ffafffff
   PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:1c.0
   IO window: disabled.
   MEM window: ff600000-ff6fffff
   PREFETCH window: fdb00000-fdbfffff
PCI: Bridge: 0000:00:1c.1
   IO window: a000-afff
   MEM window: ff700000-ff7fffff
   PREFETCH window: fdc00000-fdcfffff
PCI: Bridge: 0000:00:1c.2
   IO window: disabled.
   MEM window: ff800000-ff8fffff
   PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:1c.3
   IO window: disabled.
   MEM window: ff900000-ff9fffff
   PREFETCH window: fde00000-fdefffff
PCI: Bridge: 0000:00:1e.0
   IO window: b000-bfff
   MEM window: ff500000-ff5fffff
   PREFETCH window: fe000000-fe7fffff
PCI: No IRQ known for interrupt pin A of device 0000:00:01.0. Probably buggy MP 
table.
PCI: No IRQ known for interrupt pin A of device 0000:00:1c.0. Probably buggy MP 
table.
PCI: No IRQ known for interrupt pin B of device 0000:00:1c.1. Probably buggy MP 
table.
PCI: No IRQ known for interrupt pin C of device 0000:00:1c.2. Probably buggy MP 
table.
PCI: No IRQ known for interrupt pin D of device 0000:00:1c.3. Probably buggy MP 
table.
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered<6>Time: tsc clocksource has been installed.

PCI: No IRQ known for interrupt pin A of device 0000:00:01.0. Probably buggy MP 
table.
pcie_portdrv_probe->Dev[2585:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: No IRQ known for interrupt pin A of device 0000:00:1c.0. Probably buggy MP 
table.
pcie_portdrv_probe->Dev[2660:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: No IRQ known for interrupt pin B of device 0000:00:1c.1. Probably buggy MP 
table.
pcie_portdrv_probe->Dev[2662:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: No IRQ known for interrupt pin C of device 0000:00:1c.2. Probably buggy MP 
table.
pcie_portdrv_probe->Dev[2664:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: No IRQ known for interrupt pin D of device 0000:00:1c.3. Probably buggy MP 
table.
pcie_portdrv_probe->Dev[2666:8086] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
0000:06:02.0: ttyS1 at I/O 0xbc00 (irq = 185) is a 16550A
0000:06:02.0: ttyS2 at I/O 0xbc08 (irq = 185) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
sky2 v0.11 addr 0xff720000 irq 177 Yukon-EC (0xb6) rev 1
sky2 eth0: addr 00:11:11:43:05:2f
sky2 0000:04:00.0: pci express error (0x0)
sky2 0000:04:00.0: pci express error (0x0)
sky2 0000:04:00.0: pci express error (0x0)
sky2 0000:04:00.0: pci express error (0x0)
sky2 0000:04:00.0: pci express error (0x0)
sky2 0000:04:00.0: pci express error (0x0)

<last few lines repeat over and over neverending>

reuben

