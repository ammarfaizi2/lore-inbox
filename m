Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262144AbSJJWs6>; Thu, 10 Oct 2002 18:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbSJJWs6>; Thu, 10 Oct 2002 18:48:58 -0400
Received: from air-2.osdl.org ([65.172.181.6]:46501 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262144AbSJJWs5>;
	Thu, 10 Oct 2002 18:48:57 -0400
Message-Id: <200210102254.g9AMsgH08119@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 - kernel NULL pointer
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Oct 2002 15:54:42 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System is 2-CPU PIII 
Attempting to start the SAP DB. Get this msg:
SAP cannot open the sys devspace (which is on filesystem)
DB setup does include one raw partition.
Further details upon request
cliffw

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000

CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246
eax: c04b71e0   ebx: 00000000   ecx: 00000000   edx: 00000001
esi: cf26cba8   edi: c1bc4764   ebp: c26c7f54   esp: c26c7ee0
ds: 0068   es: 0068   ss: 0068
Process dbmsrv (pid: 1422, threadinfo=c26c6000 task=c4c4e760)
Stack: c01711a9 00000000 c1bc4764 c26c7f54 00004000 00000000 00000001 c1bc4764
       c26c7f54 00004000 00000000 c01e92b2 00000000 c1bc4764 c26c7f54 00004000
       00000000 00000001 cee2c314 c1bc4764 00002000 c1bc4764 c1bc4784 c01e92f9
Call Trace:
 [<c01711a9>] generic_file_direct_IO+0x59/0x73
 [<c01e92b2>] rw_raw_dev+0xd2/0xf0
 [<c01e92f9>] raw_read+0x29/0x30
 [<c014c756>] vfs_read+0xb6/0x180
 [<c014c3c0>] default_llseek+0x0/0x150
 [<c014c63d>] sys_llseek+0x8d/0xf0
 [<c014c9ca>] sys_read+0x2a/0x40
 [<c010788f>] syscall_call+0x7/0xb

Code:  Bad EIP value.


