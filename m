Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWI0Afp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWI0Afp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWI0Afp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:35:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:56938 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932071AbWI0Afo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:35:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FFQJFKnJdScGaqaNotoEv77lTQCTUr2JK0Ngo/zAcuoMwWJDzd2SgnVIXgqC8DHl+GPV9aPyQsobX22d5PMmqDR3GAyUAXMe0OzKwX6EZq3KbCE1P+0O055Ng68WIAszIXeqHR+Dg+hF/Q+zTtzX0VRrlP7b/1p404bFn3x4V4c=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time: acpi_pm clocksource has been installed.
Date: Wed, 27 Sep 2006 02:36:58 +0200
User-Agent: KMail/1.9.4
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com> <20060926173347.04fd66dd.rdunlap@xenotime.net>
In-Reply-To: <20060926173347.04fd66dd.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270236.58148.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 02:33, Randy Dunlap wrote:
> On Wed, 27 Sep 2006 02:22:18 +0200 Jesper Juhl wrote:
> 
> > I get this in dmesg with 2.6.18-git6 :
> >       a3:<6>Time: acpi_pm clocksource has been installed.
> > 
> > Looks like some printk() somewhere is not adding \n correctly after
> > outputting a message priority or a message priority too much is
> > used... I've not investigated where this happens, but just wanted to
> > report it.
> 
> Hi,
> How about posting (pasting) some of the message log before that?
> 
Sure, below is the entire dmesg output from this boot of the box 
(including the line above) :


Linux version 2.6.18-git6 (juhl@dragon) (gcc version 3.4.6) #1 SMP PREEMPT Wed Sep 27 01:52:25 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
 BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524208
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294832 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9bb0
ACPI: RSDT (v001 A M I  OEMRSDT  0x12000506 MSFT 0x00000097) @ 0x7ffb0000
ACPI: FADT (v002 A M I  OEMFACP  0x12000506 MSFT 0x00000097) @ 0x7ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x12000506 MSFT 0x00000097) @ 0x7ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x12000506 MSFT 0x00000097) @ 0x7ffc0040
ACPI: DSDT (v001  939M2 939M2150 0x00000150 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfec10000, GSI 24-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7f7c0000)
Detected 2200.221 MHz processor.
Built 1 zonelists.  Total pages: 524208
Kernel command line: BOOT_IMAGE=2.6.18git6 ro root=801
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c04b4000 soft=c04b2000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
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
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
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
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2071596k/2096832k available (2245k kernel code, 24100k reserved, 927k data, 212k init, 1179328k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff81000 - 0xfffff000   ( 504 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0478000 - 0xc04ad000   ( 212 kB)
      .data : 0xc03315f9 - 0xc041930c   ( 927 kB)
      .text : 0xc0100000 - 0xc03315f9   (2245 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4402.74 BogoMIPS (lpj=2201372)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Core 0
CPU: After all inits, caps: 178bfbff e3d3fbff 00000000 00000410 00000001 00000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
lockdep: not fixing up alternatives.
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c04b5000 soft=c04b3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4399.53 BogoMIPS (lpj=2199768)
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Core 1
CPU: After all inits, caps: 178bfbff e3d3fbff 00000000 00000410 00000001 00000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Total of 2 processors activated (8802.28 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: 
CPU#0 had -30 usecs TSC skew, fixed it up.
CPU#1 had 30 usecs TSC skew, fixed it up.
Brought up 2 CPUs
migration_cost=393
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-083f claimed by ali7101 ACPI
Boot video device is 0000:03:00.0
PCI: Transparent bridge - 0000:00:06.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 *5 6 7 10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ff200000-ff2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: ff300000-ff3fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: ff400000-ff4fffff
  PREFETCH window: c7f00000-d7efffff
PCI: Bridge: 0000:00:06.0
  IO window: d000-dfff
  MEM window: ff500000-ff5fffff
  PREFETCH window: 88000000-880fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 65536 (order: 9, 2359296 bytes)
TCP bind hash table entries: 32768 (order: 8, 1179648 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
Machine check exception polling timer started.
Initializing RT-Tester: OK
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler cfq registered (default)
vesafb: framebuffer at 0xc8000000, mapped to 0xf8880000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:7880
vesafb: pmi: set display start = c00c79d3, set palette = c00c7ab3
vesafb: pmi: ports = 
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
ACPI: PCI Interrupt 0000:04:07.0[A] -> GSI 22 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 21 (level, low) -> IRQ 19
eth0: VIA Rhine II at 0xff5fec00, 00:50:ba:f2:<6>serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
EDAC MC: Ver: 2.0.1 Sep 27 2006
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
a3:<6>Time: acpi_pm clocksource has been installed.
1d, IRQ 18.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
input: AT Translated Set 2 keyboard as /class/input/input0
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi 0:0:4:0: CD-ROM            PIONEER  DVD-ROM DVD-305  1.03 PQ: 0 ANSI: 2
 target0:0:4: Beginning Domain Validation
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: Ending Domain Validation
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:4:0: Attached scsi CD-ROM sr0
sr 0:0:4:0: Attached scsi generic sg0 type 5
scsi 0:0:5:0: CD-ROM            PLEXTOR  CD-R   PX-W1210S 1.01 PQ: 0 ANSI: 2
 target0:0:5: Beginning Domain Validation
 target0:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:5: Domain Validation skipping write tests
 target0:0:5: Ending Domain Validation
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
sr 0:0:5:0: Attached scsi CD-ROM sr1
sr 0:0:5:0: Attached scsi generic sg1 type 5
scsi 0:0:6:0: Direct-Access     IBM      DDYS-T36950N     S96H PQ: 0 ANSI: 3
scsi0:A:6:0: Tagged Queuing enabled.  Depth 200
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous
 target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:6: Ending Domain Validation
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:6:0: Attached scsi disk sda
sd 0:0:6:0: Attached scsi generic sg2 type 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Write protecting the kernel read-only data: 371k
Adding 763076k swap on /dev/sda3.  Priority:-1 extents:1 across:763076k
EXT3 FS on sda1, internal journal
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 20 (level, low) -> IRQ 20
Linux agpgart interface v0.101 (c) Dave Jones
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
ReiserFS: sda4: found reiserfs format "3.6" with standard journal
ReiserFS: sda4: using ordered data mode
ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda4: checking transaction log (sda4)
ReiserFS: sda4: Using r5 hash to sort names
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1


