Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTDFX5o (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 19:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbTDFX5o (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 19:57:44 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:16878 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263185AbTDFX5n (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 19:57:43 -0400
Subject: CIFS Oops in 2.5.64-bk10
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049674154.26439.31.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Apr 2003 02:09:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again

I'm back with another problem :)

Kernel 2.5.64-bk10 (has this problem already been fixed? Havn't seen
anything about it on lkml). Gcc 2.95.4

Uptime ~21 days and I've been using CIFS quite a bit for at least a
week, it's been working great until now. I just got this little
problem...


 CIFS VFS: Need to reconnect after session died to server
Unable to handle kernel paging request at virtual address 00002653
 printing eip:
eeb4224e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<eeb4224e>]    Not tainted
EFLAGS: 00210202
EIP is at reopen_files+0x26/0xb4 [cifs]
eax: 000025e3   ebx: e32d2f18   ecx: 00000053   edx: 00000001
esi: e32d2f20   edi: 00000000   ebp: c81b6680   esp: da79bd6c
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 9699, threadinfo=da79a000 task=d47b8ca0)
Stack: 00000000 c81b6680 c0290a80 da79bdc4 eeb39560 c81b6680 c0290a80 0004d2bd 
       043ab000 00000000 00001000 eeb3a01d 0000002e 0000000c c81b6680 da79bdc4 
       da79bdc8 0004d2bd 00000000 fffffff3 d7ab2220 00000000 00000000 00000000 
Call Trace:
 [<eeb39560>] gcc2_compiled.+0x80/0xcc [cifs]
 [<eeb3a01d>] CIFSSMBRead+0x45/0x18c [cifs]
 [<eeb43087>] cifs_read+0xeb/0x178 [cifs]
 [<eeb43694>] cifs_readpage+0xd4/0x1b4 [cifs]
 [<c0126af3>] add_to_page_cache_lru+0x2b/0x30
 [<c0127134>] do_generic_mapping_read+0x198/0x328
 [<c012754d>] __generic_file_aio_read+0x195/0x1b0
 [<c01272c4>] file_read_actor+0x0/0xf4
 [<c0127633>] generic_file_read+0x7b/0x98
 [<c0112ec2>] __wake_up_common+0x36/0x50
 [<c011b9fa>] update_process_times+0x2a/0x30
 [<c01162d9>] profile_hook+0x11/0x15
 [<c010d040>] timer_interrupt+0x54/0x128
 [<c0109c01>] handle_IRQ_event+0x29/0x4c
 [<c013b6a1>] vfs_read+0xa1/0x108
 [<c013b8f2>] sys_read+0x2a/0x3c
 [<c0108943>] syscall_call+0x7/0xb

Code: 8b 40 70 85 c0 74 09 50 e8 a5 a1 5e d1 83 c4 04 8b 43 1c 50 


The most annoying thing is that my music stopped :) Machine is still up
and running.

-- 
/Martin
