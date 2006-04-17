Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWDQXtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWDQXtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 19:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWDQXtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 19:49:42 -0400
Received: from web52601.mail.yahoo.com ([206.190.48.204]:5476 "HELO
	web52601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932065AbWDQXtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 19:49:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Tvm+CJncUBxawzUNet15PApn5XMwIMV3kzPDG1dFBS31Uvf2xPmzuCyu1EPK3On7FwXGe04DE+t45yI3Ylluy6OpLSivEnnWeolDb/GC5j/xV++TdXwbXs+VV5Ke2CtmMLI5j/cVJpXBwwVJfRoyyE0HBAkICebJ9R3ptVgvGfo=  ;
Message-ID: <20060417234939.28833.qmail@web52601.mail.yahoo.com>
Date: Tue, 18 Apr 2006 09:49:38 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: 2.6.16.1 & D state processes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SysRq+P:
Pid: 0, comm:              swapper
EIP: 0060:[<c0101c9e>] CPU: 0
EIP is at default_idle+0x2b/0x53
 EFLAGS: 00200246    Not tainted  (2.6.16.1 #2)
EAX: 00000000 EBX: 00010809 ECX: 00000000 EDX:
c0395000
ESI: 00099100 EDI: c038a800 EBP: 00444007 DS: 007b ES:
007b
CR0: 8005003b CR2: 00ad11c5 CR3: 1926c000 CR4:
000006d0
 [<c0101d00>] cpu_idle+0x3a/0x4f
 [<c0396610>] start_kernel+0x28d/0x28f

SysRq+T (of only D state processes - 6 of them):
kjournald     D C1605158  2912   338      1          
404   330 (L-TLB)
c1611e74 c6747cd4 0000000a c1605158 c1605030 c7847f00
003d7b1c 00000000 
       c7847f00 003d7b1c 003d0900 00000000 c1611ecc
00000000 c1611ed4 c1611e7c 
       c02d1742 c13f1930 c01520d6 c02d1f34 c01520ab
c1611ecc c43f5ed8 c1611ec8 
Call Trace:
 [<c02d1742>] io_schedule+0xe/0x16
 [<c01520d6>] sync_buffer+0x2b/0x2e
 [<c02d1f34>] __wait_on_bit+0x33/0x58
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c02d1fce>] out_of_line_wait_on_bit+0x75/0x7d
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c012956c>] wake_bit_function+0x0/0x3c
 [<c015203c>] __wait_on_buffer+0x1c/0x1f
 [<e00337e2>] journal_commit_transaction+0x809/0xeab
[jbd]
 [<c02d281d>] _spin_unlock_irq+0x5/0x7
 [<c02d15fd>] schedule+0x49f/0x4fd
 [<e0036e80>] kjournald+0xbd/0x20e [jbd]
 [<c011743c>] schedule_tail+0x34/0x90
 [<e0036769>] commit_timeout+0x0/0x5 [jbd]
 [<c012953f>] autoremove_wake_function+0x0/0x2d
 [<e0036dc3>] kjournald+0x0/0x20e [jbd]
 [<c0101005>] kernel_thread_helper+0x5/0xb

kjournald     D C1572BD8  2944  1204      1         
1206  1202 (L-TLB)
dead0e74 c6747a14 0000000a c1572bd8 c1572ab0 c7847f00
003d7b1c 00000000 
       c7847f00 003d7b1c 003d0900 00000000 dead0ecc
00000000 dead0ed4 dead0e7c 
       c02d1742 c13ef320 c01520d6 c02d1f34 c01520ab
dead0ecc c43f5e70 dead0ec8 
Call Trace:
 [<c02d1742>] io_schedule+0xe/0x16
 [<c01520d6>] sync_buffer+0x2b/0x2e
 [<c02d1f34>] __wait_on_bit+0x33/0x58
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c02d1fce>] out_of_line_wait_on_bit+0x75/0x7d
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c012956c>] wake_bit_function+0x0/0x3c
 [<c015203c>] __wait_on_buffer+0x1c/0x1f
 [<e00337e2>] journal_commit_transaction+0x809/0xeab
[jbd]
 [<c02d281d>] _spin_unlock_irq+0x5/0x7
 [<c02d15fd>] schedule+0x49f/0x4fd
 [<e0036e80>] kjournald+0xbd/0x20e [jbd]
 [<c011743c>] schedule_tail+0x34/0x90
 [<e0036769>] commit_timeout+0x0/0x5 [jbd]
 [<c012953f>] autoremove_wake_function+0x0/0x2d
 [<e0036dc3>] kjournald+0x0/0x20e [jbd]
 [<c0101005>] kernel_thread_helper+0x5/0xb

kjournald     D C1555698  2912  1206      1         
1208  1204 (L-TLB)
de991e60 c02d281d 0000000a c1555698 c1555570 c7847f00
003d7b1c 00000000 
       c7847f00 003d7b1c 003d0900 00000000 de991eb4
de991eb4 c13f1378 de991e68 
       c02d1742 c01520ab c01520d6 c02d1e5d de991eb4
d74708f4 de991eb0 00000002 
Call Trace:
 [<c02d281d>] _spin_unlock_irq+0x5/0x7
 [<c02d1742>] io_schedule+0xe/0x16
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c01520d6>] sync_buffer+0x2b/0x2e
 [<c02d1e5d>] __wait_on_bit_lock+0x2a/0x51
 [<c02d1ef9>] out_of_line_wait_on_bit_lock+0x75/0x7d
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c012956c>] wake_bit_function+0x0/0x3c
 [<c01521ea>] __lock_buffer+0x20/0x23
 [<c015222e>] ll_rw_block+0x41/0xa4
 [<e0033348>] journal_commit_transaction+0x36f/0xeab
[jbd]
 [<c02d281d>] _spin_unlock_irq+0x5/0x7
 [<c02d15fd>] schedule+0x49f/0x4fd
 [<c02d285c>] _spin_lock_irqsave+0x9/0xd
 [<e0036e80>] kjournald+0xbd/0x20e [jbd]
 [<c011743c>] schedule_tail+0x34/0x90
 [<e0036769>] commit_timeout+0x0/0x5 [jbd]
 [<c012953f>] autoremove_wake_function+0x0/0x2d
 [<e0036dc3>] kjournald+0x0/0x20e [jbd]
 [<c0101005>] kernel_thread_helper+0x5/0xb

kjournald     D C1593698  2944  1208      1         
1210  1206 (L-TLB)
de87ae74 c6747ac4 0000000a c1593698 c1593570 c7847f00
003d7b1c 00000000 
       c7847f00 003d7b1c 003d0900 00000000 de87aecc
00000000 de87aed4 de87ae7c 
       c02d1742 c13ef4d0 c01520d6 c02d1f34 c01520ab
de87aecc c43f5c68 de87aec8 
Call Trace:
 [<c02d1742>] io_schedule+0xe/0x16
 [<c01520d6>] sync_buffer+0x2b/0x2e
 [<c02d1f34>] __wait_on_bit+0x33/0x58
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c02d1fce>] out_of_line_wait_on_bit+0x75/0x7d
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c012956c>] wake_bit_function+0x0/0x3c
 [<c015203c>] __wait_on_buffer+0x1c/0x1f
 [<e00337e2>] journal_commit_transaction+0x809/0xeab
[jbd]
 [<c02d281d>] _spin_unlock_irq+0x5/0x7
 [<c02d15fd>] schedule+0x49f/0x4fd
 [<e0036e80>] kjournald+0xbd/0x20e [jbd]
 [<c011743c>] schedule_tail+0x34/0x90
 [<e0036769>] commit_timeout+0x0/0x5 [jbd]
 [<c012953f>] autoremove_wake_function+0x0/0x2d
 [<e0036dc3>] kjournald+0x0/0x20e [jbd]
 [<c0101005>] kernel_thread_helper+0x5/0xb

kjournald     D C1555BD8  2924  1212      1         
1540  1210 (L-TLB)
c1585e74 c02d285c 0000000a c1555bd8 c1555ab0 eb380300
003d7b1b 00000000 
       00200082 c15d1b9c 2d4cae00 00000000 c1585ecc
00000000 c1585ed4 c1585e7c 
       c02d1742 c13f0f40 c01520d6 c02d1f34 c01520ab
c1585ecc c43f5f40 c1585ec8 
Call Trace:
 [<c02d285c>] _spin_lock_irqsave+0x9/0xd
 [<c02d1742>] io_schedule+0xe/0x16
 [<c01520d6>] sync_buffer+0x2b/0x2e
 [<c02d1f34>] __wait_on_bit+0x33/0x58
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c02d1fce>] out_of_line_wait_on_bit+0x75/0x7d
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c012956c>] wake_bit_function+0x0/0x3c
 [<c015203c>] __wait_on_buffer+0x1c/0x1f
 [<e00337e2>] journal_commit_transaction+0x809/0xeab
[jbd]
 [<c02d281d>] _spin_unlock_irq+0x5/0x7
 [<c02d15fd>] schedule+0x49f/0x4fd
 [<c02d285c>] _spin_lock_irqsave+0x9/0xd
 [<c0121239>] lock_timer_base+0x15/0x2f
 [<e0036e80>] kjournald+0xbd/0x20e [jbd]
 [<c011743c>] schedule_tail+0x34/0x90
 [<e0036769>] commit_timeout+0x0/0x5 [jbd]
 [<c012953f>] autoremove_wake_function+0x0/0x2d
 [<e0036dc3>] kjournald+0x0/0x20e [jbd]
 [<c0101005>] kernel_thread_helper+0x5/0xb

syslogd       D C154ABD8  2312  1572      1         
1575  1540 (NOTLB)
dbfbfe94 00000003 00000009 c154abd8 c154aab0 eafafa00
003d7b1b 00000000 
       eafafa00 003d7b1b 1cd94100 00000000 de7c2a00
de7c2a14 de7c2a84 dbfbfec0 
       e0036186 00249438 00000000 00000000 00000000
00000000 00000000 dbfbfed8 
Call Trace:
 [<e0036186>] log_wait_commit+0xaa/0xf3 [jbd]
 [<c0116955>] __wake_up+0x2a/0x3d
 [<c012953f>] autoremove_wake_function+0x0/0x2d
 [<e00316c3>] journal_stop+0x1a0/0x1cd [jbd]
 [<c016cb8b>] __writeback_single_inode+0x1be/0x31a
 [<c013be53>] do_writepages+0x2b/0x32
 [<c0137f64>] __filemap_fdatawrite_range+0x65/0x71
 [<c016cd00>] sync_inode+0x19/0x2a
 [<e0063cf9>] ext3_sync_file+0x9d/0xb0 [ext3]
 [<c0151dab>] do_fsync+0x62/0xbb
 [<c01029eb>] sysenter_past_esp+0x54/0x75

mingetty      D C1593BD8  2712  1997      1         
1998  1952 (NOTLB)
df2c3cc8 c6747754 00000009 c1593bd8 c1593ab0 c7c18800
003d7b1c 00000000 
       00000246 c13f11c8 003d0900 00000000 df2c3d20
00000000 df2c3d28 df2c3cd0 
       c02d1742 c13f11c8 c01520d6 c02d1f34 c01520ab
df2c3d20 c43f5c34 df2c3d1c 
Call Trace:
 [<c02d1742>] io_schedule+0xe/0x16
 [<c01520d6>] sync_buffer+0x2b/0x2e
 [<c02d1f34>] __wait_on_bit+0x33/0x58
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c02d1fce>] out_of_line_wait_on_bit+0x75/0x7d
 [<c01520ab>] sync_buffer+0x0/0x2e
 [<c012956c>] wake_bit_function+0x0/0x3c
 [<c015203c>] __wait_on_buffer+0x1c/0x1f
 [<c0152c5b>] __bread+0x8a/0x9d
 [<e007146a>] ext3_xattr_get+0x14d/0x23b [ext3]
 [<c01519ee>] __getblk+0x3d/0x23b
 [<e00723e9>] ext3_xattr_security_get+0x38/0x42 [ext3]
 [<c016b0aa>] generic_getxattr+0x3a/0x40
 [<c019e6e2>] inode_doinit_with_dentry+0x171/0x494
 [<c0164324>] d_splice_alias+0xb0/0xd1
 [<e006b1c9>] ext3_lookup+0x72/0x77 [ext3]
 [<c015b325>] do_lookup+0xa6/0x138
 [<c015ce6b>] __link_path_walk+0x81a/0xc5d
 [<c015d2f5>] link_path_walk+0x47/0xb9
 [<c0135954>] audit_syscall_entry+0x118/0x13f
 [<c015d685>] do_path_lookup+0x1dc/0x241
 [<c015df3c>] __path_lookup_intent_open+0x42/0x72
 [<c015dfbb>] path_lookup_open+0xf/0x13
 [<c01586a9>] open_exec+0x1e/0xb3
 [<c0135954>] audit_syscall_entry+0x118/0x13f
 [<c0159bc6>] do_execve+0x3e/0x1ea
 [<c01018c0>] sys_execve+0x2b/0x69
 [<c0102a45>] syscall_call+0x7/0xb

kcheckpass    D CE66F158  2728 12164   2366           
    2367 (NOTLB)
c3dc1d48 c17b7784 00000008 ce66f158 ce66f030 c7c18800
003d7b1c 00000000 
       c7c18800 003d7b1c 00000000 00000000 df0b5400
c3dc1d8c c13f1c48 df169650 
       e0031abf 00000000 dcb4ea60 c3e78388 00000000
d9d0ca40 00000000 00000000 
Call Trace:
 [<e0031abf>] do_get_write_access+0x2e1/0x4c1 [jbd]
 [<c012956c>] wake_bit_function+0x0/0x3c
 [<e0031cb7>] journal_get_write_access+0x18/0x26 [jbd]
 [<e00652e6>] ext3_reserve_inode_write+0x2f/0x78
[ext3]
 [<e0065358>] ext3_mark_inode_dirty+0x29/0x3f [ext3]
 [<e0067aae>] ext3_dirty_inode+0x53/0x66 [ext3]
 [<c016cee1>] __mark_inode_dirty+0x27/0x152
 [<c0137dea>] do_generic_mapping_read+0x3b9/0x400
 [<c013846d>] __generic_file_aio_read+0x148/0x18f
 [<c0137351>] file_read_actor+0x0/0xe0
 [<c01384ef>] generic_file_aio_read+0x3b/0x42
 [<c014fcf3>] do_sync_read+0xb8/0xf3
 [<c012953f>] autoremove_wake_function+0x0/0x2d
 [<c014fc3b>] do_sync_read+0x0/0xf3
 [<c01505bc>] vfs_read+0x9f/0x13e
 [<c0150923>] sys_read+0x3c/0x63
 [<c0102a45>] syscall_call+0x7/0xb

I've reported the same problem on FC5 kernels
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=186856)
too, assuming it was an FC only problem. But as it
turns out, kernel.org kernels too suffer from this,
though it took a while to prove that :(.

Surprisingly, I can't trigger it with my minimal
.config, however, when I use FC5's .config, within a
few days, this problem appears. Any particular
component you'd like me to isolate?

I think I ought to try 2.6.16.<latest>.

Thanks
Hari

PS: Pls keep me in the replies.

Send instant messages to your online friends http://au.messenger.yahoo.com 
