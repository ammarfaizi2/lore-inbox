Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbTHAI1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 04:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbTHAI1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 04:27:14 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:30592 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S270691AbTHAI1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 04:27:04 -0400
From: "Nicolas P." <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: oops 2.6.0-test2 slab.c
Date: Fri, 1 Aug 2003 10:27:34 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011027.34522.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nicolas is back with his slabs oops ;) 

There are many coincidences with theses oops and activation of snmp/mrtg on
this particular system, maybe swap activation too, less oops with swap off (1G 
ram).
I use now ulimits in case of some progs went crazy, but this is not better 
than before...

Regards.

Nicolas.



Aug  1 04:04:52 hal9003 kernel: ------------[ cut here ]------------
Aug  1 04:04:52 hal9003 kernel: kernel BUG at mm/slab.c:1702!
Aug  1 04:04:52 hal9003 kernel: invalid operand: 0000 [#1]
Aug  1 04:04:52 hal9003 kernel: CPU:    0
Aug  1 04:04:52 hal9003 kernel: EIP:    0060:[free_block+449/489]    Not 
tainted
Aug  1 04:04:52 hal9003 kernel: EIP:    0060:[<c014cad2>]    Not tainted
Aug  1 04:04:52 hal9003 kernel: EFLAGS: 00010002
Aug  1 04:04:52 hal9003 kernel: EIP is at free_block+0x1c1/0x1e9
Aug  1 04:04:52 hal9003 kernel: eax: ffb7ffff   ebx: 00000021   ecx: 00000001   
edx: 0000003d
Aug  1 04:04:52 hal9003 kernel: esi: d5820000   edi: d5820018   ebp: f7797c74   
esp: f7797c4c
Aug  1 04:04:52 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 04:04:52 hal9003 kernel: Process kswapd0 (pid: 7, threadinfo=f7796000 
task=f77c1000)
Aug  1 04:04:52 hal9003 kernel: Stack: 00000000 f7797c78 00000022 f7ffd92c 
f7ffd93c 00000021 00000009 f7fee014
Aug  1 04:04:52 hal9003 kernel:        d5820180 00000010 f7797cac c014ccfb 
f7ffd920 f7fee014 00000010 00000000
Aug  1 04:04:52 hal9003 kernel:        f7797cc0 00000282 00010c00 f7ffe75c 
00000010 00010c00 d5820180 f7ffd920
Aug  1 04:04:52 hal9003 kernel: Call Trace:
Aug  1 04:04:52 hal9003 kernel:  [cache_flusharray+513/616] 
cache_flusharray+0x201/0x268
Aug  1 04:04:52 hal9003 kernel:  [<c014ccfb>] cache_flusharray+0x201/0x268
Aug  1 04:04:52 hal9003 kernel:  [kmem_cache_free+546/828] 
kmem_cache_free+0x222/0x33c
Aug  1 04:04:52 hal9003 kernel:  [<c014d335>] kmem_cache_free+0x222/0x33c
Aug  1 04:04:52 hal9003 kernel:  [free_buffer_head+34/59] 
free_buffer_head+0x22/0x3b
Aug  1 04:04:52 hal9003 kernel:  [<c016f6b5>] free_buffer_head+0x22/0x3b
Aug  1 04:04:52 hal9003 kernel:  [free_buffer_head+34/59] 
free_buffer_head+0x22/0x3b
Aug  1 04:04:52 hal9003 kernel:  [<c016f6b5>] free_buffer_head+0x22/0x3b
Aug  1 04:04:52 hal9003 kernel:  [try_to_free_buffers+298/505] 
try_to_free_buffers+0x12a/0x1f9
Aug  1 04:04:52 hal9003 kernel:  [<c016f4be>] try_to_free_buffers+0x12a/0x1f9
Aug  1 04:04:52 hal9003 kernel:  [__pagevec_free+27/36] 
__pagevec_free+0x1b/0x24
Aug  1 04:04:52 hal9003 kernel:  [<c014807e>] __pagevec_free+0x1b/0x24
Aug  1 04:04:52 hal9003 kernel:  [reiserfs_releasepage+398/506] 
reiserfs_releasepage+0x18e/0x1fa
Aug  1 04:04:52 hal9003 kernel:  [<c01e6626>] reiserfs_releasepage+0x18e/0x1fa
Aug  1 04:04:52 hal9003 kernel:  [try_to_release_page+88/102] 
try_to_release_page+0x58/0x66
Aug  1 04:04:52 hal9003 kernel:  [<c016d3bd>] try_to_release_page+0x58/0x66
Aug  1 04:04:52 hal9003 kernel:  [shrink_list+1853/2257] 
shrink_list+0x73d/0x8d1
Aug  1 04:04:52 hal9003 kernel:  [<c015140a>] shrink_list+0x73d/0x8d1
Aug  1 04:04:52 hal9003 kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Aug  1 04:04:52 hal9003 kernel:  [<c010a748>] common_interrupt+0x18/0x20
Aug  1 04:04:52 hal9003 kernel:  [shrink_cache+459/1422] 
shrink_cache+0x1cb/0x58e
Aug  1 04:04:52 hal9003 kernel:  [<c0151769>] shrink_cache+0x1cb/0x58e
Aug  1 04:04:52 hal9003 kernel:  [shrink_zone+155/157] shrink_zone+0x9b/0x9d
Aug  1 04:04:52 hal9003 kernel:  [<c0152598>] shrink_zone+0x9b/0x9d
Aug  1 04:04:52 hal9003 kernel:  [autoremove_wake_function+0/75] 
autoremove_wake_function+0x0/0x4b
Aug  1 04:04:52 hal9003 kernel:  [<c011f1b2>] 
autoremove_wake_function+0x0/0x4b
Aug  1 04:04:52 hal9003 kernel:  [balance_pgdat+274/391] 
balance_pgdat+0x112/0x187
Aug  1 04:04:52 hal9003 kernel:  [<c015288d>] balance_pgdat+0x112/0x187
Aug  1 04:04:52 hal9003 kernel:  [kswapd+248/250] kswapd+0xf8/0xfa
Aug  1 04:04:52 hal9003 kernel:  [<c01529fa>] kswapd+0xf8/0xfa
Aug  1 04:04:52 hal9003 kernel:  [autoremove_wake_function+0/75] 
autoremove_wake_function+0x0/0x4b
Aug  1 04:04:52 hal9003 kernel:  [<c011f1b2>] 
autoremove_wake_function+0x0/0x4b
Aug  1 04:04:52 hal9003 kernel:  [autoremove_wake_function+0/75] 
autoremove_wake_function+0x0/0x4b
Aug  1 04:04:52 hal9003 kernel:  [<c011f1b2>] 
autoremove_wake_function+0x0/0x4b
Aug  1 04:04:52 hal9003 kernel:  [kswapd+0/250] kswapd+0x0/0xfa
Aug  1 04:04:52 hal9003 kernel:  [<c0152902>] kswapd+0x0/0xfa
Aug  1 04:04:52 hal9003 kernel:  [kernel_thread_helper+5/11] 
kernel_thread_helper+0x5/0xb
Aug  1 04:04:52 hal9003 kernel:  [<c0107211>] kernel_thread_helper+0x5/0xb
Aug  1 04:04:52 hal9003 kernel:
Aug  1 04:04:52 hal9003 kernel: Code: 0f 0b a6 06 63 69 32 c0 e9 e5 fe ff ff 
0f 0b a5 06 63 69 32
Aug  1 04:04:52 hal9003 kernel:  fs/buffer.c:889: 
spin_lock(fs/reiserfs/journal.c:f8cde0e0) already locked by 
fs/reiserfs/inode.c/2291
Aug  1 04:04:52 hal9003 kernel: mm/slab.c:1955: spin_lock(mm/slab.c:f7ffd964) 
already locked by mm/slab.c/1955
Aug  1 04:04:52 hal9003 kernel: ------------[ cut here ]------------
Aug  1 04:04:52 hal9003 kernel: kernel BUG at mm/slab.c:1701!
Aug  1 04:04:52 hal9003 kernel: invalid operand: 0000 [#2]
Aug  1 04:04:52 hal9003 kernel: CPU:    0
Aug  1 04:04:52 hal9003 kernel: EIP:    0060:[free_block+412/489]    Not 
tainted
Aug  1 04:04:52 hal9003 kernel: EIP:    0060:[<c014caad>]    Not tainted
Aug  1 04:04:52 hal9003 kernel: EFLAGS: 00010002
Aug  1 04:04:52 hal9003 kernel: EIP is at free_block+0x19c/0x1e9
Aug  1 04:04:52 hal9003 kernel: eax: 00000018   ebx: 0000003e   ecx: 00000000   
edx: 0000003d
Aug  1 04:04:52 hal9003 kernel: esi: f0a0b000   edi: f0a0b018   ebp: e9ddf9f4   
esp: e9ddf9cc
Aug  1 04:04:52 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Aug  1 04:04:52 hal9003 kernel: Process uniq (pid: 16647, threadinfo=e9dde000 
task=cbaca000)
Aug  1 04:04:52 hal9003 kernel: Stack: c020569d c01e43c6 00000018 f7ffd92c 
f7ffd93c 0000001a 00000000 f7fee014
Aug  1 04:04:52 hal9003 kernel:        c247d180 00000010 e9ddfa2c c014ccfb 
f7ffd920 f7fee014 00000010 c0326963
Aug  1 04:04:52 hal9003 kernel:        f7ffd964 c0326963 000007a3 f7ffe75c 
00000010 00010c00 c247d180 f7ffd920
Aug  1 04:04:52 hal9003 kernel: Call Trace:
Aug  1 04:04:52 hal9003 kernel:  [check_journal_end+390/682] 
check_journal_end+0x186/0x2aa
Aug  1 04:04:52 hal9003 kernel:  [<c020569d>] check_journal_end+0x186/0x2aa
Aug  1 04:04:52 hal9003 kernel:  [reiserfs_update_sd+437/540] 
reiserfs_update_sd+0x1b5/0x21c
Aug  1 04:04:52 hal9003 kernel:  [<c01e43c6>] reiserfs_update_sd+0x1b5/0x21c
Aug  1 04:04:52 hal9003 kernel:  [cache_flusharray+513/616] 
cache_flusharray+0x201/0x268
Aug  1 04:04:52 hal9003 kernel:  [<c014ccfb>] cache_flusharray+0x201/0x268
Aug  1 04:04:52 hal9003 kernel:  [kmem_cache_free+546/828] 
kmem_cache_free+0x222/0x33c
Aug  1 04:04:52 hal9003 kernel:  [<c014d335>] kmem_cache_free+0x222/0x33c
Aug  1 04:04:52 hal9003 kernel:  [free_buffer_head+34/59] 
free_buffer_head+0x22/0x3b
Aug  1 04:04:52 hal9003 kernel:  [<c016f6b5>] free_buffer_head+0x22/0x3b
Aug  1 04:04:52 hal9003 kernel:  [free_buffer_head+34/59] 
free_buffer_head+0x22/0x3b
Aug  1 04:04:52 hal9003 kernel:  [<c016f6b5>] free_buffer_head+0x22/0x3b
Aug  1 04:04:52 hal9003 kernel:  [try_to_free_buffers+298/505] 
try_to_free_buffers+0x12a/0x1f9
Aug  1 04:04:52 hal9003 kernel:  [<c016f4be>] try_to_free_buffers+0x12a/0x1f9
Aug  1 04:04:52 hal9003 kernel:  [__pagevec_free+27/36] 
__pagevec_free+0x1b/0x24
Aug  1 04:04:52 hal9003 kernel:  [<c014807e>] __pagevec_free+0x1b/0x24
Aug  1 04:04:52 hal9003 kernel:  [reiserfs_releasepage+398/506] 
reiserfs_releasepage+0x18e/0x1fa
Aug  1 04:04:52 hal9003 kernel:  [<c01e6626>] reiserfs_releasepage+0x18e/0x1fa
Aug  1 04:04:52 hal9003 kernel:  [try_to_release_page+88/102] 
try_to_release_page+0x58/0x66
Aug  1 04:04:52 hal9003 kernel:  [<c016d3bd>] try_to_release_page+0x58/0x66
Aug  1 04:04:52 hal9003 kernel:  [shrink_list+1853/2257] 
shrink_list+0x73d/0x8d1
Aug  1 04:04:52 hal9003 kernel:  [<c015140a>] shrink_list+0x73d/0x8d1
Aug  1 04:04:52 hal9003 kernel:  [shrink_cache+459/1422] 
shrink_cache+0x1cb/0x58e
Aug  1 04:04:52 hal9003 kernel:  [<c0151769>] shrink_cache+0x1cb/0x58e
Aug  1 04:04:52 hal9003 kernel:  [shrink_zone+155/157] shrink_zone+0x9b/0x9d
Aug  1 04:04:52 hal9003 kernel:  [<c0152598>] shrink_zone+0x9b/0x9d
Aug  1 04:04:52 hal9003 kernel:  [shrink_caches+147/168] 
shrink_caches+0x93/0xa8
Aug  1 04:04:52 hal9003 kernel:  [<c015262d>] shrink_caches+0x93/0xa8
Aug  1 04:04:52 hal9003 kernel:  [try_to_free_pages+136/313] 
try_to_free_pages+0x88/0x139
Aug  1 04:04:52 hal9003 kernel:  [<c01526ca>] try_to_free_pages+0x88/0x139
Aug  1 04:04:52 hal9003 kernel:  [__alloc_pages+458/857] 
__alloc_pages+0x1ca/0x359
Aug  1 04:04:52 hal9003 kernel:  [<c0147e37>] __alloc_pages+0x1ca/0x359
Aug  1 04:04:52 hal9003 kernel:  [find_or_create_page+165/179] 
find_or_create_page+0xa5/0xb3
Aug  1 04:04:52 hal9003 kernel:  [<c0143a87>] find_or_create_page+0xa5/0xb3
Aug  1 04:04:52 hal9003 kernel:  
[reiserfs_prepare_file_region_for_write+2542/2667] 
reiserfs_prepare_file_region_for_write+0x9ee/0xa6b
Aug  1 04:04:52 hal9003 kernel:  [<c01e902e>] 
reiserfs_prepare_file_region_for_write+0x9ee/0xa6b
Aug  1 04:04:52 hal9003 kernel:  [make_cpu_key+84/94] make_cpu_key+0x54/0x5e
Aug  1 04:04:52 hal9003 kernel:  [<c01e1e85>] make_cpu_key+0x54/0x5e
Aug  1 04:04:52 hal9003 kernel:  [pathrelse+41/127] pathrelse+0x29/0x7f
Aug  1 04:04:52 hal9003 kernel:  [<c01f9a24>] pathrelse+0x29/0x7f
Aug  1 04:04:52 hal9003 kernel:  [reiserfs_file_write+800/1501] 
reiserfs_file_write+0x320/0x5dd
Aug  1 04:04:52 hal9003 kernel:  [<c01e93cb>] reiserfs_file_write+0x320/0x5dd
Aug  1 04:04:52 hal9003 kernel:  [autoremove_wake_function+37/75] 
autoremove_wake_function+0x25/0x4b
Aug  1 04:04:52 hal9003 kernel:  [<c011f1d7>] 
autoremove_wake_function+0x25/0x4b
Aug  1 04:04:52 hal9003 kernel:  [pipe_read+456/585] pipe_read+0x1c8/0x249
Aug  1 04:04:52 hal9003 kernel:  [<c0179baf>] pipe_read+0x1c8/0x249
Aug  1 04:04:52 hal9003 kernel:  [timer_interrupt+338/877] 
timer_interrupt+0x152/0x36d
Aug  1 04:04:52 hal9003 kernel:  [<c0111d00>] timer_interrupt+0x152/0x36d
Aug  1 04:04:52 hal9003 kernel:  [vfs_write+175/281] vfs_write+0xaf/0x119
Aug  1 04:04:52 hal9003 kernel:  [<c016910e>] vfs_write+0xaf/0x119
Aug  1 04:04:52 hal9003 kernel:  [sys_write+63/93] sys_write+0x3f/0x5d
Aug  1 04:04:52 hal9003 kernel:  [<c0169214>] sys_write+0x3f/0x5d
Aug  1 04:04:52 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 04:04:52 hal9003 kernel:  [<c0109ddb>] syscall_call+0x7/0xb
Aug  1 04:04:52 hal9003 kernel:
Aug  1 04:04:52 hal9003 kernel: Code: 0f 0b a5 06 63 69 32 c0 e9 56 ff ff ff 
8b 45 08 8b 50 3c e9
Aug  1 04:04:52 hal9003 kernel:  fs/buffer.c:889: 
spin_lock(fs/reiserfs/journal.c:f8cde0e0) already locked by 
fs/reiserfs/inode.c/2291
Aug  1 04:04:53 hal9003 kernel: mm/slab.c:2412: spin_lock(mm/slab.c:f7ffd964) 
already locked by mm/slab.c/1955

