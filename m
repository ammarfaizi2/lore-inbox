Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267066AbTGGPq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267074AbTGGPq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:46:26 -0400
Received: from franka.aracnet.com ([216.99.193.44]:26587 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S267066AbTGGPqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:46:11 -0400
Date: Mon, 07 Jul 2003 09:00:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 883] New: LTP symlink01 test causes oops in 2.5.74-mm2 
Message-ID: <17430000.1057593630@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=883

           Summary: LTP symlink01 test causes oops in 2.5.74-mm2
    Kernel Version: 2.5.74-mm2
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: plars@austin.ibm.com


Distribution: RedHat 7.3
Hardware Environment:
8-way PIII 700, 16GB ram

Software Environment:
gcc 2.96, Linux-2.5.74-mm2, ext3
(I will attach the kernel config in a bit)

Problem Description:
This oops does not cause the system to crash or hang.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 3546d001
Oops: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010282
EIP is at 0x0
eax: c0399ec0   ebx: fffffff4   ecx: f593ebe0   edx: f5529f78
esi: f593ea80   edi: f5452e50   ebp: f5529f70   esp: f5529ef0
ds: 007b   es: 007b   ss: 0068
Process symlink01 (pid: 4003, threadinfo=f5528000 task=f57c86f0)
Stack: c015ffc8 f5452e50 f593ea80 f5529f70 f593ebc0 f593ebc0 f5529f70 00000041
       c01607c0 f5529f78 f593ebc0 f5529f70 00000001 00000004 f593ebc0 00000000
       00030002 1e79d078 3f097ddb 1e79d078 3f097ddb 1e79d078 000343b3 00000040
Call Trace:
 [<c015ffc8>] __lookup_hash+0x78/0xa0
 [<c01607c0>] open_namei+0x3b0/0x3e0
 [<c01517a6>] filp_open+0x36/0x60
 [<c0151b85>] sys_open+0x35/0x70
 [<c0108ff3>] syscall_call+0x7/0xb

Code:  Bad EIP value.
Steps to reproduce:
Run the symlink01 test from LTP


