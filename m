Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTI0Rm0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 13:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTI0Rm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 13:42:26 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:9366
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S262119AbTI0RmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 13:42:19 -0400
Message-ID: <3F75CBF8.6060609@tupshin.com>
Date: Sat, 27 Sep 2003 10:42:16 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6a) Gecko/20030924
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: 2.6.0-test5 NULL pointer apparently in xfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me know if more info would be helpful.

-Tupshin

Sep 27 07:03:33 bastard kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000005c
Sep 27 07:03:33 bastard kernel: c0282f8d
Sep 27 07:03:33 bastard kernel: *pde = 00000000
Sep 27 07:03:33 bastard kernel: Oops: 0002 [#1]
Sep 27 07:03:33 bastard kernel: CPU:    0
Sep 27 07:03:33 bastard kernel: EIP:    0060:[<c0282f8d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 27 07:03:33 bastard kernel: EFLAGS: 00010246
Sep 27 07:03:33 bastard kernel: eax: 00000000   ebx: 00000000   ecx: 
c05059bc   edx: 00000000
Sep 27 07:03:33 bastard kernel: esi: f7dfb378   edi: 00000000   ebp: 
00000000   esp: ef751784
Sep 27 07:03:33 bastard kernel: ds: 007b   es: 007b   ss: 0068
Sep 27 07:03:33 bastard kernel: Stack: f7dfb378 000008d0 00000000 
efba8400 00000000 efba8400 c0299455 efba8400
Sep 27 07:03:33 bastard kernel: 0000000f 00000000 0000e35a fffffff1 
ffffffff 00000010 00000000 00000000
Sep 27 07:03:33 bastard kernel: 0000e35a 00000000 00000000 00000000 
00000010 00000000 00000000 00000000
Sep 27 07:03:33 bastard kernel: Call Trace:
Sep 27 07:03:33 bastard kernel: [<c0299455>] 
xfs_iomap_write_allocate+0xc5/0x4d0
Sep 27 07:03:33 bastard kernel: [<c0284729>] 
xfs_trans_unlocked_item+0x39/0x60
Sep 27 07:03:33 bastard kernel: [<c029892c>] xfs_iomap+0x40c/0x550
Sep 27 07:03:33 bastard kernel: [<c0293c62>] map_blocks+0x72/0x130
Sep 27 07:03:33 bastard kernel: [<c0294d27>] page_state_convert+0x4c7/0x620
Sep 27 07:03:33 bastard kernel: [<c013beb5>] mempool_alloc+0x75/0x160
Sep 27 07:03:33 bastard kernel: [<c01577da>] 
__block_write_full_page+0x1ba/0x3d0
Sep 27 07:03:33 bastard kernel: [<c02fc19e>] as_update_arq+0x2e/0x80
Sep 27 07:03:33 bastard kernel: [<c029552c>] linvfs_writepage+0x5c/0x110
Sep 27 07:03:33 bastard kernel: [<c0142e79>] shrink_list+0x349/0x550
Sep 27 07:03:33 bastard kernel: [<c0141e88>] __pagevec_release+0x28/0x40
Sep 27 07:03:33 bastard kernel: [<c036659c>] __map_bio+0x3c/0x100
Sep 27 07:03:33 bastard kernel: [<c0143205>] shrink_cache+0x185/0x300
Sep 27 07:03:33 bastard kernel: [<c0324b03>] __ide_dma_count+0x13/0x20
Sep 27 07:03:33 bastard kernel: [<c014390c>] shrink_zone+0x7c/0xb0
Sep 27 07:03:33 bastard kernel: [<c01439ec>] shrink_caches+0xac/0xd0
Sep 27 07:03:33 bastard kernel: [<c0143ab2>] try_to_free_pages+0xa2/0x160
Sep 27 07:03:33 bastard kernel: [<c013d2f1>] __alloc_pages+0x1d1/0x320
Sep 27 07:03:33 bastard kernel: [<c013d45f>] __get_free_pages+0x1f/0x50
Sep 27 07:03:33 bastard kernel: [<c0140215>] cache_grow+0xb5/0x250
Sep 27 07:03:33 bastard kernel: [<c014050b>] cache_alloc_refill+0x15b/0x220
Sep 27 07:03:33 bastard kernel: [<c02581f2>] 
xfs_dir2_block_lookup_int+0x52/0x1a0
Sep 27 07:03:33 bastard kernel: [<c01407de>] kmem_cache_alloc+0x3e/0x40
Sep 27 07:03:33 bastard kernel: [<c0282f65>] _xfs_trans_alloc+0x35/0xb0
Sep 27 07:03:33 bastard kernel: [<c028bfe7>] xfs_create+0x117/0x790
Sep 27 07:03:33 bastard kernel: [<c02360ab>] xfs_attr_get+0x4b/0x50
Sep 27 07:03:33 bastard kernel: [<c022e0bb>] 
xfs_acl_vhasacl_default+0x3b/0x50
Sep 27 07:03:33 bastard kernel: [<c0299ea4>] linvfs_mknod+0x334/0x3e0
Sep 27 07:03:33 bastard kernel: [<c02580ff>] xfs_dir2_block_lookup+0x2f/0xd0
Sep 27 07:03:33 bastard kernel: [<c0256593>] xfs_dir2_lookup+0xc3/0x140
Sep 27 07:03:33 bastard kernel: [<c013d081>] buffered_rmqueue+0xd1/0x170
Sep 27 07:03:33 bastard kernel: [<c012d545>] in_group_p+0x25/0x30
Sep 27 07:03:33 bastard kernel: [<c028637c>] xfs_dir_lookup_int+0x4c/0x130
Sep 27 07:03:33 bastard kernel: [<c01631cb>] vfs_create+0xbb/0x140
Sep 27 07:03:33 bastard kernel: [<c0163834>] open_namei+0x3b4/0x410
Sep 27 07:03:33 bastard kernel: [<c01535fe>] filp_open+0x3e/0x70
Sep 27 07:03:33 bastard kernel: [<c0153abb>] sys_open+0x5b/0x90
Sep 27 07:03:33 bastard kernel: [<c010b39b>] syscall_call+0x7/0xb
Sep 27 07:03:33 bastard kernel: Code: c7 43 5c 00 00 00 00 c7 03 4e 41 
52 54 8b 44 24 20 89 43 18


 >>EIP; c0282f8d <_xfs_trans_alloc+5d/b0>   <=====

 >>ecx; c05059bc <per_cpu__runqueues+49c/928>
 >>esi; f7dfb378 <__crc_iw_handler_get_spy+15f44a/35994c>
 >>esp; ef751784 <__crc_ide_unregister_subdriver+12f15a/20e1b5>

Trace; c0299455 <xfs_iomap_write_allocate+c5/4d0>
Trace; c0284729 <xfs_trans_unlocked_item+39/60>
Trace; c029892c <xfs_iomap+40c/550>
Trace; c0293c62 <map_blocks+72/130>
Trace; c0294d27 <page_state_convert+4c7/620>
Trace; c013beb5 <mempool_alloc+75/160>
Trace; c01577da <__block_write_full_page+1ba/3d0>
Trace; c02fc19e <as_update_arq+2e/80>
Trace; c029552c <linvfs_writepage+5c/110>
Trace; c0142e79 <shrink_list+349/550>
Trace; c0141e88 <__pagevec_release+28/40>
Trace; c036659c <__map_bio+3c/100>
Trace; c0143205 <shrink_cache+185/300>
Trace; c0324b03 <__ide_dma_count+13/20>
Trace; c014390c <shrink_zone+7c/b0>
Trace; c01439ec <shrink_caches+ac/d0>
Trace; c0143ab2 <try_to_free_pages+a2/160>
Trace; c013d2f1 <__alloc_pages+1d1/320>
Trace; c013d45f <__get_free_pages+1f/50>
Trace; c0140215 <cache_grow+b5/250>
Trace; c014050b <cache_alloc_refill+15b/220>
Trace; c02581f2 <xfs_dir2_block_lookup_int+52/1a0>
Trace; c01407de <kmem_cache_alloc+3e/40>
Trace; c0282f65 <_xfs_trans_alloc+35/b0>
Trace; c028bfe7 <xfs_create+117/790>
Trace; c02360ab <xfs_attr_get+4b/50>
Trace; c022e0bb <xfs_acl_vhasacl_default+3b/50>
Trace; c0299ea4 <linvfs_mknod+334/3e0>
Trace; c02580ff <xfs_dir2_block_lookup+2f/d0>
Trace; c0256593 <xfs_dir2_lookup+c3/140>
Trace; c013d081 <buffered_rmqueue+d1/170>
Trace; c012d545 <in_group_p+25/30>
Trace; c028637c <xfs_dir_lookup_int+4c/130>
Trace; c01631cb <vfs_create+bb/140>
Trace; c0163834 <open_namei+3b4/410>
Trace; c01535fe <filp_open+3e/70>
Trace; c0153abb <sys_open+5b/90>
Trace; c010b39b <syscall_call+7/b>

Code;  c0282f8d <_xfs_trans_alloc+5d/b0>
00000000 <_EIP>:
Code;  c0282f8d <_xfs_trans_alloc+5d/b0>   <=====
   0:   c7 43 5c 00 00 00 00      movl   $0x0,0x5c(%ebx)   <=====
Code;  c0282f94 <_xfs_trans_alloc+64/b0>
   7:   c7 03 4e 41 52 54         movl   $0x5452414e,(%ebx)
Code;  c0282f9a <_xfs_trans_alloc+6a/b0>
   d:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c0282f9e <_xfs_trans_alloc+6e/b0>
  11:   89 43 18                  mov    %eax,0x18(%ebx)

Sep 27 07:04:00 bastard kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000005c
Sep 27 07:04:00 bastard kernel: c0282f8d
Sep 27 07:04:00 bastard kernel: *pde = 00000000
Sep 27 07:04:00 bastard kernel: Oops: 0002 [#2]
Sep 27 07:04:00 bastard kernel: CPU:    0
Sep 27 07:04:00 bastard kernel: EIP:    0060:[<c0282f8d>]    Not tainted
Sep 27 07:04:00 bastard kernel: EFLAGS: 00010246
Sep 27 07:04:00 bastard kernel: eax: 00000000   ebx: 00000000   ecx: 
c05059bc   edx: 00000000
Sep 27 07:04:00 bastard kernel: esi: f7dfb378   edi: 00000000   ebp: 
00000000   esp: f7dcb63c
Sep 27 07:04:00 bastard kernel: ds: 007b   es: 007b   ss: 0068
Sep 27 07:04:00 bastard kernel: Stack: f7dfb378 000008d0 00000000 
efba8400 00000000 efba8400 c0299455 efba8400
Sep 27 07:04:00 bastard kernel: 0000000f 00000000 00000010 00000000 
00000000 00000001 00000000 00000000
Sep 27 07:04:00 bastard kernel: 0714ce58 00000000 00000000 00000000 
00000001 00000000 00000000 00000000
Sep 27 07:04:00 bastard kernel: Call Trace:
Sep 27 07:04:00 bastard kernel: [<c0299455>] 
xfs_iomap_write_allocate+0xc5/0x4d0
Sep 27 07:04:00 bastard kernel: [<c011d520>] 
autoremove_wake_function+0x0/0x50
Sep 27 07:04:00 bastard kernel: [<c0284729>] 
xfs_trans_unlocked_item+0x39/0x60
Sep 27 07:04:00 bastard kernel: [<c029892c>] xfs_iomap+0x40c/0x550
Sep 27 07:04:00 bastard kernel: [<c0159189>] submit_bh+0x99/0x1e0
Sep 27 07:04:00 bastard kernel: [<c0293c62>] map_blocks+0x72/0x130
Sep 27 07:04:00 bastard kernel: [<c0294d27>] page_state_convert+0x4c7/0x620
Sep 27 07:04:00 bastard kernel: [<c01577da>] 
__block_write_full_page+0x1ba/0x3d0
Sep 27 07:04:00 bastard kernel: [<c029552c>] linvfs_writepage+0x5c/0x110
Sep 27 07:04:00 bastard kernel: [<c0142e79>] shrink_list+0x349/0x550
Sep 27 07:04:00 bastard kernel: [<c0141e88>] __pagevec_release+0x28/0x40
Sep 27 07:04:00 bastard kernel: [<c0143205>] shrink_cache+0x185/0x300
Sep 27 07:04:00 bastard kernel: [<c014390c>] shrink_zone+0x7c/0xb0
Sep 27 07:04:00 bastard kernel: [<c01439ec>] shrink_caches+0xac/0xd0
Sep 27 07:04:00 bastard kernel: [<c0143ab2>] try_to_free_pages+0xa2/0x160
Sep 27 07:04:00 bastard kernel: [<c013d2f1>] __alloc_pages+0x1d1/0x320
Sep 27 07:04:00 bastard kernel: [<c013d45f>] __get_free_pages+0x1f/0x50
Sep 27 07:04:00 bastard kernel: [<c0140215>] cache_grow+0xb5/0x250
Sep 27 07:04:00 bastard kernel: [<c014050b>] cache_alloc_refill+0x15b/0x220
Sep 27 07:04:00 bastard kernel: [<c01407de>] kmem_cache_alloc+0x3e/0x40
Sep 27 07:04:00 bastard kernel: [<c0282f65>] _xfs_trans_alloc+0x35/0xb0
Sep 27 07:04:00 bastard kernel: [<c0299455>] 
xfs_iomap_write_allocate+0xc5/0x4d0
Sep 27 07:04:00 bastard kernel: [<c02aa7c2>] __delay+0x12/0x20
Sep 27 07:04:00 bastard kernel: [<c0324b03>] __ide_dma_count+0x13/0x20
Sep 27 07:04:00 bastard kernel: [<c0324910>] __ide_dma_write+0xd0/0xe0
Sep 27 07:04:00 bastard kernel: [<c0323f10>] ide_dma_intr+0x0/0xc0
Sep 27 07:04:00 bastard kernel: [<c0324450>] dma_timer_expiry+0x0/0x90
Sep 27 07:04:00 bastard kernel: [<c0284745>] 
xfs_trans_unlocked_item+0x55/0x60
Sep 27 07:04:00 bastard kernel: [<c029892c>] xfs_iomap+0x40c/0x550
Sep 27 07:04:00 bastard kernel: [<c0293c62>] map_blocks+0x72/0x130
Sep 27 07:04:00 bastard kernel: [<c0294d27>] page_state_convert+0x4c7/0x620
Sep 27 07:04:00 bastard kernel: [<c0292e8a>] pagebuf_iorequest+0x9a/0x140
Sep 27 07:04:00 bastard kernel: [<c029c312>] xfs_bdstrat_cb+0x42/0x50
Sep 27 07:04:00 bastard kernel: [<c029298c>] pagebuf_iostart+0x4c/0xb0
Sep 27 07:04:00 bastard kernel: [<c029552c>] linvfs_writepage+0x5c/0x110
Sep 27 07:04:00 bastard kernel: [<c01767d3>] mpage_writepages+0x203/0x2f0
Sep 27 07:04:00 bastard kernel: [<c02954d0>] linvfs_writepage+0x0/0x110
Sep 27 07:04:00 bastard kernel: [<c013e6c6>] do_writepages+0x36/0x40
Sep 27 07:04:00 bastard kernel: [<c0174c94>] __sync_single_inode+0xd4/0x230
Sep 27 07:04:00 bastard kernel: [<c017503e>] sync_sb_inodes+0x19e/0x260
Sep 27 07:04:00 bastard kernel: [<c017514d>] writeback_inodes+0x4d/0xa0
Sep 27 07:04:00 bastard kernel: [<c013e50c>] wb_kupdate+0x9c/0x120
Sep 27 07:04:00 bastard kernel: [<c013ead2>] __pdflush+0xd2/0x1d0
Sep 27 07:04:00 bastard kernel: [<c013ebd0>] pdflush+0x0/0x20
Sep 27 07:04:00 bastard kernel: [<c013ebdf>] pdflush+0xf/0x20
Sep 27 07:04:00 bastard kernel: [<c013e470>] wb_kupdate+0x0/0x120
Sep 27 07:04:00 bastard kernel: [<c0109284>] kernel_thread_helper+0x0/0xc
Sep 27 07:04:00 bastard kernel: [<c0109289>] kernel_thread_helper+0x5/0xc
Sep 27 07:04:00 bastard kernel: Code: c7 43 5c 00 00 00 00 c7 03 4e 41 
52 54 8b 44 24 20 89 43 18


 >>EIP; c0282f8d <_xfs_trans_alloc+5d/b0>   <=====

 >>ecx; c05059bc <per_cpu__runqueues+49c/928>
 >>esi; f7dfb378 <__crc_iw_handler_get_spy+15f44a/35994c>
 >>esp; f7dcb63c <__crc_iw_handler_get_spy+12f70e/35994c>

Trace; c0299455 <xfs_iomap_write_allocate+c5/4d0>
Trace; c011d520 <autoremove_wake_function+0/50>
Trace; c0284729 <xfs_trans_unlocked_item+39/60>
Trace; c029892c <xfs_iomap+40c/550>
Trace; c0159189 <submit_bh+99/1e0>
Trace; c0293c62 <map_blocks+72/130>
Trace; c0294d27 <page_state_convert+4c7/620>
Trace; c01577da <__block_write_full_page+1ba/3d0>
Trace; c029552c <linvfs_writepage+5c/110>
Trace; c0142e79 <shrink_list+349/550>
Trace; c0141e88 <__pagevec_release+28/40>
Trace; c0143205 <shrink_cache+185/300>
Trace; c014390c <shrink_zone+7c/b0>
Trace; c01439ec <shrink_caches+ac/d0>
Trace; c0143ab2 <try_to_free_pages+a2/160>
Trace; c013d2f1 <__alloc_pages+1d1/320>
Trace; c013d45f <__get_free_pages+1f/50>
Trace; c0140215 <cache_grow+b5/250>
Trace; c014050b <cache_alloc_refill+15b/220>
Trace; c01407de <kmem_cache_alloc+3e/40>
Trace; c0282f65 <_xfs_trans_alloc+35/b0>
Trace; c0299455 <xfs_iomap_write_allocate+c5/4d0>
Trace; c02aa7c2 <__delay+12/20>
Trace; c0324b03 <__ide_dma_count+13/20>
Trace; c0324910 <__ide_dma_write+d0/e0>
Trace; c0323f10 <ide_dma_intr+0/c0>
Trace; c0324450 <dma_timer_expiry+0/90>
Trace; c0284745 <xfs_trans_unlocked_item+55/60>
Trace; c029892c <xfs_iomap+40c/550>
Trace; c0293c62 <map_blocks+72/130>
Trace; c0294d27 <page_state_convert+4c7/620>
Trace; c0292e8a <pagebuf_iorequest+9a/140>
Trace; c029c312 <xfs_bdstrat_cb+42/50>
Trace; c029298c <pagebuf_iostart+4c/b0>
Trace; c029552c <linvfs_writepage+5c/110>
Trace; c01767d3 <mpage_writepages+203/2f0>
Trace; c02954d0 <linvfs_writepage+0/110>
Trace; c013e6c6 <do_writepages+36/40>
Trace; c0174c94 <__sync_single_inode+d4/230>
Trace; c017503e <sync_sb_inodes+19e/260>
Trace; c017514d <writeback_inodes+4d/a0>
Trace; c013e50c <wb_kupdate+9c/120>
Trace; c013ead2 <__pdflush+d2/1d0>
Trace; c013ebd0 <pdflush+0/20>
Trace; c013ebdf <pdflush+f/20>
Trace; c013e470 <wb_kupdate+0/120>
Trace; c0109284 <kernel_thread_helper+0/c>
Trace; c0109289 <kernel_thread_helper+5/c>

Code;  c0282f8d <_xfs_trans_alloc+5d/b0>
00000000 <_EIP>:
Code;  c0282f8d <_xfs_trans_alloc+5d/b0>   <=====
   0:   c7 43 5c 00 00 00 00      movl   $0x0,0x5c(%ebx)   <=====
Code;  c0282f94 <_xfs_trans_alloc+64/b0>
   7:   c7 03 4e 41 52 54         movl   $0x5452414e,(%ebx)
Code;  c0282f9a <_xfs_trans_alloc+6a/b0>
   d:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c0282f9e <_xfs_trans_alloc+6e/b0>
  11:   89 43 18                  mov    %eax,0x18(%ebx)


