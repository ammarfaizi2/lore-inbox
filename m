Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266540AbUBLSxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266445AbUBLSxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:53:44 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:19685 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266540AbUBLSw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:52:58 -0500
Date: Thu, 12 Feb 2004 10:52:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 2084] New: Reiserfs causes sytem hang
Message-ID: <3820000.1076611975@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2084

           Summary: Reiserfs causes sytem hang
    Kernel Version: 2.6.2
            Status: NEW
          Severity: high
             Owner: reiserfs-dev@namesys.com
         Submitter: geek@geekbone.org


Distribution: 
Debian Sarge

Hardware Environment: 
Whitebox P4 Xeon server with Tyan S2723 Motherboard and 3ware 7506 Raid 5 card

Software Environment: 
self compiled plain Kernel 2.6.2
Reiserfs
Raid 5

Problem Description: 
rsync was running as scheduled in cron normally and system suddenly hang up 
with the following kernel message.

------------[ cut here ]------------
kernel BUG at fs/reiserfs/namei.c:1198!
invalid operand: 0000 [#1]
CPU:    1
EIP:    0060:[<c01ac359>]    Not tainted
EFLAGS: 00010297
EIP is at reiserfs_rename+0x2ec/0xaa9
eax: 00000000   ebx: f0d81680   ecx: d66c7e50   edx: 00000000
esi: 00000000   edi: d66c7d10   ebp: ccad0338   esp: d66c7c58
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 960, threadinfo=d66c6000 task=d76b66b0)
Stack: ede4dcb8 f0d81700 00000025 d66c7e50 d66c7d10 00000000 d66c7d18 c013eef0 
       d66c7d20 00000001 00000000 00008180 d66c6000 00000001 00000000 00000000 
       d66c7d18 c192d498 c02d688c 00000005 0000003b 0006bfa7 f7688400 00000037 
Call Trace:
 [<c013eef0>] __pagevec_lru_add+0xb1/0xc0
 [<c01ace6b>] make_cpu_key+0x59/0x65
 [<c02622a5>] memcpy_toiovec+0x5a/0x87
 [<c0260a22>] kfree_skbmem+0x24/0x2c
 [<c0160d47>] vfs_rename_other+0xa6/0xdb
 [<c0160eae>] vfs_rename+0x132/0x35b
 [<c01612c8>] sys_rename+0x1f1/0x220
 [<c01525c5>] __fput+0xaa/0x101
 [<c010a88f>] syscall_call+0x7/0xb

Code: 0f 0b ae 04 4c 63 2d c0 8b 84 24 f8 01 00 00 8d 8c 24 98 01 

Steps to reproduce:
Haven't tried yet

