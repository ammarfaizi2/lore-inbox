Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbULJSKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbULJSKn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbULJSKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:10:43 -0500
Received: from crusoe.degler.net ([66.114.64.229]:18419 "EHLO
	crusoe.degler.net") by vger.kernel.org with ESMTP id S261783AbULJSHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:07:52 -0500
Message-ID: <43220.166.84.149.254.1102702048.squirrel@crusoe.degler.net>
Date: Fri, 10 Dec 2004 13:07:28 -0500 (EST)
Subject: NUMA on i386 with Opterons
From: "Stephen Degler" <stephen@degler.net>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Should i386 NUMA be working on with Opteron systems?  I'm blowing up
on various Tyan motherboards.  Of course x86_64 kernels run fine.

Any insight you could provide would be welcome.  The same error occurs
with vanilla 2.6.10-rc3.

Serial console output below:

Linux version 2.6.8.1+xfsigetfix (sdegler@localhost.localdomain) (gcc
version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #16 SMP Thu D
ec 9 22:08:15 GMT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000f7ff0000 (usable)
 BIOS-e820: 00000000f7ff0000 - 00000000f7fff000 (ACPI data)
 BIOS-e820: 00000000f7fff000 - 00000000f8000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)
get_memcfg_from_srat: assigning address to rsdp
RSD PTR  v2 [ACPIAM]
Begin SRAT table scan....
CPU 0x00 in proximity domain 0x00
CPU 0x01 in proximity domain 0x01
Memory range 0x100 to 0xF8000 (type 0x0) in proximity domain 0x00 enabled
Memory range 0x100000 to 0x180000 (type 0x0) in proximity domain 0x01 enabled
Memory range 0x0 to 0x9F (type 0x0) in proximity domain 0x00 enabled
pxm bitmap: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
 00 00 00 00 00 00 00 00 00
Number of logical nodes in system = 2

Number of memory chunks in system = 3
chunk 0 nid 0 start_pfn 00000000 end_pfn 0000009f
chunk 1 nid 0 start_pfn 00000100 end_pfn 000f8000
chunk 2 nid 1 start_pfn 00100000 end_pfn 00180000
Node: 0, start_pfn: 0, end_pfn: 1015808
  Setting physnode_map array to node 0 for pfns:
  0 65536 131072 196608 262144 327680 393216 458752 524288 589824 655360
720896
786432 851968 917504 983040
Node: 1, start_pfn: 1048576, end_pfn: 1572864
  Setting physnode_map array to node 1 for pfns:
  1048576 1114112 1179648 1245184 1310720 1376256 1441792 1507328
Reserving 4608 pages of KVA for lmem_map of node 1
Shrinking node 1 from 1572864 pages to 1568256 pages
Reserving total of 4608 pages for numa KVA remap
reserve_pages = 4608 find_max_low_pfn() ~ 229376
max_pfn = 1572864
5266MB HIGHMEM available.
878MB LOWMEM available.
min_low_pfn = 1918, max_low_pfn = 224768, highstart_pfn = 224768
Low memory ends at vaddr f6e00000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f6e00000 - f8000000
High memory starts at vaddr f6e00000
ACPI: S3 and PAE do not like each other for now, S3 disabled.
found SMP MP-table at 000ff780
NX (Execute Disable) protection: active
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x000f6700
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000314 MSFT 0x00000097) @ 0xf7ff0100
ACPI: FADT (v001 A M I  OEMFACP  0x10000314 MSFT 0x00000097) @ 0xf7ff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x10000314 MSFT 0x00000097) @ 0xf7ff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000314 MSFT 0x00000097) @ 0xf7fff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x10000314 MSFT 0x00000097) @ 0xf7ff3580
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0xf7ff3670
ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x00000000
ES7000: did not find Unisys ACPI OEM table!
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfebfe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebff000] gsi_base[28])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfebff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 2 zonelists
ying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'swapper', page f6e02360)
flags:0x06207320 mapping:446e4970 mapcount:2099263264 count:0
Backtrace:
 [<c0106fc4>] dump_stack+0x1e/0x22
 [<c013faf7>] bad_page+0x6f/0x9c
 [<c01402af>] free_hot_cold_page+0x61/0x134
 [<c06cb7d5>] one_highpage_init+0x6d/0xd4
 [<c06cc764>] set_highmem_pages_init+0xc4/0xd4
 [<c06cbd3b>] mem_init+0xed/0x226
 [<c06bc958>] start_kernel+0x10c/0x1be
 [<c06bc958>] start_kernel+0x10c/0x1be
 [<c0100211>] 0xc0100211
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'swapper', page f6e02380)
flags:0x06544345 mapping:20584154 mapcount:538976266 count:0
Backtrace:
 [<c0106fc4>] dump_stack+0x1e/0x22
 [<c013faf7>] bad_page+0x6f/0x9c
 [<c01402af>] free_hot_cold_page+0x61/0x134
 [<c06cb7d5>] one_highpage_init+0x6d/0xd4
 [<c06cc764>] set_highmem_pages_init+0xc4/0xd4
 [<c06cbd3b>] mem_init+0xed/0x226
 [<c06bc958>] start_kernel+0x10c/0x1be
 [<c0100211>] 0xc0100211


That trace above looks like there was some loossage on the serial line
right around the error.  Here is another similar run.

Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Initializing HighMem for node 0
Initializing HighMem for node 1
Bad page state at free_hot_cold_page (in process 'swapper', page f6e02000)
flags:0x06454342 mapping:41544e59 mapcount:537544016 count:0
Backtrace:
 [<c0106fc4>] dump_stack+0x1e/0x22
 [<c013fa9b>] bad_page+0x6f/0x9c
 [<c0140253>] free_hot_cold_page+0x61/0x134
 [<c06cb7d5>] one_highpage_init+0x6d/0xd4
 [<c06cc764>] set_highmem_pages_init+0xc4/0xd4
 [<c06cbd3b>] mem_init+0xed/0x226
 [<c06bc958>] start_kernel+0x10c/0x1be
 [<c0100211>] 0xc0100211

Thanks,

skd


