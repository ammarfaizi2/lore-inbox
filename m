Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSFZLFA>; Wed, 26 Jun 2002 07:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSFZLE7>; Wed, 26 Jun 2002 07:04:59 -0400
Received: from happy.kiev.ua ([193.109.241.145]:3339 "EHLO happy.kiev.ua")
	by vger.kernel.org with ESMTP id <S316512AbSFZLE7>;
	Wed, 26 Jun 2002 07:04:59 -0400
Date: Wed, 26 Jun 2002 14:02:30 +0300
From: Pavel Gulchouck <gul@gul.kiev.ua>
To: linux-kernel@vger.kernel.org
Subject: kernel crash
Message-ID: <20020626110230.GA21100@happy.kiev.ua>
Reply-To: gul@gul.kiev.ua
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux
X-FTN-Address: 2:463/68
X-Flames-To: /dev/null
X-GC: GCC d- s+: a31 C+++ UL++++ UB P+ L++ E--- W++ N++ o-- K- w--- O++
X-GC: M? V- PS PE+ Y+ PGP+ t? 5? X? R? !tv b+ DI? D? G e h--- r+++ y+++
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

RedHat 7.3, kernel 2.4.18-4, ext3, swap to partition, no SMP.

Any suggestions?
Should I change aufs to ufs in squid, or it's not related to this crash?

Jun 20 04:33:30 gate kernel: ------------[ cut here ]------------
Jun 20 04:33:30 gate kernel: kernel BUG at inode.c:1066!
Jun 20 04:33:30 gate kernel: invalid operand: 0000
Jun 20 04:33:30 gate kernel: ip_nat_ftp ipt_REJECT ipt_REDIRECT cls_u32 sch_tbf sch_cbq autofs smbfs ne2k-p
Jun 20 04:33:30 gate kernel: CPU:    0
Jun 20 04:33:31 gate kernel: EIP:    0010:[iput+47/496]    Tainted: P 
Jun 20 04:33:31 gate kernel: EIP:    0010:[<c0148cdb>]    Tainted: P 
Jun 20 04:33:31 gate kernel: EFLAGS: 00010286
Jun 20 04:33:31 gate kernel: 
Jun 20 04:33:31 gate kernel: EIP is at iput [kernel] 0x2f (2.4.18-4)
Jun 20 04:33:31 gate kernel: eax: 0000001c   ebx: c5d12810   ecx: 00000001   edx: 0020c5f3
Jun 20 04:33:31 gate kernel: esi: c74fd400   edi: 00000000   ebp: 0000004b   esp: c11c1f50
Jun 20 04:33:31 gate kernel: ds: 0018   es: 0018   ss: 0018
Jun 20 04:33:31 gate kernel: Process kswapd (pid: 4, stackpage=c11c1000)
Jun 20 04:33:31 gate kernel: Stack: c022bbab 0000042a c009dd78 c009dd60 c5d12810 c0146c66 c5d12810 c11c0000 
Jun 20 04:33:31 gate kernel:        c012e148 00000000 00000000 ffffffff c02cad78 00000000 000000e8 0000003a 
Jun 20 04:33:31 gate kernel:        000001d0 000000e8 00000000 66666667 c0146f84 0000025c c012eb96 00000006 
Jun 20 04:33:31 gate kernel: Call Trace: [prune_dcache+262/372] prune_dcache [kernel] 0x106 
Jun 20 04:33:31 gate kernel: Call Trace: [<c0146c66>] prune_dcache [kernel] 0x106 
Jun 20 04:33:31 gate kernel: [page_launder_zone+1344/1648] page_launder_zone [kernel] 0x540 
Jun 20 04:33:31 gate kernel: [<c012e148>] page_launder_zone [kernel] 0x540 
Jun 20 04:33:31 gate kernel: [shrink_dcache_memory+32/48] shrink_dcache_memory [kernel] 0x20 
Jun 20 04:33:31 gate kernel: [<c0146f84>] shrink_dcache_memory [kernel] 0x20 
Jun 20 04:33:31 gate kernel: [do_try_to_free_pages+26/376] do_try_to_free_pages [kernel] 0x1a 
Jun 20 04:33:31 gate kernel: [<c012eb96>] do_try_to_free_pages [kernel] 0x1a 
Jun 20 04:33:31 gate kernel: [kswapd+248/680] kswapd [kernel] 0xf8 
Jun 20 04:33:31 gate kernel: [<c012ee64>] kswapd [kernel] 0xf8 
Jun 20 04:33:31 gate kernel: [_stext+0/28] stext [kernel] 0x0 
Jun 20 04:33:31 gate kernel: [<c0105000>] stext [kernel] 0x0 
Jun 20 04:33:31 gate kernel: [kernel_thread+38/48] kernel_thread [kernel] 0x26
Jun 20 04:33:31 gate kernel: [<c0106e7a>] kernel_thread [kernel] 0x26 
Jun 20 04:33:31 gate kernel: [kswapd+0/680] kswapd [kernel] 0x0 
Jun 20 04:33:31 gate kernel: [<c012ed6c>] kswapd [kernel] 0x0 
Jun 20 04:33:31 gate kernel: 
Jun 20 04:33:31 gate kernel: 
Jun 20 04:33:32 gate kernel: Code: 0f 0b 59 58 85 f6 74 09 8b 46 20 85 c0 74 02 89 c7 85 ff 74 

-- 
                                Lucky carrier,
                                                  Pavel.
