Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280628AbRKGMSv>; Wed, 7 Nov 2001 07:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280683AbRKGMSn>; Wed, 7 Nov 2001 07:18:43 -0500
Received: from sunset.cs.uu.nl ([131.211.80.32]:9379 "HELO mail.cs.uu.nl")
	by vger.kernel.org with SMTP id <S280628AbRKGMS0>;
	Wed, 7 Nov 2001 07:18:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Han-Wen Nienhuys <hanwen@cs.uu.nl>
Reply-To: hanwen@cs.uu.nl
To: linux-kernel@vger.rutgers.edu
Subject: 2.4.14 Oops while reading CD ROM 
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <20011107121844Z280683-17408+11822@vger.kernel.org>
Date: Wed, 7 Nov 2001 07:18:43 -0500




I got random segfaults while trying to cat, copy from and eject a
CD-ROM disc (12:34 in the logs). This is what I found in the
logs. Apparently, something went awry this night (04:02), during the
daily cronjob run.

I think I'll go back to 2.4.13 again.


Nov  7 04:02:35 meddo kernel: Unable to handle kernel paging request at virtual address 00033642
Nov  7 04:02:35 meddo kernel:  printing eip:
Nov  7 04:02:35 meddo kernel: c0133280
Nov  7 04:02:35 meddo kernel: *pde = 00000000
Nov  7 04:02:35 meddo kernel: Oops: 0000
Nov  7 04:02:35 meddo kernel: CPU:    0
Nov  7 04:02:35 meddo kernel: EIP:    0010:[sync_page_buffers+16/176]    Not tainted
Nov  7 04:02:35 meddo kernel: EIP:    0010:[<c0133280>]    Not tainted
Nov  7 04:02:35 meddo kernel: EFLAGS: 00010207
Nov  7 04:02:35 meddo kernel: eax: 00000000   ebx: 0003362a   ecx: 000001d0   edx: 00000002
Nov  7 04:02:35 meddo kernel: esi: 00000000   edi: de9829c0   ebp: c172a8d4   esp: c179bed0
Nov  7 04:02:35 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 04:02:35 meddo kernel: Process kswapd (pid: 5, stackpage=c179b000)
Nov  7 04:02:35 meddo kernel: Stack: c010828c 0000000e 000001d0 c1747efc 0000001e 00000286 00000286 00000003 
Nov  7 04:02:35 meddo kernel:        000001d0 de9829c0 de9829c0 c013335c de9829c0 000001d0 00000207 00000206 
Nov  7 04:02:35 meddo kernel:        c103c02c c02c7ca4 000001d0 c172a8d4 00000005 00002da2 c012a342 c172a8d4 
Nov  7 04:02:35 meddo kernel: Call Trace: [do_IRQ+124/176] [try_to_free_buffers+60/304] [shrink_cache+386/768] [shrink_caches+82/144] [try_to_free_pages+44/80] 
Nov  7 04:02:35 meddo kernel: Call Trace: [<c010828c>] [<c013335c>] [<c012a342>] [<c012a602>] [<c012a66c>] 
Nov  7 04:02:35 meddo kernel:    [kswapd_balance_pgdat+76/176] [kswapd_balance+38/64] [kswapd+157/192] [kswapd+0/192] [_stext+0/48] [kernel_thread+38/48] 
Nov  7 04:02:35 meddo kernel:    [<c012a70c>] [<c012a796>] [<c012a8cd>] [<c012a830>] [<c0105000>] [<c0105506>] 
Nov  7 04:02:35 meddo kernel:    [kswapd+0/192] 
Nov  7 04:02:35 meddo kernel:    [<c012a830>] 
Nov  7 04:02:35 meddo kernel: 
Nov  7 04:02:35 meddo kernel: Code: f7 43 18 06 00 00 00 74 3c b8 07 00 00 00 0f ab 43 18 19 c0 
Nov  7 04:02:36 meddo kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
Nov  7 04:02:36 meddo kernel:  printing eip:
Nov  7 04:02:36 meddo kernel: c0133280
Nov  7 04:02:36 meddo kernel: *pde = 00000000
Nov  7 04:02:36 meddo kernel: Oops: 0000
Nov  7 04:02:36 meddo kernel: CPU:    0
Nov  7 04:02:36 meddo kernel: EIP:    0010:[sync_page_buffers+16/176]    Not tainted
Nov  7 04:02:36 meddo kernel: EIP:    0010:[<c0133280>]    Not tainted
Nov  7 04:02:36 meddo kernel: EFLAGS: 00010207
Nov  7 04:02:36 meddo kernel: eax: de7b2c24   ebx: 00000000   ecx: 000000f0   edx: 00000000
Nov  7 04:02:36 meddo kernel: esi: 00000000   edi: de7b2c00   ebp: c1725a14   esp: c48afac4
Nov  7 04:02:36 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 04:02:36 meddo kernel: Process updatedb (pid: 16578, stackpage=c48af000)
Nov  7 04:02:36 meddo kernel: Stack: c017eaa9 c48afb3c c48afb3c c48afae0 00000282 00000286 00000286 00000003 
Nov  7 04:02:36 meddo kernel:        000000f0 de7b2c00 de7b2c00 c013335c de7b2c00 000000f0 00000001 00000202 
Nov  7 04:02:37 meddo kernel:        c103c02c c02c7ca4 000000f0 c1725a14 0000001b 00002dd6 c012a342 c1725a14 
Nov  7 04:02:37 meddo kernel: Call Trace: [do_balance+185/240] [try_to_free_buffers+60/304] [shrink_cache+386/768] [shrink_caches+82/144] [try_to_free_pages+44/80] 
Nov  7 04:02:37 meddo kernel: Call Trace: [<c017eaa9>] [<c013335c>] [<c012a342>] [<c012a602>] [<c012a66c>] 
Nov  7 04:02:37 meddo kernel:    [balance_classzone+83/416] [__alloc_pages+300/464] [find_or_create_page+96/208] [grow_dev_page+35/160] [grow_buffers+124/224] [getblk+39/64] 
Nov  7 04:02:37 meddo kernel:    [<c012afe3>] [<c012b25c>] [<c01248f0>] [<c0133023>] [<c013320c>] [<c0131887>] 
Nov  7 04:02:37 meddo kernel:    [bread+24/112] [is_tree_node+53/96] [search_by_key+113/1392] [reiserfs_read_inode2+99/192] [is_tree_node+76/96] [get_new_inode+299/352] 
Nov  7 04:02:37 meddo kernel:    [<c0131a58>] [<c018f4f5>] [<c018f591>] [<c0182b93>] [<c018f50c>] [<c0141e3b>] 
Nov  7 04:02:37 meddo kernel:    [linear_search_in_dir_item+389/704] [iget4+194/208] [reiserfs_iget+33/96] [reiserfs_lookup+199/240] [__alloc_pages+232/464] [d_alloc+25/368] 
Nov  7 04:02:37 meddo kernel:    [<c017eff5>] [<c0142022>] [<c0182c11>] [<c017f347>] [<c012b218>] [<c0140459>] 
Nov  7 04:02:37 meddo kernel:    [real_lookup+163/208] [link_path_walk+875/2032] [getname+109/176] [__user_walk+58/80] [sys_lstat64+20/112] [system_call+51/56] 
Nov  7 04:02:37 meddo kernel:    [<c01381e3>] [<c013865b>] [<c0137ebd>] [<c0138e7a>] [<c0135e74>] [<c0106d3b>] 
Nov  7 04:02:37 meddo kernel: 
Nov  7 04:02:37 meddo kernel: Code: f7 43 18 06 00 00 00 74 3c b8 07 00 00 00 0f ab 43 18 19 c0 
Nov  7 04:02:37 meddo kernel:  <7>VFS: Disk change detected on device sr(11,0)
Nov  7 04:02:37 meddo kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000080
Nov  7 04:02:37 meddo kernel:  printing eip:
Nov  7 04:02:37 meddo kernel: c0112a43
Nov  7 04:02:37 meddo kernel: *pde = 00000000
Nov  7 04:02:37 meddo kernel: Oops: 0000
Nov  7 04:02:37 meddo kernel: CPU:    0
Nov  7 04:02:37 meddo kernel: EIP:    0010:[__wake_up+51/176]    Not tainted
Nov  7 04:02:37 meddo kernel: EIP:    0010:[<c0112a43>]    Not tainted
Nov  7 04:02:37 meddo kernel: EFLAGS: 00010006
Nov  7 04:02:37 meddo kernel: eax: c1721980   ebx: c1742644   ecx: 00000080   edx: c1721980
Nov  7 04:02:37 meddo kernel: esi: c1725960   edi: 00000001   ebp: c48afb20   esp: c48afb08
Nov  7 04:02:37 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 04:02:37 meddo kernel: Process tmpwatch (pid: 16585, stackpage=c48af000)
Nov  7 04:02:37 meddo kernel: Stack: 00000286 00000003 c1725984 00000000 c1725960 00000011 00002d9e c012a3b1 
Nov  7 04:02:37 meddo kernel:        00000005 c48ae000 00000100 000000f0 c02c7c84 c1785c24 ce09b0c0 c1785a74 
Nov  7 04:02:37 meddo kernel:        00000001 00000020 000000f0 00000006 00000020 c012a602 00000006 00000009 
Nov  7 04:02:37 meddo kernel: Call Trace: [shrink_cache+497/768] [shrink_caches+82/144] [try_to_free_pages+44/80] [balance_classzone+83/416] [__alloc_pages+300/464] 
Nov  7 04:02:37 meddo kernel: Call Trace: [<c012a3b1>] [<c012a602>] [<c012a66c>] [<c012afe3>] [<c012b25c>] 
Nov  7 04:02:37 meddo kernel:    [find_or_create_page+96/208] [grow_dev_page+35/160] [grow_buffers+124/224] [getblk+39/64] [bread+24/112] [is_tree_node+53/96] 
Nov  7 04:02:37 meddo kernel:    [<c01248f0>] [<c0133023>] [<c013320c>] [<c0131887>] [<c0131a58>] [<c018f4f5>] 
Nov  7 04:02:37 meddo kernel:    [search_by_key+113/1392] [reiserfs_read_inode2+99/192] [is_tree_node+76/96] [get_new_inode+299/352] [linear_search_in_dir_item+389/704] [iget4+194/208] 
Nov  7 04:02:37 meddo kernel:    [<c018f591>] [<c0182b93>] [<c018f50c>] [<c0141e3b>] [<c017eff5>] [<c0142022>] 
Nov  7 04:02:37 meddo kernel:    [reiserfs_iget+33/96] [reiserfs_lookup+199/240] [search_by_entry_key+169/448] [d_alloc+25/368] [real_lookup+163/208] [link_path_walk+875/2032] 
Nov  7 04:02:37 meddo kernel:    [<c0182c11>] [<c017f347>] [<c017eca9>] [<c0140459>] [<c01381e3>] [<c013865b>] 
Nov  7 04:02:37 meddo kernel:    [getname+109/176] [__user_walk+58/80] [sys_lstat64+20/112] [system_call+51/56] 
Nov  7 04:02:37 meddo kernel:    [<c0137ebd>] [<c0138e7a>] [<c0135e74>] [<c0106d3b>] 
Nov  7 04:02:37 meddo kernel: 
Nov  7 04:02:37 meddo kernel: Code: 8b 01 85 45 ec 74 23 31 c0 9c 5e fa c7 01 00 00 00 00 8b 51 
Nov  7 04:02:39 meddo kernel:  <7>VFS: Disk change detected on device sr(11,0)
Nov  7 12:02:39 meddo kernel: smb_get_length: recv error = 5
Nov  7 12:02:39 meddo kernel: smb_trans2_request: result=-5, setting invalid
Nov  7 12:02:42 meddo kernel: smb_retry: successful, new pid=609, generation=6
Nov  7 12:28:21 meddo modprobe: modprobe: Can't locate module nls_iso8859-1
Nov  7 12:28:21 meddo modprobe: modprobe: Can't locate module nls_iso8859-1
Nov  7 12:29:44 meddo kernel: Unable to handle kernel paging request at virtual address 02b1015a
Nov  7 12:29:44 meddo kernel:  printing eip:
Nov  7 12:29:44 meddo kernel: c01420c7
Nov  7 12:29:44 meddo kernel: *pde = 00000000
Nov  7 12:29:44 meddo kernel: Oops: 0000
Nov  7 12:29:44 meddo kernel: CPU:    0
Nov  7 12:29:44 meddo kernel: EIP:    0010:[iput+39/432]    Not tainted
Nov  7 12:29:44 meddo kernel: EIP:    0010:[<c01420c7>]    Not tainted
Nov  7 12:29:44 meddo kernel: EFLAGS: 00010206
Nov  7 12:29:44 meddo kernel: eax: 02b1013a   ebx: de933080   ecx: de933090   edx: de933090
Nov  7 12:29:44 meddo kernel: esi: 00000000   edi: de933080   ebp: 0000000e   esp: d7b9be44
Nov  7 12:29:44 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:29:44 meddo kernel: Process cat (pid: 16896, stackpage=d7b9b000)
Nov  7 12:29:44 meddo kernel: Stack: de82d0f8 de82d0e0 c014018c de933080 00000000 c16975d4 00000007 00003019 
Nov  7 12:29:44 meddo kernel:        c012a3fa 00000007 d7b9a000 ffffffff 000001d2 c02c7c84 00000000 00000000 
Nov  7 12:29:44 meddo kernel:        00000007 000001d2 00000006 00000006 c014041b 0000071e c012a611 00000006 
Nov  7 12:29:44 meddo kernel: Call Trace: [prune_dcache+300/304] [shrink_cache+570/768] [shrink_dcache_memory+27/64] [shrink_caches+97/144] [try_to_free_pages+44/80] 
Nov  7 12:29:44 meddo kernel: Call Trace: [<c014018c>] [<c012a3fa>] [<c014041b>] [<c012a611>] [<c012a66c>] 
Nov  7 12:29:44 meddo kernel:    [balance_classzone+83/416] [__alloc_pages+300/464] [generic_file_write+1152/1472] [file_read_actor+0/96] [sys_write+176/208] [schedule+500/976] 
Nov  7 12:29:44 meddo kernel:    [<c012afe3>] [<c012b25c>] [<c0126bb0>] [<c0125030>] [<c012fe30>] [<c0112834>] 
Nov  7 12:29:44 meddo kernel:    [system_call+51/56] 
Nov  7 12:29:44 meddo kernel:    [<c0106d3b>] 
Nov  7 12:29:44 meddo kernel: 
Nov  7 12:29:44 meddo kernel: Code: 8b 40 20 85 c0 0f 45 f0 85 f6 74 0b 8b 46 10 85 c0 74 04 53 
Nov  7 12:30:12 meddo kernel:  <5>smb_get_length: recv error = 5
Nov  7 12:30:12 meddo kernel: smb_request: result -5, setting invalid
Nov  7 12:30:12 meddo kernel: Unable to handle kernel paging request at virtual address 0343fdc2
Nov  7 12:30:12 meddo kernel:  printing eip:
Nov  7 12:30:12 meddo kernel: c0141931
Nov  7 12:30:12 meddo kernel: *pde = 00000000
Nov  7 12:30:12 meddo kernel: Oops: 0000
Nov  7 12:30:12 meddo kernel: CPU:    0
Nov  7 12:30:12 meddo kernel: EIP:    0010:[invalidate_list+65/176]    Not tainted
Nov  7 12:30:12 meddo kernel: EIP:    0010:[<c0141931>]    Not tainted
Nov  7 12:30:12 meddo kernel: EFLAGS: 00010207
Nov  7 12:30:12 meddo kernel: eax: de70e800   ebx: 0343fdc2   ecx: c02c8818   edx: de1bfe90
Nov  7 12:30:12 meddo kernel: esi: de933da0   edi: 0343fdc2   ebp: de1bfe90   esp: de1bfe68
Nov  7 12:30:12 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:30:12 meddo kernel: Process df (pid: 16899, stackpage=de1bf000)
Nov  7 12:30:12 meddo kernel: Stack: 00000000 00000000 c0000000 de70e800 de1bfe90 fffffffb c01419cf c02c8844 
Nov  7 12:30:12 meddo kernel:        de70e800 de1bfe90 de1bfe90 de1bfe90 de1bfe90 de1bfe90 c0000000 00000292 
Nov  7 12:30:12 meddo kernel:        00000000 c01766b0 de70e800 c028b080 fffffffb e2aa9000 00000000 00000000 
Nov  7 12:30:12 meddo kernel: Call Trace: [invalidate_inodes+47/112] [smb_request+112/528] [smb_request_ok+46/160] [smb_proc_dskattr+62/160] [smb_statfs+16/48] 
Nov  7 12:30:12 meddo kernel: Call Trace: [<c01419cf>] [<c01766b0>] [<c0172b9e>] [<c0174cde>] [<c0177520>] 
Nov  7 12:30:12 meddo kernel:    [vfs_statfs+57/64] [sys_statfs+70/160] [system_call+51/56] 
Nov  7 12:30:12 meddo kernel:    [<c012e4d9>] [<c012e526>] [<c0106d3b>] 
Nov  7 12:30:12 meddo kernel: 
Nov  7 12:30:12 meddo kernel: Code: 8b 3b 3b 5c 24 1c 75 e7 8b 04 24 29 05 70 f6 32 c0 8b 44 24 
Nov  7 12:30:25 meddo kernel:  <1>Unable to handle kernel paging request at virtual address febafe8a
Nov  7 12:30:25 meddo kernel:  printing eip:
Nov  7 12:30:25 meddo kernel: c01420c7
Nov  7 12:30:25 meddo kernel: *pde = 00000000
Nov  7 12:30:25 meddo kernel: Oops: 0000
Nov  7 12:30:25 meddo kernel: CPU:    0
Nov  7 12:30:25 meddo kernel: EIP:    0010:[iput+39/432]    Not tainted
Nov  7 12:30:25 meddo kernel: EIP:    0010:[<c01420c7>]    Not tainted
Nov  7 12:30:25 meddo kernel: EFLAGS: 00010286
Nov  7 12:30:25 meddo kernel: eax: febafe6a   ebx: de933260   ecx: de933270   edx: de933270
Nov  7 12:30:25 meddo kernel: esi: 00000000   edi: de933260   ebp: 00000605   esp: de1bfdbc
Nov  7 12:30:25 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:30:25 meddo kernel: Process mozilla-bin (pid: 16909, stackpage=de1bf000)
Nov  7 12:30:25 meddo kernel: Stack: de82d1f8 de82d1e0 c014018c de933260 00000000 c162ff9c 00000017 00003033 
Nov  7 12:30:25 meddo kernel:        c012a3fa de847020 de1be000 ffffffff 000001d2 c02c7c84 c1785f84 de891040 
Nov  7 12:30:25 meddo kernel:        00000017 000001d2 00000006 00000006 c014041b 00000606 c012a611 00000006 
Nov  7 12:30:25 meddo kernel: Call Trace: [prune_dcache+300/304] [shrink_cache+570/768] [shrink_dcache_memory+27/64] [shrink_caches+97/144] [try_to_free_pages+44/80] 
Nov  7 12:30:25 meddo kernel: Call Trace: [<c014018c>] [<c012a3fa>] [<c014041b>] [<c012a611>] [<c012a66c>] 
Nov  7 12:30:25 meddo kernel:    [balance_classzone+83/416] [__alloc_pages+300/464] [do_no_page+209/304] [handle_mm_fault+190/208] [do_mmap_pgoff+826/1312] [do_mmap_pgoff+835/1312] 
Nov  7 12:30:25 meddo kernel:    [<c012afe3>] [<c012b25c>] [<c0122471>] [<c012258e>] [<c0122dba>] [<c0122dc3>] 
Nov  7 12:30:25 meddo kernel:    [do_page_fault+764/1248] [batch_entropy_process+172/192] [cursor_timer_handler+0/48] [cursor_timer_handler+11/48] [timer_bh+150/608] [bh_action+69/80] 
Nov  7 12:30:25 meddo kernel:    [<c0111f1c>] [<c01a5a5c>] [<c0212b60>] [<c0212b6b>] [<c011c266>] [<c0119115>] 
Nov  7 12:30:25 meddo kernel:    [tasklet_hi_action+85/96] [do_softirq+91/160] [do_page_fault+0/1248] [error_code+52/60] 
Nov  7 12:30:25 meddo kernel:    [<c0119015>] [<c0118e1b>] [<c0111c20>] [<c0106e2c>] 
Nov  7 12:30:25 meddo kernel: 
Nov  7 12:30:25 meddo kernel: Code: 8b 40 20 85 c0 0f 45 f0 85 f6 74 0b 8b 46 10 85 c0 74 04 53 
Nov  7 12:30:41 meddo kernel:  <1>Unable to handle kernel paging request at virtual address ff0f02a5
Nov  7 12:30:41 meddo kernel:  printing eip:
Nov  7 12:30:41 meddo kernel: c01420c7
Nov  7 12:30:41 meddo kernel: *pde = 00000000
Nov  7 12:30:41 meddo kernel: Oops: 0000
Nov  7 12:30:41 meddo kernel: CPU:    0
Nov  7 12:30:41 meddo kernel: EIP:    0010:[iput+39/432]    Not tainted
Nov  7 12:30:41 meddo kernel: EIP:    0010:[<c01420c7>]    Not tainted
Nov  7 12:30:41 meddo kernel: EFLAGS: 00010282
Nov  7 12:30:41 meddo kernel: eax: ff0f0285   ebx: de933440   ecx: de933450   edx: de933450
Nov  7 12:30:41 meddo kernel: esi: 00000000   edi: de933440   ebp: 00000607   esp: c3d93e44
Nov  7 12:30:41 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:30:41 meddo kernel: Process cat (pid: 16910, stackpage=c3d93000)
Nov  7 12:30:41 meddo kernel: Stack: de82d278 de82d260 c014018c de933440 00000000 c16b267c 0000000c 00003021 
Nov  7 12:30:41 meddo kernel:        c012a3fa 00000000 c3d92000 ffffffff 000001d2 c02c7c84 c1785270 dae5c040 
Nov  7 12:30:41 meddo kernel:        0000000c 000001d2 00000006 00000006 c014041b 00000607 c012a611 00000006 
Nov  7 12:30:41 meddo kernel: Call Trace: [prune_dcache+300/304] [shrink_cache+570/768] [shrink_dcache_memory+27/64] [shrink_caches+97/144] [try_to_free_pages+44/80] 
Nov  7 12:30:41 meddo kernel: Call Trace: [<c014018c>] [<c012a3fa>] [<c014041b>] [<c012a611>] [<c012a66c>] 
Nov  7 12:30:41 meddo kernel:    [balance_classzone+83/416] [__alloc_pages+300/464] [generic_file_write+1152/1472] [file_read_actor+0/96] [sys_write+176/208] [sys_brk+229/240] 
Nov  7 12:30:41 meddo kernel:    [<c012afe3>] [<c012b25c>] [<c0126bb0>] [<c0125030>] [<c012fe30>] [<c0122835>] 
Nov  7 12:30:41 meddo kernel:    [system_call+51/56] 
Nov  7 12:30:41 meddo kernel:    [<c0106d3b>] 
Nov  7 12:30:41 meddo kernel: 
Nov  7 12:30:41 meddo kernel: Code: 8b 40 20 85 c0 0f 45 f0 85 f6 74 0b 8b 46 10 85 c0 74 04 53 
Nov  7 12:32:31 meddo kernel:  <1>Unable to handle kernel paging request at virtual address 0321fdde
Nov  7 12:32:31 meddo kernel:  printing eip:
Nov  7 12:32:31 meddo kernel: c01420c7
Nov  7 12:32:31 meddo kernel: *pde = 00000000
Nov  7 12:32:31 meddo kernel: Oops: 0000
Nov  7 12:32:31 meddo kernel: CPU:    0
Nov  7 12:32:31 meddo kernel: EIP:    0010:[iput+39/432]    Not tainted
Nov  7 12:32:31 meddo kernel: EIP:    0010:[<c01420c7>]    Not tainted
Nov  7 12:32:31 meddo kernel: EFLAGS: 00010206
Nov  7 12:32:31 meddo kernel: eax: 0321fdbe   ebx: de933620   ecx: de933630   edx: de933630
Nov  7 12:32:31 meddo kernel: esi: 00000000   edi: de933620   ebp: 000005fd   esp: dcaafea8
Nov  7 12:32:31 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:32:31 meddo kernel: Process mozilla-bin (pid: 16919, stackpage=dcaaf000)
Nov  7 12:32:31 meddo kernel: Stack: de82d2f8 de82d2e0 c014018c de933620 00000000 c16e1a94 0000001d 0000302c 
Nov  7 12:32:31 meddo kernel:        c012a3fa 00000282 dcaae000 ffffffff 000001f0 c02c7c84 c011cfb1 00000020 
Nov  7 12:32:31 meddo kernel:        0000001d 000001f0 00000006 00000006 c014041b 000005fd c012a611 00000006 
Nov  7 12:32:31 meddo kernel: Call Trace: [prune_dcache+300/304] [shrink_cache+570/768] [send_sig_info+129/144] [shrink_dcache_memory+27/64] [shrink_caches+97/144] 
Nov  7 12:32:31 meddo kernel: Call Trace: [<c014018c>] [<c012a3fa>] [<c011cfb1>] [<c014041b>] [<c012a611>] 
Nov  7 12:32:31 meddo kernel:    [try_to_free_pages+44/80] [balance_classzone+83/416] [__alloc_pages+300/464] [__get_free_pages+16/32] [sys_poll+276/816] [system_call+51/56] 
Nov  7 12:32:31 meddo kernel:    [<c012a66c>] [<c012afe3>] [<c012b25c>] [<c012b310>] [<c013d0b4>] [<c0106d3b>] 
Nov  7 12:32:31 meddo kernel: 
Nov  7 12:32:31 meddo kernel: Code: 8b 40 20 85 c0 0f 45 f0 85 f6 74 0b 8b 46 10 85 c0 74 04 53 
Nov  7 12:32:48 meddo kernel:  <1>Unable to handle kernel paging request at virtual address fb9a01ab
Nov  7 12:32:48 meddo kernel:  printing eip:
Nov  7 12:32:48 meddo kernel: c01420c7
Nov  7 12:32:48 meddo kernel: *pde = 00000000
Nov  7 12:32:48 meddo kernel: Oops: 0000
Nov  7 12:32:48 meddo kernel: CPU:    0
Nov  7 12:32:48 meddo kernel: EIP:    0010:[iput+39/432]    Not tainted
Nov  7 12:32:48 meddo kernel: EIP:    0010:[<c01420c7>]    Not tainted
Nov  7 12:32:48 meddo kernel: EFLAGS: 00010286
Nov  7 12:32:48 meddo kernel: eax: fb9a018b   ebx: de933800   ecx: de933810   edx: de933810
Nov  7 12:32:48 meddo kernel: esi: 00000000   edi: de933800   ebp: 0000060a   esp: d1ae7e44
Nov  7 12:32:48 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:32:48 meddo kernel: Process cp (pid: 16927, stackpage=d1ae7000)
Nov  7 12:32:48 meddo kernel: Stack: de82d378 de82d360 c014018c de933800 00000000 c16eb814 0000000d 0000302a 
Nov  7 12:32:48 meddo kernel:        c012a3fa 00000007 d1ae6000 ffffffff 000001d2 c02c7c84 00000000 00000000 
Nov  7 12:32:48 meddo kernel:        0000000d 000001d2 00000006 00000006 c014041b 0000060a c012a611 00000006 
Nov  7 12:32:48 meddo kernel: Call Trace: [prune_dcache+300/304] [shrink_cache+570/768] [shrink_dcache_memory+27/64] [shrink_caches+97/144] [try_to_free_pages+44/80] 
Nov  7 12:32:48 meddo kernel: Call Trace: [<c014018c>] [<c012a3fa>] [<c014041b>] [<c012a611>] [<c012a66c>] 
Nov  7 12:32:48 meddo kernel:    [balance_classzone+83/416] [__alloc_pages+300/464] [generic_file_write+1152/1472] [file_read_actor+0/96] [sys_write+176/208] [schedule+500/976] 
Nov  7 12:32:48 meddo kernel:    [<c012afe3>] [<c012b25c>] [<c0126bb0>] [<c0125030>] [<c012fe30>] [<c0112834>] 
Nov  7 12:32:48 meddo kernel:    [system_call+51/56] 
Nov  7 12:32:48 meddo kernel:    [<c0106d3b>] 
Nov  7 12:32:48 meddo kernel: 
Nov  7 12:32:48 meddo kernel: Code: 8b 40 20 85 c0 0f 45 f0 85 f6 74 0b 8b 46 10 85 c0 74 04 53 
Nov  7 12:33:21 meddo kernel:  <1>Unable to handle kernel paging request at virtual address 04c3ff05
Nov  7 12:33:21 meddo kernel:  printing eip:
Nov  7 12:33:21 meddo kernel: c01420c7
Nov  7 12:33:21 meddo kernel: *pde = 00000000
Nov  7 12:33:21 meddo kernel: Oops: 0000
Nov  7 12:33:21 meddo kernel: CPU:    0
Nov  7 12:33:21 meddo kernel: EIP:    0010:[iput+39/432]    Not tainted
Nov  7 12:33:21 meddo kernel: EIP:    0010:[<c01420c7>]    Not tainted
Nov  7 12:33:21 meddo kernel: EFLAGS: 00010202
Nov  7 12:33:21 meddo kernel: eax: 04c3fee5   ebx: de9339e0   ecx: de9339f0   edx: de9339f0
Nov  7 12:33:21 meddo kernel: esi: 00000000   edi: de9339e0   ebp: 0000060a   esp: dd1bbe44
Nov  7 12:33:21 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:33:21 meddo kernel: Process cat (pid: 16939, stackpage=dd1bb000)
Nov  7 12:33:21 meddo kernel: Stack: de82d3f8 de82d3e0 c014018c de9339e0 00000000 c15912fc 0000000c 00002e21 
Nov  7 12:33:21 meddo kernel:        c012a3fa 00000007 dd1ba000 ffffffff 000001d2 c02c7c84 00000000 00000000 
Nov  7 12:33:21 meddo kernel:        0000000c 000001d2 00000006 00000006 c014041b 0000060a c012a611 00000006 
Nov  7 12:33:21 meddo kernel: Call Trace: [prune_dcache+300/304] [shrink_cache+570/768] [shrink_dcache_memory+27/64] [shrink_caches+97/144] [try_to_free_pages+44/80] 
Nov  7 12:33:21 meddo kernel: Call Trace: [<c014018c>] [<c012a3fa>] [<c014041b>] [<c012a611>] [<c012a66c>] 
Nov  7 12:33:21 meddo kernel:    [balance_classzone+83/416] [__alloc_pages+300/464] [generic_file_write+1152/1472] [file_read_actor+0/96] [sys_write+176/208] [schedule+500/976] 
Nov  7 12:33:21 meddo kernel:    [<c012afe3>] [<c012b25c>] [<c0126bb0>] [<c0125030>] [<c012fe30>] [<c0112834>] 
Nov  7 12:33:21 meddo kernel:    [system_call+51/56] 
Nov  7 12:33:21 meddo kernel:    [<c0106d3b>] 
Nov  7 12:33:21 meddo kernel: 
Nov  7 12:33:21 meddo kernel: Code: 8b 40 20 85 c0 0f 45 f0 85 f6 74 0b 8b 46 10 85 c0 74 04 53 
Nov  7 12:34:51 meddo kernel:  <1>Unable to handle kernel paging request at virtual address fbb00026
Nov  7 12:34:51 meddo kernel:  printing eip:
Nov  7 12:34:51 meddo kernel: c01420c7
Nov  7 12:34:51 meddo kernel: *pde = 00000000
Nov  7 12:34:51 meddo kernel: Oops: 0000
Nov  7 12:34:51 meddo kernel: CPU:    0
Nov  7 12:34:51 meddo kernel: EIP:    0010:[iput+39/432]    Not tainted
Nov  7 12:34:51 meddo kernel: EIP:    0010:[<c01420c7>]    Not tainted
Nov  7 12:34:51 meddo kernel: EFLAGS: 00010286
Nov  7 12:34:51 meddo kernel: eax: fbb00006   ebx: de933bc0   ecx: de933bd0   edx: de933bd0
Nov  7 12:34:51 meddo kernel: esi: 00000000   edi: de933bc0   ebp: 0000001e   esp: dab6fef0
Nov  7 12:34:51 meddo kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:34:51 meddo kernel: Process umount (pid: 16977, stackpage=dab6f000)
Nov  7 12:34:51 meddo kernel: Stack: de82d478 de82d460 c014018c de933bc0 dff9c694 dff9c660 dff9c694 c0143be6 
Nov  7 12:34:51 meddo kernel:        dab6ff2c dab6ff14 dab6ff14 00000000 40128062 dab6e000 00000246 00000068 
Nov  7 12:34:51 meddo kernel:        c2565da0 c2565da0 c02cab60 c02cac1c c01403f6 00000068 d9530a00 c0134553 
Nov  7 12:34:51 meddo kernel: Call Trace: [prune_dcache+300/304] [umount_tree+166/208] [shrink_dcache_parent+38/48] [kill_super+83/288] [path_release+40/48] 
Nov  7 12:34:51 meddo kernel: Call Trace: [<c014018c>] [<c0143be6>] [<c01403f6>] [<c0134553>] [<c01380e8>] 
Nov  7 12:34:51 meddo kernel:    [sys_umount+112/192] [filp_close+63/96] [sys_oldumount+12/16] [system_call+51/56] 
Nov  7 12:34:51 meddo kernel:    [<c0143d70>] [<c012f8ff>] [<c0143dcc>] [<c0106d3b>] 
Nov  7 12:34:51 meddo kernel: 
Nov  7 12:34:51 meddo kernel: Code: 8b 40 20 85 c0 0f 45 f0 85 f6 74 0b 8b 46 10 85 c0 74 04 53 
nov  7 12:35:03 meddo su(pam_unix)[17011]: authentication failure; logname= uid=238 euid=0 tty= ruser= rhost=  user=root
nov  7 12:35:08 meddo su(pam_unix)[17013]: session opened for user root by (uid=238)
Nov  7 12:35:15 meddo kernel:  <7>VFS: Disk change detected on device sr(11,0)

This is stock Redhat 7.2, running 2.4.14 (compiled with gcc 2.96), on
a Dell Precision 220 (single CPU 1 ghz P-III), I'm running ext2 on the
/boot partition, and the rest is ReiserFS. I also have a NFS and SMB
mount. (Any further info needed?)



CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_BLK_DEV_FD=y
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_INTEL_RNG=y
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
CONFIG_DRM_MGA=m
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_FS_INFLATE=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_MULTIHEAD=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SOUND_ES1371=y
CONFIG_SOUND_ICH=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_VMIDI=y
CONFIG_SOUND_MPU401=y
CONFIG_SOUND_YM3812=y
CONFIG_USB=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_STORAGE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y




-- 

Han-Wen Nienhuys   |   hanwen@cs.uu.nl    | http://www.cs.uu.nl/~hanwen/


