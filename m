Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbUKUSRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbUKUSRo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUKUSRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:17:43 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:15493 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261755AbUKUSOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:14:22 -0500
Date: Sun, 21 Nov 2004 19:14:32 +0100
From: tp22a@softhome.net
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs/sysfs/file.c:87!
Message-Id: <20041121191432.472bc670.tp22a@softhome.net>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

I hope I do that right?

[1.] One line summary of the problem:
Crash of the system.

[2.] Full description of the problem/report:
Nov 21 03:44:00 mail kernel BUG at fs/sysfs/file.c:87!
Nov 21 03:44:00 mail invalid operand: 0000 [#1]
Nov 21 03:44:00 mail PREEMPT
Nov 21 03:44:00 mail Modules linked in: ipt_TOS ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftpip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables nfs lockd sunrpc rtc usbcore natsemi crc32 b44 mii dm_mod ide_cd cdrom
Nov 21 03:44:00 mail CPU:    0
Nov 21 03:44:00 mail EIP:    0060:[<c018e9d6>]    Not tainted VLI
Nov 21 03:44:00 mail EFLAGS: 00010206   (2.6.10-rc2)
Nov 21 03:44:00 mail EIP is at fill_read_buffer+0x96/0xa0
Nov 21 03:44:00 mail eax: 00003ee2   ebx: f50cb460   ecx: c033a79a   edx: c033a799
Nov 21 03:44:00 mail esi: c1bf7868   edi: c039f030   ebp: c039efc8   esp: ea344f34
Nov 21 03:44:00 mail ds: 007b   es: 007b   ss: 0068
Nov 21 03:44:00 mail Process tar (pid: 2078, threadinfo=ea344000 task=f7266a20)
Nov 21 03:44:00 mail Stack: c1bf3460 e45f7000 e45f7000 00000000 f50cb460 f78a6380 ea344fac 00001000
Nov 21 03:44:00 mail c018eaea d82b8eac f50cb460 d82b8eac c18e8f20 00000000 c01541da f78a6380
Nov 21 03:44:00 mail 80032800 00001000 ea344fac ffffffe8 ea344000 f78a6380 fffffff7 bfffec7c
Nov 21 03:44:00 mail Call Trace:
Nov 21 03:44:00 mail [<c018eaea>] sysfs_read_file+0x2a/0x70
Nov 21 03:44:00 mail [<c01541da>] vfs_read+0x10a/0x150
Nov 21 03:44:00 mail [<c01544d1>] sys_read+0x51/0x80
Nov 21 03:44:00 mail [<c01031a9>] sysenter_past_esp+0x52/0x71
Nov 21 03:44:00 mail Code: c0 78 22 89 03 8b 54 24 0c 8b 5c 24 10 8b 74 24 14 89 d0 8b 7c 24 18 8b 6c 24 1c 83 c4 20 c3 8d b6 00 00 00 00 89 44 24 0c eb da <0f> 0b 57 00 4c 01 33 c0 eb ca 83 ec 24 31 d2 89 74 24 18 8b 74
Nov 21 03:45:00 mail <1>Unable to handle kernel paging request at virtual address 656b203a
Nov 21 03:45:00 mail printing eip:
Nov 21 03:45:00 mail c016f478
Nov 21 03:45:00 mail *pde = 00000000
Nov 21 03:45:00 mail Oops: 0000 [#2]
Nov 21 03:45:00 mail PREEMPT
Nov 21 03:45:00 mail Modules linked in: ipt_TOS ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftpip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables nfs lockd sunrpc rtc usbcore natsemi crc32 b44 mii dm_mod ide_cd cdrom
Nov 21 03:45:00 mail CPU:    0
Nov 21 03:45:00 mail EIP:    0060:[<c016f478>]    Not tainted VLI
Nov 21 03:45:00 mail EFLAGS: 00010206   (2.6.10-rc2)
Nov 21 03:45:00 mail EIP is at find_inode_fast+0x18/0x60
Nov 21 03:45:00 mail eax: e45fa42c   ebx: 001e4ddb   ecx: 656b203a   edx: 656b203a
Nov 21 03:45:00 mail esi: f7c14600   edi: c18b4db4   ebp: f7c14600   esp: c8701d38
Nov 21 03:45:00 mail ds: 007b   es: 007b   ss: 0068
Nov 21 03:45:00 mail Process find (pid: 2190, threadinfo=c8701000 task=f51cd060)
Nov 21 03:45:00 mail Stack: 00000012 c8701000 c62650b0 001e4ddb c016fc4c f7c14600 c18b4db4 001e4ddb
Nov 21 03:45:00 mail c18b4db4 00000000 c62650b0 001e4ddb 00000000 c01e3643 f7c14600 001e4ddb
Nov 21 03:45:00 mail 00000001 c01cadd8 f7936d60 f7936d60 c62650b0 01000200 f7936d60 00000000
Nov 21 03:45:00 mail Call Trace:
Nov 21 03:45:00 mail [<c016fc4c>] iget_locked+0x6c/0x120
Nov 21 03:45:00 mail [<c01e3643>] xfs_iget+0x53/0x160
Nov 21 03:45:00 mail [<c01cadd8>] xfs_da_brelse+0x98/0x100
Nov 21 03:45:00 mail [<c0200ee4>] xfs_dir_lookup_int+0xb4/0x140
Nov 21 03:45:00 mail [<c0206e45>] xfs_lookup+0x55/0x90
Nov 21 03:45:00 mail [<c0214052>] linvfs_lookup+0x52/0xa0
Nov 21 03:45:00 mail [<c0162461>] real_lookup+0xc1/0xf0
Nov 21 03:45:00 mail [<c016274d>] do_lookup+0x9d/0xb0
Nov 21 03:45:00 mail [<c0162f80>] link_path_walk+0x820/0xed0
Nov 21 03:45:00 mail [<c01638d6>] path_lookup+0x86/0x150
Nov 21 03:45:00 mail [<c0163b63>] __user_walk+0x33/0x60
Nov 21 03:45:00 mail [<c015e2ec>] vfs_lstat+0x1c/0x70
Nov 21 03:45:00 mail [<c015e9e8>] sys_lstat64+0x18/0x40
Nov 21 03:45:00 mail [<c01031a9>] sysenter_past_esp+0x52/0x71
Nov 21 03:45:00 mail Code: 00 eb af 85 db 89 d8 75 c6 eb c2 90 8d b4 26 00 00 00 00 57 56 53 83 ec 04 8b 74 24 14 8b 7c 24 18 8b 5c 24 1c 8b 0f 85 c9 74 13 <8b> 11 8d 44 20 00 39 59 18 89 c8 74 0f 89 d1 85 c9 75 ed 31 c0
Nov 21 03:45:00 mail <6>note: find[2190] exited with preempt_count 1
Nov 21 03:45:00 mail scheduling while atomic: find/0x00000001/2190
Nov 21 03:45:00 mail [<c031f425>] schedule+0x4c5/0x570
Nov 21 03:45:00 mail [<c0142b9b>] unmap_page_range+0x4b/0x80
Nov 21 03:45:00 mail [<c0142d9f>] unmap_vmas+0x1cf/0x1e0
Nov 21 03:45:00 mail [<c0147953>] exit_mmap+0x83/0x160
Nov 21 03:45:00 mail [<c01155c7>] mmput+0x37/0xb0
Nov 21 03:45:00 mail [<c0119ef6>] do_exit+0x166/0x450
Nov 21 03:45:00 mail [<c0112350>] do_page_fault+0x0/0x5f2
Nov 21 03:45:00 mail [<c01043db>] die+0x18b/0x190
Nov 21 03:45:00 mail [<c0112350>] do_page_fault+0x0/0x5f2
Nov 21 03:45:00 mail [<c0117d47>] printk+0x17/0x20
Nov 21 03:45:00 mail [<c0112734>] do_page_fault+0x3e4/0x5f2
Nov 21 03:45:00 mail [<c01d2781>] xfs_dir2_leaf_lookup_int+0x1b1/0x2f0
Nov 21 03:45:00 mail [<c01d2781>] xfs_dir2_leaf_lookup_int+0x1b1/0x2f0
Nov 21 03:45:00 mail [<c020ed21>] pagebuf_free+0xe1/0x100
Nov 21 03:45:00 mail [<c01cadd8>] xfs_da_brelse+0x98/0x100
Nov 21 03:45:00 mail [<c0112350>] do_page_fault+0x0/0x5f2
Nov 21 03:45:00 mail [<c0103c0f>] error_code+0x2b/0x30
Nov 21 03:45:00 mail [<c016f478>] find_inode_fast+0x18/0x60
Nov 21 03:45:00 mail [<c016fc4c>] iget_locked+0x6c/0x120
Nov 21 03:45:00 mail [<c01e3643>] xfs_iget+0x53/0x160
Nov 21 03:45:00 mail [<c01cadd8>] xfs_da_brelse+0x98/0x100
Nov 21 03:45:00 mail [<c0200ee4>] xfs_dir_lookup_int+0xb4/0x140
Nov 21 03:45:00 mail [<c0206e45>] xfs_lookup+0x55/0x90
Nov 21 03:45:00 mail [<c0214052>] linvfs_lookup+0x52/0xa0
Nov 21 03:45:00 mail [<c0162461>] real_lookup+0xc1/0xf0
Nov 21 03:45:00 mail [<c016274d>] do_lookup+0x9d/0xb0
Nov 21 03:45:00 mail [<c0162f80>] link_path_walk+0x820/0xed0
Nov 21 03:45:00 mail [<c01638d6>] path_lookup+0x86/0x150
Nov 21 03:45:00 mail [<c0163b63>] __user_walk+0x33/0x60
Nov 21 03:45:00 mail [<c015e2ec>] vfs_lstat+0x1c/0x70
Nov 21 03:45:00 mail [<c015e9e8>] sys_lstat64+0x18/0x40
Nov 21 03:45:00 mail [<c01031a9>] sysenter_past_esp+0x52/0x71
Nov 21 03:45:00 mail Unable to handle kernel paging request at virtual address 6f666966
Nov 21 03:45:00 mail printing eip:
Nov 21 03:45:00 mail c016f478
Nov 21 03:45:00 mail *pde = 00000000
Nov 21 03:45:00 mail Oops: 0000 [#3]
Nov 21 03:45:00 mail PREEMPT
Nov 21 03:45:00 mail Modules linked in: ipt_TOS ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftpip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables nfs lockd sunrpc rtc usbcore natsemi crc32 b44 mii dm_mod ide_cd cdrom
Nov 21 03:45:00 mail CPU:    0
Nov 21 03:45:00 mail EIP:    0060:[<c016f478>]    Not tainted VLI
Nov 21 03:45:00 mail EFLAGS: 00010206   (2.6.10-rc2)
Nov 21 03:45:00 mail EIP is at find_inode_fast+0x18/0x60
Nov 21 03:45:00 mail eax: e45fa2ec   ebx: 01884a20   ecx: 6f666966   edx: 6f666966
Nov 21 03:45:00 mail esi: f7d47e00   edi: c18d9fa8   ebp: f7d47e00   esp: c5ecad38
Nov 21 03:45:00 mail ds: 007b   es: 007b   ss: 0068
Nov 21 03:45:00 mail Process find (pid: 2283, threadinfo=c5eca000 task=f6f06a00)
Nov 21 03:45:00 mail Stack: 00000021 c5eca000 d923f770 01884a20 c016fc4c f7d47e00 c18d9fa8 01884a20
Nov 21 03:45:00 mail c18d9fa8 00000000 d923f770 01884a20 00000000 c01e3643 f7d47e00 01884a20
Nov 21 03:45:00 mail d923f770 c5ecadf0 c5ecadf8 d923f800 0000007b 01000000 ffffff00 00000000
Nov 21 03:45:00 mail Call Trace:
Nov 21 03:45:00 mail [<c016fc4c>] iget_locked+0x6c/0x120
Nov 21 03:45:00 mail [<c01e3643>] xfs_iget+0x53/0x160
Nov 21 03:45:00 mail [<c0200ee4>] xfs_dir_lookup_int+0xb4/0x140
Nov 21 03:45:00 mail [<c0206e45>] xfs_lookup+0x55/0x90
Nov 21 03:45:00 mail [<c0214052>] linvfs_lookup+0x52/0xa0
Nov 21 03:45:00 mail [<c0162461>] real_lookup+0xc1/0xf0
Nov 21 03:45:00 mail [<c016274d>] do_lookup+0x9d/0xb0
Nov 21 03:45:00 mail [<c0162f80>] link_path_walk+0x820/0xed0
Nov 21 03:45:00 mail [<c01638d6>] path_lookup+0x86/0x150
Nov 21 03:45:00 mail [<c0163b63>] __user_walk+0x33/0x60
Nov 21 03:45:00 mail [<c015e2ec>] vfs_lstat+0x1c/0x70
Nov 21 03:45:00 mail [<c015e9e8>] sys_lstat64+0x18/0x40
Nov 21 03:45:00 mail [<c0138180>] free_pages_bulk+0x100/0x240
Nov 21 03:45:00 mail [<c010f949>] smp_apic_timer_interrupt+0x49/0x90
Nov 21 03:45:00 mail [<c01031a9>] sysenter_past_esp+0x52/0x71
Nov 21 03:45:00 mail Code: 00 eb af 85 db 89 d8 75 c6 eb c2 90 8d b4 26 00 00 00 00 57 56 53 83 ec 04 8b 74 24 14 8b 7c 24 18 8b 5c 24 1c 8b 0f 85 c9 74 13 <8b> 11 8d 44 20 00 39 59 18 89 c8 74 0f 89 d1 85 c9 75 ed 31 c0
Nov 21 03:45:00 mail <6>note: find[2283] exited with preempt_count 1
Nov 21 03:45:00 mail scheduling while atomic: find/0x00000001/2283
Nov 21 03:45:00 mail [<c031f425>] schedule+0x4c5/0x570
Nov 21 03:45:00 mail [<c0142b9b>] unmap_page_range+0x4b/0x80
Nov 21 03:45:00 mail [<c0142d9f>] unmap_vmas+0x1cf/0x1e0
Nov 21 03:45:00 mail [<c0147953>] exit_mmap+0x83/0x160
Nov 21 03:45:00 mail [<c01155c7>] mmput+0x37/0xb0
Nov 21 03:45:00 mail [<c0119ef6>] do_exit+0x166/0x450
Nov 21 03:45:00 mail [<c0112350>] do_page_fault+0x0/0x5f2
Nov 21 03:45:00 mail [<c01043db>] die+0x18b/0x190
Nov 21 03:45:00 mail [<c0112350>] do_page_fault+0x0/0x5f2
Nov 21 03:45:00 mail [<c0117d47>] printk+0x17/0x20
Nov 21 03:45:00 mail [<c0112734>] do_page_fault+0x3e4/0x5f2
Nov 21 03:45:00 mail [<c020ed21>] pagebuf_free+0xe1/0x100
Nov 21 03:45:00 mail [<c01cadd8>] xfs_da_brelse+0x98/0x100
Nov 21 03:45:00 mail [<c01ca996>] xfs_da_state_free+0x66/0x90
Nov 21 03:45:00 mail [<c0112350>] do_page_fault+0x0/0x5f2
Nov 21 03:45:00 mail [<c0103c0f>] error_code+0x2b/0x30
Nov 21 03:45:00 mail [<c016f478>] find_inode_fast+0x18/0x60
Nov 21 03:45:00 mail [<c016fc4c>] iget_locked+0x6c/0x120
Nov 21 03:45:00 mail [<c01e3643>] xfs_iget+0x53/0x160
Nov 21 03:45:00 mail [<c0200ee4>] xfs_dir_lookup_int+0xb4/0x140
Nov 21 03:45:00 mail [<c0206e45>] xfs_lookup+0x55/0x90
Nov 21 03:45:00 mail [<c0214052>] linvfs_lookup+0x52/0xa0
Nov 21 03:45:00 mail [<c0162461>] real_lookup+0xc1/0xf0
Nov 21 03:45:00 mail [<c016274d>] do_lookup+0x9d/0xb0
Nov 21 03:45:00 mail [<c0162f80>] link_path_walk+0x820/0xed0
Nov 21 03:45:00 mail [<c01638d6>] path_lookup+0x86/0x150
Nov 21 03:45:00 mail [<c0163b63>] __user_walk+0x33/0x60
Nov 21 03:45:00 mail [<c015e2ec>] vfs_lstat+0x1c/0x70
Nov 21 03:45:00 mail [<c015e9e8>] sys_lstat64+0x18/0x40
Nov 21 03:45:00 mail [<c0138180>] free_pages_bulk+0x100/0x240
Nov 21 03:45:00 mail [<c010f949>] smp_apic_timer_interrupt+0x49/0x90
Nov 21 03:45:00 mail [<c01031a9>] sysenter_past_esp+0x52/0x71
Nov 21 03:45:52 mail Unable to handle kernel paging request at virtual address 302f303d
Nov 21 03:45:52 mail printing eip:
Nov 21 03:45:52 mail c016f1e8
Nov 21 03:45:52 mail *pde = 00000000
Nov 21 03:45:52 mail Oops: 0002 [#4]
Nov 21 03:45:52 mail PREEMPT
Nov 21 03:45:52 mail Modules linked in: ipt_TOS ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftpip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables nfs lockd sunrpc rtc usbcore natsemi crc32 b44 mii dm_mod ide_cd cdrom
Nov 21 03:45:52 mail CPU:    0
Nov 21 03:45:52 mail EIP:    0060:[<c016f1e8>]    Not tainted VLI
Nov 21 03:45:52 mail EFLAGS: 00010206   (2.6.10-rc2)
Nov 21 03:45:52 mail EIP is at prune_icache+0x58/0x210
Nov 21 03:45:52 mail eax: 302f303d   ebx: e45f8c14   ecx: c035c21c   edx: c035c21c
Nov 21 03:45:52 mail esi: e45f8c0c   edi: 0000005a   ebp: c1b1d000   esp: c1b1dee0
Nov 21 03:45:52 mail ds: 007b   es: 007b   ss: 0068
Nov 21 03:45:52 mail Process kswapd0 (pid: 135, threadinfo=c1b1d000 task=c1b11060)
Nov 21 03:45:52 mail Stack: f0962d2c 00000073 0000005a f0962d34 e50a96f4 00000000 00000083 c1b1d000
Nov 21 03:45:52 mail c18dea20 c016f3c2 00000080 c013f622 00000080 000000d0 c1b1d000 0002eccc
Nov 21 03:45:52 mail 00217f00 00000000 0000000b 00000000 00000001 c035af64 c035ae40 0000000b
Nov 21 03:45:52 mail Call Trace:
Nov 21 03:45:52 mail [<c016f3c2>] shrink_icache_memory+0x22/0x50
Nov 21 03:45:52 mail [<c013f622>] shrink_slab+0x122/0x190
Nov 21 03:45:52 mail [<c0140abf>] balance_pgdat+0x20f/0x2d0
Nov 21 03:45:52 mail [<c0140c41>] kswapd+0xc1/0xe0
Nov 21 03:45:52 mail [<c012c380>] autoremove_wake_function+0x0/0x60
Nov 21 03:45:52 mail [<c01030d2>] ret_from_fork+0x6/0x14
Nov 21 03:45:52 mail [<c012c380>] autoremove_wake_function+0x0/0x60
Nov 21 03:45:52 mail [<c0140b80>] kswapd+0x0/0xe0
Nov 21 03:45:52 mail [<c01012c5>] kernel_thread_helper+0x5/0x10
Nov 21 03:45:52 mail Code: 00 00 b8 00 f0 ff ff 21 e0 ff 40 14 31 ff 8b 54 24 28 39 54 24 04 0f 8d d7 00 00 00 89 c5 eb 2f 8d 76 00 8b 43 04 8b 13 89 42 04 <89> 10 a1 1c c2 35 c0 89 58 04 89 03 c7 43 04 1c c2 35 c0 89 1d
Nov 21 03:45:52 mail <6>note: kswapd0[135] exited with preempt_count 1


[3.] Keywords (i.e., modules, networking, kernel):
Modules:
mail linux-2.6.10-rc2 # lsmod
Module                  Size  Used by
ipt_TOS                 1920  12
ipt_REJECT              5504  4
ipt_pkttype             1280  4
ipt_LOG                 6016  9
ipt_state               1408  15
ipt_multiport           1600  6
ipt_conntrack           1984  0
iptable_mangle          2048  1
ip_nat_irc              3632  0
ip_nat_tftp             3248  0
ip_nat_ftp              4400  0
iptable_nat            27780  3 ip_nat_irc,ip_nat_tftp,ip_nat_ftp
ip_conntrack_irc       70576  1 ip_nat_irc
ip_conntrack_tftp       2992  0
ip_conntrack_ftp       71472  1 ip_nat_ftp
ip_conntrack           51932  9 ipt_state,ipt_conntrack,ip_nat_irc,ip_nat_tftp,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_tftp,ip_conntrack_ftp
iptable_filter          2816  1
ip_tables              19648  10 ipt_TOS,ipt_REJECT,ipt_pkttype,ipt_LOG,ipt_state,ipt_multiport,ipt_conntrack,iptable_mangle,iptable_nat,iptable_filter
nfs                   202660  4
lockd                  62056  1 nfs
sunrpc                133412  7 nfs,lockd
rtc                    10488  0
usbcore               105976  1
natsemi                25184  0
crc32                   3840  1 natsemi
b44                    19780  0
mii                     4160  1 b44
dm_mod                 52796  6
ide_cd                 37792  0
cdrom                  38044  1 ide_cd
mail linux-2.6.10-rc2 #  

Networking:
  Bus  0, device   9, function  0:
    Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 1).
      IRQ 18.
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xf7000000 [0xf7001fff].
  Bus  0, device  15, function  0:
    Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller (rev 0).
      IRQ 18.
      Master Capable.  Latency=32.  Min Gnt=11.Max Lat=52.
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xef800000 [0xef800fff].

Kernel:
mail linux-2.6.10-rc2 # uname -a
Linux mail 2.6.10-rc2 #1 Mon Nov 15 19:29:56 CET 2004 i686 AMD Athlon (TM) AuthenticAMD GNU/Linux


[4.] Kernel version (from /proc/version):
mail linux-2.6.10-rc2 # cat /proc/version
Linux version 2.6.10-rc2 (root@mail) (gcc version 3.4.3 (Gentoo Hardened Linux 3.4.3, ssp-3.4.3-0, pie-8.7.6.6)) #1 Mon Nov 15 19:29:56 CET 2004


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
Don't know exactly what to do.


[6.] A small shell script or example program which triggers the
     problem (if possible)
Don't have one.


[7.] Environment
Gentoo Linux:
Reading specs from /usr/lib/gcc/i686-pc-linux-gnu/3.4.3/specs
Configured with: /var/tmp/portage/gcc-3.4.3/work/gcc-3.4.3/configure --enable-version-specific-runtime-libs --prefix=/usr --bindir=/usr/i686-pc-linux-gnu/gcc-bin/3.4 --includedir=/usr/lib/gcc/i686-pc-linux-gnu/3.4.3/include --datadir=/usr/share/gcc-data/i686-pc-linux-gnu/3.4 --mandir=/usr/share/gcc-data/i686-pc-linux-gnu/3.4/man --infodir=/usr/share/gcc-data/i686-pc-linux-gnu/3.4/info --with-gxx-include-dir=/usr/lib/gcc/i686-pc-linux-gnu/3.4.3/include/g++-v3 --host=i686-pc-linux-gnu --disable-altivec --enable-nls --without-included-gettext --enable-__cxa_atexit --enable-clocale=gnu --enable-shared --with-system-zlib --disable-checking --disable-werror --disable-libunwind-exceptions --enable-threads=posix --disable-multilib --disable-libgcj --enable-languages=c,c++
Thread model: posix
gcc version 3.4.3  (Gentoo Hardened Linux 3.4.3, ssp-3.4.3-0, pie-8.7.6.6)

System: AMD Athlon 1.4 GHz with 1GB Memory


[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mail 2.6.10-rc2 #1 Mon Nov 15 19:29:56 CET 2004 i686 AMD Athlon (TM) AuthenticAMD GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           1.0.1
xfsprogs               2.6.25
quota-tools            3.06.
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ipt_TOS ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables nfs lockd sunrpc rtc usbcore natsemi crc32 b44 mii dm_mod ide_cd cdrom


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon (TM)
stepping        : 4
cpu MHz         : 1400.719
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr pni syscall mmxext 3dnowext 3dnow
bogomips        : 2768.89


[7.3.] Module information (from /proc/modules):
ipt_TOS 1920 12 - Live 0xf8951000
ipt_REJECT 5504 4 - Live 0xf89c5000
ipt_pkttype 1280 4 - Live 0xf89b6000
ipt_LOG 6016 9 - Live 0xf89ba000
ipt_state 1408 15 - Live 0xf89b4000
ipt_multiport 1600 6 - Live 0xf8955000
ipt_conntrack 1984 0 - Live 0xf8953000
iptable_mangle 2048 1 - Live 0xf88b7000
ip_nat_irc 3632 0 - Live 0xf88b5000
ip_nat_tftp 3248 0 - Live 0xf88b3000
ip_nat_ftp 4400 0 - Live 0xf88b0000
iptable_nat 27780 3 ip_nat_irc,ip_nat_tftp,ip_nat_ftp, Live 0xf898b000
ip_conntrack_irc 70576 1 ip_nat_irc, Live 0xf893e000
ip_conntrack_tftp 2992 0 - Live 0xf88a5000
ip_conntrack_ftp 71472 1 ip_nat_ftp, Live 0xf892b000
ip_conntrack 51932 9 ipt_state,ipt_conntrack,ip_nat_irc,ip_nat_tftp,ip_nat_ftp,iptable_nat,ip_conntrack_irc,ip_conntrack_tftp,ip_conntrack_ftp, Live 0xf891d000
iptable_filter 2816 1 - Live 0xf888e000
ip_tables 19648 10 ipt_TOS,ipt_REJECT,ipt_pkttype,ipt_LOG,ipt_state,ipt_multiport,ipt_conntrack,iptable_mangle,iptable_nat,iptable_filter, Live 0xf88aa000
nfs 202660 4 - Live 0xf8958000
lockd 62056 1 nfs, Live 0xf88d7000
sunrpc 133412 7 nfs,lockd, Live 0xf88fb000
rtc 10488 0 - Live 0xf8890000
usbcore 105976 1 - Live 0xf88bc000
natsemi 25184 0 - Live 0xf8894000
crc32 3840 1 natsemi, Live 0xf8851000
b44 19780 0 - Live 0xf8873000
mii 4160 1 b44, Live 0xf884e000
dm_mod 52796 6 - Live 0xf887d000
ide_cd 37792 0 - Live 0xf8861000
cdrom 38044 1 ide_cd, Live 0xf8856000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0291 : pnp 00:0e
02f8-02ff : serial
0370-0372 : pnp 00:0e
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
b400-b40f : 0000:00:11.1
  b400-b407 : ide0
  b408-b40f : ide1
b800-b81f : 0000:00:10.2
d000-d01f : 0000:00:10.1
d400-d41f : 0000:00:10.0
d800-d8ff : 0000:00:0f.0
  d800-d8ff : natsemi
e000-e0ff : 0000:00:11.5
e400-e47f : motherboard
  e400-e403 : PM1a_EVT_BLK
  e404-e405 : PM1a_CNT_BLK
  e408-e40b : PM_TMR
  e420-e423 : GPE0_BLK
e800-e81f : motherboard
  e800-e81f : pnp 00:01

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3fffbfff : System RAM
  00100000-003211c0 : Kernel code
  003211c1-003cf2ff : Kernel data
3fffc000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
ef000000-ef0000ff : 0000:00:10.3
ef800000-ef800fff : 0000:00:0f.0
  ef800000-ef800fff : natsemi
f0000000-f3ffffff : 0000:00:0c.0
f7000000-f7001fff : 0000:00:09.0
  f7000000-f7001fff : b44
f8000000-fbffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
0000:00:00.0 Class 0600: 1106:3099
        Subsystem: 1043:807f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:01.0 Class 0604: 1106:b099
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 Class 0200: 14e4:4401 (rev 01)
        Subsystem: 1043:80a8
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f7000000 (32-bit, non-prefetchable) [size=f7ff0000]
        Expansion ROM at 00004000 [disabled]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:0c.0 Class 0300: 5333:5631 (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=f7fe0000]
        Expansion ROM at 00010000 [disabled]

0000:00:0f.0 Class 0200: 100b:0020
        Subsystem: 1385:f312
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2750ns min, 13000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d800
        Region 1: Memory at ef800000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:00:10.0 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1043:808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.1 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1043:808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 0
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.2 Class 0c03: 1106:3038 (rev 80)
        Subsystem: 1043:808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 0
        Region 4: I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.3 Class 0c03: 1106:3104 (rev 82) (prog-if 20)
        Subsystem: 1043:808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 0
        Region 0: Memory at ef000000 (32-bit, non-prefetchable)
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 Class 0601: 1106:3177
        Subsystem: 1043:808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: 1043:808c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at b400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.5 Class 0401: 1106:3059 (rev 50)
        Subsystem: 1043:8095
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 0
        Region 0: I/O ports at e000
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Not a SCSI system


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
# grep -v "^$\|^#" /usr/src/linux-2.6.10-rc2/.config
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MATH_EMULATION=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_APM=m
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_PCMCIA_PROBE=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPACPI=y
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDE_CHIPSETS=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_MD=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_ZERO=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_IP_TCPDIAG=m
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_IP_SCTP=m
CONFIG_SCTP_HMAC_SHA1=y
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
CONFIG_NET_PCI=y
CONFIG_B44=m
CONFIG_E100=m
CONFIG_E100_NAPI=y
CONFIG_NATSEMI=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
CONFIG_8139_OLD_RX_RESET=y
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_SHAPER=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m
CONFIG_I2C_ISA=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_EEPROM=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=m
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=y
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=852
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-15"
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp852"
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_EARLY_PRINTK=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

# mount
/dev/hda3 on / type xfs (rw,noatime,logbufs=8,logbsize=32768)
none on /dev type devfs (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw)
tmpfs on /mnt/.init.d type tmpfs (rw)
/dev/vg/usr on /usr type xfs (rw,noatime,logbufs=8,logbsize=32768)
/dev/vg/home on /home type xfs (rw,noatime,logbufs=8,logbsize=32768)
/dev/vg/opt on /opt type xfs (rw,noatime,logbufs=8,logbsize=32768)
/dev/vg/var on /var type xfs (rw,noatime,logbufs=8,logbsize=32768)
/dev/vg/tmp on /tmp type xfs (rw,noatime,logbufs=8,logbsize=32768)
none on /dev/shm type tmpfs (rw)
none on /proc/bus/usb type usbfs (rw)
/mnt/.init.d on /var/lib/init.d type none (rw,bind)
ns2.vunet.local:/gentoo.portage/distfiles on /usr/portage/distfiles type nfs (rw,vers=3,hard,intr,nolock,rsize=8192,wsize=8192,addr=192.168.0.111)
ns2.vunet.local:/gentoo.portage/packages/server/hardened/tbird on /usr/portage/packages type nfs (rw,vers=3,hard,intr,nolock,rsize=8192,wsize=8192,addr=192.168.0.111)
ns2.vunet.local:/gentoo.scripts on /mnt/gentoo.scripts type nfs (rw,vers=3,hard,intr,nolock,rsize=8192,wsize=8192,addr=192.168.0.111)
ns2.vunet.local:/gentoo.overlay on /mnt/gentoo.overlay type nfs (rw,vers=3,hard,intr,nolock,rsize=8192,wsize=8192,addr=192.168.0.111


[X.] Other notes, patches, fixes, workarounds:

