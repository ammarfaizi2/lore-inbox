Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292116AbSCDH4W>; Mon, 4 Mar 2002 02:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292122AbSCDH4P>; Mon, 4 Mar 2002 02:56:15 -0500
Received: from mail.zeelandnet.nl ([212.115.192.194]:15758 "EHLO
	mail.zeelandnet.nl") by vger.kernel.org with ESMTP
	id <S292116AbSCDHz4>; Mon, 4 Mar 2002 02:55:56 -0500
Message-ID: <000b01c1c351$afaecb80$2a0010ac@dennisws>
From: "Dennis Fleurbaaij" <dfleurbaaij@rocwest.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel bug in dcache.c
Date: Mon, 4 Mar 2002 08:53:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running a stock redhat kernel (2.4.9-21) and when I left the server on
this weekend running only apache, postgres and mrtg I got the messages
below. It resulted in a total loss of service.

Is this bug fixed ? Or can anyone fix it ? I'm not subscribed to the lkm
anymore so any replies please cc to dfleurbaaij@rocwest.nl. Furthermore
there where a load of emails from my cron daemon. Every time in pairs of 2.

Thank you,
Dennis Fleurbaaij

------------------- CRON -----------------
First email:
WARNING: rateup died from Signal 11
 with Exit Value 0 when doing router '<ip-removed>'
 Signal was 11, Returncode was 0

Second email:
ERROR: fork 2 has died ahead of time ...
------------------- /CRON -----------------



------------------- DMESG -----------------

----- Original Message -----
From: "root" <root@<address_removed>>
To: <dfleurbaaij@rocwest.nl>
Sent: Monday, March 04, 2002 8:45 AM
Subject: kernel error


> x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0140dc1>] open_namei [kernel] 0x461
> [<c0126d14>] do_munmap [kernel] 0x64
> [<c0127014>] do_brk [kernel] 0xb4
> [<c0126149>] sys_brk [kernel] 0xa9
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007baf3
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: c8d45df8
> ds: 0018   es: 0018   ss: 0018
> Process mrtg (pid: 12783, stackpage=c8d45000)
> Stack: c022e31b 0000015d 00000001 c101a9dc 00000000 00000007 c012eba4
c012e969
>        c02b29c0 00000000 00000f50 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000000 c8d44000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012eba4>] page_launder [kernel] 0x454
> [<c012e969>] page_launder [kernel] 0x219
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c01d164a>] ip_local_deliver [kernel] 0x12a
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c01d1a03>] ip_rcv [kernel] 0x323
> [<c0126c10>] unmap_fixup [kernel] 0x120
> [<c01c2cfa>] net_rx_action [kernel] 0x1aa
> [<c010827a>] handle_IRQ_event [kernel] 0x3a
> [<c011b61b>] do_softirq [kernel] 0x4b
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007c18c
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: cde4bdf8
> ds: 0018   es: 0018   ss: 0018
> Process rateup (pid: 13311, stackpage=cde4b000)
> Stack: c022e31b 0000015d 00000000 c12b1d94 00000000 00000000 c1042f10
00000000
>        c012f03e 00000000 000021a1 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000001 cde4a000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012f03e>] page_launder [kernel] 0x8ee
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0140dc1>] open_namei [kernel] 0x461
> [<c0126d14>] do_munmap [kernel] 0x64
> [<c0127014>] do_brk [kernel] 0xb4
> [<c0126149>] sys_brk [kernel] 0xa9
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007c78f
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: cad53df8
> ds: 0018   es: 0018   ss: 0018
> Process mrtg (pid: 13530, stackpage=cad53000)
> Stack: c022e31b 0000015d 00000000 c120a8e0 00000000 00000000 c120a8e0
00000000
>        c012f03e 00000000 00001099 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000001 cad52000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012f03e>] page_launder [kernel] 0x8ee
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0126537>] do_mmap_pgoff [kernel] 0x3b7
> [<c010b416>] sys_mmap2 [kernel] 0x66
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007cd46
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: c3959df8
> ds: 0018   es: 0018   ss: 0018
> Process rateup (pid: 14063, stackpage=c3959000)
> Stack: c022e31b 0000015d 00000000 c1218998 00000000 00000000 c1039698
00000000
>        c012f03e 00000000 000021fd 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000001 c3958000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012f03e>] page_launder [kernel] 0x8ee
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0140dc1>] open_namei [kernel] 0x461
> [<c0126d14>] do_munmap [kernel] 0x64
> [<c0127014>] do_brk [kernel] 0xb4
> [<c0126149>] sys_brk [kernel] 0xa9
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007d349
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: cbd1fdf8
> ds: 0018   es: 0018   ss: 0018
> Process mrtg (pid: 14284, stackpage=cbd1f000)
> Stack: c022e31b 0000015d 00000000 c13d8294 00000000 00000000 c13d8294
00000000
>        c012f03e 00000000 0000101f 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000001 cbd1e000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012f03e>] page_launder [kernel] 0x8ee
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125d08>] do_no_page [kernel] 0x78
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0126c10>] unmap_fixup [kernel] 0x120
> [<c01209f7>] do_sigaction [kernel] 0xb7
> [<c0120db3>] sys_rt_sigaction [kernel] 0x93
> [<c011a956>] sys_wait4 [kernel] 0x396
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007d985
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: cf7ffdf8
> ds: 0018   es: 0018   ss: 0018
> Process rateup (pid: 14813, stackpage=cf7ff000)
> Stack: c022e31b 0000015d 00000000 c1093934 00000000 00000000 c1010d24
00000000
>        c012f03e 00000000 0000232a 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000001 cf7fe000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012f03e>] page_launder [kernel] 0x8ee
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0140dc1>] open_namei [kernel] 0x461
> [<c0126d14>] do_munmap [kernel] 0x64
> [<c0127014>] do_brk [kernel] 0xb4
> [<c0126149>] sys_brk [kernel] 0xa9
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007df88
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: ce5a1df8
> ds: 0018   es: 0018   ss: 0018
> Process mrtg (pid: 15035, stackpage=ce5a1000)
> Stack: c022e31b 0000015d 00000001 c101a9dc 00000000 00000007 c012eba4
c012e969
>        c02b29c0 00000000 00000f13 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000000 ce5a0000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012eba4>] page_launder [kernel] 0x454
> [<c012e969>] page_launder [kernel] 0x219
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125d08>] do_no_page [kernel] 0x78
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0126c10>] unmap_fixup [kernel] 0x120
> [<c01209f7>] do_sigaction [kernel] 0xb7
> [<c0120db3>] sys_rt_sigaction [kernel] 0x93
> [<c011a956>] sys_wait4 [kernel] 0x396
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007e5f1
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: c5a5ddf8
> ds: 0018   es: 0018   ss: 0018
> Process rateup (pid: 15548, stackpage=c5a5d000)
> Stack: c022e31b 0000015d c102ee30 00000082 00000000 00000000 c102ee30
00000000
>        c012f03e 00000000 00001f2c 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000001 c5a5c000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012f03e>] page_launder [kernel] 0x8ee
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0140dc1>] open_namei [kernel] 0x461
> [<c0126d14>] do_munmap [kernel] 0x64
> [<c0127014>] do_brk [kernel] 0xb4
> [<c0126149>] sys_brk [kernel] 0xa9
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007ebf4
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: c21efdf8
> ds: 0018   es: 0018   ss: 0018
> Process mrtg (pid: 15785, stackpage=c21ef000)
> Stack: c022e31b 0000015d 00000000 c12df5ec 00000000 00000000 c12df5ec
00000000
>        c012f03e 00000000 000012fd 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000001 c21ee000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012f03e>] page_launder [kernel] 0x8ee
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125d08>] do_no_page [kernel] 0x78
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0126c10>] unmap_fixup [kernel] 0x120
> [<c01209f7>] do_sigaction [kernel] 0xb7
> [<c0120db3>] sys_rt_sigaction [kernel] 0x93
> [<c011a956>] sys_wait4 [kernel] 0x396
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>  ------------[ cut here ]------------
> kernel BUG at dcache.c:349!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0147a0c>]    Not tainted
> EFLAGS: 00010282
> EIP is at prune_dcache [kernel] 0x7c
> eax: 0000001c   ebx: c82c2b78   ecx: 00000001   edx: 0007f230
> esi: c82c2b60   edi: 00000000   ebp: 00000000   esp: ceb03df8
> ds: 0018   es: 0018   ss: 0018
> Process rateup (pid: 16295, stackpage=ceb03000)
> Stack: c022e31b 0000015d 00000000 c10c16dc 00000000 00000000 c101ab30
00000000
>        c012f03e 00000000 00001e10 000000d2 00000000 000000d2 c0147de1
00000000
>        c012f41b 00000000 000000d2 000000d2 00000001 ceb02000 00000001
c012f598
> Call Trace: [<c022e31b>] .rodata.str1.1 [kernel] 0x2816
> [<c012f03e>] page_launder [kernel] 0x8ee
> [<c0147de1>] shrink_dcache_memory [kernel] 0x21
> [<c012f41b>] do_try_to_free_pages [kernel] 0x1b
> [<c012f598>] try_to_free_pages [kernel] 0x28
> [<c01301ee>] _wrapped_alloc_pages [kernel] 0x1be
> [<c013029f>] __alloc_pages [kernel] 0xf
> [<c0125632>] do_wp_page [kernel] 0x172
> [<c0125e3e>] handle_mm_fault [kernel] 0x9e
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c01145fa>] do_page_fault [kernel] 0x17a
> [<c0140dc1>] open_namei [kernel] 0x461
> [<c0126d14>] do_munmap [kernel] 0x64
> [<c0127014>] do_brk [kernel] 0xb4
> [<c0126149>] sys_brk [kernel] 0xa9
> [<c0114480>] do_page_fault [kernel] 0x0
> [<c0107038>] error_code [kernel] 0x38
>
>
> Code: 0f 0b 5f 58 8d 56 10 8b 4a 04 8b 46 10 89 48 04 89 01 89 56
>

