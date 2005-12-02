Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVLBCcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVLBCcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVLBCcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:32:12 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:7295 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964801AbVLBCcL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:32:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UHKRsUM5TLkihb+HzZLxUhuwiB4SzOFPs6HR5tC5v5SQbAbPNvEto2LzM9EgQ9gTl0nmuiwBUSMH1xcUo26UR4VprtRsGyvWOEp6Ru5fApOaNEdFUZbAcrxZZWLsajkcUz4FlaTo3oGqncXmQfT9hAxGWO0FIw60DwsdZ++ri3Y=
Message-ID: <c775eb9b0512011832u54da8a95v74fbcc2dd2aa5fa2@mail.gmail.com>
Date: Thu, 1 Dec 2005 21:32:10 -0500
From: Bharath Ramesh <krosswindz@gmail.com>
To: Keith Mannthey <kmannth@gmail.com>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
	 <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>
	 <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>
	 <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>
	 <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/05, Keith Mannthey <kmannth@gmail.com> wrote:
> Did the smp kernel that came with your distro boot smp on i386?

The distro's i386 SMP kernel detects only one processor.
>
> An apic is an apic.  I don't think there is a diffrent interrupt
> controler (but maybe I am wrong)  I can boot opteron SMP with i386
> just fine.  My guess is what you are seeing is specific to your box.
> What sort of a box is this 8-way AMD Opteron.....

Its a custom built box, I dont have the mother board manual with me at
this instant. It uses a IWill 8-way motherboard.

>
> What i386 subarch are you selecting in your i386 build?  Could you try
> the Generic architecture?  Maybe the box is in clustered apic mode.
>
> Does booting with acpi=off help?
>

I dont have the permission to remotely login as root at this moment. I
will have access to the console in the morning. I can boot the machine
with acpi=off and try it.

> Can you send the dmesg from your x86_64 partition.   It will show us
> what the apic is doing in that arch.

dmesg for x86_64  (runs 2.6.11.10):
Bootdata ok (command line is ro root=/dev/hda2 vga=791 rhgb quiet)
Linux version 2.6.11.10 (root@drones) (gcc version 3.4.3 20041212 (Red
Hat 3.4.3-9.EL4)) #4 SMP Thu May 19 13:28:55 EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
 BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000440000000 (usable)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000f6ca0
ACPI: XSDT (v001 A M I  OEMXSDT  0x02000502 MSFT 0x00000097) @
0x00000000bfff0100
ACPI: FADT (v003 A M I  OEMFACP  0x02000502 MSFT 0x00000097) @
0x00000000bfff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x02000502 MSFT 0x00000097) @
0x00000000bfff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x02000502 MSFT 0x00000097) @
0x00000000bffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x02000502 MSFT 0x00000097) @
0x00000000bfff3cc0
ACPI: DSDT (v001  H805V H805V120 0x00000000 INTL 0x02002026) @
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: PXM 2 -> APIC 2 -> Node 2
SRAT: PXM 3 -> APIC 3 -> Node 3
SRAT: PXM 4 -> APIC 4 -> Node 4
SRAT: PXM 5 -> APIC 5 -> Node 5
SRAT: PXM 6 -> APIC 6 -> Node 6
SRAT: PXM 7 -> APIC 7 -> Node 7
SRAT: Node 0 PXM 0 100000-7fffffff
SRAT: Node 1 PXM 1 80000000-bfffffff
SRAT: Node 2 PXM 2 140000000-1bfffffff
SRAT: Node 3 PXM 3 1c0000000-23fffffff
SRAT: Node 4 PXM 4 240000000-2bfffffff
SRAT: Node 5 PXM 5 2c0000000-33fffffff
SRAT: Node 6 PXM 6 340000000-3bfffffff
SRAT: Node 7 PXM 7 3c0000000-43fffffff
SRAT: Node 0 PXM 0 0-7fffffff
node 2 shift 24 addr 140000000 conflict 0
node 3 shift 25 addr 1fe000000 conflict 0
node 7 shift 26 addr 3fc000000 conflict 0
Bootmem setup node 0 0000000000000000-000000007fffffff
Bootmem setup node 1 0000000080000000-00000000bfffffff
Bootmem setup node 2 0000000140000000-00000001bfffffff
Bootmem setup node 3 00000001c0000000-000000023fffffff
Bootmem setup node 4 0000000240000000-00000002bfffffff
Bootmem setup node 5 00000002c0000000-000000033fffffff
Bootmem setup node 6 0000000340000000-00000003bfffffff
Bootmem setup node 7 00000003c0000000-000000043fffffff
On node 0 totalpages: 524287
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 520191 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262143
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262143 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 2 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 3 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 4 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 5 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 6 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 7 totalpages: 524287
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 524287 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x10] enabled)
Processor #16 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x11] enabled)
Processor #17 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x12] enabled)
Processor #18 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x13] enabled)
Processor #19 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x14] enabled)
Processor #20 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x15] enabled)
Processor #21 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x16] enabled)
Processor #22 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x17] enabled)
Processor #23 15:5 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfcffe000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 17, address 0xfcffe000, GSI 24-27
ACPI: IOAPIC (id[0x03] address[0xfcfff000] gsi_base[28])
IOAPIC[2]: apic_id 3, version 17, address 0xfcfff000, GSI 28-31
ACPI: IOAPIC (id[0x10] address[0xfbffe000] gsi_base[32])
IOAPIC[3]: apic_id 0, version 17, address 0xfbffe000, GSI 32-35
ACPI: IOAPIC (id[0x11] address[0xfbfff000] gsi_base[36])
IOAPIC[4]: apic_id 4, version 17, address 0xfbfff000, GSI 36-39
ACPI: IOAPIC (id[0x12] address[0xfacfc000] gsi_base[40])
IOAPIC[5]: apic_id 5, version 17, address 0xfacfc000, GSI 40-43
ACPI: IOAPIC (id[0x13] address[0xfacfd000] gsi_base[44])
IOAPIC[6]: apic_id 6, version 17, address 0xfacfd000, GSI 44-47
ACPI: IOAPIC (id[0x14] address[0xfacfe000] gsi_base[48])
IOAPIC[7]: apic_id 7, version 17, address 0xfacfe000, GSI 48-51
ACPI: IOAPIC (id[0x15] address[0xfacff000] gsi_base[52])
IOAPIC[8]: apic_id 8, version 17, address 0xfacff000, GSI 52-55
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 4000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 4000000
Built 8 zonelists
Kernel command line: ro root=/dev/hda2 vga=791 rhgb quiet console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2004.577 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Memory: 15415088k/17825792k available (2083k kernel code, 0k reserved,
724k data, 208k init)
Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
CPU0: AMD Opteron(tm) Processor 846 stepping 0a
per-CPU timeslice cutoff: 1023.98 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/17 rip 6000 rsp ffff8101c1c31f58
Initializing CPU#1
Calibrating delay loop... 4005.88 BogoMIPS (lpj=2002944)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1
AMD Opteron(tm) Processor 846 stepping 0a
Booting processor 2/18 rip 6000 rsp ffff8103bff81f58
Initializing CPU#2
Calibrating delay loop... 4005.88 BogoMIPS (lpj=2002944)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2(1) -> Node 2
AMD Opteron(tm) Processor 846 stepping 0a
Booting processor 3/19 rip 6000 rsp ffff8103c3465f58
Initializing CPU#3
Calibrating delay loop... 4005.88 BogoMIPS (lpj=2002944)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3(1) -> Node 3
AMD Opteron(tm) Processor 846 stepping 0a
Booting processor 4/20 rip 6000 rsp ffff8100bffb3f58
Initializing CPU#4
Calibrating delay loop... 4005.88 BogoMIPS (lpj=2002944)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 4(1) -> Node 4
AMD Opteron(tm) Processor 846 stepping 0a
Booting processor 5/21 rip 6000 rsp ffff81023ffa5f58
Initializing CPU#5
Calibrating delay loop... 3997.69 BogoMIPS (lpj=1998848)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 5(1) -> Node 5
AMD Opteron(tm) Processor 846 stepping 0a
Booting processor 6/22 rip 6000 rsp ffff8102bffa9f58
Initializing CPU#6
Calibrating delay loop... 4005.88 BogoMIPS (lpj=2002944)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 6(1) -> Node 6
AMD Opteron(tm) Processor 846 stepping 0a
Booting processor 7/23 rip 6000 rsp ffff81033ffb3f58
Initializing CPU#7
Calibrating delay loop... 4005.88 BogoMIPS (lpj=2002944)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 7(1) -> Node 7
AMD Opteron(tm) Processor 846 stepping 0a
Total of 8 processors activated (31973.37 BogoMIPS).
Using local APIC timer interrupts.
Detected 12.528 MHz APIC timer.
checking TSC synchronization across 8 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 8 CPUs
CPU0 attaching sched-domain:
 domain 0: span 01
  groups: 01
  domain 1: span ff
   groups: 01 02 04 08 10 20 40 80
CPU1 attaching sched-domain:
 domain 0: span 02
  groups: 02
  domain 1: span ff
   groups: 02 04 08 10 20 40 80 01
CPU2 attaching sched-domain:
 domain 0: span 04
  groups: 04
  domain 1: span ff
   groups: 04 08 10 20 40 80 01 02
CPU3 attaching sched-domain:
 domain 0: span 08
  groups: 08
  domain 1: span ff
   groups: 08 10 20 40 80 01 02 04
CPU4 attaching sched-domain:
 domain 0: span 10
  groups: 10
  domain 1: span ff
   groups: 10 20 40 80 01 02 04 08
CPU5 attaching sched-domain:
 domain 0: span 20
  groups: 20
  domain 1: span ff
   groups: 20 40 80 01 02 04 08 10
CPU6 attaching sched-domain:
 domain 0: span 40
  groups: 40
  domain 1: span ff
   groups: 40 80 01 02 04 08 10 20
CPU7 attaching sched-domain:
 domain 0: span 80
  groups: 80
  domain 1: span ff
   groups: 80 01 02 04 08 10 20 40
checking if image is initramfs... it is


Thanks,

Bharath
