Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbTDKREE (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTDKREE (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:04:04 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:8893 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id S261316AbTDKREB (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 13:04:01 -0400
Message-ID: <3E96F825.5080004@blue-labs.org>
Date: Fri, 11 Apr 2003 13:15:17 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030403
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.67, remove_wait_queue, devfs_d_revalidate_wait
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 917; timestamp 2003-04-11 13:15:19, message serial number 913131
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS: server cheating in read reply: count 16384 > recvd 1000
eip: c0120850
------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:123!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0120883>]    Not tainted
EFLAGS: 00010086
EIP is at remove_wait_queue+0x33/0x90
eax: 0000000e   ebx: ded8bdc4   ecx: c040d13c   edx: 00003e2f
esi: d4c47da8   edi: 00000286   ebp: d4c47d6c   esp: d4c47d50
ds: 007b   es: 007b   ss: 0068
Process procmail (pid: 29203, threadinfo=d4c46000 task=df472140)
Stack: c03a1fd7 c0120850 da272ddc da272c40 d4c47da8 ded8bdc4 dfe133fc 
d4c47dd4
       c01a6410 c04145c0 c0457bc0 d4c47f20 ded8bdc0 dff27424 00000000 
df472140
       c011e440 00000000 00000000 00000040 00000000 dee50fc4 00000000 
df472140
Call Trace:
 [<c0120850>] remove_wait_queue+0x0/0x90
 [<c01a6410>] devfs_d_revalidate_wait+0x1b0/0x1c0
 [<c011e440>] default_wake_function+0x0/0x20
 [<c011e440>] default_wake_function+0x0/0x20
 [<c016a69c>] do_lookup+0x5c/0xb0
 [<c016ac16>] link_path_walk+0x526/0x9f0
 [<c037a2a0>] unix_find_other+0xc0/0x170
 [<c0143381>] check_poison_obj+0x41/0x1c0
 [<c037a7ec>] unix_dgram_connect+0x10c/0x1b0
 [<c0329636>] sys_connect+0x76/0xa0
 [<c0328271>] sock_map_fd+0x121/0x140
 [<c032922a>] sys_socket+0x3a/0x60
 [<c032a190>] sys_socketcall+0xc0/0x270
 [<c016eb3f>] do_fcntl+0xff/0x1d0
 [<c016ecc0>] sys_fcntl64+0x50/0xa0
 [<c0109863>] syscall_call+0x7/0xb

Code: 0f 0b 7b 00 a7 1f 3a c0 f0 fe 0b 0f 88 1b 1d 00 00 8b 56 10
 buffer layer error at fs/buffer.c:127
Call Trace:
 [<c015d230>] __wait_on_buffer+0xd0/0xe0
 [<c0120ad0>] autoremove_wake_function+0x0/0x50
 [<c0120ad0>] autoremove_wake_function+0x0/0x50
 [<c0200e08>] reiserfs_unmap_buffer+0x68/0xb0
 [<c0200eb8>] unmap_buffers+0x68/0x70
 [<c0201095>] indirect2direct+0x1d5/0x2b0
 [<c01fecc4>] reiserfs_cut_from_item+0x3d4/0x4e0
 [<c01ff095>] reiserfs_do_truncate+0x265/0x520
 [<c015ffb2>] block_prepare_write+0x32/0x50
 [<c01ed738>] reiserfs_truncate_file+0x128/0x2b0
 [<c02054d7>] journal_end+0x27/0x30
 [<c01eed42>] reiserfs_file_release+0x2e2/0x500
 [<c01715fd>] locks_delete_lock+0x8d/0xf0
 [<c01715fd>] locks_delete_lock+0x8d/0xf0
 [<c015cc81>] __fput+0xe1/0xf0
 [<c015b264>] filp_close+0xf4/0x120
 [<c015b30a>] sys_close+0x7a/0x90
 [<c0109863>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:127
Call Trace:
 [<c015d230>] __wait_on_buffer+0xd0/0xe0
 [<c0120ad0>] autoremove_wake_function+0x0/0x50
 [<c0120ad0>] autoremove_wake_function+0x0/0x50
 [<c0200e08>] reiserfs_unmap_buffer+0x68/0xb0
 [<c0200eb8>] unmap_buffers+0x68/0x70
 [<c0201095>] indirect2direct+0x1d5/0x2b0
 [<c01fecc4>] reiserfs_cut_from_item+0x3d4/0x4e0
 [<c01ff095>] reiserfs_do_truncate+0x265/0x520
 [<c015ffb2>] block_prepare_write+0x32/0x50
 [<c01ed738>] reiserfs_truncate_file+0x128/0x2b0
 [<c02054d7>] journal_end+0x27/0x30
 [<c01eed42>] reiserfs_file_release+0x2e2/0x500
 [<c015cc81>] __fput+0xe1/0xf0
 [<c015b264>] filp_close+0xf4/0x120
 [<c01246ec>] put_files_struct+0x7c/0xf0
 [<c01254bb>] do_exit+0x1fb/0x570
 [<c0125865>] sys_exit+0x15/0x20
 [<c0109863>] syscall_call+0x7/0xb

NFS: server cheating in read reply: count 16384 > recvd 1000
NFS: server cheating in read reply: count 16384 > recvd 1000
buffer layer error at fs/buffer.c:127
Call Trace:
 [<c015d230>] __wait_on_buffer+0xd0/0xe0
 [<c0120ad0>] autoremove_wake_function+0x0/0x50
 [<c0120ad0>] autoremove_wake_function+0x0/0x50
 [<c0200e08>] reiserfs_unmap_buffer+0x68/0xb0
 [<c0200eb8>] unmap_buffers+0x68/0x70
 [<c0201095>] indirect2direct+0x1d5/0x2b0
 [<c01fecc4>] reiserfs_cut_from_item+0x3d4/0x4e0
 [<c01ff095>] reiserfs_do_truncate+0x265/0x520
 [<c015ffb2>] block_prepare_write+0x32/0x50
 [<c01ed738>] reiserfs_truncate_file+0x128/0x2b0
 [<c02054d7>] journal_end+0x27/0x30
 [<c01eed42>] reiserfs_file_release+0x2e2/0x500
 [<c015cc81>] __fput+0xe1/0xf0
 [<c015b264>] filp_close+0xf4/0x120
 [<c01246ec>] put_files_struct+0x7c/0xf0
 [<c01254bb>] do_exit+0x1fb/0x570
 [<c015b264>] filp_close+0xf4/0x120
 [<c0125865>] sys_exit+0x15/0x20
 [<c0109863>] syscall_call+0x7/0xb

nfs: server james not responding, timed out
NFS: server cheating in read reply: count 16384 > recvd 1000


