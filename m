Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTJQQST (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 12:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTJQQST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 12:18:19 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:51094 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263485AbTJQQSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 12:18:17 -0400
Date: Fri, 17 Oct 2003 09:18:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: jonlar@netinsight.net
Subject: [Bug 1367] New: Ooop in 2.6.0-test7 (top proc) 
Message-ID: <635570000.1066407490@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Ooop in 2.6.0-test7 (top proc)
    Kernel Version: 2.6.0-test7
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: jonlar@netinsight.net


Using debian/unstable on an Intel Celeron. 

Got an Oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000034
 printing eip:
c01720be
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01720be>]    Not tainted
EFLAGS: 00010246
EIP is at proc_pid_stat+0x366/0x3c0
eax: 00000104   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 0000000a   edi: d37fd080   ebp: c49af900   esp: dc339e74
ds: 007b   es: 007b   ss: 0068
Process top (pid: 652, threadinfo=dc338000 task=dd4872e0)
Stack: 00000000 ffffffff 00000104 00000012 00000000 0000005d 00000000 00000000
       00000000 00000000 00000000 00000015 00000000 00000000 00000000 00ecf02e
       00000000 0014a000 0000005d ffffffff 08048000 0804b780 bffffdc0 bffffb80
Call Trace:
 [<c011cfc6>] do_exit+0x37e/0x38c
 [<c016f47b>] proc_info_read+0x4f/0x138
 [<c014753c>] vfs_read+0x9c/0xcc
 [<c014771d>] sys_read+0x31/0x4c
 [<c010a627>] syscall_call+0x7/0xb
 
Code: 8b 42 34 50 8b 42 2c 50 8b b4 24 b4 00 00 00 56 0f be 84 24

Steps to reproduce:

Don't know. Was running top [top: procps version 3.1.12].

