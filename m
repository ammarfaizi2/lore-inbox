Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263723AbTCUSco>; Fri, 21 Mar 2003 13:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbTCUSbn>; Fri, 21 Mar 2003 13:31:43 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:38848 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263710AbTCUSaU>;
	Fri, 21 Mar 2003 13:30:20 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.65 panic in remove_proc_entry() while trying to rmmod
Date: Fri, 21 Mar 2003 10:36:35 -0800
User-Agent: KMail/1.4.1
Cc: andrew <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZO3414CJFI7R9AOLMLQ2"
Message-Id: <200303211036.35504.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ZO3414CJFI7R9AOLMLQ2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I get following panic while playing with scsi_debug.
Any ideas on how to fix this ?

Thanks,
Badari


--------------Boundary-00=_ZO3414CJFI7R9AOLMLQ2
Content-Type: text/plain;
  charset="us-ascii";
  name="panic"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="panic"

Unable to handle kernel paging request at virtual address 6b6b6b6d
 printing eip:
c018590a
*pde = 00000000
Oops: 0000 [#1]
CPU:    4
EIP:    0060:[<c018590a>]    Not tainted
EFLAGS: 00010202 VLI
EIP is at proc_match+0xa/0x30
eax: 6b6b6b6b   ebx: 00000002   ecx: d9d61e9c   edx: 6b6b6b6b
esi: d9d61e9c   edi: f7166e74   ebp: c03a2648   esp: d9d61e60
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 10547, threadinfo=d9d60000 task=d9ade0a0)
Stack: d9d61e9c f7166e74 c018679e 00000002 d9d61e9c 6b6b6b6b d9d61e9c f440a084
       f440a084 c0295efa d9d61e9c f7166e44 d9d61e9c c03a23cc 0000001a d9003632
       f440a084 c03a2648 c01081cc f440a084 f44259c4 c028f733 f440a084 00000000
Call Trace:
 [<c018679e>] remove_proc_entry+0x5e/0x110
 [<c0295efa>] scsi_proc_host_rm+0x2a/0x50
 [<c01081cc>] __up_wakeup+0x8/0xc
 [<c028f733>] scsi_unregister+0x103/0x120
 [<f8966929>] sdebug_driver_remove+0x119/0x160 [scsi_debug]
 [<f8969440>] sdebug_driverfs_driver+0x0/0x74 [scsi_debug]
 [<f8969440>] sdebug_driverfs_driver+0x0/0x74 [scsi_debug]
 [<c0254134>] device_release_driver+0x44/0x50
 [<f8969498>] sdebug_driverfs_driver+0x58/0x74 [scsi_debug]
 [<c0254169>] driver_detach+0x29/0x40
 [<f8969660>] pseudo_lld_bus+0x40/0xe0 [scsi_debug]
 [<f8969620>] pseudo_lld_bus+0x0/0xe0 [scsi_debug]
 [<c02543e8>] bus_remove_driver+0x38/0x80
 [<f8969440>] sdebug_driverfs_driver+0x0/0x74 [scsi_debug]
 [<f896944c>] sdebug_driverfs_driver+0xc/0x74 [scsi_debug]
 [<f8969440>] sdebug_driverfs_driver+0x0/0x74 [scsi_debug]
 [<c025479f>] driver_unregister+0xf/0x33
 [<f8969440>] sdebug_driverfs_driver+0x0/0x74 [scsi_debug]
 [<f8969700>] +0x0/0x4e0 [scsi_debug]
 [<f896651a>] scsi_debug_unregister_driver+0xa/0x10 [scsi_debug]
 [<f8969440>] sdebug_driverfs_driver+0x0/0x74 [scsi_debug]
 [<f8966984>] +0x14/0x40 [scsi_debug]
 [<f8969440>] sdebug_driverfs_driver+0x0/0x74 [scsi_debug]
 [<c013517f>] sys_delete_module+0x1ff/0x230
 [<c0148f8b>] do_munmap+0x17b/0x190
 [<c0148fe4>] sys_munmap+0x44/0x70
 [<c0109303>] syscall_call+0x7/0xb

Code: 63 08 00 59 e9 8a e6 ff ff 66 4a 0f 85 1b e7 ff ff 51 e8 9a 64 08 00 59 e9 0f e7 ff ff 8d 74 26 00 57 56 8b


--------------Boundary-00=_ZO3414CJFI7R9AOLMLQ2--

