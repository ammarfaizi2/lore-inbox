Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbUEMPFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUEMPFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbUEMPFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:05:21 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:17117 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262996AbUEMPFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:05:09 -0400
Date: Thu, 13 May 2004 08:05:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 2698] New: Kernel Crash;	Could be related to quotas on ext3
Message-ID: <9880000.1084460706@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2698

           Summary: Kernel Crash; Could be related to quotas on ext3
    Kernel Version: 2.6.6
            Status: NEW
          Severity: high
             Owner: akpm@digeo.com
         Submitter: mjw99@ic.ac.uk


Distribution:
RHL 9, but with Vanilla 2.6.6 Kernel
Hardware Environment:
ic7 max 3 MOBO with SATA drives
Software Environment:
Problem Description:
Kernel Crash;

May 13 11:55:28 server kernel: VFS: Quota for id 0 referenced but not present.
May 13 11:55:28 server kernel: VFS: Can't read quota structure for id 0.
May 13 11:55:28 server kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000074
May 13 11:55:28 server kernel:  printing eip:
May 13 11:55:28 server kernel: c017cba3
May 13 11:55:28 server kernel: *pde = 00000000
May 13 11:55:28 server kernel: Oops: 0000 [#1]
May 13 11:55:28 server kernel: SMP
May 13 11:55:28 server kernel: CPU:    1
May 13 11:55:28 server kernel: EIP:    0060:[<c017cba3>]    Not tainted
May 13 11:55:28 server kernel: EFLAGS: 00010282   (2.6.6)
May 13 11:55:28 server kernel: EIP is at dquot_transfer+0x14e/0x415
May 13 11:55:28 server kernel: eax: 00000000   ebx: 00000004   ecx: f69ea210  
edx: 00000000
May 13 11:55:28 server kernel: esi: 00000000   edi: 00000006   ebp: 00000000  
esp: e3763e84
May 13 11:55:28 server kernel: ds: 007b   es: 007b   ss: 0068
May 13 11:55:28 server kernel: Process mv (pid: 15167, threadinfo=e3762000
task=eed70130)
May 13 11:55:28 server kernel: Stack: f69ea210 2be60000 00000000 00000000
e3763eaf 00000000 00000000 00000001
May 13 11:55:28 server kernel:        2be60000 00000000 0000381c 00000000
00000000 f69eae10 f69ea210 f131324c
May 13 11:55:28 server kernel:        c06a381c f131324c c06a381c c0191642
c06a381c e3763f28 de319540 00000046
May 13 11:55:28 server kernel: Call Trace:
May 13 11:55:28 server kernel:  [<c0191642>] ext3_setattr+0xbe/0x280
May 13 11:55:28 server kernel:  [<c016b510>] notify_change+0x1cc/0x200
May 13 11:55:28 server kernel:  [<c0150804>] chown_common+0xae/0xe0
May 13 11:55:28 server kernel:  [<c015f668>] __user_walk+0x5c/0x5e
May 13 11:55:28 server kernel:  [<c0150885>] sys_chown+0x4f/0x5b
May 13 11:55:28 server kernel:  [<c0105fe7>] syscall_call+0x7/0xb
May 13 11:55:28 server kernel:
May 13 11:55:28 server kernel: Code: 8b 42 74 83 f8 01 0f 86 e1 01 00 00 83 e8
01 89 42 74 8b 42

Steps to reproduce:
Unknown :(

