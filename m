Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTD0UcV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 16:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbTD0UcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 16:32:20 -0400
Received: from ip-86-8.evc.net ([212.95.86.8]:2176 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S261759AbTD0UcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 16:32:18 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: oops ide-scsi 2.5.68
Date: Sun, 27 Apr 2003 22:44:18 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304272244.18348.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

Here is an oops with "hdc=ide-scsi",
I know ide-scsi will become obsolete,
but with now I cannot burn CDs without it....

Regards.

Apr 27 22:20:51 hal9003 kernel: SCSI subsystem initialized
Apr 27 22:20:51 hal9003 kernel: Linux agpgart interface v0.100 (c) Dave Jones
Apr 27 22:20:51 hal9003 kernel: [drm] Initialized radeon 1.8.0 20020828 on 
minor 0
Apr 27 22:20:51 hal9003 kernel: hdb: ATAPI 40X DVD-ROM drive, 512kB Cache, 
UDMA(33)
Apr 27 22:20:51 hal9003 kernel: Uniform CD-ROM driver Revision: 3.12
Apr 27 22:20:51 hal9003 kernel: end_request: I/O error, dev hdb, sector 0
Apr 27 22:20:51 hal9003 kernel: scsi0 : SCSI host adapter emulation for IDE 
ATAPI devices
Apr 27 22:20:51 hal9003 kernel: Unable to handle kernel paging request at 
virtual address 8910438d
Apr 27 22:20:51 hal9003 kernel:  printing eip:
Apr 27 22:20:51 hal9003 kernel: f8ae5e11
Apr 27 22:20:51 hal9003 kernel: *pde = 00000000
Apr 27 22:20:51 hal9003 kernel: Oops: 0000 [#1]
Apr 27 22:20:51 hal9003 kernel: CPU:    0
Apr 27 22:20:51 hal9003 kernel: EIP:    0060:[<f8ae5e11>]    Not tainted
Apr 27 22:20:51 hal9003 kernel: EFLAGS: 00010287
Apr 27 22:20:51 hal9003 kernel: EIP is at scsi_get_device_flags+0xa9/0x122 
[scsi_mod]
Apr 27 22:20:51 hal9003 kernel: eax: 00000000   ebx: 8910438d   ecx: 00000007   
edx: f8aeaca1
Apr 27 22:20:51 hal9003 kernel: esi: f8aeaca2   edi: c0384e29   ebp: f731de48   
esp: f731de2c
Apr 27 22:20:51 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Apr 27 22:20:51 hal9003 kernel: Process modprobe (pid: 369, 
threadinfo=f731c000 task=f7429280)
Apr 27 22:20:51 hal9003 kernel: Stack: 00000008 8910438d f731de34 f731de34 
f731de74 c0384e20 f731de74 f731de90
Apr 27 22:20:51 hal9003 kernel:        f8aeb611 c0384e28 c0384e30 c0384e20 
00000024 00001770 00000003 f731de90
Apr 27 22:20:51 hal9003 kernel:        c01379f8 f7292c00 00000012 f7310024 
f8aebb15 c0384e20 f7292c00 c1b1f800
Apr 27 22:20:51 hal9003 kernel: Call Trace:
Apr 27 22:20:51 hal9003 kernel:  [<f8aeb611>] scsi_probe_lun+0xb2/0x1e2 
[scsi_mod]
Apr 27 22:20:51 hal9003 kernel:  [kmalloc+345/394] kmalloc+0x159/0x18a
Apr 27 22:20:51 hal9003 kernel:  [<c01379f8>] kmalloc+0x159/0x18a
Apr 27 22:20:51 hal9003 kernel:  [<f8aebb15>] 
scsi_probe_and_add_lun+0x62/0x11c [scsi_mod]
Apr 27 22:20:51 hal9003 kernel:  [<f8aebb2e>] 
scsi_probe_and_add_lun+0x7b/0x11c [scsi_mod]
Apr 27 22:20:51 hal9003 kernel:  [<f8aec0e2>] scsi_scan_target+0x4d/0xc3 
[scsi_mod]
Apr 27 22:20:51 hal9003 kernel:  [printk+267/318] printk+0x10b/0x13e
Apr 27 22:20:51 hal9003 kernel:  [<c011c4af>] printk+0x10b/0x13e
Apr 27 22:20:51 hal9003 kernel:  [<f8aec195>] scsi_scan_host+0x3d/0x5c 
[scsi_mod]
Apr 27 22:20:51 hal9003 kernel:  [<f8ae0d80>] idescsi_primary+0x0/0xe0 
[ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [<f8ae679a>] scsi_add_host+0x4e/0x87 
[scsi_mod]
Apr 27 22:20:51 hal9003 kernel:  [<f8adfdc0>] +0x320/0x423 [ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [<f8adfa29>] idescsi_attach+0xd2/0x105 
[ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [<f8ae0d80>] idescsi_primary+0x0/0xe0 
[ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [<f8ae0cc4>] +0xc4/0xcc [ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [<f8ae0c00>] +0x0/0xcc [ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [ata_attach+164/261] ata_attach+0xa4/0x105
Apr 27 22:20:51 hal9003 kernel:  [<c022f3a8>] ata_attach+0xa4/0x105
Apr 27 22:20:51 hal9003 kernel:  [<f8ae0c00>] +0x0/0xcc [ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [ide_register_driver+201/203] 
ide_register_driver+0xc9/0xcb
Apr 27 22:20:51 hal9003 kernel:  [<c0230143>] ide_register_driver+0xc9/0xcb
Apr 27 22:20:51 hal9003 kernel:  [<f8ae0f80>] +0x0/0x200 [ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [<f8a90042>] +0x42/0x64 [ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [<f8ae0c00>] +0x0/0xcc [ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [sys_init_module+258/423] 
sys_init_module+0x102/0x1a7
Apr 27 22:20:51 hal9003 kernel:  [<c012dc09>] sys_init_module+0x102/0x1a7
Apr 27 22:20:51 hal9003 kernel:  [<f8ae0f80>] +0x0/0x200 [ide_scsi]
Apr 27 22:20:51 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 27 22:20:51 hal9003 kernel:  [<c0108fe3>] syscall_call+0x7/0xb
Apr 27 22:20:51 hal9003 kernel:
Apr 27 22:20:51 hal9003 kernel: Code: 8b 03 89 45 e8 0f 18 00 81 fb 34 a5 af 
f8 0f 85 66 ff ff ff
Apr 27 22:20:51 hal9003 kernel:  <7>ohci-hcd 00:03.1: GetStatus 
roothub.portstatus [1] = 0x00010100 CSC PPS


