Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTE3QJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTE3QJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:09:31 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:640 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S263771AbTE3QId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:08:33 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/slab.c:1549
Date: Fri, 30 May 2003 18:23:18 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2V41+ySjJFxTfin"
Message-Id: <200305301823.18586.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_2V41+ySjJFxTfin
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



Here I am back again with 2.5.70,

with 2.5.69 I had always crashes without syslogs between 4:00 AM  and 5:00 AM,
(maybe crontabs checks)
this time I had the system always running in the morning with 2.5.70 with this 
in syslog :
(I was sleeping at 4:00 AM, so nothing special else ... using stranges modules 
or so)

Regards.

Nicolas.

May 30 04:52:06 hal9003 kernel: ------------[ cut here ]------------
May 30 04:52:06 hal9003 kernel: kernel BUG at mm/slab.c:1549!
May 30 04:52:06 hal9003 kernel: invalid operand: 0000 [#1]
May 30 04:52:06 hal9003 kernel: CPU:    0
May 30 04:52:06 hal9003 kernel: EIP:    0060:[kmem_cache_free+604/694]    Not 
tainted
May 30 04:52:06 hal9003 kernel: EIP:    0060:[<c0138d61>]    Not tainted
May 30 04:52:06 hal9003 kernel: EFLAGS: 00013087
May 30 04:52:06 hal9003 kernel: EIP is at kmem_cache_free+0x25c/0x2b6
May 30 04:52:06 hal9003 kernel: eax: c18764c8   ebx: 008764c8   ecx: f7ffc318   
edx: f7ffdd4c
May 30 04:52:06 hal9003 kernel: esi: 000000b4   edi: f62858f4   ebp: f61fddd0   
esp: f61fdda8
May 30 04:52:06 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
May 30 04:52:06 hal9003 kernel: Process X (pid: 1189, threadinfo=f61fc000 
task=f63cf380)
May 30 04:52:06 hal9003 kernel: Stack: c9cc4000 0000006b 00004000 c022d925 
c022d936 f7ff85c0 00003292 f62858f4
May 30 04:52:06 hal9003 kernel:        00000000 f62858f4 f61fdde4 c022d936 
f7ffdd4c f62858f4 00000000 f61fddfc
May 30 04:52:06 hal9003 kernel:        c022d9be f62858f4 00002f00 00000000 
f62858f4 f61fde74 c027e669 f62858f4
May 30 04:52:06 hal9003 kernel: Call Trace:
May 30 04:52:06 hal9003 kernel:  [kfree_skbmem+20/44] kfree_skbmem+0x14/0x2c
May 30 04:52:06 hal9003 kernel:  [<c022d925>] kfree_skbmem+0x14/0x2c
May 30 04:52:06 hal9003 kernel:  [kfree_skbmem+37/44] kfree_skbmem+0x25/0x2c
May 30 04:52:06 hal9003 kernel:  [<c022d936>] kfree_skbmem+0x25/0x2c
May 30 04:52:06 hal9003 kernel:  [kfree_skbmem+37/44] kfree_skbmem+0x25/0x2c
May 30 04:52:06 hal9003 kernel:  [<c022d936>] kfree_skbmem+0x25/0x2c
May 30 04:52:06 hal9003 kernel:  [__kfree_skb+129/246] __kfree_skb+0x81/0xf6
May 30 04:52:06 hal9003 kernel:  [<c022d9be>] __kfree_skb+0x81/0xf6
May 30 04:52:06 hal9003 kernel:  [unix_stream_recvmsg+564/1170] 
unix_stream_recvmsg+0x234/0x492
May 30 04:52:06 hal9003 kernel:  [<c027e669>] unix_stream_recvmsg+0x234/0x492
May 30 04:52:06 hal9003 kernel:  [normal_poll+260/341] normal_poll+0x104/0x155
May 30 04:52:06 hal9003 kernel:  [<c01e6c58>] normal_poll+0x104/0x155
May 30 04:52:06 hal9003 kernel:  [sock_aio_read+204/211] 
sock_aio_read+0xcc/0xd3
May 30 04:52:06 hal9003 kernel:  [<c022a5f1>] sock_aio_read+0xcc/0xd3
May 30 04:52:06 hal9003 kernel:  [do_sync_read+137/180] do_sync_read+0x89/0xb4
May 30 04:52:06 hal9003 kernel:  [<c014a243>] do_sync_read+0x89/0xb4
May 30 04:52:06 hal9003 kernel:  [do_setitimer+332/373] 
do_setitimer+0x14c/0x175
May 30 04:52:06 hal9003 kernel:  [<c011f1bc>] do_setitimer+0x14c/0x175
May 30 04:52:06 hal9003 kernel:  [vfs_read+233/281] vfs_read+0xe9/0x119
May 30 04:52:06 hal9003 kernel:  [<c014a357>] vfs_read+0xe9/0x119
May 30 04:52:06 hal9003 kernel:  [sys_read+63/93] sys_read+0x3f/0x5d
May 30 04:52:06 hal9003 kernel:  [<c014a593>] sys_read+0x3f/0x5d
May 30 04:52:06 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 30 04:52:06 hal9003 kernel:  [<c0108fab>] syscall_call+0x7/0xb
May 30 04:52:06 hal9003 kernel:
May 30 04:52:06 hal9003 kernel: Code: 0f 0b 0d 06 1b ed 29 c0 e9 06 fe ff ff 
89 7c 24 04 c7 04 24


May 30 09:05:00 hal9003 kernel: Bad page state at free_hot_cold_page
May 30 09:05:00 hal9003 kernel: flags:0x02000100 mapping:00000000 mapped:1 
count:0
May 30 09:05:00 hal9003 kernel: Backtrace:
May 30 09:05:00 hal9003 kernel: Call Trace:
May 30 09:05:00 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
May 30 09:05:00 hal9003 kernel:  [<c0134c5f>] bad_page+0x5d/0x84
May 30 09:05:00 hal9003 kernel:  [free_hot_cold_page+84/219] 
free_hot_cold_page+0x54/0xdb
May 30 09:05:00 hal9003 kernel:  [<c01351f3>] free_hot_cold_page+0x54/0xdb
May 30 09:05:00 hal9003 kernel:  [zap_pte_range+336/409] 
zap_pte_range+0x150/0x199
May 30 09:05:00 hal9003 kernel:  [<c013d0bb>] zap_pte_range+0x150/0x199
May 30 09:05:00 hal9003 kernel:  [generic_file_read+144/167] 
generic_file_read+0x90/0xa7
May 30 09:05:00 hal9003 kernel:  [<c0132921>] generic_file_read+0x90/0xa7
May 30 09:05:00 hal9003 kernel:  [zap_pmd_range+75/103] 
zap_pmd_range+0x4b/0x67
May 30 09:05:00 hal9003 kernel:  [<c013d14f>] zap_pmd_range+0x4b/0x67
May 30 09:05:00 hal9003 kernel:  [unmap_page_range+65/103] 
unmap_page_range+0x41/0x67
May 30 09:05:00 hal9003 kernel:  [<c013d1ac>] unmap_page_range+0x41/0x67
May 30 09:05:00 hal9003 kernel:  [unmap_vmas+203/532] unmap_vmas+0xcb/0x214
May 30 09:05:00 hal9003 kernel:  [<c013d29d>] unmap_vmas+0xcb/0x214
May 30 09:05:00 hal9003 kernel:  [exit_mmap+110/361] exit_mmap+0x6e/0x169
May 30 09:05:00 hal9003 kernel:  [<c0140a02>] exit_mmap+0x6e/0x169
May 30 09:05:00 hal9003 kernel:  [mmput+62/128] mmput+0x3e/0x80
May 30 09:05:00 hal9003 kernel:  [<c011b0c4>] mmput+0x3e/0x80
May 30 09:05:00 hal9003 kernel:  [do_exit+241/773] do_exit+0xf1/0x305
May 30 09:05:00 hal9003 kernel:  [<c011e55f>] do_exit+0xf1/0x305
May 30 09:05:00 hal9003 kernel:  [do_group_exit+82/114] 
do_group_exit+0x52/0x72
May 30 09:05:00 hal9003 kernel:  [<c011e819>] do_group_exit+0x52/0x72
May 30 09:05:00 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 30 09:05:00 hal9003 kernel:  [<c0108fab>] syscall_call+0x7/0xb
May 30 09:05:00 hal9003 kernel:
May 30 09:05:00 hal9003 kernel: Trying to fix it up, but a reboot is needed
May 30 09:05:00 hal9003 kernel: Bad page state at prep_new_page
May 30 09:05:00 hal9003 kernel: flags:0x02000100 mapping:00000000 mapped:1 
count:0
May 30 09:05:00 hal9003 kernel: Backtrace:
May 30 09:05:00 hal9003 kernel: Call Trace:
May 30 09:05:00 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
May 30 09:05:00 hal9003 kernel:  [<c0134c5f>] bad_page+0x5d/0x84
May 30 09:05:00 hal9003 kernel:  [prep_new_page+51/74] prep_new_page+0x33/0x4a
May 30 09:05:00 hal9003 kernel:  [<c0134f09>] prep_new_page+0x33/0x4a
May 30 09:05:00 hal9003 kernel:  [buffered_rmqueue+147/252] 
buffered_rmqueue+0x93/0xfc
May 30 09:05:00 hal9003 kernel:  [<c0135326>] buffered_rmqueue+0x93/0xfc
May 30 09:05:00 hal9003 kernel:  [__alloc_pages+131/770] 
__alloc_pages+0x83/0x302
May 30 09:05:00 hal9003 kernel:  [<c0135412>] __alloc_pages+0x83/0x302
May 30 09:05:00 hal9003 kernel:  [generic_file_aio_write_nolock+719/2586] 
generic_file_aio_write_nolock+0x2cf/0xa1a
May 30 09:05:00 hal9003 kernel:  [<c0133765>] 
generic_file_aio_write_nolock+0x2cf/0xa1a
May 30 09:05:00 hal9003 kernel:  [__copy_to_user_ll+112/116] 
__copy_to_user_ll+0x70/0x74
May 30 09:05:00 hal9003 kernel:  [<c01c213a>] __copy_to_user_ll+0x70/0x74
May 30 09:05:00 hal9003 kernel:  [generic_file_write_nolock+122/145] 
generic_file_write_nolock+0x7a/0x91
May 30 09:05:00 hal9003 kernel:  [<c0133f2a>] 
generic_file_write_nolock+0x7a/0x91
May 30 09:05:00 hal9003 kernel:  [unix_dgram_recvmsg+345/534] 
unix_dgram_recvmsg+0x159/0x216
May 30 09:05:00 hal9003 kernel:  [<c027e28f>] unix_dgram_recvmsg+0x159/0x216
May 30 09:05:00 hal9003 kernel:  [do_con_write+673/1704] 
do_con_write+0x2a1/0x6a8
May 30 09:05:00 hal9003 kernel:  [<c01f2ce9>] do_con_write+0x2a1/0x6a8
May 30 09:05:00 hal9003 kernel:  [sock_recvmsg+153/180] sock_recvmsg+0x99/0xb4
May 30 09:05:00 hal9003 kernel:  [<c022a50a>] sock_recvmsg+0x99/0xb4
May 30 09:05:00 hal9003 kernel:  [buffered_rmqueue+147/252] 
buffered_rmqueue+0x93/0xfc
May 30 09:05:00 hal9003 kernel:  [<c0135326>] buffered_rmqueue+0x93/0xfc
May 30 09:05:00 hal9003 kernel:  [generic_file_write+85/106] 
generic_file_write+0x55/0x6a
May 30 09:05:00 hal9003 kernel:  [<c0134024>] generic_file_write+0x55/0x6a
May 30 09:05:00 hal9003 kernel:  [reiserfs_file_write+82/1468] 
reiserfs_file_write+0x52/0x5bc
May 30 09:05:00 hal9003 kernel:  [<c01a090b>] reiserfs_file_write+0x52/0x5bc
May 30 09:05:00 hal9003 kernel:  [__get_free_pages+53/64] 
__get_free_pages+0x35/0x40
May 30 09:05:00 hal9003 kernel:  [<c01356c6>] __get_free_pages+0x35/0x40
May 30 09:05:00 hal9003 kernel:  [sockfd_lookup+26/114] 
sockfd_lookup+0x1a/0x72
May 30 09:05:00 hal9003 kernel:  [<c022a27f>] sockfd_lookup+0x1a/0x72
May 30 09:05:00 hal9003 kernel:  [sys_recvfrom+212/237] sys_recvfrom+0xd4/0xed
May 30 09:05:00 hal9003 kernel:  [<c022b7a9>] sys_recvfrom+0xd4/0xed
May 30 09:05:00 hal9003 kernel:  [do_readv_writev+459/651] 
do_readv_writev+0x1cb/0x28b
May 30 09:05:00 hal9003 kernel:  [<c014a8f9>] do_readv_writev+0x1cb/0x28b
May 30 09:05:00 hal9003 kernel:  [reiserfs_file_write+0/1468] 
reiserfs_file_write+0x0/0x5bc
May 30 09:05:00 hal9003 kernel:  [<c01a08b9>] reiserfs_file_write+0x0/0x5bc
May 30 09:05:00 hal9003 kernel:  [vfs_writev+95/99] vfs_writev+0x5f/0x63
May 30 09:05:00 hal9003 kernel:  [<c014aa7b>] vfs_writev+0x5f/0x63
May 30 09:05:00 hal9003 kernel:  [sys_writev+63/93] sys_writev+0x3f/0x5d
May 30 09:05:00 hal9003 kernel:  [<c014ab1b>] sys_writev+0x3f/0x5d
May 30 09:05:00 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 30 09:05:00 hal9003 kernel:  [<c0108fab>] syscall_call+0x7/0xb
May 30 09:05:00 hal9003 kernel:
May 30 09:05:00 hal9003 kernel: Trying to fix it up, but a reboot is needed



May 30 11:49:21 hal9003 kernel: Unable to handle kernel paging request at 
virtual address 9d37f5e0
May 30 11:49:21 hal9003 kernel:  printing eip:
May 30 11:49:21 hal9003 kernel: c0138230
May 30 11:49:21 hal9003 kernel: *pde = 00000000
May 30 11:49:21 hal9003 kernel: Oops: 0000 [#2]
May 30 11:49:21 hal9003 kernel: CPU:    0
May 30 11:49:21 hal9003 kernel: EIP:    0060:[cache_alloc_refill+149/616]    
Not tainted
May 30 11:49:21 hal9003 kernel: EIP:    0060:[<c0138230>]    Not tainted
May 30 11:49:21 hal9003 kernel: EFLAGS: 00010097
May 30 11:49:21 hal9003 kernel: EIP is at cache_alloc_refill+0x95/0x268
May 30 11:49:21 hal9003 kernel: eax: 74636572   ebx: cbaa6000   ecx: 00000004   
edx: 0000000e
May 30 11:49:21 hal9003 kernel: esi: cbaa6018   edi: 0000000e   ebp: c6545e94   
esp: c6545e6c
May 30 11:49:21 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
May 30 11:49:21 hal9003 kernel: Process smtpd (pid: 31285, threadinfo=c6544000 
task=efeba080)
May 30 11:49:21 hal9003 kernel: Stack: d59a1524 00000002 f7ffd398 f7ff8e30 
f7ffd3a0 f7ff8e20 00000009 00000000
May 30 11:49:21 hal9003 kernel:        f7ffd38c 00000246 c6545ebc c0138974 
f7ffd38c 000000d0 ffffffff 00000005
May 30 11:49:21 hal9003 kernel:        00000000 00000000 c4e7183c c6545f19 
c6545ef4 c015e32b f7ffd38c 000000d0
May 30 11:49:21 hal9003 kernel: Call Trace:
May 30 11:49:21 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
May 30 11:49:21 hal9003 kernel:  [<c0138974>] kmem_cache_alloc+0x13d/0x144
May 30 11:49:21 hal9003 kernel:  [d_alloc+30/438] d_alloc+0x1e/0x1b6
May 30 11:49:21 hal9003 kernel:  [<c015e32b>] d_alloc+0x1e/0x1b6
May 30 11:49:21 hal9003 kernel:  [vsprintf+39/43] vsprintf+0x27/0x2b
May 30 11:49:21 hal9003 kernel:  [<c01bfde6>] vsprintf+0x27/0x2b
May 30 11:49:21 hal9003 kernel:  [sprintf+31/35] sprintf+0x1f/0x23
May 30 11:49:21 hal9003 kernel:  [<c01bfe09>] sprintf+0x1f/0x23
May 30 11:49:21 hal9003 kernel:  [sock_map_fd+134/310] sock_map_fd+0x86/0x136
May 30 11:49:21 hal9003 kernel:  [<c022a1b5>] sock_map_fd+0x86/0x136
May 30 11:49:21 hal9003 kernel:  [unix_create+73/110] unix_create+0x49/0x6e
May 30 11:49:21 hal9003 kernel:  [<c027ca81>] unix_create+0x49/0x6e
May 30 11:49:21 hal9003 kernel:  [sys_socket+58/86] sys_socket+0x3a/0x56
May 30 11:49:21 hal9003 kernel:  [<c022b023>] sys_socket+0x3a/0x56
May 30 11:49:21 hal9003 kernel:  [sys_socketcall+114/610] 
sys_socketcall+0x72/0x262
May 30 11:49:21 hal9003 kernel:  [<c022bec6>] sys_socketcall+0x72/0x262
May 30 11:49:21 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 30 11:49:21 hal9003 kernel:  [<c0108fab>] syscall_call+0x7/0xb
May 30 11:49:21 hal9003 kernel:
May 30 11:49:21 hal9003 kernel: Code: 8b 04 86 83 f8 ff 75 ed 8b 7b 10 89 d0 
29 f8 39 c1 0f 85 5c
May 30 11:49:29 hal9003 kernel:  <1>Unable to handle kernel paging request at 
virtual address 9d37f5e0
May 30 11:49:29 hal9003 kernel:  printing eip:
May 30 11:49:29 hal9003 kernel: c0138230
May 30 11:49:29 hal9003 kernel: *pde = 00000000
May 30 11:49:29 hal9003 kernel: Oops: 0000 [#3]
May 30 11:49:29 hal9003 kernel: CPU:    0
May 30 11:49:29 hal9003 kernel: EIP:    0060:[cache_alloc_refill+149/616]    
Not tainted
May 30 11:49:29 hal9003 kernel: EIP:    0060:[<c0138230>]    Not tainted
May 30 11:49:29 hal9003 kernel: EFLAGS: 00010097
May 30 11:49:29 hal9003 kernel: EIP is at cache_alloc_refill+0x95/0x268
May 30 11:49:29 hal9003 kernel: eax: 74636572   ebx: cbaa6000   ecx: 00000004   
edx: 0000000e
May 30 11:49:29 hal9003 kernel: esi: cbaa6018   edi: f7ff8e20   ebp: f5385e48   
esp: f5385e20
May 30 11:49:29 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
May 30 11:49:29 hal9003 kernel: Process squid (pid: 1896, threadinfo=f5384000 
task=f540b280)
May 30 11:49:29 hal9003 kernel: Stack: 00000003 00000003 f7ffd398 c122d490 
f7ffd3a0 f7ff8e20 00000010 fffffff4
May 30 11:49:29 hal9003 kernel:        f7ffd38c 00000246 f5385e70 c0138974 
f7ffd38c 000000d0 f5385e80 c0134024
May 30 11:49:29 hal9003 kernel:        f53dc5a8 fffffff4 e7741ec8 e7741e60 
f5385ea8 c015e32b f7ffd38c 000000d0
May 30 11:49:29 hal9003 kernel: Call Trace:
May 30 11:49:29 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
May 30 11:49:29 hal9003 kernel:  [<c0138974>] kmem_cache_alloc+0x13d/0x144
May 30 11:49:29 hal9003 kernel:  [generic_file_write+85/106] 
generic_file_write+0x55/0x6a
May 30 11:49:29 hal9003 kernel:  [<c0134024>] generic_file_write+0x55/0x6a
May 30 11:49:29 hal9003 kernel:  [d_alloc+30/438] d_alloc+0x1e/0x1b6
May 30 11:49:29 hal9003 kernel:  [<c015e32b>] d_alloc+0x1e/0x1b6
May 30 11:49:29 hal9003 kernel:  [d_lookup+35/68] d_lookup+0x23/0x44
May 30 11:49:29 hal9003 kernel:  [<c015e796>] d_lookup+0x23/0x44
May 30 11:49:29 hal9003 kernel:  [real_lookup+164/225] real_lookup+0xa4/0xe1
May 30 11:49:29 hal9003 kernel:  [<c0155990>] real_lookup+0xa4/0xe1
May 30 11:49:29 hal9003 kernel:  [do_lookup+141/152] do_lookup+0x8d/0x98
May 30 11:49:29 hal9003 kernel:  [<c0155beb>] do_lookup+0x8d/0x98
May 30 11:49:29 hal9003 kernel:  [link_path_walk+827/1579] 
link_path_walk+0x33b/0x62b
May 30 11:49:29 hal9003 kernel:  [<c0155f31>] link_path_walk+0x33b/0x62b
May 30 11:49:29 hal9003 kernel:  [open_namei+118/991] open_namei+0x76/0x3df
May 30 11:49:29 hal9003 kernel:  [<c0156a84>] open_namei+0x76/0x3df
May 30 11:49:29 hal9003 kernel:  [sys_poll+474/560] sys_poll+0x1da/0x230
May 30 11:49:29 hal9003 kernel:  [<c015adf6>] sys_poll+0x1da/0x230
May 30 11:49:29 hal9003 kernel:  [filp_open+65/100] filp_open+0x41/0x64
May 30 11:49:29 hal9003 kernel:  [<c01497a6>] filp_open+0x41/0x64
May 30 11:49:29 hal9003 kernel:  [getname+140/186] getname+0x8c/0xba
May 30 11:49:29 hal9003 kernel:  [<c0155648>] getname+0x8c/0xba
May 30 11:49:29 hal9003 kernel:  [sys_open+85/133] sys_open+0x55/0x85
May 30 11:49:29 hal9003 kernel:  [<c0149b84>] sys_open+0x55/0x85
May 30 11:49:29 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 30 11:49:29 hal9003 kernel:  [<c0108fab>] syscall_call+0x7/0xb
May 30 11:49:29 hal9003 kernel:
May 30 11:49:29 hal9003 kernel: Code: 8b 04 86 83 f8 ff 75 ed 8b 7b 10 89 d0 
29 f8 39 c1 0f 85 5c

[root@hal9003 npa]# lsmod
Module                  Size  Used by
lp                      8544  0
sis900                 15236  0
crc32                   4096  1 sis900
e100                   54404  0
ide_scsi               12544  0
sg                     29836  0
scsi_mod               93596  2 ide_scsi,sg
i2c_sis96x              3968  0
ide_cd                 36864  0
cdrom                  32288  1 ide_cd
des                    11392  0
af_key                 25096  0
ah                      5888  0
md5                     3712  0
ov511                  88604  0
button                  4884  0
ac                      3592  0
thermal                11144  0
fan                     3080  0
processor              11544  1 thermal
usblp                  11264  0
nfsd                   88624  0
exportfs                4864  1 nfsd
ehci_hcd               34048  0
ohci_hcd               30464  0
usbcore                97364  6 ov511,usblp,ehci_hcd,ohci_hcd
udf                    91396  0
parport_pc             22680  1
parport                34880  2 lp,parport_pc
i2c_dev                 7680  0
ipt_state               1536  3
ipt_ULOG                5512  0
ipt_LOG                 4736  7
iptable_filter          2304  1
iptable_mangle          2304  0
ipt_MASQUERADE          3072  1
iptable_nat            18836  2 ipt_MASQUERADE
ip_conntrack           23828  3 ipt_state,ipt_MASQUERADE,iptable_nat
ip_tables              13952  7 
ipt_state,ipt_ULOG,ipt_LOG,iptable_filter,iptable_mangle,ipt_MASQUERADE,iptable_nat
loop                   12680  6
isofs                  30136  3
zlib_inflate           20864  1 isofs
tuner                  14340  0
saa7134                82060  0
video_buf              16256  1 saa7134
v4l1_compat            13312  1 saa7134
i2c_core               19588  4 i2c_sis96x,i2c_dev,tuner,saa7134
v4l2_common             3968  1 saa7134
videodev                8320  2 ov511,saa7134
i810_audio             25088  0
ac97_codec             13440  1 i810_audio
ohci1394               33024  0
ieee1394               66572  1 ohci1394
ntfs                   83984  0
af_packet              11656  4


--Boundary-00=_2V41+ySjJFxTfin
Content-Type: text/plain;
  charset="us-ascii";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
# CONFIG_EMBEDDED is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_TOSHIBA=m
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y

#
# ACPI Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=m
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_TABLE=m

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP=m
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDE_TCQ=y
# CONFIG_BLK_DEV_IDE_TCQ_DEFAULT is not set
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=8
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
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
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=m
# CONFIG_NETFILTER is not set
CONFIG_UNIX=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=m
# CONFIG_IPV6 is not set
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
CONFIG_PCMCIA_XIRCOM=m
CONFIG_PCMCIA_XIRTULIP=m
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# Old SIR device drivers
#
# CONFIG_IRTTY_OLD is not set
CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
# CONFIG_USB_IRDA is not set
# CONFIG_NSC_FIR is not set
# CONFIG_WINBOND_FIR is not set
CONFIG_TOSHIBA_OLD=m
CONFIG_TOSHIBA_FIR=m
# CONFIG_SMC_IRCC_OLD is not set
# CONFIG_SMC_IRCC_FIR is not set
# CONFIG_ALI_FIR is not set
# CONFIG_VLSI_FIR is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

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
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
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
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

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
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m

#
# I2C Hardware Sensors Mainboard support
#
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C Hardware Sensors Chip support
#
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
CONFIG_BUSMOUSE=y
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
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
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_DRM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
# CONFIG_VIDEO_PROC_FS is not set

#
# Video Adapters
#
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
# CONFIG_VIDEO_BTCX is not set

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
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
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
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
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=m
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
CONFIG_NLS_CODEPAGE_1250=m
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=m

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_RTCTIMER is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_YMFPCI=m
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
# CONFIG_SOUND_SB is not set
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
CONFIG_SOUND_YMFPCI=m
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# SCSI support is needed for USB Storage
#

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
# CONFIG_USB_SCANNER is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
CONFIG_USB_VICAM=m
# CONFIG_USB_DSBR is not set
CONFIG_USB_IBMCAM=m
CONFIG_USB_KONICAWC=m
CONFIG_USB_OV511=m
CONFIG_USB_PWC=m
CONFIG_USB_SE401=m
CONFIG_USB_STV680=m

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
CONFIG_USB_LCD=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y

--Boundary-00=_2V41+ySjJFxTfin--

