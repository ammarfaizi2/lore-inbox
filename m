Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbUAWXPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUAWXPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:15:37 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:15968 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S266752AbUAWXPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:15:25 -0500
Message-ID: <4011AB0B.4030906@blueyonder.co.uk>
Date: Fri, 23 Jan 2004 23:15:23 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040118
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-rc1-mm2 kernel oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jan 2004 23:15:45.0496 (UTC) FILETIME=[D43D1580:01C3E206]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this on bootup, Athlon XP2200+
=====================================
Linux version 2.6.2-rc1-mm2 (root@barrabas) (gcc version 3.3.1 (SuSE 
Linux)) #8 Fri Jan 23 22:26:32 GMT 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
  BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 131068
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126972 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5c10
ACPI: RSDT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x1fffc0b2
ACPI: BOOT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x1fffc030
ACPI: MADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x1fffc058
ACPI: DSDT (v001   ASUS A7V333   0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
current: c039a100
current->thread_info: c040a000
Initializing CPU#0
Kernel command line: root=/dev/hda1 vga=normal desktop splash=silent 
init 3 console=ttyS1
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1802.998 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 514344k/524272k available (2268k kernel code, 9180k reserved, 
837k data, 168k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... 
<1>Unable to handle kernel paging request at virtual address fffb
c000
  printing eip:
c0416106
*pde = 0007d067
*pte = 00101025
Oops: 0003 [#1]
PREEMPT DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c0416106>]    Not tainted VLI
EFLAGS: 00010206
EIP is at test_wp_bit+0x36/0x90
eax: 00000001   ebx: 000000a8   ecx: 00101025   edx: 0007d000
esi: 00000345   edi: 000008dc   ebp: 00000009   esp: c040bf88
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c040a000 task=c039a100)
Stack: 00000042 00101000 00000025 c04163a4 c0348120 0007d928 0007fff0 
000008dc
        000023dc 00000345 000000a8 00000000 004fff60 1fffc000 c1000000 
0001fffc
        000008f7 00000000 00099800 c0107000 0008e000 c040c468 c03437d7 
c043a104
Call Trace:
  [<c04163a4>] mem_init+0x244/0x260
  [<c0107000>] run_init_process+0x0/0x30
  [<c040c468>] start_kernel+0xe8/0x380
  [<c040c0f0>] unknown_bootoption+0x0/0x170

Code: 81 49 d0 ff c7 44 24 08 25 00 00 00 c7 44 24 04 00 10 10 00 c7 04 
24 42 00 00 00 e8 c5 dc cf ff b8 01 00 00 00 8a 15 00 c0 fb ff <88
 > 15 00 c0 fb ff 31 c0 c7 04 24 42 00 00 00 c7 44 24 04 00 00
  <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.
