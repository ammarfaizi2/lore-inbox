Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277371AbRJOKMS>; Mon, 15 Oct 2001 06:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277372AbRJOKMI>; Mon, 15 Oct 2001 06:12:08 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:40836 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S277371AbRJOKL5>; Mon, 15 Oct 2001 06:11:57 -0400
Date: Mon, 15 Oct 2001 11:12:29 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: oops from our mailer
Message-ID: <Pine.LNX.4.33.0110151107060.2244-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more oopses (this time apparently self-decoded) from my 2.4.9-ac10 + ext3
0.9.9 + both extra ext3 patches + jfs-1.0.4.

This machine is a UP Athlon, probably not highmem (I could check?).

Oct 15 06:25:01 nick kernel:  printing eip:
Oct 15 06:25:01 nick kernel: c012adb3
Oct 15 06:25:01 nick kernel: Oops: 0002
Oct 15 06:25:01 nick kernel: CPU:    0
Oct 15 06:25:02 nick kernel: EIP:    0010:[__free_pages_ok+403/672]
Oct 15 06:25:02 nick kernel: EFLAGS: 00010087
Oct 15 06:25:02 nick kernel: eax: c09ead50   ebx: c09eacb4   ecx: c09eacd8   edx: 00000000
Oct 15 06:25:02 nick kernel: esi: 181a6cad   edi: 00000000   ebp: 0c0d3656   esp: d7efbf6c
Oct 15 06:25:02 nick kernel: ds: 0018   es: 0018   ss: 0018
Oct 15 06:25:02 nick kernel: Process kswapd (pid: 4, stackpage=d7efb000)
Oct 15 06:25:02 nick kernel: Stack: c12124a8 5a2cf071 c09eacd8 00000217 ffffffff c131cec0 c131ce98 00000000
Oct 15 06:25:02 nick kernel:        00001489 c012a005 00000001 00000000 000003ff 00000000 000000c0 00000000
Oct 15 06:25:02 nick kernel:        000000c0 0008e000 c012a6ab 000000c0 00000000 c01f0040 00000006 c012a75e
Oct 15 06:25:02 nick kernel: Call Trace: [page_launder+1461/2208] [do_try_to_free_pages+27/96] [kswapd+110/240] [stext+0/48] [stext+0/48]
Oct 15 06:25:02 nick kernel:    [kernel_thread+38/48] [kswapd+0/240]
Oct 15 06:25:02 nick kernel:
Oct 15 06:25:02 nick kernel: Code: 0f bb 2a 19 c0 85 c0 0f 84 c5 00 00 00 8b 44 24 10 f7 d8 31
Oct 15 06:29:14 nick kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
Oct 15 06:29:14 nick kernel:  printing eip:
Oct 15 06:29:14 nick kernel: c01344e5
Oct 15 06:29:14 nick kernel: Oops: 0002
Oct 15 06:29:14 nick kernel: CPU:    0
Oct 15 06:29:14 nick kernel: EIP:    0010:[brw_page+85/208]
Oct 15 06:29:14 nick kernel: EFLAGS: 00010213
Oct 15 06:29:14 nick kernel: eax: 00000002   ebx: c14cb5b8   ecx: c023ba00   edx: 00000301
Oct 15 06:29:14 nick kernel: esi: 00000000   edi: c6ec5dd8   ebp: c6d1d53c   esp: c6ec5d8c
Oct 15 06:29:14 nick kernel: ds: 0018   es: 0018   ss: 0018
Oct 15 06:29:14 nick kernel: Process ypserv (pid: 32724, stackpage=c6ec5000)
Oct 15 06:29:14 nick kernel: Stack: 00000001 00000000 00000000 00001000 c012aa37 00000001 c14cb5b8 00000301
Oct 15 06:29:14 nick kernel:        c6ec5dd4 00001000 00000000 0000822b 030174ee 00000000 00000001 c022b280
Oct 15 06:29:14 nick kernel:        fffffffe 00000046 0000822b 00000046 c6ec5e04 0000000b 00000282 00000282
Oct 15 06:29:14 nick kernel: Call Trace: [rw_swap_page_base+311/400] [rw_swap_page+95/160] [swap_writepage+120/128] [page_launder+772/2208] [do_try_to_free_pages+27/96]
Oct 15 06:29:14 nick kernel:    [try_to_free_pages+40/64] [__alloc_pages+430/576] [do_wp_page+370/592] [rtc:__insmod_rtc_O/lib/modules/2.4.9-ac10-jfs/kernel/drivers/ch+-281148/96] [handle_mm_fault+157/208] [posix_lock_file+1343/1360]
Oct 15 06:29:14 nick kernel:    [do_page_fault+374/1152] [kmem_cache_free+533/672] [fcntl_setlk+448/464] [rtc:__insmod_rtc_O/lib/modules/2.4.9-ac10-jfs/kernel/drivers/ch+-331759/96] [filp_close+82/96] [do_page_fault+0/1152]
Oct 15 06:29:14 nick kernel:    [error_code+56/64]
Oct 15 06:29:14 nick kernel:
Oct 15 06:29:14 nick kernel: Code: 0f ab 46 18 19 c0 85 c0 74 26 bb 02 00 00 00 8d b6 00 00 00

