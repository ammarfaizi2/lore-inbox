Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTKYOTD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 09:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbTKYOTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 09:19:03 -0500
Received: from netlx014.civ.utwente.nl ([130.89.1.88]:1872 "EHLO
	netlx014.civ.utwente.nl") by vger.kernel.org with ESMTP
	id S262580AbTKYOSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 09:18:55 -0500
Date: Tue, 25 Nov 2003 15:18:49 +0100 (CET)
From: Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: test10 Oops : Probably smb related
Message-ID: <Pine.LNX.4.44.0311251512150.16698-100000@sarijopen.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ave people

When I'm copying from a samba mount to an xfs filesystem (local)  I
sometimes get an oops. The Oops also occures in test9. I tested both 
preempt and non-preempt. System is debian woody with vanilla test10 
kernel+ qc-usb kernel module.

If you need more info,please ask.

Greetz Mu

The relevant snippet from /var/log/messages.
Nov 25 02:30:32 bentocam kernel: SMB connection re-established (-5)
Nov 25 02:31:01 bentocam kernel:  printing eip:
Nov 25 02:31:01 bentocam kernel: e097db79
Nov 25 02:31:01 bentocam kernel: Oops: 0000 [#1]
Nov 25 02:31:01 bentocam kernel: CPU:    0
Nov 25 02:31:01 bentocam kernel: EIP:    0060:[_end+543222321/1070132920]    Not tainted
Nov 25 02:31:01 bentocam kernel: EFLAGS: 00010246
Nov 25 02:31:01 bentocam kernel: EIP is at smb_add_request+0x259/0x2f0 [smbfs]
Nov 25 02:31:01 bentocam kernel: eax: cc1b4ef8   ebx: cc1b4f60   ecx: cc1b4f60   edx: d8d0ff00
Nov 25 02:31:01 bentocam kernel: esi: c9f93c94   edi: d8d0ff0c   ebp: c9f93ca8   esp: c9f93c7c
Nov 25 02:31:01 bentocam kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 02:31:01 bentocam kernel: Process cp (pid: 8457, threadinfo=c9f92000 task=c39869d0)
Nov 25 02:31:01 bentocam kernel: Stack: d8d0ff00 d8d0ff00 ffffffff cc1b4f60 00000000 cc1b4ef8 00000000 c39869d0 
Nov 25 02:31:01 bentocam kernel:        c01162a0 00100100 00200200 c9f93cc0 e0976da1 d8d0ff00 d8d0ff00 00000000 
Nov 25 02:31:01 bentocam kernel:        00000000 c9f93ce8 e0977925 d8d0ff00 0000002e 0000000c ffffffff 00000000 
Nov 25 02:31:01 bentocam kernel: Call Trace:
Nov 25 02:31:01 bentocam kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 25 02:31:01 bentocam kernel:  [_end+543194201/1070132920] smb_request_ok+0x21/0x70 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543197149/1070132920] smb_proc_readX+0xc5/0xf0 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543216787/1070132920] smb_readpage_sync+0xcb/0x150 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543216958/1070132920] smb_readpage+0x26/0xb0 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [read_pages+174/368] read_pages+0xae/0x170
Nov 25 02:31:01 bentocam kernel:  [do_page_cache_readahead+225/272] do_page_cache_readahead+0xe1/0x110
Nov 25 02:31:01 bentocam kernel:  [page_cache_readahead+233/288] page_cache_readahead+0xe9/0x120
Nov 25 02:31:01 bentocam kernel:  [do_generic_mapping_read+101/1136] do_generic_mapping_read+0x65/0x470
Nov 25 02:31:01 bentocam kernel:  [__generic_file_aio_read+384/416] __generic_file_aio_read+0x180/0x1a0
Nov 25 02:31:01 bentocam kernel:  [file_read_actor+0/224] file_read_actor+0x0/0xe0
Nov 25 02:31:01 bentocam kernel:  [_end+543867743/1070132920] linvfs_write+0xd7/0xf0 [xfs]
Nov 25 02:31:01 bentocam kernel:  [generic_file_read+127/160] generic_file_read+0x7f/0xa0
Nov 25 02:31:01 bentocam kernel:  [do_sync_write+127/176] do_sync_write+0x7f/0xb0
Nov 25 02:31:01 bentocam kernel:  [recalc_task_prio+327/352] recalc_task_prio+0x147/0x160
Nov 25 02:31:01 bentocam kernel:  [_end+543217810/1070132920] smb_file_read+0x4a/0x60 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [vfs_read+158/208] vfs_read+0x9e/0xd0
Nov 25 02:31:01 bentocam kernel:  [sys_read+48/80] sys_read+0x30/0x50
Nov 25 02:31:01 bentocam kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 02:31:01 bentocam kernel: 
Nov 25 02:31:01 bentocam kernel: Code: 8b 42 1c 50 52 68 81 01 98 e0 68 e0 01 98 e0 e8 03 ba 79 df 
Nov 25 02:31:01 bentocam kernel:  <1>Unable to handle kernel paging request at virtual address cf67ff1c
Nov 25 02:31:01 bentocam kernel:  printing eip:
Nov 25 02:31:01 bentocam kernel: e097db79
Nov 25 02:31:01 bentocam kernel: Oops: 0000 [#2]
Nov 25 02:31:01 bentocam kernel: CPU:    0
Nov 25 02:31:01 bentocam kernel: EIP:    0060:[_end+543222321/1070132920]    Not tainted
Nov 25 02:31:01 bentocam kernel: EFLAGS: 00010246
Nov 25 02:31:01 bentocam kernel: EIP is at smb_add_request+0x259/0x2f0 [smbfs]
Nov 25 02:31:01 bentocam kernel: eax: cc1b4ef8   ebx: cc1b4f60   ecx: cc1b4f60   edx: cf67ff00
Nov 25 02:31:01 bentocam kernel: esi: da197c94   edi: cf67ff0c   ebp: da197ca8   esp: da197c7c
Nov 25 02:31:01 bentocam kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 02:31:01 bentocam kernel: Process cp (pid: 8558, threadinfo=da196000 task=d83139d0)
Nov 25 02:31:01 bentocam kernel: Stack: cf67ff00 cf67ff00 ffffffff cc1b4f60 00000000 cc1b4ef8 00000000 d83139d0 
Nov 25 02:31:01 bentocam kernel:        c01162a0 00100100 00200200 da197cc0 e0976da1 cf67ff00 cf67ff00 00000000 
Nov 25 02:31:01 bentocam kernel:        00000000 da197ce8 e0977925 cf67ff00 0000002e 0000000c ffffffff 00000000 
Nov 25 02:31:01 bentocam kernel: Call Trace:
Nov 25 02:31:01 bentocam kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 25 02:31:01 bentocam kernel:  [_end+543194201/1070132920] smb_request_ok+0x21/0x70 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543197149/1070132920] smb_proc_readX+0xc5/0xf0 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543216787/1070132920] smb_readpage_sync+0xcb/0x150 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543216958/1070132920] smb_readpage+0x26/0xb0 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [read_pages+174/368] read_pages+0xae/0x170
Nov 25 02:31:01 bentocam kernel:  [do_page_cache_readahead+225/272] do_page_cache_readahead+0xe1/0x110
Nov 25 02:31:01 bentocam kernel:  [page_cache_readahead+233/288] page_cache_readahead+0xe9/0x120
Nov 25 02:31:01 bentocam kernel:  [do_generic_mapping_read+101/1136] do_generic_mapping_read+0x65/0x470
Nov 25 02:31:01 bentocam kernel:  [__generic_file_aio_read+384/416] __generic_file_aio_read+0x180/0x1a0
Nov 25 02:31:01 bentocam kernel:  [file_read_actor+0/224] file_read_actor+0x0/0xe0
Nov 25 02:31:01 bentocam kernel:  [_end+543867743/1070132920] linvfs_write+0xd7/0xf0 [xfs]
Nov 25 02:31:01 bentocam kernel:  [generic_file_read+127/160] generic_file_read+0x7f/0xa0
Nov 25 02:31:01 bentocam kernel:  [do_sync_write+127/176] do_sync_write+0x7f/0xb0
Nov 25 02:31:01 bentocam kernel:  [_end+543031733/1070132920] usb_hcd_irq+0x2d/0x60 [usbcore]
Nov 25 02:31:01 bentocam kernel:  [recalc_task_prio+327/352] recalc_task_prio+0x147/0x160
Nov 25 02:31:01 bentocam kernel:  [_end+543217810/1070132920] smb_file_read+0x4a/0x60 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [vfs_read+158/208] vfs_read+0x9e/0xd0
Nov 25 02:31:01 bentocam kernel:  [sys_read+48/80] sys_read+0x30/0x50
Nov 25 02:31:01 bentocam kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 02:31:01 bentocam kernel: 
Nov 25 02:31:01 bentocam kernel: Code: 8b 42 1c 50 52 68 81 01 98 e0 68 e0 01 98 e0 e8 03 ba 79 df 
Nov 25 02:31:01 bentocam kernel:  <1>Unable to handle kernel paging request at virtual address da273f1c
Nov 25 02:31:01 bentocam kernel:  printing eip:
Nov 25 02:31:01 bentocam kernel: e097db79
Nov 25 02:31:01 bentocam kernel: Oops: 0000 [#3]
Nov 25 02:31:01 bentocam kernel: CPU:    0
Nov 25 02:31:01 bentocam kernel: EIP:    0060:[_end+543222321/1070132920]    Not tainted
Nov 25 02:31:01 bentocam kernel: EFLAGS: 00010246
Nov 25 02:31:01 bentocam kernel: EIP is at smb_add_request+0x259/0x2f0 [smbfs]
Nov 25 02:31:01 bentocam kernel: eax: cc1b4ef8   ebx: cc1b4f60   ecx: cc1b4f60   edx: da273f00
Nov 25 02:31:01 bentocam kernel: esi: d93cdc94   edi: da273f0c   ebp: d93cdca8   esp: d93cdc7c
Nov 25 02:31:01 bentocam kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 02:31:01 bentocam kernel: Process cp (pid: 8568, threadinfo=d93cc000 task=cb42d9d0)
Nov 25 02:31:01 bentocam kernel: Stack: da273f00 da273f00 ffffffff cc1b4f60 00000000 cc1b4ef8 00000000 cb42d9d0 
Nov 25 02:31:01 bentocam kernel:        c01162a0 00100100 00200200 d93cdcc0 e0976da1 da273f00 da273f00 00000000 
Nov 25 02:31:01 bentocam kernel:        00000000 d93cdce8 e0977925 da273f00 0000002e 0000000c ffffffff 00000000 
Nov 25 02:31:01 bentocam kernel: Call Trace:
Nov 25 02:31:01 bentocam kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 25 02:31:01 bentocam kernel:  [_end+543194201/1070132920] smb_request_ok+0x21/0x70 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543197149/1070132920] smb_proc_readX+0xc5/0xf0 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543216787/1070132920] smb_readpage_sync+0xcb/0x150 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543216958/1070132920] smb_readpage+0x26/0xb0 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [read_pages+174/368] read_pages+0xae/0x170
Nov 25 02:31:01 bentocam kernel:  [do_page_cache_readahead+225/272] do_page_cache_readahead+0xe1/0x110
Nov 25 02:31:01 bentocam kernel:  [page_cache_readahead+233/288] page_cache_readahead+0xe9/0x120
Nov 25 02:31:01 bentocam kernel:  [do_generic_mapping_read+101/1136] do_generic_mapping_read+0x65/0x470
Nov 25 02:31:01 bentocam kernel:  [__generic_file_aio_read+384/416] __generic_file_aio_read+0x180/0x1a0
Nov 25 02:31:01 bentocam kernel:  [file_read_actor+0/224] file_read_actor+0x0/0xe0
Nov 25 02:31:01 bentocam kernel:  [_end+543867743/1070132920] linvfs_write+0xd7/0xf0 [xfs]
Nov 25 02:31:01 bentocam kernel:  [generic_file_read+127/160] generic_file_read+0x7f/0xa0
Nov 25 02:31:01 bentocam kernel:  [do_sync_write+127/176] do_sync_write+0x7f/0xb0
Nov 25 02:31:01 bentocam kernel:  [recalc_task_prio+327/352] recalc_task_prio+0x147/0x160
Nov 25 02:31:01 bentocam kernel:  [_end+543217810/1070132920] smb_file_read+0x4a/0x60 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [vfs_read+158/208] vfs_read+0x9e/0xd0
Nov 25 02:31:01 bentocam kernel:  [sys_read+48/80] sys_read+0x30/0x50
Nov 25 02:31:01 bentocam kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 02:31:01 bentocam kernel: 
Nov 25 02:31:01 bentocam kernel: Code: 8b 42 1c 50 52 68 81 01 98 e0 68 e0 01 98 e0 e8 03 ba 79 df 
Nov 25 02:31:01 bentocam kernel:  <1>Unable to handle kernel paging request at virtual address cec72f1c
Nov 25 02:31:01 bentocam kernel:  printing eip:
Nov 25 02:31:01 bentocam kernel: e097db79
Nov 25 02:31:01 bentocam kernel: Oops: 0000 [#4]
Nov 25 02:31:01 bentocam kernel: CPU:    0
Nov 25 02:31:01 bentocam kernel: EIP:    0060:[_end+543222321/1070132920]    Not tainted
Nov 25 02:31:01 bentocam kernel: EFLAGS: 00010246
Nov 25 02:31:01 bentocam kernel: EIP is at smb_add_request+0x259/0x2f0 [smbfs]
Nov 25 02:31:01 bentocam kernel: eax: cc1b4ef8   ebx: cc1b4f60   ecx: cc1b4f60   edx: cec72f00
Nov 25 02:31:01 bentocam kernel: esi: db739c94   edi: cec72f0c   ebp: db739ca8   esp: db739c7c
Nov 25 02:31:01 bentocam kernel: ds: 007b   es: 007b   ss: 0068
Nov 25 02:31:01 bentocam kernel: Process cp (pid: 8600, threadinfo=db738000 task=cf2069d0)
Nov 25 02:31:01 bentocam kernel: Stack: cec72f00 cec72f00 ffffffff cc1b4f60 00000000 cc1b4ef8 00000000 cf2069d0 
Nov 25 02:31:01 bentocam kernel:        c01162a0 00100100 00200200 db739cc0 e0976da1 cec72f00 cec72f00 00000000 
Nov 25 02:31:01 bentocam kernel:        00000000 db739ce8 e0977925 cec72f00 0000002e 0000000c ffffffff 00000000 
Nov 25 02:31:01 bentocam kernel: Call Trace:
Nov 25 02:31:01 bentocam kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Nov 25 02:31:01 bentocam kernel:  [_end+543194201/1070132920] smb_request_ok+0x21/0x70 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543197149/1070132920] smb_proc_readX+0xc5/0xf0 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543216787/1070132920] smb_readpage_sync+0xcb/0x150 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543216958/1070132920] smb_readpage+0x26/0xb0 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [read_pages+174/368] read_pages+0xae/0x170
Nov 25 02:31:01 bentocam kernel:  [do_page_cache_readahead+225/272] do_page_cache_readahead+0xe1/0x110
Nov 25 02:31:01 bentocam kernel:  [page_cache_readahead+233/288] page_cache_readahead+0xe9/0x120
Nov 25 02:31:01 bentocam kernel:  [do_generic_mapping_read+101/1136] do_generic_mapping_read+0x65/0x470
Nov 25 02:31:01 bentocam kernel:  [__generic_file_aio_read+384/416] __generic_file_aio_read+0x180/0x1a0
Nov 25 02:31:01 bentocam kernel:  [file_read_actor+0/224] file_read_actor+0x0/0xe0
Nov 25 02:31:01 bentocam kernel:  [_end+543867743/1070132920] linvfs_write+0xd7/0xf0 [xfs]
Nov 25 02:31:01 bentocam kernel:  [generic_file_read+127/160] generic_file_read+0x7f/0xa0
Nov 25 02:31:01 bentocam kernel:  [do_sync_write+127/176] do_sync_write+0x7f/0xb0
Nov 25 02:31:01 bentocam kernel:  [_end+543214022/1070132920] smb_revalidate_inode+0x2e/0x40 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [_end+543217810/1070132920] smb_file_read+0x4a/0x60 [smbfs]
Nov 25 02:31:01 bentocam kernel:  [vfs_read+158/208] vfs_read+0x9e/0xd0
Nov 25 02:31:01 bentocam kernel:  [sys_read+48/80] sys_read+0x30/0x50
Nov 25 02:31:01 bentocam kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 25 02:31:01 bentocam kernel: 
Nov 25 02:31:01 bentocam kernel: Code: 8b 42 1c 50 52 68 81 01 98 e0 68 e0 01 98 e0 e8 03 ba 79 df 









