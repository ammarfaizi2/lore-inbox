Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbSKLXoO>; Tue, 12 Nov 2002 18:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267031AbSKLXoO>; Tue, 12 Nov 2002 18:44:14 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:2268 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267030AbSKLXoM>;
	Tue, 12 Nov 2002 18:44:12 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200211122349.gACNneB27936@eng2.beaverton.ibm.com>
Subject: OOPS on module unload 2.5.47-mm1
To: linux-kernel@vger.kernel.org (lkml)
Date: Tue, 12 Nov 2002 15:49:40 -0800 (PST)
Cc: pbadari@us.ibm.com (Badari Pulavarty)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get following panic while rmmod qla driver.  (2.5.47-mm1).

Is this a known problem ? Any ideas ?

Thanks,
Badari


Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Synchronizing SCSI cache: 
Unable to handle kernel paging request at virtual address 5a5a5a5e
 printing eip:
c025ea85
*pde = 00000000
Oops: 0002
qla2200  
CPU:    0
EIP:    0060:[<c025ea85>]    Not tainted
EFLAGS: 00010287
EIP is at __blk_cleanup_queue+0x25/0x70
eax: 5a5a5a5a   ebx: d31c8c94   ecx: d23ab5ac   edx: d31c8c94
esi: 000001ab   edi: d31c8c90   ebp: d302f000   esp: d2eebf28
ds: 0068   es: 0068   ss: 0068
Process rmmod (pid: 2708, threadinfo=d2eea000 task=d2e48180)
Stack: 00000800 d2f60000 d31c8c2c c025eae7 d31c8c90 d31c8c00 f89424c0 c02960d9 
       d31c8c2c d2f60000 00000006 c0295f22 d2f60000 d2a44000 c0295f10 c0295e2d 
       d2f60000 00000006 d2eea000 00000000 c029694e f89424c0 c0295f10 f8915000 
Call Trace:
 [<c025eae7>] blk_cleanup_queue+0x17/0x60
 [<f89424c0>] driver_template+0x0/0x68 [qla2200]
 [<c02960d9>] scsi_remove_host+0x179/0x1b0
 [<c0295f22>] scsi_remove_legacy_host+0x12/0x50
 [<c0295f10>] scsi_remove_legacy_host+0x0/0x50
 [<c0295e2d>] scsi_tp_for_each_host+0x7d/0x110
 [<c029694e>] scsi_unregister_host+0x6e/0xf0
 [<f89424c0>] driver_template+0x0/0x68 [qla2200]
 [<c0295f10>] scsi_remove_legacy_host+0x0/0x50
 [<f8929aba>] exit_this_scsi_driver+0xa/0x10 [qla2200]
 [<f89424c0>] driver_template+0x0/0x68 [qla2200]
 [<c012081e>] free_module+0x1e/0x130
 [<c011faa4>] sys_delete_module+0x1b4/0x410
 [<c0109173>] syscall_call+0x7/0xb

Code: 89 50 04 89 02 89 09 89 49 04 51 8b 0d 0c 43 5c c0 46 51 e8 

