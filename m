Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTJUDn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 23:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbTJUDn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 23:43:27 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:26752 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP id S262817AbTJUDnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 23:43:24 -0400
Date: Mon, 20 Oct 2003 20:35:42 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: linux-kernel@vger.kernel.org
Subject: odd dmesg
Message-ID: <Pine.LNX.4.53.0310202028360.887@bigred.russwhit.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
While everything seems to be working ok, here's the first few lines
of dmesg:

Linux version 2.6.0-test8 (russ@bigred) (gcc version 3.3.2) #2 SMP Sun Oct 19 10:35:51 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
 BIOS-e820: 000000007fef0000 - 000000007feff000 (ACPI data)
 BIOS-e820: 000000007feff000 - 000000007ff00000 (ACPI NVS)
 BIOS-e820: 000000007ff00000 - 000000007ff80000 (usable)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7170
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 524160
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294784 pages, LIFO batch:16
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7100
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x7fefcf28
ACPI: FADT (v001 AMD    TECATE   0x06040000 PTL  0x000f4240) @ 0x7fefef2e
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x7fefefa2
ACPI: DSDT (v001    AMD  AMDACPI 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:6 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x1])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Lin6 ro root=301 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1667.062 MHz processor.
Console: colour VGA+ 80x25
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():1
Call Trace:
 [<c011e6d0>] __might_sleep+0xa0/0xc0
 [<c0121aea>] acquire_console_sem+0x3a/0x60
 [<c0121d33>] register_console+0x83/0x1e0
 [<c0272770>] vgacon_save_screen+0x0/0x80
 [<c03a1d46>] con_init+0x206/0x240
 [<c0105000>] _stext+0x0/0x70
 [<c03a11b1>] console_init+0x31/0x40
 [<c038e85d>] start_kernel+0xdd/0x1a0
 [<c038e4a0>] unknown_bootoption+0x0/0x100

Memory: 2071648k/2096640k available (1886k kernel code, 23792k reserved, 717k data, 148k init, 1179072k highmem)
[..]

And for reference here's the output of scripts/ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bigred 2.6.0-test8 #2 SMP Sun Oct 19 10:35:51 PDT 2003 i686 unknown

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.13-pre2
e2fsprogs              1.32
jfsutils               1.1.1
reiserfsprogs          3.6.4
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         ipt_LOG ipt_limit ipt_state iptable_filter ip_tables ip_conntrack_ftp ip_conntrack sg ide_scsi ide_cd cdrom rtc

Let me know if there is something I need to change.

Thanks
  Russ
