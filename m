Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264618AbTFELlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264620AbTFELll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:41:41 -0400
Received: from adsl-66-72-183-162.dsl.sfldmi.ameritech.net ([66.72.183.162]:11904
	"EHLO kaeding.homelinux.net") by vger.kernel.org with ESMTP
	id S264618AbTFELli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:41:38 -0400
Date: Thu, 5 Jun 2003 07:55:08 -0400 (EDT)
From: Thomas Kaeding <kaeding@kaeding.homelinux.org>
X-X-Sender: kaeding@kaeding.localdomain
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:102
Message-ID: <Pine.LNX.4.44.0306050752400.759-100000@kaeding.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My linux box froze up today.  My kernel is 2.4.20 with Mandrake's
supermount patch.  Attached is a snippet from sys.log.  Please
email me to let me know if this is a known bug, where the fix is,
or if anyone is working on it.  Thanks!

Thomas

Jun  4 22:28:02 kaeding kernel: NVRM: AGPGART: freed 128 pages
Jun  4 22:28:02 kaeding kernel: NVRM: AGPGART: freed 257 pages
Jun  4 22:28:04 kaeding kernel: NVRM: AGPGART: freed 16 pages
Jun  4 22:28:04 kaeding kernel: NVRM: AGPGART: backend released
Jun  4 22:28:22 kaeding sudo:  kaeding : TTY=tty1 ; PWD=/home/kaeding ;
USER=root ; COMMAND=/usr/bin/fam
Jun  4 22:37:32 kaeding kernel: kernel BUG at page_alloc.c:102!
Jun  4 22:37:32 kaeding kernel: invalid operand: 0000
Jun  4 22:37:32 kaeding kernel: CPU:    0
Jun  4 22:37:32 kaeding kernel: EIP:    0010:[__free_pages_ok+68/652]
Tainted: P
Jun  4 22:37:32 kaeding kernel: EFLAGS: 00010282
Jun  4 22:37:32 kaeding kernel: eax: c119fd80   ebx: c12b8fb4   ecx:
c12b8fd0   edx: c02d421c
Jun  4 22:37:32 kaeding kernel: esi: 00000000   edi: 00000008   ebp:
000001f4   esp: c12eff14
Jun  4 22:37:32 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 22:37:32 kaeding kernel: Process kswapd (pid: 4,
stackpage=c12ef000)
Jun  4 22:37:32 kaeding kernel: Stack: cd1166c0 c12b8fb4 00000008 000001f4
c013372c c12b8fb4 000001d0 00000008
Jun  4 22:37:32 kaeding kernel:        000001f4 c0131c8c cd1166c0 c12b8fb4
c01299f2 c012aa03 c0129a2b 00000020
Jun  4 22:37:32 kaeding kernel:        000001d0 00000020 00000006 00000006
c12ee000 00001f63 000001d0 c02d43b4
Jun  4 22:37:32 kaeding kernel: Call Trace:
[try_to_free_buffers+144/228] [try_to_release_page+68/72]
[shrink_cache+490/764] [__free_pages+27/28] [shrink_cache+547/764]
Jun  4 22:37:32 kaeding kernel:   [shrink_caches+88/136]
[try_to_free_pages_zone+60/92] [kswapd_balance_pgdat+65/140]
[kswapd_balance+26/48] [kswapd+153/188] [kernel_thread+40/56]
Jun  4 22:37:32 kaeding kernel:
Jun  4 22:37:32 kaeding kernel: Code: 0f 0b 66 00 53 02 28 c0 89 d8 2b 05
90 f0 33 c0 69 c0 a3 8b
Jun  4 22:37:33 kaeding kernel:  kernel BUG at page_alloc.c:102!
Jun  4 22:37:33 kaeding kernel: invalid operand: 0000
Jun  4 22:37:33 kaeding kernel: CPU:    0
Jun  4 22:37:33 kaeding kernel: EIP:    0010:[__free_pages_ok+68/652]
Tainted: P
Jun  4 22:37:33 kaeding kernel: EFLAGS: 00010282
Jun  4 22:37:33 kaeding kernel: eax: c1272ed8   ebx: c1148c00   ecx:
c1148c1c   edx: c02d421c
Jun  4 22:37:33 kaeding kernel: esi: 00000000   edi: 00000020   ebp:
00000200   esp: c5f51e10
Jun  4 22:37:33 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 22:37:33 kaeding kernel: Process gtk-gnutella (pid: 28819,
stackpage=c5f51000)
Jun  4 22:37:33 kaeding kernel: Stack: cd116780 c1148c00 00000020 00000200
c013372c c1148c00 000001d2 00000020
Jun  4 22:37:33 kaeding kernel:        00000200 c0131c8c cd116780 c1148c00
c01299f2 c012aa03 c0129a2b 00000020
Jun  4 22:37:33 kaeding kernel:        000001d2 00000020 00000006 00000006
c5f50000 00001fde 000001d2 c02d43b4
Jun  4 22:37:33 kaeding kernel: Call Trace:
[try_to_free_buffers+144/228] [try_to_release_page+68/72]
[shrink_cache+490/764] [__free_pages+27/28] [shrink_cache+547/764]
Jun  4 22:37:33 kaeding kernel:   [shrink_caches+88/136]
[try_to_free_pages_zone+60/92] [balance_classzone+80/456]
[__alloc_pages+274/352] [ext3_get_block+0/100] [_alloc_pages+22/24]
Jun  4 22:37:33 kaeding kernel:   [page_cache_read+110/188]
[generic_file_readahead+261/316] [do_generic_file_read+422/1028]
[generic_file_read+124/272] [file_read_actor+0/140] [sys_read+143/232]
Jun  4 22:37:33 kaeding kernel:   [system_call+51/56]
Jun  4 22:37:33 kaeding kernel:
Jun  4 22:37:33 kaeding kernel: Code: 0f 0b 66 00 53 02 28 c0 89 d8 2b 05
90 f0 33 c0 69 c0 a3 8b
Jun  4 22:43:56 kaeding kernel:  kernel BUG at page_alloc.c:102!
Jun  4 22:43:56 kaeding kernel: invalid operand: 0000
Jun  4 22:43:56 kaeding kernel: CPU:    0
Jun  4 22:43:56 kaeding kernel: EIP:    0010:[__free_pages_ok+68/652]
Tainted: P
Jun  4 22:43:56 kaeding kernel: EFLAGS: 00010282
Jun  4 22:43:56 kaeding kernel: eax: c11b115c   ebx: c1130974   ecx:
c1130990   edx: c02d421c
Jun  4 22:43:56 kaeding kernel: esi: 00000000   edi: 00000020   ebp:
00000200   esp: cfec5e10
Jun  4 22:43:56 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 22:43:56 kaeding kernel: Process streamcast.pl (pid: 14515,
stackpage=cfec5000)
Jun  4 22:43:56 kaeding kernel: Stack: cd1167e0 c1130974 00000020 00000200
c013372c c1130974 000001d2 00000020
Jun  4 22:43:56 kaeding kernel:        00000200 c0131c8c cd1167e0 c1130974
c01299f2 c012aa03 c0129a2b 00000020
Jun  4 22:43:56 kaeding kernel:        000001d2 00000020 00000006 00000006
cfec4000 00001fd5 000001d2 c02d43b4
Jun  4 22:43:56 kaeding kernel: Call Trace:
[try_to_free_buffers+144/228] [try_to_release_page+68/72]
[shrink_cache+490/764] [__free_pages+27/28] [shrink_cache+547/764]
Jun  4 22:43:56 kaeding kernel:   [shrink_caches+88/136]
[try_to_free_pages_zone+60/92] [balance_classzone+80/456]
[__alloc_pages+274/352] [ext3_get_block+0/100] [_alloc_pages+22/24]
Jun  4 22:43:56 kaeding kernel:   [page_cache_read+110/188]
[generic_file_readahead+261/316] [do_generic_file_read+422/1028]
[generic_file_read+124/272] [file_read_actor+0/140] [sys_read+143/232]
Jun  4 22:43:56 kaeding kernel:   [system_call+51/56]
Jun  4 22:43:56 kaeding kernel:
Jun  4 22:43:56 kaeding kernel: Code: 0f 0b 66 00 53 02 28 c0 89 d8 2b 05
90 f0 33 c0 69 c0 a3 8b
Jun  5 07:41:48 kaeding syslogd 1.4.1: restart.

-----------------end


