Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272671AbTHPIoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 04:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272672AbTHPIoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 04:44:13 -0400
Received: from mail.suse.de ([213.95.15.193]:17929 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272671AbTHPIoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 04:44:10 -0400
Date: Sat, 16 Aug 2003 10:44:09 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: scsi proc_info called unconditionally
Message-ID: <20030816084409.GA8038@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why is ->proc_info() called when the function pointer is NULL?

(none):/# mount proc
(none):/# cat /proc/scsi/
53c94        device_info  scsi
(none):/# cat /proc/scsi/53c94/0
proc_scsi_read: 00000000 called
Oops: kernel access of bad area, sig: 11 [#1]
NIP: 00000000 LR: C00EC6C8 SP: C03BBE90 REGS: c03bbde0 TRAP: 0401    Not tainted
MSR: 40009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c027b7e0[16] 'cat' Last syscall: 3
GPR00: C00EC6A0 C03BBE90 C027B7E0 C4705400 C43B5000 C03BBEC8 00000000 00000C00
GPR08: 00000000 00000000 C01C6E8F C01B0000 0000000D
Call trace:
 [c007a254] proc_file_read+0xb8/0x2cc
 [c004d97c] vfs_read+0xdc/0x128
 [c004dbe8] sys_read+0x40/0x74
 [c000780c] ret_from_syscall+0x0/0x4c
Segmentation fault


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
