Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264790AbSJORSh>; Tue, 15 Oct 2002 13:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264791AbSJORSh>; Tue, 15 Oct 2002 13:18:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:28402 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264790AbSJORSf>;
	Tue, 15 Oct 2002 13:18:35 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200210151724.g9FHOI426577@eng2.beaverton.ibm.com>
Subject: 2.5.42 kernel BUG at drivers/base/core.c:251!
To: linux-kernel@vger.kernel.org (lkml)
Date: Tue, 15 Oct 2002 10:24:18 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a known problem on 2.5.42 ? Happens all the time with rmmod.

- Badari

kernel BUG at drivers/base/core.c:251!
invalid operand: 0000
qla2200  
CPU:    0
EIP:    0060:[<c023eb24>]    Not tainted
EFLAGS: 00010202
EIP is at put_device+0x64/0x90
eax: 00000000   ebx: f8a08028   ecx: f8a080c4   edx: 00000001
esi: c3aded54   edi: f8a08000   ebp: 00000003   esp: cb007ee4
ds: 0068   es: 0068   ss: 0068
Process rmmod (pid: 4803, threadinfo=cb006000 task=f62c98c0)
Stack: f8a08028 c0477a40 c02ce533 f8a08028 f8a08028 c0477b5c f8a08028 c0477b6c 
       00000000 40153f6d 00000286 f68fc000 c0477a40 c3adec00 f4df0000 c02a7a9a 
       c3adec00 cb007f30 00000002 00030002 00000001 08071002 c041685c 08070ffd 
Call Trace:
 [<c02ce533>] sg_detach+0x1e3/0x210
 [<c02a7a9a>] scsi_unregister_host+0x26a/0x5d0
 [<c01f4736>] __generic_copy_to_user+0x56/0x80
 [<c013e4e8>] __alloc_pages+0x98/0x270
 [<f89e7cba>] exit_this_scsi_driver+0xa/0x10 [qla2200]
 [<f8a00360>] driver_template+0x0/0x74 [qla2200]
 [<c011ea0e>] free_module+0x1e/0x130
 [<c011dc94>] sys_delete_module+0x1b4/0x410
 [<c01075e3>] syscall_call+0x7/0xb

Code: 0f 0b fb 00 6c 3e 3c c0 8b 83 d4 00 00 00 85 c0 74 04 53 ff 





-- 
Badari Pulavarty
badari@us.ibm.com
IBM Linux Technology Center - Kernel Team
