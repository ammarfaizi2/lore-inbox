Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVAXNWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVAXNWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVAXNWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:22:14 -0500
Received: from mail.ceskyhosting.cz ([81.0.238.160]:44981 "HELO
	mail.ceskyhosting.cz") by vger.kernel.org with SMTP id S261380AbVAXNT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:19:57 -0500
Message-ID: <41F4F5D4.9000502@eq.cz>
Date: Mon, 24 Jan 2005 14:19:16 +0100
From: "0602@eq.cz" <0602@eq.cz>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug: mm/rmap.c:483
Content-Type: multipart/mixed;
 boundary="------------080900010207040308010209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080900010207040308010209
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've also experienced mentioned bug, kernel 2.6.10-ac8.

The relevant syslog entries and .config are attached.

I'm not subscribed, so please CC me.

Regards,

r.

--------------080900010207040308010209
Content-Type: text/plain;
 name="kernel_bug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_bug.txt"

Jan 23 20:00:40 kryton kernel: md: sda3 has different UUID to sdb5
Jan 23 20:00:40 kryton kernel: md: sda2 has different UUID to sdb5
Jan 23 20:00:40 kryton kernel: md: sda1 has different UUID to sdb5
Jan 23 20:00:40 kryton kernel: md: sdb2 has different UUID to sdb3
Jan 23 20:00:40 kryton kernel: md: sdb1 has different UUID to sdb3
Jan 23 20:00:40 kryton kernel: md: sda2 has different UUID to sdb3
Jan 23 20:00:40 kryton kernel: md: sda1 has different UUID to sdb3
Jan 23 20:00:40 kryton kernel: md: sdb1 has different UUID to sdb2
Jan 23 20:00:40 kryton kernel: md: sda1 has different UUID to sdb2
Jan 23 20:00:40 kryton kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Jan 23 20:01:14 kryton kernel: swap_free: Bad swap offset entry 00100000
Jan 23 20:01:14 kryton kernel: swap_free: Bad swap offset entry 00110000
Jan 23 20:01:14 kryton kernel: swap_free: Bad swap offset entry 00100000
Jan 23 20:01:14 kryton kernel: ------------[ cut here ]------------
Jan 23 20:01:14 kryton kernel: kernel BUG at mm/rmap.c:483!
Jan 23 20:01:14 kryton kernel: invalid operand: 0000 [#1]
Jan 23 20:01:14 kryton kernel: CPU:    0
Jan 23 20:01:14 kryton kernel: EIP:    0060:[<c013da28>]    Not tainted VLI
Jan 23 20:01:14 kryton kernel: EFLAGS: 00010286   (2.6.10-ac8-wp2ac) 
Jan 23 20:01:14 kryton kernel: EIP is at page_remove_rmap+0x28/0x40
Jan 23 20:01:14 kryton kernel: eax: ffffffff   ebx: 00000000   ecx: b7829000   edx: c1dc4be0
Jan 23 20:01:14 kryton kernel: esi: f5adc0a4   edi: c1dc4be0   ebp: 0019f000   esp: f5af1d9c
Jan 23 20:01:14 kryton kernel: ds: 007b   es: 007b   ss: 0068
Jan 23 20:01:14 kryton kernel: Process httpd (pid: 425, threadinfo=f5af0000 task=f6831500)
Jan 23 20:01:14 kryton kernel: Stack: c01375d9 c1dc4be0 f1bc99e0 f6831500 ec435080 6e25f005 b7c29000 f5acbb7c 
Jan 23 20:01:14 kryton kernel:        b79c8000 00000000 c0137753 c049c014 f5acbb78 b7829000 0019f000 00000000 
Jan 23 20:01:14 kryton kernel:        c049c014 b7829000 f5acbb7c b79c8000 00000000 c01377c3 c049c014 f5acbb78 
Jan 23 20:01:14 kryton kernel: Call Trace:
Jan 23 20:01:14 kryton kernel:  [<c01375d9>] zap_pte_range+0x149/0x260
Jan 23 20:01:14 kryton kernel:  [<c0137753>] zap_pmd_range+0x63/0x80
Jan 23 20:01:14 kryton kernel:  [<c01377c3>] unmap_page_range+0x53/0x80
Jan 23 20:01:14 kryton kernel:  [<c01378f6>] unmap_vmas+0x106/0x1c0
Jan 23 20:01:14 kryton kernel:  [<c013bd82>] exit_mmap+0x72/0x140
Jan 23 20:01:14 kryton kernel:  [<c011333f>] mmput+0x2f/0x80
Jan 23 20:01:14 kryton kernel:  [<c0116fc7>] do_exit+0x137/0x320
Jan 23 20:01:14 kryton kernel:  [<c0117223>] do_group_exit+0x33/0x70
Jan 23 20:01:14 kryton kernel:  [<c011f6d9>] get_signal_to_deliver+0x1e9/0x2d0
Jan 23 20:01:14 kryton kernel:  [<c0102117>] do_signal+0x97/0x120
Jan 23 20:01:14 kryton kernel:  [<c01f6cae>] copy_to_user+0x3e/0x50
Jan 23 20:01:14 kryton kernel:  [<c01f6cae>] copy_to_user+0x3e/0x50
Jan 23 20:01:14 kryton kernel:  [<c012061a>] sys_rt_sigaction+0xaa/0xc0
Jan 23 20:01:14 kryton kernel:  [<c010d560>] do_page_fault+0x0/0x5c5
Jan 23 20:01:14 kryton kernel:  [<c01021d7>] do_notify_resume+0x37/0x3c
Jan 23 20:01:14 kryton kernel:  [<c010231e>] work_notifysig+0x13/0x15
Jan 23 20:01:14 kryton kernel: Code: 74 26 00 8b 54 24 04 8b 02 f6 c4 08 75 27 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 0c 9c 58 fa ff 0d 50 a1 4a c0 50 9d c3 <0f> 0b e3 01 b7 dd 39 c0 eb ea 0f 0b e0 01 b7 dd 39 c0 eb cf 8d 

[...]

Jan 23 20:02:24 kryton kernel:  ------------[ cut here ]------------
Jan 23 20:02:24 kryton kernel: kernel BUG at fs/reiserfs/inode.c:357!
Jan 23 20:02:24 kryton kernel: invalid operand: 0000 [#2]
Jan 23 20:02:24 kryton kernel: CPU:    0
Jan 23 20:02:24 kryton kernel: EIP:    0060:[<c01856ba>]    Not tainted VLI
Jan 23 20:02:24 kryton kernel: EFLAGS: 00010202   (2.6.10-ac8-wp2ac) 
Jan 23 20:02:24 kryton kernel: EIP is at _get_block_create_0+0x30a/0x7b0
Jan 23 20:02:24 kryton kernel: eax: 00000003   ebx: 00001000   ecx: 00000001   edx: 00000000
Jan 23 20:02:24 kryton kernel: esi: 00000313   edi: ff927000   ebp: 00000004   esp: f5fcb9fc
Jan 23 20:02:24 kryton kernel: ds: 007b   es: 007b   ss: 0068
Jan 23 20:02:24 kryton kernel: Process httpd (pid: 416, threadinfo=f5fca000 task=f3780580)
Jan 23 20:02:24 kryton kernel: Stack: c1dccba0 f40d20d8 f5fcba80 00000000 0000000f 00000003 c01f3d4f 00000001 
Jan 23 20:02:24 kryton kernel:        00000000 00010001 c01f3fdd 00000000 00000000 00000000 ff926000 f40d20d8 
Jan 23 20:02:24 kryton kernel:        f40b365c 000cab54 000cd23d 00000001 30000000 0240ffff 000106b0 00000001 
Jan 23 20:02:24 kryton kernel: Call Trace:
Jan 23 20:02:24 kryton kernel:  [<c01f3d4f>] radix_tree_node_alloc+0x1f/0x60
Jan 23 20:02:24 kryton kernel:  [<c01f3fdd>] radix_tree_insert+0xed/0x110
Jan 23 20:02:24 kryton kernel:  [<c0167091>] mpage_readpages+0xf1/0x160
Jan 23 20:02:24 kryton kernel:  [<c01872b0>] reiserfs_get_block+0x14b0/0x14c0
Jan 23 20:02:24 kryton kernel:  [<c02eeea3>] ip_finish_output2+0x93/0x190
Jan 23 20:02:24 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:02:24 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:02:24 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:02:24 kryton kernel:  [<c02ec8ed>] ip_finish_output+0x1dd/0x1f0
Jan 23 20:02:24 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:02:24 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:02:24 kryton kernel:  [<c02eedf4>] dst_output+0x14/0x30
Jan 23 20:02:24 kryton kernel:  [<c02e0e89>] nf_hook_slow+0xc9/0x100
Jan 23 20:02:24 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:02:24 kryton kernel:  [<c02ececd>] ip_queue_xmit+0x3ad/0x4d0
Jan 23 20:02:24 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:02:24 kryton kernel:  [<c010d6ec>] do_page_fault+0x18c/0x5c5
Jan 23 20:02:24 kryton kernel:  [<c019b9cf>] search_by_key+0x73f/0x10a0
Jan 23 20:02:24 kryton kernel:  [<c019aeb3>] pathrelse+0x23/0x40
Jan 23 20:02:24 kryton kernel:  [<c0166f93>] do_mpage_readpage+0x333/0x340
Jan 23 20:02:24 kryton kernel:  [<c02f219d>] tcp_sendmsg+0x47d/0x10c0
Jan 23 20:02:24 kryton kernel:  [<c01f3d4f>] radix_tree_node_alloc+0x1f/0x60
Jan 23 20:02:24 kryton kernel:  [<c01f3fdd>] radix_tree_insert+0xed/0x110
Jan 23 20:02:24 kryton kernel:  [<c012a384>] add_to_page_cache+0x54/0x80
Jan 23 20:02:24 kryton kernel:  [<c01670ce>] mpage_readpages+0x12e/0x160
Jan 23 20:02:24 kryton kernel:  [<c0185e00>] reiserfs_get_block+0x0/0x14c0
Jan 23 20:02:24 kryton kernel:  [<c02cd13a>] sock_sendmsg+0xda/0x100
Jan 23 20:02:24 kryton kernel:  [<c0131432>] read_pages+0x132/0x140
Jan 23 20:02:24 kryton kernel:  [<c0185e00>] reiserfs_get_block+0x0/0x14c0
Jan 23 20:02:24 kryton kernel:  [<c012e8e4>] __alloc_pages+0x1d4/0x370
Jan 23 20:02:24 kryton kernel:  [<c013169f>] do_page_cache_readahead+0xcf/0x140
Jan 23 20:02:24 kryton kernel:  [<c013180a>] page_cache_readahead+0xfa/0x1f0
Jan 23 20:02:24 kryton kernel:  [<c012aa82>] do_generic_mapping_read+0xd2/0x440
Jan 23 20:02:24 kryton kernel:  [<c0146277>] do_readv_writev+0x1f7/0x280
Jan 23 20:02:24 kryton kernel:  [<c012b32e>] generic_file_sendfile+0x5e/0x70
Jan 23 20:02:24 kryton kernel:  [<c012b250>] file_send_actor+0x0/0x80
Jan 23 20:02:24 kryton kernel:  [<c01466dd>] do_sendfile+0x1fd/0x2f0
Jan 23 20:02:24 kryton kernel:  [<c012b250>] file_send_actor+0x0/0x80
Jan 23 20:02:24 kryton kernel:  [<c014682f>] sys_sendfile+0x5f/0xc0
Jan 23 20:02:24 kryton kernel:  [<c01022d3>] syscall_call+0x7/0xb
Jan 23 20:02:24 kryton kernel: Code: 00 00 00 e8 a9 fe 00 00 8b 44 24 3c 0f b7 40 16 66 89 44 24 26 b8 0f 00 00 00 8d b4 26 00 00 00 00 89 c1 99 83 f1 02 09 d1 74 08 <0f> 0b 65 01 36 f8 39 c0 66 83 7c 24 26 00 0f 85 86 02 00 00 8b 
Jan 23 20:02:24 kryton kernel:  ------------[ cut here ]------------
Jan 23 20:02:24 kryton kernel: kernel BUG at fs/reiserfs/inode.c:357!
Jan 23 20:02:24 kryton kernel: invalid operand: 0000 [#3]
Jan 23 20:02:24 kryton kernel: CPU:    0
Jan 23 20:02:24 kryton kernel: EIP:    0060:[<c01856ba>]    Not tainted VLI
Jan 23 20:02:24 kryton kernel: EFLAGS: 00010202   (2.6.10-ac8-wp2ac) 
Jan 23 20:02:24 kryton kernel: EIP is at _get_block_create_0+0x30a/0x7b0
Jan 23 20:02:24 kryton kernel: eax: 00000000   ebx: 00000001   ecx: 00000002   edx: 00000000
Jan 23 20:02:24 kryton kernel: esi: f40d2018   edi: ff92e028   ebp: 00000028   esp: f51079fc
Jan 23 20:02:24 kryton kernel: ds: 007b   es: 007b   ss: 0068
Jan 23 20:02:24 kryton kernel: Process httpd (pid: 494, threadinfo=f5106000 task=f74fb580)
Jan 23 20:02:24 kryton kernel: Stack: f178ee00 f5107a60 f5107a80 00000000 0000000f 00000003 00283d4f 00000001 
Jan 23 20:02:24 kryton kernel:        00000000 00000001 00000000 00000000 00000000 00000000 ff92e028 f40d2018 
Jan 23 20:02:24 kryton kernel:        f40b365c 000cab54 000cd239 00000001 20000000 0028ffff 00010358 00000001 
Jan 23 20:02:24 kryton kernel: Call Trace:
Jan 23 20:02:24 kryton kernel:  [<c0167091>] mpage_readpages+0xf1/0x160
Jan 23 20:02:24 kryton kernel:  [<c01872b0>] reiserfs_get_block+0x14b0/0x14c0
Jan 23 20:02:24 kryton kernel:  [<c02eeea3>] ip_finish_output2+0x93/0x190
Jan 23 20:02:24 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:02:24 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:02:24 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:02:24 kryton kernel:  [<c02ec8ed>] ip_finish_output+0x1dd/0x1f0
Jan 23 20:02:24 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:02:24 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:02:24 kryton kernel:  [<c02eedf4>] dst_output+0x14/0x30
Jan 23 20:02:24 kryton kernel:  [<c02e0e89>] nf_hook_slow+0xc9/0x100
Jan 23 20:02:24 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:02:24 kryton kernel:  [<c02ececd>] ip_queue_xmit+0x3ad/0x4d0
Jan 23 20:02:24 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:02:24 kryton kernel:  [<c010d6ec>] do_page_fault+0x18c/0x5c5
Jan 23 20:02:24 kryton kernel:  [<c019aeb3>] pathrelse+0x23/0x40
Jan 23 20:02:24 kryton kernel:  [<c0166f93>] do_mpage_readpage+0x333/0x340
Jan 23 20:02:24 kryton kernel:  [<c02f219d>] tcp_sendmsg+0x47d/0x10c0
Jan 23 20:02:24 kryton kernel:  [<c01f3d4f>] radix_tree_node_alloc+0x1f/0x60
Jan 23 20:02:24 kryton kernel:  [<c01f3fdd>] radix_tree_insert+0xed/0x110
Jan 23 20:02:24 kryton kernel:  [<c012a384>] add_to_page_cache+0x54/0x80
Jan 23 20:02:24 kryton kernel:  [<c01670ce>] mpage_readpages+0x12e/0x160
Jan 23 20:02:24 kryton kernel:  [<c0185e00>] reiserfs_get_block+0x0/0x14c0
Jan 23 20:02:24 kryton kernel:  [<c02cd13a>] sock_sendmsg+0xda/0x100
Jan 23 20:02:24 kryton kernel:  [<c0131432>] read_pages+0x132/0x140
Jan 23 20:02:24 kryton kernel:  [<c0185e00>] reiserfs_get_block+0x0/0x14c0
Jan 23 20:02:24 kryton kernel:  [<c012e8e4>] __alloc_pages+0x1d4/0x370
Jan 23 20:02:24 kryton kernel:  [<c013169f>] do_page_cache_readahead+0xcf/0x140
Jan 23 20:02:24 kryton kernel:  [<c013180a>] page_cache_readahead+0xfa/0x1f0
Jan 23 20:02:24 kryton kernel:  [<c012aa82>] do_generic_mapping_read+0xd2/0x440
Jan 23 20:02:24 kryton kernel:  [<c0146277>] do_readv_writev+0x1f7/0x280
Jan 23 20:02:24 kryton kernel:  [<c012b32e>] generic_file_sendfile+0x5e/0x70
Jan 23 20:02:24 kryton kernel:  [<c012b250>] file_send_actor+0x0/0x80
Jan 23 20:02:24 kryton kernel:  [<c01466dd>] do_sendfile+0x1fd/0x2f0
Jan 23 20:02:24 kryton kernel:  [<c012b250>] file_send_actor+0x0/0x80
Jan 23 20:02:24 kryton kernel:  [<c014682f>] sys_sendfile+0x5f/0xc0
Jan 23 20:02:24 kryton kernel:  [<c01022d3>] syscall_call+0x7/0xb
Jan 23 20:02:24 kryton kernel: Code: 00 00 00 e8 a9 fe 00 00 8b 44 24 3c 0f b7 40 16 66 89 44 24 26 b8 0f 00 00 00 8d b4 26 00 00 00 00 89 c1 99 83 f1 02 09 d1 74 08 <0f> 0b 65 01 36 f8 39 c0 66 83 7c 24 26 00 0f 85 86 02 00 00 8b 

[...]

Jan 23 20:11:29 kryton kernel:  ------------[ cut here ]------------
Jan 23 20:11:29 kryton kernel: kernel BUG at fs/reiserfs/inode.c:357!
Jan 23 20:11:29 kryton kernel: invalid operand: 0000 [#4]
Jan 23 20:11:29 kryton kernel: CPU:    0
Jan 23 20:11:29 kryton kernel: EIP:    0060:[<c01856ba>]    Not tainted VLI
Jan 23 20:11:29 kryton kernel: EFLAGS: 00010202   (2.6.10-ac8-wp2ac) 
Jan 23 20:11:29 kryton kernel: EIP is at _get_block_create_0+0x30a/0x7b0
Jan 23 20:11:29 kryton kernel: eax: 00000000   ebx: 00001000   ecx: 00000002   edx: 00000000
Jan 23 20:11:29 kryton kernel: esi: ca9d2048   edi: ffad2000   ebp: 00000004   esp: f47c19fc
Jan 23 20:11:29 kryton kernel: ds: 007b   es: 007b   ss: 0068
Jan 23 20:11:29 kryton kernel: Process httpd (pid: 532, threadinfo=f47c0000 task=f04119e0)
Jan 23 20:11:29 kryton kernel: Stack: c1a2ee20 ca9d2048 f47c1a80 00000000 0000000f 00000003 f7c20000 00000001 
Jan 23 20:11:29 kryton kernel:        00000000 00000000 00000800 00000000 00000000 00000000 ffad1000 ca9d2048 
Jan 23 20:11:29 kryton kernel:        d70e283c 000cab51 000cd1ed 00000001 00000000 04f8ffff 0000095c 486b3280 
Jan 23 20:11:29 kryton kernel: Call Trace:
Jan 23 20:11:29 kryton kernel:  [<c01872b0>] reiserfs_get_block+0x14b0/0x14c0
Jan 23 20:11:29 kryton kernel:  [<c02eeea3>] ip_finish_output2+0x93/0x190
Jan 23 20:11:29 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:11:29 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:11:29 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:11:29 kryton kernel:  [<c02ec8ed>] ip_finish_output+0x1dd/0x1f0
Jan 23 20:11:29 kryton kernel:  [<c02eee10>] ip_finish_output2+0x0/0x190
Jan 23 20:11:29 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:11:29 kryton kernel:  [<c02eedf4>] dst_output+0x14/0x30
Jan 23 20:11:29 kryton kernel:  [<c02e0e89>] nf_hook_slow+0xc9/0x100
Jan 23 20:11:29 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:11:29 kryton kernel:  [<c02ececd>] ip_queue_xmit+0x3ad/0x4d0
Jan 23 20:11:29 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:11:29 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:11:29 kryton kernel:  [<c012e670>] buffered_rmqueue+0xc0/0x160
Jan 23 20:11:29 kryton kernel:  [<c02eede0>] dst_output+0x0/0x30
Jan 23 20:11:29 kryton kernel:  [<c012e8e4>] __alloc_pages+0x1d4/0x370
Jan 23 20:11:29 kryton kernel:  [<c0166f93>] do_mpage_readpage+0x333/0x340
Jan 23 20:11:29 kryton kernel:  [<c01f3d4f>] radix_tree_node_alloc+0x1f/0x60
Jan 23 20:11:29 kryton kernel:  [<c01f3fdd>] radix_tree_insert+0xed/0x110
Jan 23 20:11:29 kryton kernel:  [<c012a384>] add_to_page_cache+0x54/0x80
Jan 23 20:11:29 kryton kernel:  [<c01670ce>] mpage_readpages+0x12e/0x160
Jan 23 20:11:29 kryton kernel:  [<c0185e00>] reiserfs_get_block+0x0/0x14c0
Jan 23 20:11:29 kryton kernel:  [<c02cd13a>] sock_sendmsg+0xda/0x100
Jan 23 20:11:29 kryton kernel:  [<c0131432>] read_pages+0x132/0x140
Jan 23 20:11:29 kryton kernel:  [<c0185e00>] reiserfs_get_block+0x0/0x14c0
Jan 23 20:11:29 kryton kernel:  [<c012e8e4>] __alloc_pages+0x1d4/0x370
Jan 23 20:11:29 kryton kernel:  [<c013169f>] do_page_cache_readahead+0xcf/0x140
Jan 23 20:11:29 kryton kernel:  [<c013180a>] page_cache_readahead+0xfa/0x1f0
Jan 23 20:11:29 kryton kernel:  [<c012aa82>] do_generic_mapping_read+0xd2/0x440
Jan 23 20:11:29 kryton kernel:  [<c0146277>] do_readv_writev+0x1f7/0x280
Jan 23 20:11:29 kryton kernel:  [<c012b32e>] generic_file_sendfile+0x5e/0x70
Jan 23 20:11:29 kryton kernel:  [<c012b250>] file_send_actor+0x0/0x80
Jan 23 20:11:29 kryton kernel:  [<c01466dd>] do_sendfile+0x1fd/0x2f0
Jan 23 20:11:29 kryton kernel:  [<c012b250>] file_send_actor+0x0/0x80
Jan 23 20:11:29 kryton kernel:  [<c014682f>] sys_sendfile+0x5f/0xc0
Jan 23 20:11:29 kryton kernel:  [<c01022d3>] syscall_call+0x7/0xb
Jan 23 20:11:29 kryton kernel: Code: 00 00 00 e8 a9 fe 00 00 8b 44 24 3c 0f b7 40 16 66 89 44 24 26 b8 0f 00 00 00 8d b4 26 00 00 00 00 89 c1 99 83 f1 02 09 d1 74 08 <0f> 0b 65 01 36 f8 39 c0 66 83 7c 24 26 00 0f 85 86 02 00 00 8b 

[...]

Jan 23 20:25:18 kryton kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Jan 23 20:25:53 kryton kernel: ------------[ cut here ]------------
Jan 23 20:25:53 kryton kernel: kernel BUG at mm/rmap.c:483!
Jan 23 20:25:53 kryton kernel: invalid operand: 0000 [#1]
Jan 23 20:25:53 kryton kernel: CPU:    0
Jan 23 20:25:53 kryton kernel: EIP:    0060:[<c013da28>]    Not tainted VLI
Jan 23 20:25:53 kryton kernel: EFLAGS: 00010286   (2.6.10-ac8-wp2ac) 
Jan 23 20:25:53 kryton kernel: EIP is at page_remove_rmap+0x28/0x40
Jan 23 20:25:53 kryton kernel: eax: ffffffff   ebx: c1f43e20   ecx: 5b069045   edx: c1b60d20
Jan 23 20:25:53 kryton kernel: esi: f5adce04   edi: 00000004   ebp: c1b60d20   esp: f5afbe90
Jan 23 20:25:53 kryton kernel: ds: 007b   es: 007b   ss: 0068
Jan 23 20:25:53 kryton kernel: Process httpd (pid: 421, threadinfo=f5afa000 task=f5ab1500)
Jan 23 20:25:53 kryton kernel: Stack: c0138438 c1b60d20 00000004 00000e04 ffff9000 ffffa000 c1f43e20 f5ace0ac 
Jan 23 20:25:53 kryton kernel:        0af811b4 f5a99800 00000001 c01391ca f5a99800 f5acb4bc 0af811b4 f5adce04 
Jan 23 20:25:53 kryton kernel:        f5ace0ac 5b069045 f5afbee8 f5a99800 f5a9982c f5acb4bc f5ab1500 c010d6ec 
Jan 23 20:25:53 kryton kernel: Call Trace:
Jan 23 20:25:53 kryton kernel:  [<c0138438>] do_wp_page+0x238/0x320
Jan 23 20:25:53 kryton kernel:  [<c01391ca>] handle_mm_fault+0x13a/0x150
Jan 23 20:25:53 kryton kernel:  [<c010d6ec>] do_page_fault+0x18c/0x5c5
Jan 23 20:25:53 kryton kernel:  [<c013bbcd>] __do_brk+0x1ad/0x280
Jan 23 20:25:53 kryton kernel:  [<c0139e5e>] sys_brk+0xee/0x120
Jan 23 20:25:53 kryton kernel:  [<c010d560>] do_page_fault+0x0/0x5c5
Jan 23 20:25:53 kryton kernel:  [<c010247b>] error_code+0x2b/0x30
Jan 23 20:25:53 kryton kernel: Code: 74 26 00 8b 54 24 04 8b 02 f6 c4 08 75 27 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 0c 9c 58 fa ff 0d 50 a1 4a c0 50 9d c3 <0f> 0b e3 01 b7 dd 39 c0 eb ea 0f 0b e0 01 b7 dd 39 c0 eb cf 8d 
Jan 23 20:25:53 kryton kernel:  ------------[ cut here ]------------
Jan 23 20:25:53 kryton kernel: kernel BUG at mm/rmap.c:483!
Jan 23 20:25:53 kryton kernel: invalid operand: 0000 [#2]
Jan 23 20:25:53 kryton kernel: CPU:    0
Jan 23 20:25:53 kryton kernel: EIP:    0060:[<c013da28>]    Not tainted VLI
Jan 23 20:25:53 kryton kernel: EFLAGS: 00010286   (2.6.10-ac8-wp2ac) 
Jan 23 20:25:53 kryton kernel: EIP is at page_remove_rmap+0x28/0x40
Jan 23 20:25:53 kryton kernel: eax: ffffffff   ebx: 00001000   ecx: c1b29de0   edx: c1b29de0
Jan 23 20:25:53 kryton kernel: esi: f5adc004   edi: c1b29de0   ebp: 00048000   esp: f5afbc38
Jan 23 20:25:53 kryton kernel: ds: 007b   es: 007b   ss: 0068
Jan 23 20:25:53 kryton kernel: Process httpd (pid: 421, threadinfo=f5afa000 task=f5ab1500)
Jan 23 20:25:53 kryton kernel: Stack: c01375d9 c1b29de0 f5afbc68 c0111878 f7488580 594ef045 0b000000 f5ace0b0 
Jan 23 20:25:53 kryton kernel:        0ac48000 00000000 c0137753 c049c014 f5ace0ac 0ac00000 00048000 00000000 
Jan 23 20:25:53 kryton kernel:        c049c014 0ac00000 f5ace0b0 0ac48000 00000000 c01377c3 c049c014 f5ace0ac 
Jan 23 20:25:53 kryton kernel: Call Trace:
Jan 23 20:25:53 kryton kernel:  [<c01375d9>] zap_pte_range+0x149/0x260
Jan 23 20:25:53 kryton kernel:  [<c0111878>] recalc_task_prio+0xa8/0x1a0
Jan 23 20:25:53 kryton kernel:  [<c0137753>] zap_pmd_range+0x63/0x80
Jan 23 20:25:53 kryton kernel:  [<c01377c3>] unmap_page_range+0x53/0x80
Jan 23 20:25:53 kryton kernel:  [<c01378f6>] unmap_vmas+0x106/0x1c0
Jan 23 20:25:53 kryton kernel:  [<c013bd82>] exit_mmap+0x72/0x140
Jan 23 20:25:53 kryton kernel:  [<c011333f>] mmput+0x2f/0x80
Jan 23 20:25:53 kryton kernel:  [<c0116fc7>] do_exit+0x137/0x320
Jan 23 20:25:53 kryton kernel:  [<c0102f90>] do_invalid_op+0x0/0xd0
Jan 23 20:25:53 kryton kernel:  [<c0102bbe>] die+0x14e/0x150
Jan 23 20:25:53 kryton kernel:  [<c0103042>] do_invalid_op+0xb2/0xd0
Jan 23 20:25:53 kryton kernel:  [<c03278f0>] ip_nat_fn+0x80/0x240
Jan 23 20:25:53 kryton kernel:  [<c013da28>] page_remove_rmap+0x28/0x40
Jan 23 20:25:53 kryton kernel:  [<c012e401>] __rmqueue+0xd1/0x110
Jan 23 20:25:53 kryton kernel:  [<c012e670>] buffered_rmqueue+0xc0/0x160
Jan 23 20:25:53 kryton kernel:  [<c012e8e4>] __alloc_pages+0x1d4/0x370
Jan 23 20:25:53 kryton kernel:  [<c010247b>] error_code+0x2b/0x30
Jan 23 20:25:53 kryton kernel:  [<c013da28>] page_remove_rmap+0x28/0x40
Jan 23 20:25:53 kryton kernel:  [<c0138438>] do_wp_page+0x238/0x320
Jan 23 20:25:53 kryton kernel:  [<c01391ca>] handle_mm_fault+0x13a/0x150
Jan 23 20:25:53 kryton kernel:  [<c010d6ec>] do_page_fault+0x18c/0x5c5
Jan 23 20:25:53 kryton kernel:  [<c013bbcd>] __do_brk+0x1ad/0x280
Jan 23 20:25:53 kryton kernel:  [<c0139e5e>] sys_brk+0xee/0x120
Jan 23 20:25:53 kryton kernel:  [<c010d560>] do_page_fault+0x0/0x5c5
Jan 23 20:25:53 kryton kernel:  [<c010247b>] error_code+0x2b/0x30
Jan 23 20:25:53 kryton kernel: Code: 74 26 00 8b 54 24 04 8b 02 f6 c4 08 75 27 83 42 08 ff 0f 98 c0 84 c0 74 11 8b 42 08 40 78 0c 9c 58 fa ff 0d 50 a1 4a c0 50 9d c3 <0f> 0b e3 01 b7 dd 39 c0 eb ea 0f 0b e0 01 b7 dd 39 c0 eb cf 8d 
Jan 23 20:26:14 kryton kernel:  <6>input: AT Translated Set 2 keyboard on isa0060/serio0
Jan 23 20:29:15 kryton kernel: Bad page state at prep_new_page (in process 'httpd', page c1b29de0)
Jan 23 20:29:15 kryton kernel: flags:0x40000110 mapping:00000000 mapcount:-1 count:0
Jan 23 20:29:15 kryton kernel: Backtrace:
Jan 23 20:29:15 kryton kernel:  [<c012df95>] bad_page+0x75/0xb0
Jan 23 20:29:15 kryton kernel:  [<c012e310>] prep_new_page+0x40/0x60
Jan 23 20:29:15 kryton kernel:  [<c012e670>] buffered_rmqueue+0xc0/0x160
Jan 23 20:29:15 kryton kernel:  [<c012ea5e>] __alloc_pages+0x34e/0x370
Jan 23 20:29:15 kryton kernel:  [<c012b719>] filemap_nopage+0x1c9/0x340
Jan 23 20:29:15 kryton kernel:  [<c0138ea7>] do_no_page+0x207/0x2f0
Jan 23 20:29:15 kryton kernel:  [<c02ea009>] ip_rcv_finish+0x1b9/0x230
Jan 23 20:29:15 kryton kernel:  [<c0139170>] handle_mm_fault+0xe0/0x150
Jan 23 20:29:15 kryton kernel:  [<c010d6ec>] do_page_fault+0x18c/0x5c5
Jan 23 20:29:15 kryton kernel:  [<c011cdf4>] update_process_times+0x44/0x50
Jan 23 20:29:15 kryton kernel:  [<c0106174>] timer_interrupt+0x54/0xf0
Jan 23 20:29:15 kryton kernel:  [<c01290c0>] handle_IRQ_event+0x30/0x70
Jan 23 20:29:15 kryton kernel:  [<c011929b>] __do_softirq+0x7b/0x90
Jan 23 20:29:15 kryton kernel:  [<c010d560>] do_page_fault+0x0/0x5c5
Jan 23 20:29:15 kryton kernel:  [<c010247b>] error_code+0x2b/0x30
Jan 23 20:29:15 kryton kernel: Trying to fix it up, but a reboot is needed

--------------080900010207040308010209
Content-Type: text/plain;
 name="config-2.6.10-ac8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6.10-ac8"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.10-ac8
# Mon Jan 10 13:04:48 2005
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION="-wp2ac"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
# CONFIG_KOBJECT_UEVENT is not set
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_HZ=1000
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_AHCI=y
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_NV is not set
CONFIG_SCSI_SATA_PROMISE=y
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID5=y
# CONFIG_MD_RAID6 is not set
CONFIG_MD_MULTIPATH=y
# CONFIG_MD_FAULTY is not set
# CONFIG_BLK_DEV_DM is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y
CONFIG_IP_TCPDIAG=y
CONFIG_IP_TCPDIAG_IPV6=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_INET6_IPCOMP=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_TUNNEL=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CONNTRACK_MARK is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
# CONFIG_IP_NF_MATCH_TOS is not set
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
# CONFIG_IP_NF_MATCH_OWNER is not set
# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
# CONFIG_IP_NF_MATCH_REALM is not set
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
# CONFIG_IP_NF_MATCH_HASHLIMIT is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
# CONFIG_IP_NF_TARGET_SAME is not set
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_MATCH_OPTS=y
CONFIG_IP6_NF_MATCH_FRAG=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_MULTIPORT=y
# CONFIG_IP6_NF_MATCH_OWNER is not set
CONFIG_IP6_NF_MATCH_MARK=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_AHESP=y
# CONFIG_IP6_NF_MATCH_LENGTH is not set
CONFIG_IP6_NF_MATCH_EUI64=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y
# CONFIG_IP6_NF_RAW is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=y
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=y
CONFIG_WINBOND_840=y
CONFIG_DM9102=y
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
CONFIG_E100_NAPI=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
CONFIG_E1000_NAPI=y
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_4KSTACKS is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------080900010207040308010209--
