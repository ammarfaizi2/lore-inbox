Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbTFFCon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 22:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbTFFCon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 22:44:43 -0400
Received: from [203.78.64.148] ([203.78.64.148]:14641 "EHLO smtpo01.icare.priv")
	by vger.kernel.org with ESMTP id S265287AbTFFCol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 22:44:41 -0400
Message-ID: <3EE0031E.2080206@carfield.com.hk>
Date: Fri, 06 Jun 2003 10:57:34 +0800
From: Carfield Yim <carfield@carfield.com.hk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b; MultiZilla v1.1.31) Gecko/20030314
X-Accept-Language: zh-hk
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:102!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2003 02:56:08.0583 (UTC) FILETIME=[2DFA0970:01C32BD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I get the following message at 2.4.20 #2 Sun May 11 23:32:46 GST
2003 i686 unknown unknown GNU/Linux

Jun  4 04:04:12 desktop kernel: kernel BUG at page_alloc.c:102!
Jun  4 04:04:12 desktop kernel: invalid operand: 0000
Jun  4 04:04:12 desktop kernel: CPU:    0
Jun  4 04:04:12 desktop kernel: EIP:    0010:[__free_pages_ok+69/672]
 Tainted: P
Jun  4 04:04:12 desktop kernel: EIP:    0010:[<c0132665>]    Tainted: P
Jun  4 04:04:12 desktop kernel: EFLAGS: 00010286
Jun  4 04:04:12 desktop kernel: eax: c148ea88   ebx: c16dbb88   ecx:
ef38f0e4   edx: c0293d98
Jun  4 04:04:12 desktop kernel: esi: 00000000   edi: 00000000   ebp:
00000000   esp: effe3f0c
Jun  4 04:04:12 desktop kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 04:04:12 desktop kernel: Process kswapd (pid: 4, stackpage=effe3000)
Jun  4 04:04:12 desktop kernel: Stack: 00000282 00000003 c6baa6c0
c6baa6c0 c6baa6c0 c16dbb88 c013d96b c6baa6c0
Jun  4 04:04:12 desktop kernel:        ef38f0e4 c16dbb88 000037eb
c0293f10 c0131a99 c16dbb88 000001d0 effe2000
Jun  4 04:04:12 desktop kernel:        000001f8 000001d0 0000000f
00000020 000001d0 00000020 00000006 c0131c73
Jun  4 04:04:12 desktop kernel: Call Trace:
[try_to_free_buffers+139/240] [shrink_cache+649/784]
[shrink_caches+99/160] [try_to_free_pages_zone+54/80]
[kswapd_balance_pgdat+92/176]
Jun  4 04:04:12 desktop kernel: Call Trace:    [<c013d96b>] [<c0131a99>]
[<c0131c73>] [<c0131ce6>] [<c0131dfc>]
Jun  4 04:04:12 desktop kernel:   [kswapd_balance+40/64]
[kswapd+157/192] [_stext+0/64] [kernel_thread+46/64] [kswapd+0/192]
Jun  4 04:04:12 desktop kernel:   [<c0131e78>] [<c0131fad>] [<c0105000>]
[<c01057ce>] [<c0131f10>]
Jun  4 04:04:12 desktop kernel:
Jun  4 04:04:12 desktop kernel: Code: 0f 0b 66 00 45 64 26 c0 8b 15 d0
a1 2f c0 89 d8 29 d0 c1 f8
Jun  4 04:04:12 desktop kernel:  kernel BUG at page_alloc.c:102!
Jun  4 04:04:12 desktop kernel: invalid operand: 0000
Jun  4 04:04:12 desktop kernel: CPU:    0
Jun  4 04:04:12 desktop kernel: EIP:    0010:[__free_pages_ok+69/672]
 Tainted: P
Jun  4 04:04:12 desktop kernel: EIP:    0010:[<c0132665>]    Tainted: P
Jun  4 04:04:12 desktop kernel: EFLAGS: 00010286
Jun  4 04:04:12 desktop kernel: eax: c17c1e10   ebx: c14fe904   ecx:
ef38f0e4   edx: c0293d98
Jun  4 04:04:12 desktop kernel: esi: 00000000   edi: 00000000   ebp:
00000000   esp: dd0e7df4
Jun  4 04:04:12 desktop kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 04:04:12 desktop kernel: Process rpmv (pid: 17429,
stackpage=dd0e7000)
Jun  4 04:04:12 desktop kernel: Stack: 00000282 00000003 dd10dae0
dd10dae0 dd10dae0 c14fe904 c013d96b dd10dae0
Jun  4 04:04:12 desktop kernel:        ef38f0e4 c14fe904 0000385d
c0293f10 c0131a99 c14fe904 000001d2 dd0e6000
Jun  4 04:04:12 desktop kernel:        00000200 000001d2 0000001f
00000020 000001d2 00000020 00000006 c0131c73
Jun  4 04:04:12 desktop kernel: Call Trace:
[try_to_free_buffers+139/240] [shrink_cache+649/784]
[shrink_caches+99/160] [try_to_free_pages_zone+54/80]
[balance_classzone+87/496]
Jun  4 04:04:12 desktop kernel: Call Trace:    [<c013d96b>] [<c0131a99>]
[<c0131c73>] [<c0131ce6>] [<c0132b87>]
Jun  4 04:04:12 desktop kernel:   [__alloc_pages+243/400]
[page_cache_read+109/208] [reiserfs_get_block+0/4384]
[generic_file_readahead+201/352]
[do_generic_file_read+812/1104] [file_read_actor+0/160]
Jun  4 04:04:12 desktop kernel:   [<c0132e13>] [<c012b09d>] [<c01746a0>]
[<c012b709>] [<c012bafc>] [<c012bec0>]
Jun  4 04:04:12 desktop kernel:   [generic_file_read+168/336]
[file_read_actor+0/160] [sys_read+163/320] [system_call+51/56]
Jun  4 04:04:12 desktop kernel:   [<c012c008>] [<c012bec0>] [<c0139333>]
[<c010745f>]
Jun  4 04:04:12 desktop kernel:
Jun  4 04:04:12 desktop kernel: Code: 0f 0b 66 00 45 64 26 c0 8b 15 d0
a1 2f c0 89 d8 29 d0 c1 f8
Jun  4 04:04:12 desktop :

It force me to reboot and nothing else, only happen one since compilation.

