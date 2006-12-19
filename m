Return-Path: <linux-kernel-owner+w=401wt.eu-S1754788AbWLSA2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbWLSA2A (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbWLSA2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:28:00 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:31464 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbWLSA17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:27:59 -0500
Date: Mon, 18 Dec 2006 16:29:02 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc1-mm1
Message-Id: <20061218162902.9820426d.randy.dunlap@oracle.com>
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
References: <20061214225913.3338f677.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 22:59:13 -0800 Andrew Morton wrote:

Got this on booting up on x86_64 test box.
Didn't happen on next boot.


BUG: scheduling while atomic: hald-addon-stor/0x20000000/3300

Call Trace:
 [<ffffffff8020ac30>] show_trace+0x34/0x47
 [<ffffffff8020ac55>] dump_stack+0x12/0x17
 [<ffffffff8050c2dd>] __sched_text_start+0x5d/0x7ba
 [<ffffffff8022b3f0>] __cond_resched+0x1c/0x44
 [<ffffffff8050cb4d>] cond_resched+0x29/0x30
 [<ffffffff8050e7aa>] __reacquire_kernel_lock+0x26/0x44
 [<ffffffff8050cae6>] thread_return+0xac/0xea
 [<ffffffff8022b3f0>] __cond_resched+0x1c/0x44
 [<ffffffff8050cb4d>] cond_resched+0x29/0x30
 [<ffffffff8050cb83>] wait_for_completion+0x17/0xd2
 [<ffffffff80337a19>] blk_execute_rq+0x98/0xb8
 [<ffffffff80413e7b>] scsi_execute+0xd4/0xf1
 [<ffffffff80413f51>] scsi_execute_req+0xb9/0xde
 [<ffffffff80413faf>] scsi_test_unit_ready+0x39/0x75
 [<ffffffff804443cd>] sd_media_changed+0x40/0x87
 [<ffffffff8029cde0>] check_disk_change+0x1f/0x76
 [<ffffffff8044417e>] sd_open+0x80/0x113
 [<ffffffff8029d4c4>] do_open+0x9f/0x2a7
 [<ffffffff8029d8bc>] blkdev_open+0x2e/0x5d
 [<ffffffff8027afeb>] __dentry_open+0xd9/0x1a7
 [<ffffffff8027b16a>] do_filp_open+0x2a/0x38
 [<ffffffff8027b1bc>] do_sys_open+0x44/0xc8
 [<ffffffff8020956e>] system_call+0x7e/0x83
 [<00002b6c5bb34580>]

---
~Randy
kconfig:  http://oss.oracle.com/~rdunlap/configs/config-2620-rc1mm1
full log:  http://oss.oracle.com/~rdunlap/logs/2620-rc1mm1.out
