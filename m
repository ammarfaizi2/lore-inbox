Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTJTXlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbTJTXlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:41:16 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:59047 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263129AbTJTXkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:40:35 -0400
Subject: Oops with 2.4.22 (kernel BUG at vmscan.c:358!)
From: Stian Jordet <liste@jordet.nu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-+fCfopxE4OR9dlSDZ2Ag"
Message-Id: <1066693255.7926.5.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 21 Oct 2003 01:40:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+fCfopxE4OR9dlSDZ2Ag
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

early sunday morning my box became unresponsible from remote. After two
years of duty, it of course had to die when I was out of city. When I
came back this evening, the screen was full of oopses (attached) and
totally unresponsive to keyboard. The only solution was a hard reset.

At the time this started, it should have been running a quite memory
consuming perl-script. Since I upgraded to 2.4.22 (from 2.4.19) I had
about 35 days uptime, before this happened last night.

Is this a real bug, or just bad luck?

Best regards,
Stian

--=-+fCfopxE4OR9dlSDZ2Ag
Content-Disposition: attachment; filename=syslog
Content-Type: text/plain; name=syslog; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Oct 19 04:09:10 dodge kernel: Unable to handle kernel paging request at virtual address 4f6f3992
Oct 19 04:09:10 dodge kernel:  printing eip:
Oct 19 04:09:10 dodge kernel: c0130e0b
Oct 19 04:09:10 dodge kernel: *pde = 00000000
Oct 19 04:09:10 dodge kernel: Oops: 0000
Oct 19 04:09:10 dodge kernel: CPU:    0
Oct 19 04:09:10 dodge kernel: EIP:    0010:[try_to_release_page+35/72]    Not tainted
Oct 19 04:09:10 dodge kernel: EFLAGS: 00010282
Oct 19 04:09:10 dodge kernel: eax: 4f6f3976   ebx: c10dfb10   ecx: c10dfb2c   edx: c0298fb4
Oct 19 04:09:10 dodge kernel: esi: 000001d0   edi: 00000008   ebp: 000001e0   esp: cb73bf3c
Oct 19 04:09:10 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:09:10 dodge kernel: Process kswapd (pid: 4, stackpage=cb73b000)
Oct 19 04:09:10 dodge kernel: Stack: c11c3f80 c10dfb10 c01295d2 c10dfb10 000001d0 00000020 000001d0 00000020 
Oct 19 04:09:10 dodge kernel:        00000006 00000006 cb73a000 000012ab 000001d0 c0298fb4 c0129830 00000006 
Oct 19 04:09:10 dodge kernel:        00000007 00000006 00000020 000001d0 c0298fb4 c0298fb4 c012989c 00000020 
Oct 19 04:09:10 dodge kernel: Call Trace:    [shrink_cache+486/760] [shrink_caches+88/136] [try_to_free_pages_zone+60/92] [kswapd_balance_pgdat+65/140] [kswapd_balance+26/48]
Oct 19 04:09:10 dodge kernel:   [kswapd+153/188] [arch_kernel_thread+40/56]
Oct 19 04:09:10 dodge kernel: 
Oct 19 04:09:10 dodge kernel: Code: 83 78 1c 00 74 12 56 53 8b 40 1c ff d0 83 c4 08 85 c0 75 04 
Oct 19 04:09:40 dodge kernel:  kernel BUG at vmscan.c:358!
Oct 19 04:09:40 dodge kernel: invalid operand: 0000
Oct 19 04:09:40 dodge kernel: CPU:    0
Oct 19 04:09:40 dodge kernel: EIP:    0010:[shrink_cache+144/760]    Not tainted
Oct 19 04:09:40 dodge kernel: EFLAGS: 00010246
Oct 19 04:09:40 dodge kernel: eax: 3dbc428d   ebx: 00000000   ecx: c01ba8f4   edx: 000001e9
Oct 19 04:09:40 dodge kernel: esi: c01ba8d8   edi: 00000020   ebp: 000001e9   esp: ca6d9df4
Oct 19 04:09:40 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:09:40 dodge kernel: Process bwbar (pid: 278, stackpage=ca6d9000)
Oct 19 04:09:40 dodge kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 ca6d8000 00001320 000001d2 
Oct 19 04:09:40 dodge kernel:        c0298fb4 c0129830 00000006 00000006 00000006 00000020 000001d2 c0298fb4 
Oct 19 04:09:40 dodge kernel:        c0298fb4 c012989c 00000020 ca6d8000 00000000 00000010 c0298fb4 c012a268 
Oct 19 04:09:40 dodge kernel: Call Trace:    [shrink_caches+88/136] [try_to_free_pages_zone+60/92] [balance_classzone+80/456] [__alloc_pages+274/352] [_alloc_pages+22/24]
Oct 19 04:09:40 dodge kernel:   [do_anonymous_page+52/212] [do_no_page+51/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152] [do_brk+284/512]
Oct 19 04:09:40 dodge kernel:   [sys_brk+187/228] [error_code+52/60]
Oct 19 04:09:40 dodge kernel: 
Oct 19 04:09:40 dodge kernel: Code: 0f 0b 66 01 07 f5 24 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 07 
Oct 19 04:09:44 dodge kernel:  kernel BUG at vmscan.c:358!
Oct 19 04:09:44 dodge kernel: invalid operand: 0000
Oct 19 04:09:44 dodge kernel: CPU:    0
Oct 19 04:09:44 dodge kernel: EIP:    0010:[shrink_cache+144/760]    Not tainted
Oct 19 04:09:44 dodge kernel: EFLAGS: 00010246
Oct 19 04:09:44 dodge kernel: eax: 3dbc428d   ebx: 00000000   ecx: c01ba8f4   edx: 000001e9
Oct 19 04:09:44 dodge kernel: esi: c01ba8d8   edi: 00000020   ebp: 000001e9   esp: c37a9d08
Oct 19 04:09:44 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:09:44 dodge kernel: Process pisg (pid: 20079, stackpage=c37a9000)
Oct 19 04:09:44 dodge kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 c37a8000 00001321 000001d2 
Oct 19 04:09:44 dodge kernel:        c0298fb4 c0129830 00000006 00000006 00000006 00000020 000001d2 c0298fb4 
Oct 19 04:09:44 dodge kernel:        c0298fb4 c012989c 00000020 c37a8000 00000000 00000010 c0298fb4 c012a268 
Oct 19 04:09:44 dodge kernel: Call Trace:    [shrink_caches+88/136] [try_to_free_pages_zone+60/92] [balance_classzone+80/456] [__alloc_pages+274/352] [_alloc_pages+22/24]
Oct 19 04:09:44 dodge kernel:   [do_anonymous_page+52/212] [do_no_page+51/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152] [megaIssueCmd+68/660]
Oct 19 04:09:44 dodge kernel:   [mega_runpendq+35/60] [megaraid_queue+229/540] [scsi_dispatch_cmd+423/532] [scsi_request_fn+765/820] [error_code+52/60] [file_read_actor+90/132]
Oct 19 04:09:44 dodge kernel:   [do_generic_file_read+471/1028] [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 04:09:44 dodge kernel: 
Oct 19 04:09:44 dodge kernel: Code: 0f 0b 66 01 07 f5 24 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 07 
Oct 19 04:09:46 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:09:46 dodge kernel:  printing eip:
Oct 19 04:09:46 dodge kernel: c012389b
Oct 19 04:09:46 dodge kernel: *pde = 00000000
Oct 19 04:09:46 dodge kernel: Oops: 0000
Oct 19 04:09:46 dodge kernel: CPU:    0
Oct 19 04:09:46 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 04:09:46 dodge kernel: EFLAGS: 00010296
Oct 19 04:09:46 dodge kernel: eax: 80685000   ebx: c74fdf8c   ecx: 00000010   edx: 0000f7a3
Oct 19 04:09:46 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c74fdf34
Oct 19 04:09:46 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:09:46 dodge kernel: Process spamd (pid: 20089, stackpage=c74fd000)
Oct 19 04:09:46 dodge kernel: Stack: 00000000 c1dba920 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 04:09:46 dodge kernel:        c74b1680 c0123ecb c1dba920 c1dba940 c74fdf8c c0123db4 00000000 c1dba920 
Oct 19 04:09:46 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 04:09:46 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 04:09:46 dodge kernel: 
Oct 19 04:09:46 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 04:10:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:10:01 dodge kernel:  printing eip:
Oct 19 04:10:01 dodge kernel: c0123367
Oct 19 04:10:01 dodge kernel: *pde = 00000000
Oct 19 04:10:01 dodge kernel: Oops: 0000
Oct 19 04:10:01 dodge kernel: CPU:    0
Oct 19 04:10:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:10:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:10:01 dodge kernel: eax: 80685000   ebx: c849fba0   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:10:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c6a5de90
Oct 19 04:10:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:10:01 dodge kernel: Process mrtg (pid: 20097, stackpage=c6a5d000)
Oct 19 04:10:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c27525e0 00000000 c849fba0 
Oct 19 04:10:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c4332a60 c0120f92 c849fba0 08067000 00000000 
Oct 19 04:10:01 dodge kernel:        080675c0 c27525e0 00000000 c849fba0 c012110e c27525e0 c849fba0 080675c0 
Oct 19 04:10:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:10:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:10:01 dodge kernel: 
Oct 19 04:10:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:10:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:10:01 dodge kernel:  printing eip:
Oct 19 04:10:01 dodge kernel: c0123367
Oct 19 04:10:01 dodge kernel: *pde = 00000000
Oct 19 04:10:01 dodge kernel: Oops: 0000
Oct 19 04:10:01 dodge kernel: CPU:    0
Oct 19 04:10:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:10:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:10:01 dodge kernel: eax: 80685000   ebx: c9bd8920   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:10:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c3affe90
Oct 19 04:10:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:10:01 dodge kernel: Process awstats.pl (pid: 20099, stackpage=c3aff000)
Oct 19 04:10:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752c20 00000000 c9bd8920 
Oct 19 04:10:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 ca316de0 c0120f92 c9bd8920 08067000 00000000 
Oct 19 04:10:01 dodge kernel:        080675c0 c2752c20 00000000 c9bd8920 c012110e c2752c20 c9bd8920 080675c0 
Oct 19 04:10:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:10:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:10:01 dodge kernel: 
Oct 19 04:10:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:14:40 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:14:40 dodge kernel:  printing eip:
Oct 19 04:14:40 dodge kernel: c012389b
Oct 19 04:14:40 dodge kernel: *pde = 00000000
Oct 19 04:14:40 dodge kernel: Oops: 0000
Oct 19 04:14:40 dodge kernel: CPU:    0
Oct 19 04:14:40 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 04:14:40 dodge kernel: EFLAGS: 00010296
Oct 19 04:14:40 dodge kernel: eax: 80685000   ebx: c2b91f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 04:14:40 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c2b91f34
Oct 19 04:14:40 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:14:40 dodge kernel: Process spamd (pid: 20123, stackpage=c2b91000)
Oct 19 04:14:40 dodge kernel: Stack: 00000000 c8a73ea0 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 04:14:40 dodge kernel:        c74b1680 c0123ecb c8a73ea0 c8a73ec0 c2b91f8c c0123db4 00000000 c8a73ea0 
Oct 19 04:14:40 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 04:14:40 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 04:14:40 dodge kernel: 
Oct 19 04:14:40 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 04:15:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:15:01 dodge kernel:  printing eip:
Oct 19 04:15:01 dodge kernel: c0123367
Oct 19 04:15:01 dodge kernel: *pde = 00000000
Oct 19 04:15:01 dodge kernel: Oops: 0000
Oct 19 04:15:01 dodge kernel: CPU:    0
Oct 19 04:15:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:15:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:15:01 dodge kernel: eax: 80685000   ebx: c69adc00   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:15:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c7c55e90
Oct 19 04:15:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:15:01 dodge kernel: Process mrtg (pid: 20126, stackpage=c7c55000)
Oct 19 04:15:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 c69adc00 
Oct 19 04:15:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c78fd760 c0120f92 c69adc00 08067000 00000000 
Oct 19 04:15:01 dodge kernel:        080675c0 c2752540 00000000 c69adc00 c012110e c2752540 c69adc00 080675c0 
Oct 19 04:15:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:15:01 dodge kernel:   [do_brk+284/512] [schedule+746/788] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:15:01 dodge kernel: 
Oct 19 04:15:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:20:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:20:01 dodge kernel:  printing eip:
Oct 19 04:20:01 dodge kernel: c0123367
Oct 19 04:20:01 dodge kernel: *pde = 00000000
Oct 19 04:20:01 dodge kernel: Oops: 0000
Oct 19 04:20:01 dodge kernel: CPU:    0
Oct 19 04:20:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:20:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:20:01 dodge kernel: eax: 80685000   ebx: c61811a0   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:20:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: ca0b3e90
Oct 19 04:20:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:20:01 dodge kernel: Process awstats.pl (pid: 20134, stackpage=ca0b3000)
Oct 19 04:20:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752d60 00000000 c61811a0 
Oct 19 04:20:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c4332a60 c0120f92 c61811a0 08067000 00000000 
Oct 19 04:20:01 dodge kernel:        080675c0 c2752d60 00000000 c61811a0 c012110e c2752d60 c61811a0 080675c0 
Oct 19 04:20:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:20:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:20:01 dodge kernel: 
Oct 19 04:20:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:20:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:20:01 dodge kernel:  printing eip:
Oct 19 04:20:01 dodge kernel: c0123367
Oct 19 04:20:01 dodge kernel: *pde = 00000000
Oct 19 04:20:01 dodge kernel: Oops: 0000
Oct 19 04:20:01 dodge kernel: CPU:    0
Oct 19 04:20:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:20:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:20:01 dodge kernel: eax: 80685000   ebx: c69adb40   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:20:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2693e90
Oct 19 04:20:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:20:01 dodge kernel: Process mrtg (pid: 20135, stackpage=c2693000)
Oct 19 04:20:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752d60 00000000 c69adb40 
Oct 19 04:20:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c50cbaa0 c0120f92 c69adb40 08067000 00000000 
Oct 19 04:20:01 dodge kernel:        080675c0 c2752d60 00000000 c69adb40 c012110e c2752d60 c69adb40 080675c0 
Oct 19 04:20:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:20:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:20:01 dodge kernel: 
Oct 19 04:20:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:21:21 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:21:21 dodge kernel:  printing eip:
Oct 19 04:21:21 dodge kernel: c012389b
Oct 19 04:21:21 dodge kernel: *pde = 00000000
Oct 19 04:21:21 dodge kernel: Oops: 0000
Oct 19 04:21:21 dodge kernel: CPU:    0
Oct 19 04:21:21 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 04:21:21 dodge kernel: EFLAGS: 00010296
Oct 19 04:21:21 dodge kernel: eax: 80685000   ebx: c8017f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 04:21:21 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c8017f34
Oct 19 04:21:21 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:21:21 dodge kernel: Process spamd (pid: 20158, stackpage=c8017000)
Oct 19 04:21:21 dodge kernel: Stack: 00000000 c6748660 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 04:21:21 dodge kernel:        c74b1680 c0123ecb c6748660 c6748680 c8017f8c c0123db4 00000000 c6748660 
Oct 19 04:21:21 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 04:21:21 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 04:21:21 dodge kernel: 
Oct 19 04:21:21 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 04:25:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:25:01 dodge kernel:  printing eip:
Oct 19 04:25:01 dodge kernel: c0123367
Oct 19 04:25:01 dodge kernel: *pde = 00000000
Oct 19 04:25:01 dodge kernel: Oops: 0000
Oct 19 04:25:01 dodge kernel: CPU:    0
Oct 19 04:25:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:25:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:25:01 dodge kernel: eax: 80685000   ebx: c849f600   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:25:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2b91e90
Oct 19 04:25:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:25:01 dodge kernel: Process mrtg (pid: 20164, stackpage=c2b91000)
Oct 19 04:25:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752a40 00000000 c849f600 
Oct 19 04:25:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c768e940 c0120f92 c849f600 08067000 00000000 
Oct 19 04:25:01 dodge kernel:        080675c0 c2752a40 00000000 c849f600 c012110e c2752a40 c849f600 080675c0 
Oct 19 04:25:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:25:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:25:01 dodge kernel: 
Oct 19 04:25:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:25:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:25:01 dodge kernel:  printing eip:
Oct 19 04:25:01 dodge kernel: c0123367
Oct 19 04:25:01 dodge kernel: *pde = 00000000
Oct 19 04:25:01 dodge kernel: Oops: 0000
Oct 19 04:25:01 dodge kernel: CPU:    0
Oct 19 04:25:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:25:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:25:01 dodge kernel: eax: 80685000   ebx: ca8419e0   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:25:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c77b7e90
Oct 19 04:25:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:25:01 dodge kernel: Process gotmail (pid: 20165, stackpage=c77b7000)
Oct 19 04:25:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 ca8419e0 
Oct 19 04:25:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c8a73ba0 c0120f92 ca8419e0 08067000 00000000 
Oct 19 04:25:01 dodge kernel:        080675c0 c2752540 00000000 ca8419e0 c012110e c2752540 ca8419e0 080675c0 
Oct 19 04:25:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:25:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:25:01 dodge kernel: 
Oct 19 04:25:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:30:02 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:30:02 dodge kernel:  printing eip:
Oct 19 04:30:02 dodge kernel: c0123367
Oct 19 04:30:02 dodge kernel: *pde = 00000000
Oct 19 04:30:02 dodge kernel: Oops: 0000
Oct 19 04:30:02 dodge kernel: CPU:    0
Oct 19 04:30:02 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:30:02 dodge kernel: EFLAGS: 00010296
Oct 19 04:30:02 dodge kernel: eax: 80685000   ebx: c9bd8b60   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:30:02 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: ca0b3e90
Oct 19 04:30:02 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:30:02 dodge kernel: Process mrtg (pid: 20176, stackpage=ca0b3000)
Oct 19 04:30:02 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752c20 00000000 c9bd8b60 
Oct 19 04:30:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c3c885c0 c0120f92 c9bd8b60 08067000 00000000 
Oct 19 04:30:02 dodge kernel:        080675c0 c2752c20 00000000 c9bd8b60 c012110e c2752c20 c9bd8b60 080675c0 
Oct 19 04:30:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:30:02 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:30:02 dodge kernel: 
Oct 19 04:30:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:30:02 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:30:02 dodge kernel:  printing eip:
Oct 19 04:30:02 dodge kernel: c0123367
Oct 19 04:30:02 dodge kernel: *pde = 00000000
Oct 19 04:30:02 dodge kernel: Oops: 0000
Oct 19 04:30:02 dodge kernel: CPU:    0
Oct 19 04:30:02 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:30:02 dodge kernel: EFLAGS: 00010296
Oct 19 04:30:02 dodge kernel: eax: 80685000   ebx: c14cbe40   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:30:02 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c7743e90
Oct 19 04:30:02 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:30:02 dodge kernel: Process awstats.pl (pid: 20177, stackpage=c7743000)
Oct 19 04:30:02 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c27525e0 00000000 c14cbe40 
Oct 19 04:30:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c78fdb60 c0120f92 c14cbe40 08067000 00000000 
Oct 19 04:30:02 dodge kernel:        080675c0 c27525e0 00000000 c14cbe40 c012110e c27525e0 c14cbe40 080675c0 
Oct 19 04:30:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:30:02 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:30:02 dodge kernel: 
Oct 19 04:30:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:35:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:35:01 dodge kernel:  printing eip:
Oct 19 04:35:01 dodge kernel: c0123367
Oct 19 04:35:01 dodge kernel: *pde = 00000000
Oct 19 04:35:01 dodge kernel: Oops: 0000
Oct 19 04:35:01 dodge kernel: CPU:    0
Oct 19 04:35:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:35:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:35:01 dodge kernel: eax: 80685000   ebx: c849f0c0   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:35:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2693e90
Oct 19 04:35:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:35:01 dodge kernel: Process mrtg (pid: 20197, stackpage=c2693000)
Oct 19 04:35:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752a40 00000000 c849f0c0 
Oct 19 04:35:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c8345260 c0120f92 c849f0c0 08067000 00000000 
Oct 19 04:35:01 dodge kernel:        080675c0 c2752a40 00000000 c849f0c0 c012110e c2752a40 c849f0c0 080675c0 
Oct 19 04:35:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:35:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:35:01 dodge kernel: 
Oct 19 04:35:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:36:20 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:36:20 dodge kernel:  printing eip:
Oct 19 04:36:20 dodge kernel: c012389b
Oct 19 04:36:20 dodge kernel: *pde = 00000000
Oct 19 04:36:20 dodge kernel: Oops: 0000
Oct 19 04:36:20 dodge kernel: CPU:    0
Oct 19 04:36:20 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 04:36:20 dodge kernel: EFLAGS: 00010296
Oct 19 04:36:20 dodge kernel: eax: 80685000   ebx: c4239f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 04:36:20 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c4239f34
Oct 19 04:36:20 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:36:20 dodge kernel: Process spamd (pid: 20205, stackpage=c4239000)
Oct 19 04:36:21 dodge kernel: Stack: 00000000 c1dba9a0 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 04:36:21 dodge kernel:        c74b1680 c0123ecb c1dba9a0 c1dba9c0 c4239f8c c0123db4 00000000 c1dba9a0 
Oct 19 04:36:21 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 04:36:21 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 04:36:21 dodge kernel: 
Oct 19 04:36:21 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 04:40:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:40:01 dodge kernel:  printing eip:
Oct 19 04:40:01 dodge kernel: c0123367
Oct 19 04:40:01 dodge kernel: *pde = 00000000
Oct 19 04:40:01 dodge kernel: Oops: 0000
Oct 19 04:40:01 dodge kernel: CPU:    0
Oct 19 04:40:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:40:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:40:01 dodge kernel: eax: 80685000   ebx: c9bd8f20   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:40:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c458be90
Oct 19 04:40:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:40:01 dodge kernel: Process mrtg (pid: 20214, stackpage=c458b000)
Oct 19 04:40:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752d60 00000000 c9bd8f20 
Oct 19 04:40:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c9c78420 c0120f92 c9bd8f20 08067000 00000000 
Oct 19 04:40:01 dodge kernel:        080675c0 c2752d60 00000000 c9bd8f20 c012110e c2752d60 c9bd8f20 080675c0 
Oct 19 04:40:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:40:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:40:01 dodge kernel: 
Oct 19 04:40:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:40:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:40:01 dodge kernel:  printing eip:
Oct 19 04:40:01 dodge kernel: c0123367
Oct 19 04:40:01 dodge kernel: *pde = 00000000
Oct 19 04:40:01 dodge kernel: Oops: 0000
Oct 19 04:40:01 dodge kernel: CPU:    0
Oct 19 04:40:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:40:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:40:01 dodge kernel: eax: 80685000   ebx: c849f540   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:40:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2b91e90
Oct 19 04:40:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:40:01 dodge kernel: Process awstats.pl (pid: 20215, stackpage=c2b91000)
Oct 19 04:40:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c27525e0 00000000 c849f540 
Oct 19 04:40:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c77e60a0 c0120f92 c849f540 08067000 00000000 
Oct 19 04:40:01 dodge kernel:        080675c0 c27525e0 00000000 c849f540 c012110e c27525e0 c849f540 080675c0 
Oct 19 04:40:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:40:01 dodge kernel:   [do_brk+284/512] [do_softirq+90/164] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:40:01 dodge kernel: 
Oct 19 04:40:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:40:39 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:40:39 dodge kernel:  printing eip:
Oct 19 04:40:39 dodge kernel: c012389b
Oct 19 04:40:39 dodge kernel: *pde = 00000000
Oct 19 04:40:39 dodge kernel: Oops: 0000
Oct 19 04:40:39 dodge kernel: CPU:    0
Oct 19 04:40:39 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 04:40:39 dodge kernel: EFLAGS: 00010296
Oct 19 04:40:39 dodge kernel: eax: 80685000   ebx: c2ffbf8c   ecx: 00000010   edx: 0000f7a3
Oct 19 04:40:39 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c2ffbf34
Oct 19 04:40:39 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:40:39 dodge kernel: Process spamd (pid: 20237, stackpage=c2ffb000)
Oct 19 04:40:39 dodge kernel: Stack: 00000000 c9c78420 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 04:40:39 dodge kernel:        c74b1680 c0123ecb c9c78420 c9c78440 c2ffbf8c c0123db4 00000000 c9c78420 
Oct 19 04:40:39 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 04:40:39 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 04:40:39 dodge kernel: 
Oct 19 04:40:39 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 04:40:43 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:40:43 dodge kernel:  printing eip:
Oct 19 04:40:43 dodge kernel: c012389b
Oct 19 04:40:43 dodge kernel: *pde = 00000000
Oct 19 04:40:43 dodge kernel: Oops: 0000
Oct 19 04:40:43 dodge kernel: CPU:    0
Oct 19 04:40:43 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 04:40:43 dodge kernel: EFLAGS: 00010296
Oct 19 04:40:43 dodge kernel: eax: 80685000   ebx: c2ffbf8c   ecx: 00000010   edx: 0000f7a3
Oct 19 04:40:43 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c2ffbf34
Oct 19 04:40:43 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:40:43 dodge kernel: Process spamd (pid: 20244, stackpage=c2ffb000)
Oct 19 04:40:43 dodge kernel: Stack: 00000000 c9b96f40 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 04:40:43 dodge kernel:        c74b1680 c0123ecb c9b96f40 c9b96f60 c2ffbf8c c0123db4 00000000 c9b96f40 
Oct 19 04:40:43 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 04:40:43 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 04:40:43 dodge kernel: 
Oct 19 04:40:43 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 04:41:06 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:41:06 dodge kernel:  printing eip:
Oct 19 04:41:06 dodge kernel: c012389b
Oct 19 04:41:06 dodge kernel: *pde = 00000000
Oct 19 04:41:06 dodge kernel: Oops: 0000
Oct 19 04:41:06 dodge kernel: CPU:    0
Oct 19 04:41:06 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 04:41:06 dodge kernel: EFLAGS: 00010296
Oct 19 04:41:06 dodge kernel: eax: 80685000   ebx: ca0b3f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 04:41:06 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: ca0b3f34
Oct 19 04:41:06 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:41:06 dodge kernel: Process spamd (pid: 20250, stackpage=ca0b3000)
Oct 19 04:41:06 dodge kernel: Stack: 00000000 c8915520 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 04:41:06 dodge kernel:        c74b1680 c0123ecb c8915520 c8915540 ca0b3f8c c0123db4 00000000 c8915520 
Oct 19 04:41:06 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 04:41:06 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 04:41:06 dodge kernel: 
Oct 19 04:41:06 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 04:45:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:45:01 dodge kernel:  printing eip:
Oct 19 04:45:01 dodge kernel: c0123367
Oct 19 04:45:01 dodge kernel: *pde = 00000000
Oct 19 04:45:01 dodge kernel: Oops: 0000
Oct 19 04:45:01 dodge kernel: CPU:    0
Oct 19 04:45:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:45:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:45:01 dodge kernel: eax: 80685000   ebx: c9bd84a0   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:45:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c4239e90
Oct 19 04:45:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:45:01 dodge kernel: Process mrtg (pid: 20254, stackpage=c4239000)
Oct 19 04:45:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752720 00000000 c9bd84a0 
Oct 19 04:45:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c1ea2840 c0120f92 c9bd84a0 08067000 00000000 
Oct 19 04:45:01 dodge kernel:        080675c0 c2752720 00000000 c9bd84a0 c012110e c2752720 c9bd84a0 080675c0 
Oct 19 04:45:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:45:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:45:01 dodge kernel: 
Oct 19 04:45:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:50:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:50:01 dodge kernel:  printing eip:
Oct 19 04:50:01 dodge kernel: c0123367
Oct 19 04:50:01 dodge kernel: *pde = 00000000
Oct 19 04:50:01 dodge kernel: Oops: 0000
Oct 19 04:50:01 dodge kernel: CPU:    0
Oct 19 04:50:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:50:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:50:01 dodge kernel: eax: 80685000   ebx: c849f720   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:50:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2693e90
Oct 19 04:50:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:50:01 dodge kernel: Process mrtg (pid: 20264, stackpage=c2693000)
Oct 19 04:50:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752a40 00000000 c849f720 
Oct 19 04:50:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c9b961c0 c0120f92 c849f720 08067000 00000000 
Oct 19 04:50:01 dodge kernel:        080675c0 c2752a40 00000000 c849f720 c012110e c2752a40 c849f720 080675c0 
Oct 19 04:50:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:50:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:50:01 dodge kernel: 
Oct 19 04:50:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:50:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:50:01 dodge kernel:  printing eip:
Oct 19 04:50:01 dodge kernel: c0123367
Oct 19 04:50:01 dodge kernel: *pde = 00000000
Oct 19 04:50:01 dodge kernel: Oops: 0000
Oct 19 04:50:01 dodge kernel: CPU:    0
Oct 19 04:50:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:50:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:50:01 dodge kernel: eax: 80685000   ebx: c14cbde0   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:50:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c77b7e90
Oct 19 04:50:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:50:01 dodge kernel: Process awstats.pl (pid: 20265, stackpage=c77b7000)
Oct 19 04:50:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 c14cbde0 
Oct 19 04:50:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c77e6820 c0120f92 c14cbde0 08067000 00000000 
Oct 19 04:50:01 dodge kernel:        080675c0 c2752540 00000000 c14cbde0 c012110e c2752540 c14cbde0 080675c0 
Oct 19 04:50:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:50:01 dodge kernel:   [update_wall_time+11/52] [do_brk+284/512] [schedule+746/788] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:50:01 dodge kernel: 
Oct 19 04:50:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 04:55:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 04:55:01 dodge kernel:  printing eip:
Oct 19 04:55:01 dodge kernel: c0123367
Oct 19 04:55:01 dodge kernel: *pde = 00000000
Oct 19 04:55:01 dodge kernel: Oops: 0000
Oct 19 04:55:01 dodge kernel: CPU:    0
Oct 19 04:55:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 04:55:01 dodge kernel: EFLAGS: 00010296
Oct 19 04:55:01 dodge kernel: eax: 80685000   ebx: c14cbb40   ecx: ca6f13a4   edx: 0000001f
Oct 19 04:55:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c7743e90
Oct 19 04:55:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 04:55:01 dodge kernel: Process mrtg (pid: 20285, stackpage=c7743000)
Oct 19 04:55:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752c20 00000000 c14cbb40 
Oct 19 04:55:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c3bd2860 c0120f92 c14cbb40 08067000 00000000 
Oct 19 04:55:01 dodge kernel:        080675c0 c2752c20 00000000 c14cbb40 c012110e c2752c20 c14cbb40 080675c0 
Oct 19 04:55:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 04:55:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 04:55:01 dodge kernel: 
Oct 19 04:55:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:00:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:00:01 dodge kernel:  printing eip:
Oct 19 05:00:01 dodge kernel: c0123367
Oct 19 05:00:01 dodge kernel: *pde = 00000000
Oct 19 05:00:01 dodge kernel: Oops: 0000
Oct 19 05:00:01 dodge kernel: CPU:    0
Oct 19 05:00:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:00:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:00:01 dodge kernel: eax: 80685000   ebx: c849f300   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:00:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2693e90
Oct 19 05:00:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:00:01 dodge kernel: Process mrtg (pid: 20295, stackpage=c2693000)
Oct 19 05:00:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 c849f300 
Oct 19 05:00:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c70e44a0 c0120f92 c849f300 08067000 00000000 
Oct 19 05:00:01 dodge kernel:        080675c0 c2752540 00000000 c849f300 c012110e c2752540 c849f300 080675c0 
Oct 19 05:00:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:00:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:00:01 dodge kernel: 
Oct 19 05:00:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:00:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:00:01 dodge kernel:  printing eip:
Oct 19 05:00:01 dodge kernel: c0123367
Oct 19 05:00:01 dodge kernel: *pde = 00000000
Oct 19 05:00:01 dodge kernel: Oops: 0000
Oct 19 05:00:01 dodge kernel: CPU:    0
Oct 19 05:00:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:00:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:00:01 dodge kernel: eax: 80685000   ebx: c9bd88c0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:00:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c59b7e90
Oct 19 05:00:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:00:01 dodge kernel: Process awstats.pl (pid: 20296, stackpage=c59b7000)
Oct 19 05:00:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c27525e0 00000000 c9bd88c0 
Oct 19 05:00:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 ca316be0 c0120f92 c9bd88c0 08067000 00000000 
Oct 19 05:00:01 dodge kernel:        080675c0 c27525e0 00000000 c9bd88c0 c012110e c27525e0 c9bd88c0 080675c0 
Oct 19 05:00:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:00:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:00:01 dodge kernel: 
Oct 19 05:00:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:05:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:05:01 dodge kernel:  printing eip:
Oct 19 05:05:01 dodge kernel: c0123367
Oct 19 05:05:01 dodge kernel: *pde = 00000000
Oct 19 05:05:01 dodge kernel: Oops: 0000
Oct 19 05:05:01 dodge kernel: CPU:    0
Oct 19 05:05:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:05:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:05:01 dodge kernel: eax: 80685000   ebx: c849f960   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:05:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2ffbe90
Oct 19 05:05:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:05:01 dodge kernel: Process mrtg (pid: 20316, stackpage=c2ffb000)
Oct 19 05:05:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752360 00000000 c849f960 
Oct 19 05:05:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c562f560 c0120f92 c849f960 08067000 00000000 
Oct 19 05:05:01 dodge kernel:        080675c0 c2752360 00000000 c849f960 c012110e c2752360 c849f960 080675c0 
Oct 19 05:05:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:05:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:05:01 dodge kernel: 
Oct 19 05:05:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:10:02 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:10:02 dodge kernel:  printing eip:
Oct 19 05:10:02 dodge kernel: c0123367
Oct 19 05:10:02 dodge kernel: *pde = 00000000
Oct 19 05:10:02 dodge kernel: Oops: 0000
Oct 19 05:10:02 dodge kernel: CPU:    0
Oct 19 05:10:02 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:10:02 dodge kernel: EFLAGS: 00010296
Oct 19 05:10:02 dodge kernel: eax: 80685000   ebx: c14cb660   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:10:02 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c4239e90
Oct 19 05:10:02 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:10:02 dodge kernel: Process mrtg (pid: 20326, stackpage=c4239000)
Oct 19 05:10:02 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c27525e0 00000000 c14cb660 
Oct 19 05:10:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c57e91a0 c0120f92 c14cb660 08067000 00000000 
Oct 19 05:10:02 dodge kernel:        080675c0 c27525e0 00000000 c14cb660 c012110e c27525e0 c14cb660 080675c0 
Oct 19 05:10:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:10:02 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:10:02 dodge kernel: 
Oct 19 05:10:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:10:02 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:10:02 dodge kernel:  printing eip:
Oct 19 05:10:02 dodge kernel: c0123367
Oct 19 05:10:02 dodge kernel: *pde = 00000000
Oct 19 05:10:02 dodge kernel: Oops: 0000
Oct 19 05:10:02 dodge kernel: CPU:    0
Oct 19 05:10:02 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:10:02 dodge kernel: EFLAGS: 00010296
Oct 19 05:10:02 dodge kernel: eax: 80685000   ebx: c9bd8aa0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:10:02 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2693e90
Oct 19 05:10:02 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:10:02 dodge kernel: Process awstats.pl (pid: 20327, stackpage=c2693000)
Oct 19 05:10:02 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 c9bd8aa0 
Oct 19 05:10:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c9b96540 c0120f92 c9bd8aa0 08067000 00000000 
Oct 19 05:10:02 dodge kernel:        080675c0 c2752540 00000000 c9bd8aa0 c012110e c2752540 c9bd8aa0 080675c0 
Oct 19 05:10:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:10:02 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:10:02 dodge kernel: 
Oct 19 05:10:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:15:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:15:01 dodge kernel:  printing eip:
Oct 19 05:15:01 dodge kernel: c0123367
Oct 19 05:15:01 dodge kernel: *pde = 00000000
Oct 19 05:15:01 dodge kernel: Oops: 0000
Oct 19 05:15:01 dodge kernel: CPU:    0
Oct 19 05:15:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:15:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:15:01 dodge kernel: eax: 80685000   ebx: c6181da0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:15:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c458be90
Oct 19 05:15:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:15:01 dodge kernel: Process mrtg (pid: 20349, stackpage=c458b000)
Oct 19 05:15:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752220 00000000 c6181da0 
Oct 19 05:15:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 ca316ce0 c0120f92 c6181da0 08067000 00000000 
Oct 19 05:15:01 dodge kernel:        080675c0 c2752220 00000000 c6181da0 c012110e c2752220 c6181da0 080675c0 
Oct 19 05:15:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:15:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:15:01 dodge kernel: 
Oct 19 05:15:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:20:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:20:01 dodge kernel:  printing eip:
Oct 19 05:20:01 dodge kernel: c0123367
Oct 19 05:20:01 dodge kernel: *pde = 00000000
Oct 19 05:20:01 dodge kernel: Oops: 0000
Oct 19 05:20:01 dodge kernel: CPU:    0
Oct 19 05:20:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:20:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:20:01 dodge kernel: eax: 80685000   ebx: c9bd8f20   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:20:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c8017e90
Oct 19 05:20:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:20:01 dodge kernel: Process mrtg (pid: 20357, stackpage=c8017000)
Oct 19 05:20:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 c9bd8f20 
Oct 19 05:20:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c9b961c0 c0120f92 c9bd8f20 08067000 00000000 
Oct 19 05:20:01 dodge kernel:        080675c0 c2752540 00000000 c9bd8f20 c012110e c2752540 c9bd8f20 080675c0 
Oct 19 05:20:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:20:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:20:01 dodge kernel: 
Oct 19 05:20:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:20:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:20:01 dodge kernel:  printing eip:
Oct 19 05:20:01 dodge kernel: c0123367
Oct 19 05:20:01 dodge kernel: *pde = 00000000
Oct 19 05:20:01 dodge kernel: Oops: 0000
Oct 19 05:20:01 dodge kernel: CPU:    0
Oct 19 05:20:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:20:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:20:01 dodge kernel: eax: 80685000   ebx: c6181680   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:20:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c8017e90
Oct 19 05:20:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:20:01 dodge kernel: Process awstats.pl (pid: 20358, stackpage=c8017000)
Oct 19 05:20:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 c6181680 
Oct 19 05:20:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c77e60a0 c0120f92 c6181680 08067000 00000000 
Oct 19 05:20:01 dodge kernel:        080675c0 c2752540 00000000 c6181680 c012110e c2752540 c6181680 080675c0 
Oct 19 05:20:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:20:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:20:01 dodge kernel: 
Oct 19 05:20:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:25:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:25:01 dodge kernel:  printing eip:
Oct 19 05:25:01 dodge kernel: c0123367
Oct 19 05:25:01 dodge kernel: *pde = 00000000
Oct 19 05:25:01 dodge kernel: Oops: 0000
Oct 19 05:25:01 dodge kernel: CPU:    0
Oct 19 05:25:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:25:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:25:01 dodge kernel: eax: 80685000   ebx: c849f360   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:25:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: ca0b3e90
Oct 19 05:25:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:25:01 dodge kernel: Process mrtg (pid: 20383, stackpage=ca0b3000)
Oct 19 05:25:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752a40 00000000 c849f360 
Oct 19 05:25:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c57e9120 c0120f92 c849f360 08067000 00000000 
Oct 19 05:25:01 dodge kernel:        080675c0 c2752a40 00000000 c849f360 c012110e c2752a40 c849f360 080675c0 
Oct 19 05:25:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:25:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:25:01 dodge kernel: 
Oct 19 05:25:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:25:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:25:01 dodge kernel:  printing eip:
Oct 19 05:25:01 dodge kernel: c0123367
Oct 19 05:25:01 dodge kernel: *pde = 00000000
Oct 19 05:25:01 dodge kernel: Oops: 0000
Oct 19 05:25:01 dodge kernel: CPU:    0
Oct 19 05:25:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:25:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:25:01 dodge kernel: eax: 80685000   ebx: c9bd8a40   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:25:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c7743e90
Oct 19 05:25:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:25:01 dodge kernel: Process gotmail (pid: 20384, stackpage=c7743000)
Oct 19 05:25:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752ae0 00000000 c9bd8a40 
Oct 19 05:25:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c70e44a0 c0120f92 c9bd8a40 08067000 00000000 
Oct 19 05:25:01 dodge kernel:        080675c0 c2752ae0 00000000 c9bd8a40 c012110e c2752ae0 c9bd8a40 080675c0 
Oct 19 05:25:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:25:01 dodge kernel:   [update_wall_time+11/52] [do_brk+284/512] [do_softirq+90/164] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:25:01 dodge kernel: 
Oct 19 05:25:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:30:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:30:01 dodge kernel:  printing eip:
Oct 19 05:30:01 dodge kernel: c0123367
Oct 19 05:30:01 dodge kernel: *pde = 00000000
Oct 19 05:30:01 dodge kernel: Oops: 0000
Oct 19 05:30:01 dodge kernel: CPU:    0
Oct 19 05:30:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:30:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:30:01 dodge kernel: eax: 80685000   ebx: c6181500   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:30:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c8017e90
Oct 19 05:30:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:30:01 dodge kernel: Process mrtg (pid: 20391, stackpage=c8017000)
Oct 19 05:30:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752360 00000000 c6181500 
Oct 19 05:30:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c33a57e0 c0120f92 c6181500 08067000 00000000 
Oct 19 05:30:01 dodge kernel:        080675c0 c2752360 00000000 c6181500 c012110e c2752360 c6181500 080675c0 
Oct 19 05:30:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:30:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:30:01 dodge kernel: 
Oct 19 05:30:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:30:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:30:01 dodge kernel:  printing eip:
Oct 19 05:30:01 dodge kernel: c0123367
Oct 19 05:30:01 dodge kernel: *pde = 00000000
Oct 19 05:30:01 dodge kernel: Oops: 0000
Oct 19 05:30:01 dodge kernel: CPU:    0
Oct 19 05:30:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:30:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:30:01 dodge kernel: eax: 80685000   ebx: c9bd8680   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:30:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c4239e90
Oct 19 05:30:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:30:01 dodge kernel: Process awstats.pl (pid: 20393, stackpage=c4239000)
Oct 19 05:30:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c27525e0 00000000 c9bd8680 
Oct 19 05:30:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c4cb3c60 c0120f92 c9bd8680 08067000 00000000 
Oct 19 05:30:01 dodge kernel:        080675c0 c27525e0 00000000 c9bd8680 c012110e c27525e0 c9bd8680 080675c0 
Oct 19 05:30:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:30:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:30:01 dodge kernel: 
Oct 19 05:30:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:35:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:35:01 dodge kernel:  printing eip:
Oct 19 05:35:01 dodge kernel: c0123367
Oct 19 05:35:01 dodge kernel: *pde = 00000000
Oct 19 05:35:01 dodge kernel: Oops: 0000
Oct 19 05:35:01 dodge kernel: CPU:    0
Oct 19 05:35:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:35:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:35:01 dodge kernel: eax: 80685000   ebx: c6181f80   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:35:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c7743e90
Oct 19 05:35:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:35:01 dodge kernel: Process mrtg (pid: 20415, stackpage=c7743000)
Oct 19 05:35:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752ae0 00000000 c6181f80 
Oct 19 05:35:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c562f560 c0120f92 c6181f80 08067000 00000000 
Oct 19 05:35:01 dodge kernel:        080675c0 c2752ae0 00000000 c6181f80 c012110e c2752ae0 c6181f80 080675c0 
Oct 19 05:35:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:35:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:35:01 dodge kernel: 
Oct 19 05:35:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:40:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:40:01 dodge kernel:  printing eip:
Oct 19 05:40:01 dodge kernel: c0123367
Oct 19 05:40:01 dodge kernel: *pde = 00000000
Oct 19 05:40:01 dodge kernel: Oops: 0000
Oct 19 05:40:01 dodge kernel: CPU:    0
Oct 19 05:40:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:40:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:40:01 dodge kernel: eax: 80685000   ebx: c849f9c0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:40:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2693e90
Oct 19 05:40:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:40:01 dodge kernel: Process mrtg (pid: 20423, stackpage=c2693000)
Oct 19 05:40:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c27525e0 00000000 c849f9c0 
Oct 19 05:40:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c9c783a0 c0120f92 c849f9c0 08067000 00000000 
Oct 19 05:40:01 dodge kernel:        080675c0 c27525e0 00000000 c849f9c0 c012110e c27525e0 c849f9c0 080675c0 
Oct 19 05:40:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:40:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:40:01 dodge kernel: 
Oct 19 05:40:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:40:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:40:01 dodge kernel:  printing eip:
Oct 19 05:40:01 dodge kernel: c0123367
Oct 19 05:40:01 dodge kernel: *pde = 00000000
Oct 19 05:40:01 dodge kernel: Oops: 0000
Oct 19 05:40:01 dodge kernel: CPU:    0
Oct 19 05:40:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:40:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:40:01 dodge kernel: eax: 80685000   ebx: c6181ce0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:40:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c8017e90
Oct 19 05:40:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:40:01 dodge kernel: Process awstats.pl (pid: 20425, stackpage=c8017000)
Oct 19 05:40:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752d60 00000000 c6181ce0 
Oct 19 05:40:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 cabff3e0 c0120f92 c6181ce0 08067000 00000000 
Oct 19 05:40:01 dodge kernel:        080675c0 c2752d60 00000000 c6181ce0 c012110e c2752d60 c6181ce0 080675c0 
Oct 19 05:40:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:40:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:40:01 dodge kernel: 
Oct 19 05:40:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:40:54 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:40:54 dodge kernel:  printing eip:
Oct 19 05:40:54 dodge kernel: c012389b
Oct 19 05:40:54 dodge kernel: *pde = 00000000
Oct 19 05:40:54 dodge kernel: Oops: 0000
Oct 19 05:40:54 dodge kernel: CPU:    0
Oct 19 05:40:54 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 05:40:54 dodge kernel: EFLAGS: 00010296
Oct 19 05:40:54 dodge kernel: eax: 80685000   ebx: c8017f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 05:40:54 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c8017f34
Oct 19 05:40:54 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:40:54 dodge kernel: Process spamd (pid: 20449, stackpage=c8017000)
Oct 19 05:40:54 dodge kernel: Stack: 00000000 c57e9120 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 05:40:54 dodge kernel:        c74b1680 c0123ecb c57e9120 c57e9140 c8017f8c c0123db4 00000000 c57e9120 
Oct 19 05:40:54 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 05:40:54 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 05:40:54 dodge kernel: 
Oct 19 05:40:54 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 05:40:57 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:40:57 dodge kernel:  printing eip:
Oct 19 05:40:57 dodge kernel: c012389b
Oct 19 05:40:57 dodge kernel: *pde = 00000000
Oct 19 05:40:57 dodge kernel: Oops: 0000
Oct 19 05:40:57 dodge kernel: CPU:    0
Oct 19 05:40:57 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 05:40:57 dodge kernel: EFLAGS: 00010296
Oct 19 05:40:57 dodge kernel: eax: 80685000   ebx: c8017f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 05:40:57 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c8017f34
Oct 19 05:40:57 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:40:57 dodge kernel: Process spamd (pid: 20454, stackpage=c8017000)
Oct 19 05:40:57 dodge kernel: Stack: 00000000 ca316360 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 05:40:57 dodge kernel:        c74b1680 c0123ecb ca316360 ca316380 c8017f8c c0123db4 00000000 ca316360 
Oct 19 05:40:57 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 05:40:57 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 05:40:57 dodge kernel: 
Oct 19 05:40:57 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 05:40:58 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:40:58 dodge kernel:  printing eip:
Oct 19 05:40:58 dodge kernel: c012389b
Oct 19 05:40:58 dodge kernel: *pde = 00000000
Oct 19 05:40:58 dodge kernel: Oops: 0000
Oct 19 05:40:58 dodge kernel: CPU:    0
Oct 19 05:40:58 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 05:40:58 dodge kernel: EFLAGS: 00010296
Oct 19 05:40:58 dodge kernel: eax: 80685000   ebx: c7743f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 05:40:58 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c7743f34
Oct 19 05:40:58 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:40:58 dodge kernel: Process spamd (pid: 20460, stackpage=c7743000)
Oct 19 05:40:58 dodge kernel: Stack: 00000000 c9b964c0 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 05:40:58 dodge kernel:        c74b1680 c0123ecb c9b964c0 c9b964e0 c7743f8c c0123db4 00000000 c9b964c0 
Oct 19 05:40:58 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 05:40:58 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 05:40:58 dodge kernel: 
Oct 19 05:40:58 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 05:40:58 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:40:58 dodge kernel:  printing eip:
Oct 19 05:40:58 dodge kernel: c012389b
Oct 19 05:40:58 dodge kernel: *pde = 00000000
Oct 19 05:40:58 dodge kernel: Oops: 0000
Oct 19 05:40:58 dodge kernel: CPU:    0
Oct 19 05:40:58 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 05:40:58 dodge kernel: EFLAGS: 00010296
Oct 19 05:40:58 dodge kernel: eax: 80685000   ebx: ca0b3f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 05:40:58 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: ca0b3f34
Oct 19 05:40:58 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:40:58 dodge kernel: Process spamd (pid: 20464, stackpage=ca0b3000)
Oct 19 05:40:58 dodge kernel: Stack: 00000000 c4332a60 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 05:40:58 dodge kernel:        c74b1680 c0123ecb c4332a60 c4332a80 ca0b3f8c c0123db4 00000000 c4332a60 
Oct 19 05:40:58 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 05:40:58 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 05:40:58 dodge kernel: 
Oct 19 05:40:58 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 05:45:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:45:01 dodge kernel:  printing eip:
Oct 19 05:45:01 dodge kernel: c0123367
Oct 19 05:45:01 dodge kernel: *pde = 00000000
Oct 19 05:45:01 dodge kernel: Oops: 0000
Oct 19 05:45:01 dodge kernel: CPU:    0
Oct 19 05:45:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:45:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:45:01 dodge kernel: eax: 80685000   ebx: c14cbde0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:45:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c7743e90
Oct 19 05:45:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:45:01 dodge kernel: Process mrtg (pid: 20468, stackpage=c7743000)
Oct 19 05:45:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752a40 00000000 c14cbde0 
Oct 19 05:45:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c78fdb60 c0120f92 c14cbde0 08067000 00000000 
Oct 19 05:45:02 dodge kernel:        080675c0 c2752a40 00000000 c14cbde0 c012110e c2752a40 c14cbde0 080675c0 
Oct 19 05:45:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:45:02 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:45:02 dodge kernel: 
Oct 19 05:45:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:50:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:50:01 dodge kernel:  printing eip:
Oct 19 05:50:01 dodge kernel: c0123367
Oct 19 05:50:01 dodge kernel: *pde = 00000000
Oct 19 05:50:01 dodge kernel: Oops: 0000
Oct 19 05:50:01 dodge kernel: CPU:    0
Oct 19 05:50:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:50:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:50:01 dodge kernel: eax: 80685000   ebx: c9bd88c0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:50:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c77b7e90
Oct 19 05:50:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:50:01 dodge kernel: Process mrtg (pid: 20476, stackpage=c77b7000)
Oct 19 05:50:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 c9bd88c0 
Oct 19 05:50:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c78fdc60 c0120f92 c9bd88c0 08067000 00000000 
Oct 19 05:50:01 dodge kernel:        080675c0 c2752540 00000000 c9bd88c0 c012110e c2752540 c9bd88c0 080675c0 
Oct 19 05:50:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:50:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:50:01 dodge kernel: 
Oct 19 05:50:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:50:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:50:01 dodge kernel:  printing eip:
Oct 19 05:50:01 dodge kernel: c0123367
Oct 19 05:50:01 dodge kernel: *pde = 00000000
Oct 19 05:50:01 dodge kernel: Oops: 0000
Oct 19 05:50:01 dodge kernel: CPU:    0
Oct 19 05:50:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:50:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:50:01 dodge kernel: eax: 80685000   ebx: c14cb0c0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:50:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2b91e90
Oct 19 05:50:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:50:01 dodge kernel: Process awstats.pl (pid: 20477, stackpage=c2b91000)
Oct 19 05:50:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752220 00000000 c14cb0c0 
Oct 19 05:50:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c57e97a0 c0120f92 c14cb0c0 08067000 00000000 
Oct 19 05:50:01 dodge kernel:        080675c0 c2752220 00000000 c14cb0c0 c012110e c2752220 c14cb0c0 080675c0 
Oct 19 05:50:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:50:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:50:01 dodge kernel: 
Oct 19 05:50:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 05:55:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 05:55:01 dodge kernel:  printing eip:
Oct 19 05:55:01 dodge kernel: c0123367
Oct 19 05:55:01 dodge kernel: *pde = 00000000
Oct 19 05:55:01 dodge kernel: Oops: 0000
Oct 19 05:55:01 dodge kernel: CPU:    0
Oct 19 05:55:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 05:55:01 dodge kernel: EFLAGS: 00010296
Oct 19 05:55:01 dodge kernel: eax: 80685000   ebx: c9bd8ce0   ecx: ca6f13a4   edx: 0000001f
Oct 19 05:55:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: ca0b3e90
Oct 19 05:55:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 05:55:01 dodge kernel: Process mrtg (pid: 20499, stackpage=ca0b3000)
Oct 19 05:55:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752360 00000000 c9bd8ce0 
Oct 19 05:55:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c77e6ca0 c0120f92 c9bd8ce0 08067000 00000000 
Oct 19 05:55:01 dodge kernel:        080675c0 c2752360 00000000 c9bd8ce0 c012110e c2752360 c9bd8ce0 080675c0 
Oct 19 05:55:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 05:55:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 05:55:01 dodge kernel: 
Oct 19 05:55:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:00:02 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:00:02 dodge kernel:  printing eip:
Oct 19 06:00:02 dodge kernel: c0123367
Oct 19 06:00:02 dodge kernel: *pde = 00000000
Oct 19 06:00:02 dodge kernel: Oops: 0000
Oct 19 06:00:02 dodge kernel: CPU:    0
Oct 19 06:00:02 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:00:02 dodge kernel: EFLAGS: 00010296
Oct 19 06:00:02 dodge kernel: eax: 80685000   ebx: c53f5bc0   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:00:02 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c458be90
Oct 19 06:00:02 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:00:02 dodge kernel: Process mrtg (pid: 20508, stackpage=c458b000)
Oct 19 06:00:02 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752720 00000000 c53f5bc0 
Oct 19 06:00:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c78fdb60 c0120f92 c53f5bc0 08067000 00000000 
Oct 19 06:00:02 dodge kernel:        080675c0 c2752720 00000000 c53f5bc0 c012110e c2752720 c53f5bc0 080675c0 
Oct 19 06:00:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:00:02 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:00:02 dodge kernel: 
Oct 19 06:00:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:00:02 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:00:02 dodge kernel:  printing eip:
Oct 19 06:00:02 dodge kernel: c0123367
Oct 19 06:00:02 dodge kernel: *pde = 00000000
Oct 19 06:00:02 dodge kernel: Oops: 0000
Oct 19 06:00:02 dodge kernel: CPU:    0
Oct 19 06:00:02 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:00:02 dodge kernel: EFLAGS: 00010296
Oct 19 06:00:02 dodge kernel: eax: 80685000   ebx: c14cb7e0   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:00:02 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c77b7e90
Oct 19 06:00:02 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:00:02 dodge kernel: Process awstats.pl (pid: 20509, stackpage=c77b7000)
Oct 19 06:00:02 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752540 00000000 c14cb7e0 
Oct 19 06:00:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c4cb3c60 c0120f92 c14cb7e0 08067000 00000000 
Oct 19 06:00:02 dodge kernel:        080675c0 c2752540 00000000 c14cb7e0 c012110e c2752540 c14cb7e0 080675c0 
Oct 19 06:00:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:00:02 dodge kernel:   [do_brk+284/512] [schedule+746/788] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:00:02 dodge kernel: 
Oct 19 06:00:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:05:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:05:01 dodge kernel:  printing eip:
Oct 19 06:05:01 dodge kernel: c0123367
Oct 19 06:05:01 dodge kernel: *pde = 00000000
Oct 19 06:05:01 dodge kernel: Oops: 0000
Oct 19 06:05:01 dodge kernel: CPU:    0
Oct 19 06:05:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:05:01 dodge kernel: EFLAGS: 00010296
Oct 19 06:05:01 dodge kernel: eax: 80685000   ebx: c14cb660   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:05:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c8017e90
Oct 19 06:05:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:05:01 dodge kernel: Process mrtg (pid: 20531, stackpage=c8017000)
Oct 19 06:05:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752d60 00000000 c14cb660 
Oct 19 06:05:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c78fdc60 c0120f92 c14cb660 08067000 00000000 
Oct 19 06:05:01 dodge kernel:        080675c0 c2752d60 00000000 c14cb660 c012110e c2752d60 c14cb660 080675c0 
Oct 19 06:05:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:05:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:05:01 dodge kernel: 
Oct 19 06:05:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:10:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:10:01 dodge kernel:  printing eip:
Oct 19 06:10:01 dodge kernel: c0123367
Oct 19 06:10:01 dodge kernel: *pde = 00000000
Oct 19 06:10:01 dodge kernel: Oops: 0000
Oct 19 06:10:01 dodge kernel: CPU:    0
Oct 19 06:10:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:10:01 dodge kernel: EFLAGS: 00010296
Oct 19 06:10:01 dodge kernel: eax: 80685000   ebx: c849ff00   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:10:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c4239e90
Oct 19 06:10:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:10:01 dodge kernel: Process awstats.pl (pid: 20540, stackpage=c4239000)
Oct 19 06:10:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752a40 00000000 c849ff00 
Oct 19 06:10:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c562f560 c0120f92 c849ff00 08067000 00000000 
Oct 19 06:10:01 dodge kernel:        080675c0 c2752a40 00000000 c849ff00 c012110e c2752a40 c849ff00 080675c0 
Oct 19 06:10:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:10:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:10:01 dodge kernel: 
Oct 19 06:10:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:10:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:10:01 dodge kernel:  printing eip:
Oct 19 06:10:01 dodge kernel: c0123367
Oct 19 06:10:01 dodge kernel: *pde = 00000000
Oct 19 06:10:01 dodge kernel: Oops: 0000
Oct 19 06:10:01 dodge kernel: CPU:    0
Oct 19 06:10:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:10:01 dodge kernel: EFLAGS: 00010296
Oct 19 06:10:01 dodge kernel: eax: 80685000   ebx: c849f180   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:10:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2ffbe90
Oct 19 06:10:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:10:01 dodge kernel: Process mrtg (pid: 20539, stackpage=c2ffb000)
Oct 19 06:10:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752c20 00000000 c849f180 
Oct 19 06:10:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c1dbab20 c0120f92 c849f180 08067000 00000000 
Oct 19 06:10:01 dodge kernel:        080675c0 c2752c20 00000000 c849f180 c012110e c2752c20 c849f180 080675c0 
Oct 19 06:10:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:10:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:10:01 dodge kernel: 
Oct 19 06:10:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:15:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:15:01 dodge kernel:  printing eip:
Oct 19 06:15:01 dodge kernel: c0123367
Oct 19 06:15:01 dodge kernel: *pde = 00000000
Oct 19 06:15:01 dodge kernel: Oops: 0000
Oct 19 06:15:01 dodge kernel: CPU:    0
Oct 19 06:15:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:15:01 dodge kernel: EFLAGS: 00010296
Oct 19 06:15:01 dodge kernel: eax: 80685000   ebx: c9bd8500   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:15:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c7743e90
Oct 19 06:15:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:15:01 dodge kernel: Process mrtg (pid: 20563, stackpage=c7743000)
Oct 19 06:15:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752ae0 00000000 c9bd8500 
Oct 19 06:15:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c70e4220 c0120f92 c9bd8500 08067000 00000000 
Oct 19 06:15:01 dodge kernel:        080675c0 c2752ae0 00000000 c9bd8500 c012110e c2752ae0 c9bd8500 080675c0 
Oct 19 06:15:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:15:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:15:01 dodge kernel: 
Oct 19 06:15:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:18:44 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:18:44 dodge kernel:  printing eip:
Oct 19 06:18:44 dodge kernel: c012389b
Oct 19 06:18:44 dodge kernel: *pde = 00000000
Oct 19 06:18:44 dodge kernel: Oops: 0000
Oct 19 06:18:44 dodge kernel: CPU:    0
Oct 19 06:18:44 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 06:18:44 dodge kernel: EFLAGS: 00010296
Oct 19 06:18:44 dodge kernel: eax: 80685000   ebx: c2b91f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 06:18:44 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c2b91f34
Oct 19 06:18:44 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:18:44 dodge kernel: Process spamd (pid: 20569, stackpage=c2b91000)
Oct 19 06:18:44 dodge kernel: Stack: 00000000 c6a3bf40 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 06:18:44 dodge kernel:        c74b1680 c0123ecb c6a3bf40 c6a3bf60 c2b91f8c c0123db4 00000000 c6a3bf40 
Oct 19 06:18:44 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 06:18:44 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 06:18:44 dodge kernel: 
Oct 19 06:18:44 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 06:20:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:20:01 dodge kernel:  printing eip:
Oct 19 06:20:01 dodge kernel: c0123367
Oct 19 06:20:01 dodge kernel: *pde = 00000000
Oct 19 06:20:01 dodge kernel: Oops: 0000
Oct 19 06:20:01 dodge kernel: CPU:    0
Oct 19 06:20:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:20:01 dodge kernel: EFLAGS: 00010296
Oct 19 06:20:01 dodge kernel: eax: 80685000   ebx: c14cbea0   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:20:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c77b7e90
Oct 19 06:20:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:20:01 dodge kernel: Process mrtg (pid: 20577, stackpage=c77b7000)
Oct 19 06:20:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752360 00000000 c14cbea0 
Oct 19 06:20:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 ca316be0 c0120f92 c14cbea0 08067000 00000000 
Oct 19 06:20:01 dodge kernel:        080675c0 c2752360 00000000 c14cbea0 c012110e c2752360 c14cbea0 080675c0 
Oct 19 06:20:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:20:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:20:01 dodge kernel: 
Oct 19 06:20:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:20:01 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:20:01 dodge kernel:  printing eip:
Oct 19 06:20:01 dodge kernel: c0123367
Oct 19 06:20:01 dodge kernel: *pde = 00000000
Oct 19 06:20:01 dodge kernel: Oops: 0000
Oct 19 06:20:01 dodge kernel: CPU:    0
Oct 19 06:20:01 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:20:01 dodge kernel: EFLAGS: 00010296
Oct 19 06:20:01 dodge kernel: eax: 80685000   ebx: c14cbf00   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:20:01 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2ffbe90
Oct 19 06:20:01 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:20:01 dodge kernel: Process awstats.pl (pid: 20579, stackpage=c2ffb000)
Oct 19 06:20:01 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752a40 00000000 c14cbf00 
Oct 19 06:20:01 dodge kernel:        000000a5 cb77de8c ca6f12e0 c6a3bbc0 c0120f92 c14cbf00 08067000 00000000 
Oct 19 06:20:01 dodge kernel:        080675c0 c2752a40 00000000 c14cbf00 c012110e c2752a40 c14cbf00 080675c0 
Oct 19 06:20:01 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:20:01 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:20:01 dodge kernel: 
Oct 19 06:20:01 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:23:06 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:23:06 dodge kernel:  printing eip:
Oct 19 06:23:06 dodge kernel: c012389b
Oct 19 06:23:06 dodge kernel: *pde = 00000000
Oct 19 06:23:06 dodge kernel: Oops: 0000
Oct 19 06:23:06 dodge kernel: CPU:    0
Oct 19 06:23:06 dodge kernel: EIP:    0010:[do_generic_file_read+367/1028]    Not tainted
Oct 19 06:23:06 dodge kernel: EFLAGS: 00010296
Oct 19 06:23:06 dodge kernel: eax: 80685000   ebx: c2693f8c   ecx: 00000010   edx: 0000f7a3
Oct 19 06:23:06 dodge kernel: esi: cb77de8c   edi: c74b1744   ebp: 00000000   esp: c2693f34
Oct 19 06:23:06 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:23:06 dodge kernel: Process spamd (pid: 20604, stackpage=c2693000)
Oct 19 06:23:06 dodge kernel: Stack: 00000000 c1dbab20 ffffffea 00000200 00001000 00000001 00000000 00000000 
Oct 19 06:23:06 dodge kernel:        c74b1680 c0123ecb c1dbab20 c1dbab40 c2693f8c c0123db4 00000000 c1dbab20 
Oct 19 06:23:06 dodge kernel:        ffffffea 00000200 00001000 00000818 00000000 00000000 00000000 00000200 
Oct 19 06:23:06 dodge kernel: Call Trace:    [generic_file_read+147/400] [file_read_actor+0/132] [sys_read+150/240] [system_call+51/56]
Oct 19 06:23:06 dodge kernel: 
Oct 19 06:23:06 dodge kernel: Code: 39 78 08 75 f4 39 68 0c 75 ef 89 c3 85 db 0f 84 61 01 00 00 
Oct 19 06:25:02 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:25:02 dodge kernel:  printing eip:
Oct 19 06:25:02 dodge kernel: c0123367
Oct 19 06:25:02 dodge kernel: *pde = 00000000
Oct 19 06:25:02 dodge kernel: Oops: 0000
Oct 19 06:25:02 dodge kernel: CPU:    0
Oct 19 06:25:02 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:25:02 dodge kernel: EFLAGS: 00010296
Oct 19 06:25:02 dodge kernel: eax: 80685000   ebx: c53f5680   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:25:02 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c4239e90
Oct 19 06:25:02 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:25:02 dodge kernel: Process mrtg (pid: 20612, stackpage=c4239000)
Oct 19 06:25:02 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752720 00000000 c53f5680 
Oct 19 06:25:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c70e4220 c0120f92 c53f5680 08067000 00000000 
Oct 19 06:25:02 dodge kernel:        080675c0 c2752720 00000000 c53f5680 c012110e c2752720 c53f5680 080675c0 
Oct 19 06:25:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:25:02 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:25:02 dodge kernel: 
Oct 19 06:25:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:25:02 dodge kernel:  <1>Unable to handle kernel paging request at virtual address 80685008
Oct 19 06:25:02 dodge kernel:  printing eip:
Oct 19 06:25:02 dodge kernel: c0123367
Oct 19 06:25:02 dodge kernel: *pde = 00000000
Oct 19 06:25:02 dodge kernel: Oops: 0000
Oct 19 06:25:02 dodge kernel: CPU:    0
Oct 19 06:25:02 dodge kernel: EIP:    0010:[__find_get_page+23/44]    Not tainted
Oct 19 06:25:02 dodge kernel: EFLAGS: 00010296
Oct 19 06:25:02 dodge kernel: eax: 80685000   ebx: c53f5320   ecx: ca6f13a4   edx: 0000001f
Oct 19 06:25:02 dodge kernel: esi: 000000a5   edi: 0000001f   ebp: ca6f13a4   esp: c2ffbe90
Oct 19 06:25:02 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:25:02 dodge kernel: Process gotmail (pid: 20613, stackpage=c2ffb000)
Oct 19 06:25:02 dodge kernel: Stack: c0124604 ca6f13a4 0000001f cb77de8c 080675c0 c2752220 00000000 c53f5320 
Oct 19 06:25:02 dodge kernel:        000000a5 cb77de8c ca6f12e0 c6a3b3c0 c0120f92 c53f5320 08067000 00000000 
Oct 19 06:25:02 dodge kernel:        080675c0 c2752220 00000000 c53f5320 c012110e c2752220 c53f5320 080675c0 
Oct 19 06:25:02 dodge kernel: Call Trace:    [filemap_nopage+188/504] [do_no_page+82/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152]
Oct 19 06:25:02 dodge kernel:   [do_brk+284/512] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:25:02 dodge kernel: 
Oct 19 06:25:02 dodge kernel: Code: 39 48 08 75 f4 39 50 0c 75 ef 85 c0 74 03 ff 40 14 c3 8d 76 
Oct 19 06:25:04 dodge kernel:  kernel BUG at vmscan.c:358!
Oct 19 06:25:04 dodge kernel: invalid operand: 0000
Oct 19 06:25:04 dodge kernel: CPU:    0
Oct 19 06:25:04 dodge kernel: EIP:    0010:[shrink_cache+144/760]    Not tainted
Oct 19 06:25:04 dodge kernel: EFLAGS: 00010246
Oct 19 06:25:04 dodge kernel: eax: 3dbc428d   ebx: 00000000   ecx: c01ba8f4   edx: 000001e5
Oct 19 06:25:04 dodge kernel: esi: c01ba8d8   edi: 00000020   ebp: 000001e5   esp: c2693df4
Oct 19 06:25:04 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:25:04 dodge kernel: Process dpkg (pid: 20616, stackpage=c2693000)
Oct 19 06:25:04 dodge kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 c2692000 000012f2 000001d2 
Oct 19 06:25:04 dodge kernel:        c0298fb4 c0129830 00000006 00000007 00000006 00000020 000001d2 c0298fb4 
Oct 19 06:25:04 dodge kernel:        c0298fb4 c012989c 00000020 c2692000 00000000 00000010 c0298fb4 c012a268 
Oct 19 06:25:04 dodge kernel: Call Trace:    [shrink_caches+88/136] [try_to_free_pages_zone+60/92] [balance_classzone+80/456] [__alloc_pages+274/352] [_alloc_pages+22/24]
Oct 19 06:25:04 dodge kernel:   [do_anonymous_page+52/212] [do_no_page+51/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152] [update_wall_time+11/52]
Oct 19 06:25:04 dodge kernel:   [do_brk+284/512] [do_softirq+90/164] [sys_brk+187/228] [error_code+52/60]
Oct 19 06:25:04 dodge kernel: 
Oct 19 06:25:04 dodge kernel: Code: 0f 0b 66 01 07 f5 24 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 07 
Oct 19 06:25:29 dodge kernel:  kernel BUG at vmscan.c:358!
Oct 19 06:25:29 dodge kernel: invalid operand: 0000
Oct 19 06:25:29 dodge kernel: CPU:    0
Oct 19 06:25:29 dodge kernel: EIP:    0010:[shrink_cache+144/760]    Not tainted
Oct 19 06:25:29 dodge kernel: EFLAGS: 00010246
Oct 19 06:25:29 dodge kernel: eax: 3dbc428d   ebx: 00000000   ecx: c01ba8f4   edx: 000001d0
Oct 19 06:25:29 dodge kernel: esi: c01ba8d8   edi: 00000020   ebp: 000001d0   esp: c2679d00
Oct 19 06:25:29 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:25:29 dodge kernel: Process find (pid: 20638, stackpage=c2679000)
Oct 19 06:25:29 dodge kernel: Stack: 00000020 000000f0 00000020 00000006 00000006 c2678000 00001228 000000f0 
Oct 19 06:25:29 dodge kernel:        c0298fb4 c0129830 00000006 00000007 00000006 00000020 000000f0 c0298fb4 
Oct 19 06:25:29 dodge kernel:        c0298fb4 c012989c 00000020 c2678000 00000000 00000010 c0298fb4 c012a268 
Oct 19 06:25:29 dodge kernel: Call Trace:    [shrink_caches+88/136] [try_to_free_pages_zone+60/92] [balance_classzone+80/456] [ext3_get_block_handle+127/576] [__alloc_pages+274/352]
Oct 19 06:25:29 dodge kernel:   [_alloc_pages+22/24] [find_or_create_page+86/208] [grow_dev_page+35/164] [grow_buffers+203/276] [getblk+49/80] [ext3_getblk+185/612]
Oct 19 06:25:29 dodge kernel:   [getblk+71/80] [ext3_read_inode+22/632] [ext3_read_inode+610/632] [ext3_bread+35/124] [ext3_readdir+150/912] [vfs_permission+116/240]
Oct 19 06:25:29 dodge kernel:   [permission+43/48] [vfs_readdir+97/132] [filldir64+0/276] [sys_getdents64+79/179] [filldir64+0/276] [sys_fcntl64+127/136]
Oct 19 06:25:29 dodge kernel:   [system_call+51/56]
Oct 19 06:25:29 dodge kernel: 
Oct 19 06:25:29 dodge kernel: Code: 0f 0b 66 01 07 f5 24 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 07 
Oct 19 06:25:29 dodge kernel:  kernel BUG at vmscan.c:358!
Oct 19 06:25:29 dodge kernel: invalid operand: 0000
Oct 19 06:25:29 dodge kernel: CPU:    0
Oct 19 06:25:29 dodge kernel: EIP:    0010:[shrink_cache+144/760]    Not tainted
Oct 19 06:25:29 dodge kernel: EFLAGS: 00010246
Oct 19 06:25:29 dodge kernel: eax: 3dbc428d   ebx: 00000000   ecx: c01ba8f4   edx: 000001d1
Oct 19 06:25:29 dodge kernel: esi: c01ba8d8   edi: 00000020   ebp: 000001d1   esp: c15e1e5c
Oct 19 06:25:29 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:25:29 dodge kernel: Process frcode (pid: 20637, stackpage=c15e1000)
Oct 19 06:25:29 dodge kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 c15e0000 0000122a 000001d2 
Oct 19 06:25:29 dodge kernel:        c0298fb4 c0129830 00000006 00000007 00000006 00000020 000001d2 c0298fb4 
Oct 19 06:25:29 dodge kernel:        c0298fb4 c012989c 00000020 c15e0000 00000000 00000010 c0298fb4 c012a268 
Oct 19 06:25:29 dodge kernel: Call Trace:    [shrink_caches+88/136] [try_to_free_pages_zone+60/92] [balance_classzone+80/456] [__alloc_pages+274/352] [do_generic_file_write+396/968]
Oct 19 06:25:29 dodge kernel:   [_alloc_pages+22/24] [do_generic_file_write+428/968] [generic_file_write+255/284] [ext3_file_write+35/188] [sys_write+150/240] [system_call+51/56]
Oct 19 06:25:29 dodge kernel: 
Oct 19 06:25:29 dodge kernel: Code: 0f 0b 66 01 07 f5 24 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 07 
Oct 19 06:25:39 dodge kernel:  kernel BUG at vmscan.c:358!
Oct 19 06:25:39 dodge kernel: invalid operand: 0000
Oct 19 06:25:39 dodge kernel: CPU:    0
Oct 19 06:25:39 dodge kernel: EIP:    0010:[shrink_cache+144/760]    Not tainted
Oct 19 06:25:39 dodge kernel: EFLAGS: 00010246
Oct 19 06:25:39 dodge kernel: eax: 3dbc428d   ebx: 00000000   ecx: c01ba8f4   edx: 000001d1
Oct 19 06:25:39 dodge kernel: esi: c01ba8d8   edi: 00000020   ebp: 000001d1   esp: c45fde3c
Oct 19 06:25:39 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:25:39 dodge kernel: Process isoqlog (pid: 20643, stackpage=c45fd000)
Oct 19 06:25:39 dodge kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 c45fc000 0000122b 000001d2 
Oct 19 06:25:39 dodge kernel:        c0298fb4 c0129830 00000006 00000007 00000006 00000020 000001d2 c0298fb4 
Oct 19 06:25:39 dodge kernel:        c0298fb4 c012989c 00000020 c45fc000 00000000 00000010 c0298fb4 c012a268 
Oct 19 06:25:39 dodge kernel: Call Trace:    [shrink_caches+88/136] [try_to_free_pages_zone+60/92] [balance_classzone+80/456] [__alloc_pages+274/352] [ext3_get_block+0/100]
Oct 19 06:25:39 dodge kernel:   [_alloc_pages+22/24] [page_cache_read+110/188] [generic_file_readahead+261/316] [do_generic_file_read+422/1028] [generic_file_read+147/400] [file_read_actor+0/132]
Oct 19 06:25:39 dodge kernel:   [sys_read+150/240] [system_call+51/56]
Oct 19 06:25:39 dodge kernel: 
Oct 19 06:25:39 dodge kernel: Code: 0f 0b 66 01 07 f5 24 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 07 
Oct 19 06:25:49 dodge kernel:  kernel BUG at vmscan.c:358!
Oct 19 06:25:49 dodge kernel: invalid operand: 0000
Oct 19 06:25:49 dodge kernel: CPU:    0
Oct 19 06:25:49 dodge kernel: EIP:    0010:[shrink_cache+144/760]    Not tainted
Oct 19 06:25:49 dodge kernel: EFLAGS: 00010246
Oct 19 06:25:49 dodge kernel: eax: 3dbc428d   ebx: 00000000   ecx: c01ba8f4   edx: 000001d1
Oct 19 06:25:49 dodge kernel: esi: c01ba8d8   edi: 00000020   ebp: 000001d1   esp: c45fddf4
Oct 19 06:25:49 dodge kernel: ds: 0018   es: 0018   ss: 0018
Oct 19 06:25:49 dodge kernel: Process logrotate (pid: 20645, stackpage=c45fd000)
Oct 19 06:25:49 dodge kernel: Stack: 00000020 000001d2 00000020 00000006 00000006 c45fc000 0000122b 000001d2 
Oct 19 06:25:49 dodge kernel:        c0298fb4 c0129830 00000006 00000007 00000006 00000020 000001d2 c0298fb4 
Oct 19 06:25:49 dodge kernel:        c0298fb4 c012989c 00000020 c45fc000 00000000 00000010 c0298fb4 c012a268 
Oct 19 06:25:49 dodge kernel: Call Trace:    [shrink_caches+88/136] [try_to_free_pages_zone+60/92] [balance_classzone+80/456] [__alloc_pages+274/352] [_alloc_pages+22/24]
Oct 19 06:25:49 dodge kernel:   [do_anonymous_page+52/212] [do_no_page+51/380] [handle_mm_fault+82/176] [do_page_fault+352/1152] [do_page_fault+0/1152] [do_munmap+561/576]
Oct 19 06:25:49 dodge kernel:   [sys_munmap+53/84] [error_code+52/60]
Oct 19 06:25:49 dodge kernel: 
Oct 19 06:25:49 dodge kernel: Code: 0f 0b 66 01 07 f5 24 c0 8b 41 fc a8 80 74 08 0f 0b 67 01 07 
Oct 19 06:26:00 dodge kernel:  kernel BUG at vmscan.c:358!
Oct 19 06:26:00 dodge kernel: invalid operand: 0000
Oct 19 06:26:00 dodge kernel: CPU:    0
Oct 19 06:26:00 dodge kernel: EIP:    0010:[shrink_cache+144/760]    Not tainted
Oct 19 06:26:00 dodge kernel: EFLAGS: 00010246

--=-+fCfopxE4OR9dlSDZ2Ag--

