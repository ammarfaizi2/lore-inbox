Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTKAQNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 11:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTKAQNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 11:13:38 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:1942 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S263024AbTKAQNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 11:13:37 -0500
Subject: 2.6.0test9 Dmesg messages
From: Peter Zaitsev <peter@mysql.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MySQL
Message-Id: <1067703103.2168.616.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 01 Nov 2003 19:11:44 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel developers,

I've been testing kernel 2.6.0test9 on QuadXeon w HT with 3WARE RAID10
(8 drives)

On the IO stress test I found a lot of following messages in dmesg, I'm
not sure what do they mean and how to get rid of them:

Badness in as_completed_request at drivers/block/as-iosched.c:919
Call Trace:
 [<c0228499>] as_completed_request+0x1ed/0x21d
 [<c0220bde>] elv_completed_request+0x1f/0x21
 [<c022302a>] __blk_put_request+0x3e/0xb5
 [<c02240ab>] end_that_request_last+0x60/0xed
 [<c025e638>] scsi_end_request+0xcb/0x109
 [<c025e98c>] scsi_io_completion+0x179/0x4c2
 [<c012a5c4>] update_wall_time+0xd/0x36
 [<c02a8782>] sd_rw_intr+0x87/0x2fe
 [<c025c11b>] scsi_delete_timer+0x1a/0x66
 [<c0259bce>] scsi_finish_command+0x84/0xd8
 [<c02599d1>] scsi_softirq+0xe4/0x223
 [<c0126047>] do_softirq+0xc3/0xc5
 [<c010d4ec>] do_IRQ+0x164/0x1d5
 [<c010888e>] default_idle+0x0/0x2d
 [<c010b720>] common_interrupt+0x18/0x20
 [<c010888e>] default_idle+0x0/0x2d
 [<c01088b8>] default_idle+0x2a/0x2d
 [<c010892c>] cpu_idle+0x37/0x40
 [<c0105000>] rest_init+0x0/0x65
 [<c0430854>] start_kernel+0x1a8/0x1e8
 [<c0430403>] unknown_bootoption+0x0/0xff


Please let me know which additional information I need to provide, in
order to help to track down this issue.

I've also seen some serve performance degradation issues compared to 2.4
but as they might be related to this issue, I'll do more tests before
reporting them.



-- 
Peter Zaitsev, Full-Time Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification

