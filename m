Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbUKXHhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbUKXHhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUKXHhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:37:10 -0500
Received: from ns.theshore.net ([67.18.92.50]:52356 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S262444AbUKXHYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:24:12 -0500
Message-ID: <001301c4d1f6$941d1370$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc2-bk7 - Badness in cfq_put_request at drivers/block/cfq-iosched.c:1402
Date: Wed, 24 Nov 2004 01:24:01 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badness in cfq_put_request at drivers/block/cfq-iosched.c:1402
 [<c025eed4>] cfq_put_request+0xcc/0x119
 [<c0252520>] elv_put_request+0x25/0x27
 [<c02553a5>] __blk_put_request+0x66/0xab
 [<c0256647>] end_that_request_last+0x6a/0x10b
 [<c029d836>] scsi_end_request+0xbf/0xe6
 [<c029db11>] scsi_io_completion+0x117/0x4b6
 [<c029b2e2>] scsi_delete_timer+0x1a/0x66
 [<c02a9290>] sd_rw_intr+0x89/0x30f
 [<c0114472>] rebalance_tick+0xac/0xbb
 [<c0298e8a>] scsi_finish_command+0x85/0xd9
 [<c0298d9d>] scsi_softirq+0xb7/0xdd
 [<c011cba7>] __do_softirq+0xb7/0xc6
 [<c011cbe3>] do_softirq+0x2d/0x2f
 [<c01046b6>] do_IRQ+0x1e/0x24
 [<c0102db2>] common_interrupt+0x1a/0x20
 [<c01005da>] mwait_idle+0x31/0x48
 [<c01005a0>] cpu_idle+0x33/0x3c
 [<c046aa49>] start_kernel+0x175/0x1b1
 [<c046a4bd>] unknown_bootoption+0x0/0x1ab

-Chris
