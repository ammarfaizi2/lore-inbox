Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTKALBa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 06:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTKALBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 06:01:30 -0500
Received: from smtp.inet.fi ([192.89.123.192]:52923 "EHLO smtp.inet.fi")
	by vger.kernel.org with ESMTP id S263751AbTKALB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 06:01:28 -0500
From: Jarkko Lehti <grue@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Problems with dvd writing with 2.6test9 and 2.6test9-mm1
Date: Sat, 1 Nov 2003 13:01:29 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311011301.29719.grue@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can write one dvd ok. but when trying to write another one it fails, and 
into kernel logs comes this:

Nov  1 12:28:35 nolife kernel: end_request: I/O error, dev sr0, sector 
97311285
Nov  1 12:28:35 nolife kernel: Badness in as_completed_request at 
drivers/block/as-iosched.c:912
Nov  1 12:28:35 nolife kernel: Call Trace:
Nov  1 12:28:35 nolife kernel:  [<c028d2e9>] as_completed_request+0x169/0x210
Nov  1 12:28:35 nolife kernel:  [<c0285b1f>] elv_completed_request+0x1f/0x30
Nov  1 12:28:35 nolife kernel:  [<c0287fac>] __blk_put_request+0x3c/0xc0
Nov  1 12:28:35 nolife kernel:  [<c028805f>] blk_put_request+0x2f/0x60
Nov  1 12:28:35 nolife kernel:  [<c028b890>] sg_io+0x320/0x480
Nov  1 12:28:35 nolife kernel:  [<c028c0a9>] scsi_cmd_ioctl+0x2b9/0x560
Nov  1 12:28:35 nolife kernel:  [<c014437c>] mark_page_accessed+0x2c/0x40
Nov  1 12:28:35 nolife kernel:  [<c013bf39>] filemap_nopage+0x219/0x310
Nov  1 12:28:35 nolife kernel:  [<c014a09f>] do_no_page+0x19f/0x390
Nov  1 12:28:35 nolife kernel:  [<c02de8dc>] cdrom_ioctl+0x3c/0xfb0
Nov  1 12:28:35 nolife kernel:  [<c012e9d9>] sys_rt_sigaction+0xb9/0x120
Nov  1 12:28:35 nolife kernel:  [<c028a038>] blkdev_ioctl+0xa8/0x45c
Nov  1 12:28:35 nolife kernel:  [<c016aea3>] sys_ioctl+0xf3/0x280
Nov  1 12:28:35 nolife kernel:  [<c011c4f0>] do_page_fault+0x0/0x502
Nov  1 12:28:35 nolife kernel:  [<c042193f>] syscall_call+0x7/0xb
Nov  1 12:28:35 nolife kernel:
Nov  1 12:28:35 nolife kernel: end_request: I/O error, dev sr0, sector 
97311285
Nov  1 12:28:40 nolife kernel: end_request: I/O error, dev sr0, sector 
98095485
Nov  1 12:28:40 nolife kernel: end_request: I/O error, dev sr0, sector 
98095485
Nov  1 12:28:45 nolife kernel: end_request: I/O error, dev sr0, sector 
98095773
Nov  1 12:28:45 nolife kernel: end_request: I/O error, dev sr0, sector 
98095773
Nov  1 12:28:50 nolife kernel: end_request: I/O error, dev sr0, sector 
98095733
Nov  1 12:28:50 nolife kernel: end_request: I/O error, dev sr0, sector 
98095733
Nov  1 12:28:55 nolife kernel: end_request: I/O error, dev sr0, sector 
48526645
Nov  1 12:28:55 nolife kernel: end_request: I/O error, dev sr0, sector 
48526645
Nov  1 12:29:00 nolife kernel: end_request: I/O error, dev sr0, sector 
98095917
Nov  1 12:29:00 nolife kernel: end_request: I/O error, dev sr0, sector 
98095917
Nov  1 12:29:05 nolife kernel: end_request: I/O error, dev sr0, sector 
27557799

... and so on

After rebooting things work again for writing another dvd...

software I use for burning is k3b-0.10

My dvd burner is nec-nd1300 and I'm using ide-scsi compiled into kernel.

