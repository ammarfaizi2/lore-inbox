Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUCOWBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbUCOWBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:01:00 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:38850 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262768AbUCOV5U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:57:20 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@us.ibm.com>
Subject: sysfs panic on 2.6.4-mm1
Date: Mon, 15 Mar 2004 13:52:57 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200403151352.57454.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happend while rmmod qla2200 on 2.6.4-mm1.

Thanks,
Badari

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c019e1df
*pde = 00000000
Oops: 0000 [#1]
SMP
CPU:    7
EIP:    0060:[<c019e1df>]    Not tainted VLI
EFLAGS: 00010282   (2.6.4-mm1)
EIP is at sysfs_hash_and_remove+0xf/0x6e
eax: 00000000   ebx: f634c298   ecx: f634c23c   edx: c03d82f9
esi: 00000000   edi: 00000000   ebp: f2f87eac   esp: f2f87ea4
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 23347, threadinfo=f2f86000 task=f79e26b0)
Stack: f634c298 f634c298 f2f87ec8 c0299c29 c0449be4 f634c244 f634c298 f634c184
       00000000 f2f87ed4 c0299c6b f634c000 f2f87ee4 c02c1ffd f3a50000 f7bbb000
       f2f87ef4 c02c14ff f3a50000 c3366044 f2f87f00 c02bb72b f3a501e0 f2f87f10
Call Trace:
 [<c0299c29>] class_device_del+0x89/0xc0
 [<c0299c6b>] class_device_unregister+0xb/0x20
 [<c02c1ffd>] scsi_remove_device+0x4d/0x90
 [<c02c14ff>] scsi_forget_host+0x3f/0x70
 [<c02bb72b>] scsi_remove_host+0x1b/0x50
 [<f8978bc4>] qla2x00_remove_one+0x74/0xb0 [qla2xxx]
 [<c0255a4c>] pci_device_remove+0x2c/0x30
 [<c0298fe9>] device_release_driver+0x59/0x60
 [<c0299018>] driver_detach+0x28/0x40
 [<c029923c>] bus_remove_driver+0x3c/0x70
 [<c02995db>] driver_unregister+0xb/0x1d
 [<c0255bfe>] pci_unregister_driver+0xe/0x20
 [<c013c201>] sys_delete_module+0x121/0x170
 [<c0155e5a>] unmap_vma_list+0x1a/0x30
 [<c01562a7>] do_munmap+0x127/0x190
 [<c0156352>] sys_munmap+0x42/0x70
 [<c03a5c1e>] sysenter_past_esp+0x43/0x65

Code: f2 e8 b6 26 fd ff 83 c4 10 5b 5e 5f 5d c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 08 89 74 24 04 89 c6 89 1c 24 <8b> 40 0c 8d 48 74 f0 ff 48 74 78 53 89 f0 e8 6e ff ff ff 3d 18

