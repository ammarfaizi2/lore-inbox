Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUFTPjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUFTPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUFTPjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 11:39:25 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:32458 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265490AbUFTPjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 11:39:23 -0400
Date: Sun, 20 Jun 2004 11:39:22 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7: preempt + sysfs = BUG on ppc
Message-ID: <20040620153922.GA20103@zero>
Reply-To: Tom Vier <tmv@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i forgot to exclude /sys when i ran rsync. this is easily reproducable.

kernel BUG in fill_read_buffer at fs/sysfs/file.c:92!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT 
NIP: C009687C LR: C0096870 SP: D1587EA0 REGS: d1587df0 TRAP: 0700    Not tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c07b4060[879] 'rsync' THREAD: d1586000Last syscall: 3 
GPR00: 00000001 D1587EA0 C07B4060 FFFFFFEA C7E38000 D327F000 00007F11 00000000 
GPR08: 00000000 00000000 00000000 D1586000 20002442 1004CFE4 00000000 00000000 
GPR16: 00001000 10040000 10040000 10040000 10040000 00000003 00001000 00000000 
GPR24: 00001000 00000000 00000000 00000000 C010E348 C0264BEC D1B64F1C C079F1A8 
NIP [c009687c] fill_read_buffer+0x70/0xb4
LR [c0096870] fill_read_buffer+0x64/0xb4
Call trace:
 [c0096a28] sysfs_read_file+0x5c/0x78
 [c005ad68] vfs_read+0xdc/0x128
 [c005afd8] sys_read+0x40/0x74
 [c0005b20] ret_from_syscall+0x0/0x44

kernel BUG in fill_read_buffer at fs/sysfs/file.c:92!
Oops: Exception in kernel mode, sig: 5 [#2]
PREEMPT 
NIP: C009687C LR: C0096870 SP: C577FEA0 REGS: c577fdf0 TRAP: 0700    Not tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c07b4060[1230] 'rsync' THREAD: c577e000Last syscall: 3 
GPR00: 00000001 C577FEA0 C07B4060 FFFFFFEA C4828000 D327F000 00007F11 00000000 
GPR08: 00000000 00000000 00000000 C577E000 20002442 1004CFE4 00000000 00000000 
GPR16: 00001000 10040000 10040000 10040000 10040000 00000003 00001000 00000000 
GPR24: 00001000 00000000 00000000 00000000 C010E348 C0264BEC D1B6433C C079F1A8 
NIP [c009687c] fill_read_buffer+0x70/0xb4
LR [c0096870] fill_read_buffer+0x64/0xb4
Call trace:
 [c0096a28] sysfs_read_file+0x5c/0x78
 [c005ad68] vfs_read+0xdc/0x128
 [c005afd8] sys_read+0x40/0x74
 [c0005b20] ret_from_syscall+0x0/0x44

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE

