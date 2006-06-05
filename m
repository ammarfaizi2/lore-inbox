Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750722AbWFEQgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWFEQgG (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWFEQgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:36:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:30161 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750722AbWFEQgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:36:04 -0400
Subject: 2.6.17-rc5-mm2 problem ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 09:37:40 -0700
Message-Id: <1149525461.26170.22.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Have you seen this on 2.6.17-rc5-mm2 before ? Could be due to my
patchset (fileop cleanups), but doesn't seem like it ..

Thanks,
Badari

Unable to handle kernel NULL pointer dereference at 0000000000000008
RIP:
 [<ffffffff80448d5f>] skb_dequeue+0x2c/0x50
PGD 18024d067 PUD 19d2ab067 PMD 0
Oops: 0002 [1] SMP
last sysfs file: /class/net/sit0/address
CPU 2
Modules linked in: usbserial parport_pc lp parport ipv6 ohci_hcd
i2c_amd756 i2c_core usbcore dm_mod
Pid: 4438, comm: syslogd Not tainted 2.6.17-rc5-mm2 #2
RIP: 0010:[<ffffffff80448d5f>]  [<ffffffff80448d5f>] skb_dequeue
+0x2c/0x50
RSP: 0018:ffff81019d157b68  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff81019f7f61d8 RCX: ffff81019d157c54
RDX: 0000000000000000 RSI: 0000000000000246 RDI: ffff81019f7f61ec
RBP: ffff8101bdff05c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffff81019d157bd8 R11: 0000000000000028 R12: ffff81019f7f61ec
R13: ffff81019d157cb8 R14: ffff81019d157c54 R15: 0000000000000000
FS:  00002b2f389756e0(0000) GS:ffff8101a00ca640(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000019d950000 CR4: 00000000000006e0
Process syslogd (pid: 4438, threadinfo ffff81019d156000, task
ffff81019d41d090)
Stack: 0000000000000000 ffff81019f7f6140 ffff81019f7f61d8
ffffffff8044b673
       ffff81019f7f6370 7fffffffffffffff ffff81019d156000
ffff81019d157bd8
       ffff81019d41d090 ffffffff80240137
Call Trace:
 [<ffffffff8044b673>] skb_recv_datagram+0x93/0x1f8
 [<ffffffff80240137>] debug_mutex_add_waiter+0x50/0x65
 [<ffffffff804bd59b>] __mutex_lock_slowpath+0x1d4/0x218
 [<ffffffff804a3cc6>] unix_dgram_recvmsg+0x6e/0x1e5
 [<ffffffff80240137>] debug_mutex_add_waiter+0x50/0x65
 [<ffffffff80444e4b>] sock_recvmsg+0x117/0x13b
 [<ffffffff80253c7e>] generic_file_aio_write+0x72/0xc7
 [<ffffffff80253c0c>] generic_file_aio_write+0x0/0xc7
 [<ffffffff80276b88>] do_sync_readv_writev+0xc8/0x10f
 [<ffffffff8023d005>] autoremove_wake_function+0x0/0x2e
 [<ffffffff80445d5b>] sys_recvfrom+0xd3/0x12f
 [<ffffffff804c0e28>] kprobe_flush_task+0x1e/0x53
 [<ffffffff802091e6>] system_call+0x7e/0x83


