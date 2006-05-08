Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWEHA5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWEHA5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 20:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWEHA5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 20:57:39 -0400
Received: from web52608.mail.yahoo.com ([206.190.48.211]:3684 "HELO
	web52608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932089AbWEHA5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 20:57:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zNv01CwY4FwSbhVMbL4laLQFquvD6Al1sZbCgv4hhbFfKuXivfh6O77FbY1dvrpAQITf3XJssL8MeFJ0rszDJQ58CodfoTw6el7m2lv+wzFKRRRit+mFUk3fc/D+CjkaW4BajJKdLpgDNQUBaqysZhSoIUKqNHPYv2vlA30VbFc=  ;
Message-ID: <20060508005737.65808.qmail@web52608.mail.yahoo.com>
Date: Mon, 8 May 2006 10:57:37 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: 2.6.16.1 & D state processes
To: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <1146640680.14649.1.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Mike Galbraith <efault@gmx.de> wrote:
> On Wed, 2006-05-03 at 17:04 +1000, Srihari
> Vijayaraghavan wrote:
> 
> > Any clues?
> 
> Nope.

OK. Thx. (Mike & Andrew, pls let me know if you want
to be removed from the cc list.)

I heard that a few colleagues are experiencing the
same problem as well on their machines (all IBM
NetVista P-IV desktops) on FC5, which goes to prove
that I'm not alone.

(I've suggested them to try "noapic" kernel boot
parameter with FC5 kernel.)

To my untrained eyes, this is the key difference
between 2.6.IOAPIC & 2.6.no-IOAPIC in /proc/interrupts
in ref to timer (which I suspect the source of the
problem; correct me if I'm wrong):
2.6.16.14.IOAPIC: 0: NNNNN IO-APIC-edge timer
2.6.16.14.no-IOAPIC: 0: NNNNN XT-PIC timer

Here's dmesg with apic=debug:
Linux version 2.6.16.14 (xxxxxxx@yyyyyyy) (gcc version
4.1.0 20060304
(Red Hat 4.1.0-3)) #1 Fri May 5 14:41:31 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800
(usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000001f6f0000
(usable)
 BIOS-e820: 000000001f6f0000 - 000000001f6fb000 (ACPI
data)
 BIOS-e820: 000000001f6fb000 - 000000001f700000 (ACPI
NVS)
 BIOS-e820: 000000001f700000 - 000000001f780000
(usable)
 BIOS-e820: 000000001f780000 - 0000000020000000
(reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000
(reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000
(reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000
(reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000
(reserved)
503MB LOWMEM available.
found SMP MP-table at 000f61d0
On node 0 totalpages: 128896
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 124800 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI present.
ACPI: RSDP (v000 PTLTD                                
) @ 0x000f6260
ACPI: RSDT (v001 PTLTD    RSDT   0x060400d0  LTP
0x00000000) @ 0x1f6f7325
ACPI: FADT (v001 IBM    NETVISTA 0x060400d0 PTL 
0x00000001) @ 0x1f6faee2
ACPI: TCPA (v001 IBM    NETVISTA 0x060400d0 PTL 
0x00000001) @ 0x1f6faf56
ACPI: MADT (v001 PTLTD  	 APIC   0x060400d0  LTP
0x00000000) @ 0x1f6faf88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x060400d0  LTP
0x00000001) @ 0x1f6fafd8
ACPI: DSDT (v001    IBM Yelotail 0x060400d0 MSFT
0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000]
gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000,
GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high
level)
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap:
20000000:dec00000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ rhgb
console=ttyS0,115200 console=tty0 apic=debug
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c02ff000 soft=c02fe000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2392.752 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6,
262144 bytes)
Inode-cache hash table entries: 32768 (order: 5,
131072 bytes)
Memory: 507228k/515584k available (1344k kernel code,
7700k reserved, 532k data, 136k init, 0k highmem)
Checking if this processor honours the WP bit even in
supervisor mode... Ok.
Calibrating delay using timer specific routine..
4792.69 BogoMIPS (lpj=9585392)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary
module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000
00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000
00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps: bfebfbff 00000000 00000000
00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Checking 'hlt' instruction... OK.
Getting VERSION: 50014
Getting VERSION: 50014
Getting ID: 0
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-16, 1-17, 1-18, 1-19, 1-20,
1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2392.2093 MHz.
..... host bus clock speed is 132.3671 MHz.
checking if image is initramfs... it is
Freeing initrd memory: 896k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd98d, last
bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI quirk: region 1000-107f claimed by ICH4
ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table
[\_SB_.PCI0.SLOT._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11
12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *9 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11
12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11
12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 *9 10 11
12 14 15)
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................
IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  1    0    0   0   0    1    1    41
 03 001 01  0    0    0   0   0    1    1    49
 04 001 01  0    0    0   0   0    1    1    51
 05 001 01  0    0    0   0   0    1    1    59
 06 001 01  0    0    0   0   0    1    1    61
 07 001 01  0    0    0   0   0    1    1    69
 08 001 01  0    0    0   0   0    1    1    71
 09 001 01  0    1    0   0   0    1    1    79
 0a 001 01  0    0    0   0   0    1    1    81
 0b 001 01  0    0    0   0   0    1    1    89
 0c 001 01  0    0    0   0   0    1    1    91
 0d 001 01  0    0    0   0   0    1    1    99
 0e 001 01  0    0    0   0   0    1    1    A1
 0f 001 01  0    0    0   0   0    1    1    A9
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: c0100000-c01fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to
64
Simple Boot Flag at 0x6c set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1147084640.752:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
...
##### End #####

Thanks


Send instant messages to your online friends http://au.messenger.yahoo.com 
