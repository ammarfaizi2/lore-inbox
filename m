Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVAKFYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVAKFYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 00:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVAKFYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 00:24:00 -0500
Received: from web52604.mail.yahoo.com ([206.190.39.142]:15235 "HELO
	web52604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262377AbVAKFXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 00:23:55 -0500
Message-ID: <20050111052355.14035.qmail@web52604.mail.yahoo.com>
Date: Tue, 11 Jan 2005 16:23:55 +1100 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: [PROBLEM] Badness in cfq_account_completion at drivers/block/cfq-iosched.c:916
To: linux-kernel@vger.kernel.org
Cc: sriharivijayaraghavan@yahoo.com.au
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see zillion of these error messages in vanilla
2.6.10:
Jan 11 16:10:13 linux kernel:  [<c0220ee0>]
scsi_end_request+0xa9/0xd6
Jan 11 16:10:13 linux kernel:  [<c0221181>]
scsi_io_completion+0xee/0x48e
Jan 11 16:10:13 linux kernel:  [<c028145f>]
_spin_unlock_irqrestore+0x5/0x6
Jan 11 16:10:13 linux kernel:  [<c01233d0>]
__mod_timer+0x122/0x160
Jan 11 16:10:13 linux kernel:  [<c01f187e>]
i8042_interrupt+0x4b/0x19f
Jan 11 16:10:13 linux kernel:  [<f881ca9c>]
sd_rw_intr+0x52/0x2a3 [sd_mod]
Jan 11 16:10:14 linux kernel:  [<c021d0e2>]
scsi_finish_command+0x17/0xb2
Jan 11 16:10:15 linux kernel:  [<c0123cc8>]
run_timer_softirq+0x175/0x17d
Jan 11 16:10:15 linux kernel:  [<c021d05e>]
scsi_softirq+0x9c/0xd3
Jan 11 16:10:15 linux kernel:  [<c011fde2>]
__do_softirq+0x62/0xce
Jan 11 16:10:15 linux kernel:  [<c0105112>]
do_softirq+0x42/0x49
Jan 11 16:10:15 linux kernel:  =======================
Jan 11 16:10:15 linux kernel:  [<c0105022>]
do_IRQ+0x42/0x54
Jan 11 16:10:16 linux kernel:  [<c010376e>]
common_interrupt+0x1a/0x20
Jan 11 16:10:16 linux kernel:  [<c010101e>]
default_idle+0x0/0x33
Jan 11 16:10:16 linux kernel:  [<c0101047>]
default_idle+0x29/0x33
Jan 11 16:10:16 linux kernel:  [<c01010b2>]
cpu_idle+0x2e/0x3e
Jan 11 16:10:16 linux kernel:  [<c03388ff>]
start_kernel+0x18d/0x1c9
Jan 11 16:10:16 linux kernel:  [<c0338345>]
unknown_bootoption+0x0/0x1bc
Jan 11 16:10:16 linux kernel: Badness in
cfq_account_completion at
drivers/block/cfq-iosched.c:916
Jan 11 16:10:16 linux kernel:  [<c020566a>]
cfq_completed_request+0xf6/0xfe
Jan 11 16:10:16 linux kernel:  [<c01ffbff>]
__blk_put_request+0x4d/0x90
Jan 11 16:10:16 linux kernel:  [<c0200e7e>]
end_that_request_last+0xb5/0xe3
Jan 11 16:10:16 linux kernel:  [<c0220ee0>]
scsi_end_request+0xa9/0xd6
Jan 11 16:10:16 linux kernel:  [<c0221181>]
scsi_io_completion+0xee/0x48e
Jan 11 16:10:16 linux kernel:  [<c028145f>]
_spin_unlock_irqrestore+0x5/0x6
Jan 11 16:10:16 linux kernel:  [<c01233d0>]
__mod_timer+0x122/0x160
Jan 11 16:10:16 linux kernel:  [<c01f187e>]
i8042_interrupt+0x4b/0x19f
Jan 11 16:10:16 linux kernel:  [<f881ca9c>]
sd_rw_intr+0x52/0x2a3 [sd_mod]
Jan 11 16:10:16 linux kernel:  [<c021d0e2>]
scsi_finish_command+0x17/0xb2
Jan 11 16:10:16 linux kernel:  [<c0123cc8>]
run_timer_softirq+0x175/0x17d
Jan 11 16:10:16 linux kernel:  [<c021d05e>]
scsi_softirq+0x9c/0xd3
Jan 11 16:10:16 linux kernel:  [<c011fde2>]
__do_softirq+0x62/0xce
Jan 11 16:10:16 linux kernel:  [<c0105112>]
do_softirq+0x42/0x49

It is an IBM x360, 2 Xeon (HT), 4 GB, Hardware RAID
70+ GB on IBM ServeRaid etc.

Thanks
Hari

PS: Please cc me in replies, as I am not subscribed to
LKML. I will see if I see same error messages in
-bk<latest>.


Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
