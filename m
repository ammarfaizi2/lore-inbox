Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTIHVi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTIHVi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:38:27 -0400
Received: from research.suspicious.org ([198.78.65.136]:38927 "EHLO
	research.suspicious.org") by vger.kernel.org with ESMTP
	id S263578AbTIHViY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:38:24 -0400
Date: Mon, 8 Sep 2003 17:38:21 -0500
From: phil <phil@research.suspicious.org>
To: linux-kernel@vger.kernel.org
Subject: reiserfs error, 2.6.0-test4-mm6
Message-Id: <20030908173821.43165f12.phil@research.suspicious.org>
Organization: research.suspicious.org
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Unable to handle kernel paging request at virtual address 181d2d42
  printing eip:
 c016c45c
 *pde = 00000000
 Oops: 0000 [#2]
 PREEMPT 
 CPU:    0
 EIP:    0060:[copy_namespace+44/688]    Not tainted VLI
 EFLAGS: 00010246
 EIP is at find_inode+0x3c/0x80
 eax: 181d2d42   ebx: 181d2d42   ecx: 0000000f   edx: 18
1d2d42
 esi: cfdb3e48   edi: dfc4ea00   ebp: c1536a18   esp: cf
db3d50
 ds: 007b   es: 007b   ss: 0068
 Process find (pid: 4722, threadinfo=cfdb2000 task=d1b7e
670)
 Stack: cfdb3e24 d13ff6fc cfdb2000 cfdb3e48 dfc4ea00 c15
36a18 c016ca7d dfc4ea00 
        c1536a18 c01caeb0 cfdb3db4 c01c5bf8 cfdb3db4 c01
cad80 c01caeb0 cfdb3de4 
        cfdb3e48 cfdb3db4 00000000 c01caf28 dfc4ea00 000
03fe0 c01caeb0 c01cad80 
 Call Trace:
  [sys_pivot_root+13/896] iget5_locked+0x6d/0xf0
  [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
x30
  [reiserfs_encode_fh+8/192] reiserfs_find_entry+0xb8/0x
160
  [reiserfs_readdir+912/1360] reiserfs_init_locked_inode
+0x0/0x20
  [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
x30
  [reiserfs_readdir+1336/1360] reiserfs_iget+0x48/0xb0
  [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
x30
  [reiserfs_readdir+912/1360] reiserfs_init_locked_inode
+0x0/0x20
  [reiserfs_new_directory+35/560] reiserfs_lookup+0x133/
0x180
  [alloc_vfsmnt+147/224] d_lookup+0x23/0x50
  [.text.lock.namei+115/395] real_lookup+0xc8/0xf0
  [locate_fd+214/288] do_lookup+0x96/0xb0
  [do_fcntl+64/432] link_path_walk+0x490/0x8f0
  [sys_ioctl+73/656] __user_walk+0x49/0x60
  [.text.lock.pipe+143/211] vfs_lstat+0x1c/0x60
  [follow_down+123/144] sys_lstat64+0x1b/0x40
  [__func__.1+291/340] syscall_call+0x7/0xb
 
 Code: 00 85 db 74 2e 80 3d c1 4d 3d c0 02 8b 13 89 d0 7
4 04 0f 18 00 90 39 bb 80 00 00 00 74 1f 85 d2 89 d3 74 0f 80 3d c1 4d 3d c0 02 
<8b> 02 89 c2 75 e1 eb e3 31 c0 83 c4 08 5b 5e 5f 5d c3 8b 44 24 
  <6>note: find[4722] exited with preempt_count 2
 bad: scheduling while atomic!
 Call Trace:
  [copy_mm+851/928] schedule+0x5c3/0x5d0
  [do_mmap_pgoff+1227/1664] unmap_page_range+0x4b/0x90
  [get_unmapped_area+69/320] unmap_vmas+0x1b5/0x230
  [shmem_getpage+1195/2400] exit_mmap+0x7b/0x190
  [_call_console_drivers+105/128] mmput+0x79/0xf0
  [find_resource+146/208] do_exit+0x122/0x360
  [try_to_free_low+192/208] do_page_fault+0x0/0x454
  [do_IRQ+41/304] die+0xf9/0x100
  [hugetlb_report_meminfo+12/64] do_page_fault+0x12c/0x4
54
  [deactivate_super+43/192] __getblk+0x2b/0x60
  [alloc_super+245/368] __find_get_block+0x65/0xe0
  [flush_commit_list+901/1136] is_tree_node+0x65/0x70
  [deactivate_super+43/192] __getblk+0x2b/0x60
  [flush_commit_list+901/1136] is_tree_node+0x65/0x70
  [flush_journal_list+415/1056] search_by_key+0x63f/0xdd
0
  [try_to_free_low+192/208] do_page_fault+0x0/0x454
  [__func__.0+741/288670] error_code+0x2f/0x38
  [copy_namespace+44/688] find_inode+0x3c/0x80
  [sys_pivot_root+13/896] iget5_locked+0x6d/0xf0
  [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
x30
  [reiserfs_encode_fh+8/192] reiserfs_find_entry+0xb8/0x
160
  [reiserfs_readdir+912/1360] reiserfs_init_locked_inode
+0x0/0x20
  [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
x30
  [reiserfs_readdir+1336/1360] reiserfs_iget+0x48/0xb0
  [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
x30
  [reiserfs_readdir+912/1360] reiserfs_init_locked_inode+0x0/0x20
  [reiserfs_new_directory+35/560] reiserfs_lookup+0x133/
0x180
  [alloc_vfsmnt+147/224] d_lookup+0x23/0x50
  [.text.lock.namei+115/395] real_lookup+0xc8/0xf0
  [locate_fd+214/288] do_lookup+0x96/0xb0
  [do_fcntl+64/432] link_path_walk+0x490/0x8f0
  [sys_ioctl+73/656] __user_walk+0x49/0x60
  [.text.lock.pipe+143/211] vfs_lstat+0x1c/0x60
  [follow_down+123/144] sys_lstat64+0x1b/0x40
  [__func__.1+291/340] syscall_call+0x7/0xb

