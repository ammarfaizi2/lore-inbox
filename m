Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271737AbTGRKQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271740AbTGRKQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:16:37 -0400
Received: from mcrg.uib.es ([130.206.33.134]:2688 "EHLO minime.uib.es")
	by vger.kernel.org with ESMTP id S271718AbTGRKP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:15:27 -0400
From: Ricardo Galli <gallir@uib.es>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
Date: Fri, 18 Jul 2003 12:28:40 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307181228.40142.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,
	I still see some oops that I think are ext3 related. The machine now is 
almost hang, it works via ssh but the X/KDE environment just locks up, I had 
to reboot it.


Find below the three oops I found during last 24 hours.

Regards,


 Unable to handle kernel paging request at virtual address e9000018
 printing eip:
c0168790
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0168790>]    Not tainted
EFLAGS: 00010286
EIP is at find_inode_fast+0x20/0x70
eax: df456a90   ebx: 002f2b15   ecx: e9000018   edx: e9000018
esi: dfe03800   edi: dff8ecc4   ebp: dfe03800   esp: dd42de34
ds: 007b   es: 007b   ss: 0068
Process famd (pid: 19519, threadinfo=dd42c000 task=d428e0a0)
Stack: 00000000 dd42c000 db202800 002f2b15 c0168e42 dfe03800 dff8ecc4 002f2b15
       dff8ecc4 002f2b15 db202800 dfe03800 db202800 c018a54b dfe03800 002f2b15
       d9a8e07c fffffff4 d9af3738 d9af36d0 c015cd92 d9af36d0 db202800 dd42df38
Call Trace:
 [<c0168e42>] iget_locked+0x52/0xc0
 [<c018a54b>] ext3_lookup+0x6b/0xd0
 [<c015cd92>] real_lookup+0xd2/0x100
 [<c015d036>] do_lookup+0x96/0xb0
 [<c015d4e0>] link_path_walk+0x490/0x8a0
 [<c015ddf9>] __user_walk+0x49/0x60
 [<c0158fac>] vfs_lstat+0x1c/0x60
 [<c015965b>] sys_lstat64+0x1b/0x40
 [<c01092bb>] syscall_call+0x7/0xb

Code: 8b 11 0f 18 02 90 39 59 18 89 c8 74 13 85 d2 89 d1 75 ed 31
 <6>note: famd[19519] exited with preempt_count 1
Unable to handle kernel paging request at virtual address e9000018
 printing eip:
c0168790
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0168790>]    Not tainted
EFLAGS: 00010286
EIP is at find_inode_fast+0x20/0x70
eax: df456a90   ebx: 002a2b1f   ecx: e9000018   edx: e9000018
esi: dfe03800   edi: dff8ecc4   ebp: dfe03800   esp: dadbbe34
ds: 007b   es: 007b   ss: 0068
Process updatedb (pid: 25529, threadinfo=dadba000 task=d34b40c0)
Stack: 00000000 dadba000 dea27a80 002a2b1f c0168e42 dfe03800 dff8ecc4 002a2b1f
       dff8ecc4 002a2b1f dea27a80 dfe03800 dea27a80 c018a54b dfe03800 002a2b1f
       c4788030 fffffff4 df567a98 df567a30 c015cd92 df567a30 dea27a80 dadbbf38
Call Trace:
 [<c0168e42>] iget_locked+0x52/0xc0
 [<c018a54b>] ext3_lookup+0x6b/0xd0
 [<c015cd92>] real_lookup+0xd2/0x100
 [<c015d036>] do_lookup+0x96/0xb0
 [<c015d4e0>] link_path_walk+0x490/0x8a0
 [<c015ddf9>] __user_walk+0x49/0x60
 [<c0158fac>] vfs_lstat+0x1c/0x60
 [<c015965b>] sys_lstat64+0x1b/0x40
 [<c01092bb>] syscall_call+0x7/0xb

Code: 8b 11 0f 18 02 90 39 59 18 89 c8 74 13 85 d2 89 d1 75 ed 31
 <6>note: updatedb[25529] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c0118667>] schedule+0x3b7/0x3c0
 [<c014084b>] unmap_page_range+0x4b/0x80
 [<c0140a4d>] unmap_vmas+0x1cd/0x230
 [<c0144608>] exit_mmap+0x78/0x190
 [<c011a084>] mmput+0x64/0xc0
 [<c011dd23>] do_exit+0x113/0x440
 [<c0116c60>] do_page_fault+0x0/0x479
 [<c010a360>] do_divide_error+0x0/0x100
 [<c0116d8c>] do_page_fault+0x12c/0x479
 [<c015233b>] __getblk+0x2b/0x60
 [<c0186263>] ext3_getblk+0x93/0x260
 [<c0150b5f>] wake_up_buffer+0xf/0x30
 [<c0150bac>] unlock_buffer+0x2c/0x50
 [<c015435c>] ll_rw_block+0x5c/0x90
 [<c0152293>] __find_get_block+0x73/0xf0
 [<c018a1d4>] ext3_find_entry+0x354/0x410
 [<c0116c60>] do_page_fault+0x0/0x479
 [<c0109cc5>] error_code+0x2d/0x38
 [<c0168790>] find_inode_fast+0x20/0x70
 [<c0168e42>] iget_locked+0x52/0xc0
 [<c018a54b>] ext3_lookup+0x6b/0xd0
 [<c015cd92>] real_lookup+0xd2/0x100
 [<c015d036>] do_lookup+0x96/0xb0
 [<c015d4e0>] link_path_walk+0x490/0x8a0
 [<c015ddf9>] __user_walk+0x49/0x60
 [<c0158fac>] vfs_lstat+0x1c/0x60
 [<c015965b>] sys_lstat64+0x1b/0x40
 [<c01092bb>] syscall_call+0x7/0xb


-- 
  ricardo galli
