Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUAGSAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266287AbUAGR7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:59:19 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:7093 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266288AbUAGR65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:58:57 -0500
Date: Wed, 07 Jan 2004 09:58:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: nuno.grilo@netcabo.pt
Subject: [Bug 1803] New: Unable to handle kernel paging request	at schedule_timeout+0x7f/0xc0
Message-ID: <3670000.1073498334@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1803

           Summary: Unable to handle kernel paging request  at
                    schedule_timeout+0x7f/0xc0
    Kernel Version: 2.6.1-rc1
            Status: NEW
          Severity: high
             Owner: rml@tech9.net
         Submitter: nuno.grilo@netcabo.pt


Distribution: Gentoo R1.4
Hardware Environment: 
Epia MINI-ITX 1000MHz MB
512MB RAM
Hauppauge PVR350 TV capture device
Software Environment:
XFree 4.3.99.902
Problem Description:
Got a kernel oops and X died.
Here is a copy of the Oops:
Unable to handle kernel paging request at virtual address fbeaa9de
 printing eip:
c012802f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c012802f>]    Not tainted
EFLAGS: 00013206
EIP is at schedule_timeout+0x7f/0xc0
eax: 00019130   ebx: 00000000   ecx: ca248000   edx: ca249ec0
esi: 00019130   edi: 0000001a   ebp: 0000001a   esp: ca249eb4
ds: 007b   es: 007b   ss: 0068
Process X (pid: 5035, threadinfo=ca248000 task=ca2ad2c0)
Stack: ca249ec0 01c57f6e c9f7f000 00100100 00200200 01c57f6e 4b87ad6e c0127fa0
       ca2ad2c0 00000000 cbd9d200 00000000 00000000 c0168633 d613c5a0 00000000
       00000000 00000000 00000000 00000304 03fffe1a 00000000 00000000 03fffe1a
Call Trace:
 [<c0127fa0>] process_timeout+0x0/0x10
 [<c0168633>] do_select+0x193/0x2e0
 [<c01682e0>] __pollwait+0x0/0xd0
 [<c0168ab2>] sys_select+0x302/0x540
 [<c0154ece>] vfs_read+0xfe/0x130
 [<c010b477>] syscall_call+0x7/0xb

Code: 8b 74 24 30 83 c4 34 c3 89 74 24 04 8b 44 24 34 c7 04 24 c0
Steps to reproduce:


