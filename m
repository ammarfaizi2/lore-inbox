Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbTJKCNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbTJKCNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:13:15 -0400
Received: from CPE-144-132-162-109.nsw.bigpond.net.au ([144.132.162.109]:36601
	"EHLO tigers-lfs.local") by vger.kernel.org with ESMTP
	id S263222AbTJKCNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:13:06 -0400
Date: Sat, 11 Oct 2003 12:11:49 +1000
From: Greg Schafer <gschafer@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test7 Oops Report
Message-ID: <20031011021149.GA349@tigers-lfs.nsw.bigpond.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

While running the NPTL test suite on stock -test7 my machine halted (was
sort of still usable but couldn't fork any new processes) and the attached
OOPS appeared in the syslog.

This box is SMP - Tyan S2466N-4M with pair of Athlon-MP 2200's.
Linux version 2.6.0-test7 (root@tigers-lfs) (gcc version 2.95.4 20030502
(prerelease)) #1 SMP Sat Oct 11 10:19:54 EST 2003

Thanks
Greg
(not subscribed)

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

Oct 11 11:24:14 tigers-lfs kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000009c
Oct 11 11:24:14 tigers-lfs kernel:  printing eip:
Oct 11 11:24:14 tigers-lfs kernel: c01f39af
Oct 11 11:24:14 tigers-lfs kernel: *pde = 00000000
Oct 11 11:24:14 tigers-lfs kernel: Oops: 0000 [#1]
Oct 11 11:24:14 tigers-lfs kernel: CPU:    0
Oct 11 11:24:14 tigers-lfs kernel: EIP:    0060:[init_dev+31/1072]    Not tainted
Oct 11 11:24:14 tigers-lfs kernel: EFLAGS: 00010246
Oct 11 11:24:14 tigers-lfs kernel: EIP is at init_dev+0x1f/0x430
Oct 11 11:24:14 tigers-lfs kernel: eax: 00000000   ebx: ef996000   ecx: 6d6f682f   edx: 00000000
Oct 11 11:24:14 tigers-lfs kernel: esi: 00000000   edi: 00000000   ebp: ef997ee8   esp: ef997ea8
Oct 11 11:24:14 tigers-lfs kernel: ds: 007b   es: 007b   ss: 0068
Oct 11 11:24:14 tigers-lfs kernel: Process sh (pid: 5527, threadinfo=ef996000 task=cae29320)
Oct 11 11:24:14 tigers-lfs kernel: Stack: 6d6f682f ef996000 00000000 00000000 00000000 ef997ed8 c016868c 00000000
Oct 11 11:24:14 tigers-lfs kernel:        c012d252 00000004 ef997ee8 c015f499 00000004 f7d8f614 00008803 ef997f78
Oct 11 11:24:14 tigers-lfs kernel:        ef997f18 c01f465a 00000000 6d6f682f ef997f10 ef996000 00000000 c03d7580
Oct 11 11:24:14 tigers-lfs kernel: Call Trace:
Oct 11 11:24:14 tigers-lfs kernel:  [dput+28/576] dput+0x1c/0x240
Oct 11 11:24:14 tigers-lfs kernel:  [in_group_p+34/48] in_group_p+0x22/0x30
Oct 11 11:24:14 tigers-lfs kernel:  [vfs_permission+121/256] vfs_permission+0x79/0x100
Oct 11 11:24:14 tigers-lfs kernel:  [tty_open+410/864] tty_open+0x19a/0x360
Oct 11 11:24:14 tigers-lfs kernel:  [cdev_get+54/64] cdev_get+0x36/0x40
Oct 11 11:24:14 tigers-lfs kernel:  [chrdev_open+451/544] chrdev_open+0x1c3/0x220
Oct 11 11:24:14 tigers-lfs kernel:  [dentry_open+204/384] dentry_open+0xcc/0x180
Oct 11 11:24:14 tigers-lfs kernel:  [filp_open+79/96] filp_open+0x4f/0x60
Oct 11 11:24:14 tigers-lfs kernel:  [sys_open+55/128] sys_open+0x37/0x80
Oct 11 11:24:14 tigers-lfs kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 11 11:24:14 tigers-lfs kernel:
Oct 11 11:24:14 tigers-lfs kernel: Code: 8b 82 9c 00 00 00 83 c4 04 8b 1c 88 85 db 0f 85 0f 03 00 00

--2oS5YaxWCcQjTEyO
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="config-2.6.0-test7.gz"
Content-Transfer-Encoding: base64

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
PAAA

--2oS5YaxWCcQjTEyO--
