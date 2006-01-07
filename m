Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWAGNhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWAGNhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 08:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWAGNhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 08:37:03 -0500
Received: from [202.67.154.148] ([202.67.154.148]:60116 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1030449AbWAGNg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 08:36:58 -0500
Message-ID: <43BFC3FF.5080908@ns666.com>
Date: Sat, 07 Jan 2006 14:37:03 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Night Owl 3.12V
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Badness in as_insert_request at drivers/block/as-iosched.c:1519
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya all,

I was just playing a cd as usual and i noticed suddenly the errors
below, they repeated like 8 times.

kernel: 2.6.14.5


Jan 7 14:32:40 localhost kernel: Badness in as_insert_request at
drivers/block/as-iosched.c:1519
Jan 7 14:32:40 localhost kernel: [as_insert_request+100/384]
Jan 7 14:32:40 localhost kernel: [__elv_add_request+120/192]
Jan 7 14:32:40 localhost kernel: [elv_add_request+76/112]
Jan 7 14:32:40 localhost kernel: [blk_execute_rq_nowait+72/96]
Jan 7 14:32:40 localhost kernel: [blk_execute_rq+148/192]
Jan 7 14:32:40 localhost kernel: [blk_end_sync_rq+0/64]
Jan 7 14:32:40 localhost kernel: [blk_rq_bio_prep+115/160]
Jan 7 14:32:40 localhost kernel: [cdrom_read_cdda_bpc+391/496]
Jan 7 14:32:40 localhost kernel: [cdrom_read_cdda+68/176]
Jan 7 14:32:40 localhost kernel: [mmc_ioctl+1373/2752]
Jan 7 14:32:40 localhost kernel: [cdrom_read_cdda+68/176]
Jan 7 14:32:40 localhost kernel: [mmc_ioctl+1373/2752]
Jan 7 14:32:40 localhost kernel: [scsi_cmd_ioctl+125/1232]
Jan 7 14:32:40 localhost last message repeated 3 times
Jan 7 14:32:40 localhost kernel: [cdrom_ioctl+3228/3392]
Jan 7 14:32:40 localhost kernel: [activate_task+141/160]
Jan 7 14:32:40 localhost kernel: [try_to_wake_up+730/832]
Jan 7 14:32:40 localhost kernel: [idecd_ioctl+133/144]
Jan 7 14:32:40 localhost kernel: [blkdev_driver_ioctl+82/144]
Jan 7 14:32:40 localhost kernel: [blkdev_ioctl+168/432]
Jan 7 14:32:40 localhost kernel: [block_ioctl+43/48]
Jan 7 14:32:40 localhost kernel: [do_ioctl+142/160]
Jan 7 14:32:40 localhost kernel: [vfs_ioctl+101/496]
Jan 7 14:32:40 localhost kernel: [sys_ioctl+103/144]
Jan 7 14:32:40 localhost kernel: [syscall_call+7/11]
Jan 7 14:32:40 localhost kernel: arq->state: 4

Appreciate it if any one can take a look.

Thanks,

Mark
