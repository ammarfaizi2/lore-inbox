Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRKSLbV>; Mon, 19 Nov 2001 06:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278085AbRKSLbM>; Mon, 19 Nov 2001 06:31:12 -0500
Received: from ids.big.univali.br ([200.169.51.11]:25984 "HELO
	mail.big.univali.br") by vger.kernel.org with SMTP
	id <S278081AbRKSLbC>; Mon, 19 Nov 2001 06:31:02 -0500
Message-Id: <5.1.0.14.1.20011119091745.00a99b90@mail.big.univali.br>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 19 Nov 2001 09:31:00 -0200
To: linux-kernel@vger.kernel.org
From: Marcus Grando <marcus@big.univali.br>
Subject: remove_free_dquot: dquot not on the free list?? 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hello,

        This problem occours in 2.4.15-pre5.

        Some ideas to solve this problem?

Tanks in advance

Marcus Grando

------log-------
Nov 18 16:08:54 ids kernel: remove_free_dquot: dquot not on the free list?? 
Nov 18 16:08:54 ids last message repeated 32 times
Nov 18 16:08:55 ids kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004 
Nov 18 16:08:55 ids kernel:  printing eip: 
Nov 18 16:08:55 ids kernel: c0146bab 
Nov 18 16:08:55 ids kernel: *pde = 00000000 
Nov 18 16:08:55 ids kernel: Oops: 0002 
Nov 18 16:08:55 ids kernel: CPU:    0 
Nov 18 16:08:55 ids kernel: EIP:    0010:[dqput+159/196]    Not tainted 
Nov 18 16:08:55 ids kernel: EFLAGS: 00010246 
Nov 18 16:08:55 ids kernel: eax: ca859eb0   ebx: cfdf2860   ecx: cfdf2870   edx: 00000000 
Nov 18 16:08:55 ids kernel: esi: d5dc56e4   edi: c1956000   ebp: c1957f58   esp: c1957f04 
Nov 18 16:08:55 ids kernel: ds: 0018   es: 0018   ss: 0018 
Nov 18 16:08:55 ids kernel: Process kswapd (pid: 5, stackpage=c1957000) 
Nov 18 16:08:55 ids kernel: Stack: 00000000 c014798b cfdf2860 c1956000 d5dc5600 c01429e8 d5dc5600 d5dc5600  
Nov 18 16:08:55 ids kernel:        c1957f58 c0260364 c0142a9f d5dc5600 dcb68268 dcb68260 c0142ce7 c1957f58  
Nov 18 16:08:55 ids kernel:        0000001f 000001d0 00000020 00000006 0000006c cf3fa7e8 d0f18688 c0142d23  
Nov 18 16:08:56 ids kernel: Call Trace: [dquot_drop+47/64] [clear_inode+124/248] [dispose_list+59/84] [prune_icache+191/224] [shrink_icache_memory+27/48]  
Nov 18 16:08:56 ids kernel:    [shrink_caches+120/152] [try_to_free_pages+32/64] [kswapd_balance_pgdat+87/176] [kswapd_balance+22/44] [kswapd+163/204] [_stext+0/68]  
Nov 18 16:08:56 ids kernel:    [kernel_thread+35/48]  
Nov 18 16:08:56 ids kernel:  
Nov 18 16:08:56 ids kernel: Code: 89 4a 04 89 53 10 89 41 04 89 08 ff 05 e4 01 2e c0 8d 43 24  
Nov 18 16:08:56 ids kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004 
Nov 18 16:08:56 ids kernel:  printing eip: 
Nov 18 16:08:56 ids kernel: c0146a6d 
Nov 18 16:08:56 ids kernel: *pde = 00000000 
Nov 18 16:08:56 ids kernel: Oops: 0002 
Nov 18 16:08:56 ids kernel: CPU:    1 
Nov 18 16:08:56 ids kernel: EIP:    0010:[prune_dqcache+33/140]    Not tainted 
Nov 18 16:08:56 ids kernel: EFLAGS: 00010206 
Nov 18 16:08:56 ids kernel: eax: 00000000   ebx: ca859ea0   ecx: ca859eb0   edx: 00000007 
Nov 18 16:08:56 ids kernel: esi: 0000000c   edi: 00000020   ebp: 00000006   esp: c24c9de0 
Nov 18 16:08:56 ids kernel: ds: 0018   es: 0018   ss: 0018 
Nov 18 16:08:56 ids kernel: Process amavis (pid: 11265, stackpage=c24c9000) 
Nov 18 16:08:56 ids kernel: Stack: 0000001f 000001d2 c0146af7 0000000c 00000007 c0129164 00000006 000001d2  
Nov 18 16:08:56 ids kernel:        00000006 000001d2 00000006 000001d2 00000006 000001d2 c025f6a8 000001d2  
Nov 18 16:08:56 ids kernel:        000168d6 c025f6a8 c012919c 00000020 00000000 00000000 c24c8000 c0129a50  
Nov 18 16:08:56 ids kernel: Call Trace: [shrink_dqcache_memory+31/52] [shrink_caches+128/152] [try_to_free_pages+32/64] [balance_classzone+104/388] [__alloc_pages+323/436]  
Nov 18 16:08:56 ids kernel:    [_alloc_pages+24/28] [do_anonymous_page+52/160] [do_no_page+51/300] [handle_mm_fault+92/188] [do_page_fault+375/1232] [do_page_fault+0/1232]  
Nov 18 16:08:56 ids kernel:    [timer_bh+56/688] [tqueue_bh+22/28] [bh_action+76/140] [tasklet_hi_action+97/144] [do_softirq+131/224] [do_IRQ+213/228]  
Nov 18 16:08:56 ids kernel:    [error_code+52/60]  
Nov 18 16:08:56 ids kernel:  
Nov 18 16:08:56 ids kernel: Code: 89 50 04 89 02 89 59 f0 89 59 f4 8b 53 10 39 ca 75 11 68 c0  
Nov 18 16:08:56 ids kernel:  <1>Unable to handle kernel paging request at virtual address 1cac0095 
Nov 18 16:08:56 ids kernel:  printing eip: 
Nov 18 16:08:56 ids kernel: c0146d3c 
Nov 18 16:08:56 ids kernel: *pde = 00000000 
Nov 18 16:08:57 ids kernel: Oops: 0000 
Nov 18 16:08:57 ids kernel: CPU:    0 
Nov 18 16:08:57 ids kernel: EIP:    0010:[dqget+212/576]    Not tainted 
Nov 18 16:08:57 ids kernel: EFLAGS: 00010203 
Nov 18 16:08:57 ids kernel: eax: 00000000   ebx: c02e02b8   ecx: 00000806   edx: 1cac0059 
Nov 18 16:08:57 ids kernel: esi: 00000000   edi: 00000000   ebp: df996c00   esp: c24c9ed4 
Nov 18 16:08:57 ids kernel: ds: 0018   es: 0018   ss: 0018 
Nov 18 16:08:57 ids kernel: Process bounce (pid: 11266, stackpage=c24c9000) 
Nov 18 16:08:57 ids kernel: Stack: 00000000 00000000 d46682c0 00000000 1cac0059 00000002 df16faa0 df6842c0  
Nov 18 16:08:57 ids kernel:        c0140c69 df996c84 0000100c 00000000 00000017 c01478a0 df996c00 00000000  
Nov 18 16:08:57 ids kernel:        00000000 00000000 00000000 d46682c0 c24c9f8c c24c9f30 ffff0006 00000000  
Nov 18 16:08:57 ids kernel: Call Trace: [dput+25/324] [dquot_initialize+168/356] [open_namei+1421/1736] [filp_open+59/92] [sys_open+54/208]  
Nov 18 16:08:57 ids kernel:    [system_call+51/56]  
Nov 18 16:08:57 ids kernel:  
Nov 18 16:08:57 ids kernel: Code: 66 39 4a 3c 75 0f 8b 44 24 3c 39 42 38 75 06 66 39 7a 3e 74  
Nov 18 16:08:57 ids kernel:  <1>Unable to handle kernel paging request at virtual address 1cac0095 
Nov 18 16:08:57 ids kernel:  printing eip: 
Nov 18 16:08:57 ids kernel: c0146d3c 
Nov 18 16:08:57 ids kernel: *pde = 00000000 
Nov 18 16:08:57 ids kernel: Oops: 0000 
Nov 18 16:08:57 ids kernel: CPU:    0 
Nov 18 16:08:57 ids kernel: EIP:    0010:[dqget+212/576]    Not tainted 
Nov 18 16:08:57 ids kernel: EFLAGS: 00010203 
Nov 18 16:08:57 ids kernel: eax: 00000000   ebx: c02e02b8   ecx: 00000806   edx: 1cac0059 
Nov 18 16:08:57 ids kernel: esi: 00000000   edi: 00000000   ebp: df996c00   esp: cf487ed4 
Nov 18 16:08:57 ids kernel: ds: 0018   es: 0018   ss: 0018 
Nov 18 16:08:57 ids kernel: Process bounce (pid: 11267, stackpage=cf487000) 
Nov 18 16:08:57 ids kernel: Stack: 00000000 00000000 d4668680 00000000 1cac0059 00000002 df16faa0 c43ffec0  
Nov 18 16:08:57 ids kernel:        c0140c69 df996c84 0000100c 00000000 00000017 c01478a0 df996c00 00000000  
Nov 18 16:08:57 ids kernel:        00000000 00000000 00000000 d4668680 cf487f8c cf487f30 ffff0006 00000000  
Nov 18 16:08:57 ids kernel: Call Trace: [dput+25/324] [dquot_initialize+168/356] [open_namei+1421/1736] [filp_open+59/92] [sys_open+54/208]  
Nov 18 16:08:57 ids kernel:    [system_call+51/56]  
Nov 18 16:08:57 ids kernel:  
Nov 18 16:08:57 ids kernel: Code: 66 39 4a 3c 75 0f 8b 44 24 3c 39 42 38 75 06 66 39 7a 3e 74  
Nov 18 16:08:57 ids kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004 
Nov 18 16:08:57 ids kernel:  printing eip: 
Nov 18 16:08:57 ids kernel: c0146bab 
Nov 18 16:08:57 ids kernel: *pde = 00000000 
Nov 18 16:08:57 ids kernel: Oops: 0002 
Nov 18 16:08:57 ids kernel: CPU:    1 
Nov 18 16:08:58 ids kernel: EIP:    0010:[dqput+159/196]    Not tainted 
Nov 18 16:08:58 ids kernel: EFLAGS: 00010246 
Nov 18 16:08:58 ids kernel: eax: ca859eb0   ebx: cc507340   ecx: cc507350   edx: 00000000 
Nov 18 16:08:58 ids kernel: esi: defa1924   edi: defa1840   ebp: cf486000   esp: cf487f04 
Nov 18 16:08:58 ids kernel: ds: 0018   es: 0018   ss: 0018 
Nov 18 16:08:58 ids kernel: Process rm (pid: 11268, stackpage=cf487000) 
Nov 18 16:08:58 ids kernel: Stack: 00000000 c014798b cc507340 cf486000 df996c00 c0154b0b defa1840 defa1840  
Nov 18 16:08:58 ids kernel:        cf486000 cf486000 c01553e0 df996c00 0007186b 00000000 d1069bc0 c015546a  
Nov 18 16:08:58 ids kernel:        c0155490 defa1840 defa1840 cf486000 ffffffff c014343c defa1840 d37cdb60  
Nov 18 16:08:58 ids kernel: Call Trace: [dquot_drop+47/64] [ext2_free_inode+191/540] [ext2_delete_inode+0/252] [ext2_delete_inode+138/252] [ext2_delete_inode+176/252]  
Nov 18 16:08:58 ids kernel:    [iput+336/532] [dput+230/324] [sys_rmdir+200/260] [system_call+51/56]  
Nov 18 16:08:58 ids kernel:  
Nov 18 16:08:58 ids kernel: Code: 89 4a 04 89 53 10 89 41 04 89 08 ff 05 e4 01 2e c0 8d 43 24  
Nov 18 16:09:01 ids kernel:  <1>Unable to handle kernel paging request at virtual address 1cac0095 
Nov 18 16:09:01 ids kernel:  printing eip: 
Nov 18 16:09:01 ids kernel: c0146d3c 
Nov 18 16:09:01 ids kernel: *pde = 00000000 
Nov 18 16:09:01 ids kernel: Oops: 0000 
Nov 18 16:09:01 ids kernel: CPU:    0 
Nov 18 16:09:01 ids kernel: EIP:    0010:[dqget+212/576]    Not tainted 
Nov 18 16:09:01 ids kernel: EFLAGS: 00010203 
Nov 18 16:09:01 ids kernel: eax: cfdf2760   ebx: c02e02b8   ecx: 00000811   edx: 1cac0059 
Nov 18 16:09:01 ids kernel: esi: 00000000   edi: 00000000   ebp: c1916800   esp: d5ea3ed4 
Nov 18 16:09:01 ids kernel: ds: 0018   es: 0018   ss: 0018 
Nov 18 16:09:01 ids kernel: Process python (pid: 11270, stackpage=d5ea3000) 
Nov 18 16:09:01 ids kernel: Stack: 00000000 00000000 c028fdc0 00000096 1cac0059 00000002 d3c068a0 dcb5fbe0  
Nov 18 16:09:01 ids kernel:        d3c068a0 c1916884 0000110e 00000000 00000017 c01478a0 c1916800 00000096  
Nov 18 16:09:01 ids kernel:        00000000 00000000 00000000 c028fdc0 d5ea3f8c d5ea3f30 ffff0006 00000000  
Nov 18 16:09:01 ids kernel: Call Trace: [dquot_initialize+168/356] [open_namei+1421/1736] [filp_open+59/92] [sys_open+54/208] [system_call+51/56]  
Nov 18 16:09:01 ids kernel:  
Nov 18 16:09:01 ids kernel: Code: 66 39 4a 3c 75 0f 8b 44 24 3c 39 42 38 75 06 66 39 7a 3e 74  
Nov 18 16:09:05 ids kernel:  <1>Unable to handle kernel paging request at virtual address 1cac0095 
Nov 18 16:09:05 ids kernel:  printing eip: 
Nov 18 16:09:05 ids kernel: c0146d3c 
Nov 18 16:09:05 ids kernel: *pde = 00000000 
Nov 18 16:09:05 ids kernel: Oops: 0000 
Nov 18 16:09:05 ids kernel: CPU:    1 
Nov 18 16:09:05 ids kernel: EIP:    0010:[dqget+212/576]    Not tainted 
Nov 18 16:09:05 ids kernel: EFLAGS: 00010203 
Nov 18 16:09:05 ids kernel: eax: 00000000   ebx: c02e02b8   ecx: 00000806   edx: 1cac0059 
Nov 18 16:09:05 ids kernel: esi: 00000000   edi: 00000000   ebp: df996c00   esp: d5e5be28 
Nov 18 16:09:05 ids kernel: ds: 0018   es: 0018   ss: 0018 
Nov 18 16:09:05 ids kernel: Process nmbd (pid: 11271, stackpage=d5e5b000) 
Nov 18 16:09:05 ids kernel: Stack: 00000000 00000000 c332a660 00000000 1cac0059 00000002 56555453 5a595857  
Nov 18 16:09:05 ids kernel:        00000000 df996c84 0000100c 00000000 00000017 c01478a0 df996c00 00000000  
Nov 18 16:09:05 ids kernel:        00000000 c01477f8 c026063c c01477f8 d5e5a000 d5e5be84 ffff6c00 00000000 

