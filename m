Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264880AbSKEQQD>; Tue, 5 Nov 2002 11:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSKEQQD>; Tue, 5 Nov 2002 11:16:03 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:41229 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S264880AbSKEQQC>;
	Tue, 5 Nov 2002 11:16:02 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: 2.5.46: buffer layer error at fs/buffer.c:1623
Date: Tue, 5 Nov 2002 16:22:00 +0000 (UTC)
Organization: Cistron
Message-ID: <aq8r78$v1m$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1036513320 31798 62.216.29.67 (5 Nov 2002 16:22:00 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I just saw this:

Nov  5 17:09:10 enterprise kernel: buffer layer error at fs/buffer.c:1623
Nov  5 17:09:10 enterprise kernel: Pass this trace through ksymoops for reporting
Nov  5 17:09:10 enterprise kernel: Call Trace: [__buffer_error+51/64]  [__block_write_full_page+127/880]  [block_write_full_page+45/160]  [blkdev_get_block+0/80]  [blkdev_writepage+15/32]  [blkdev_get_block+0/80]  [mpage_writepages+478/816]  [blkdev_writepage+0/32]  [__set_page_dirty_buffers+205/224]  [try_to_unmap_one+198/256]  [generic_writepages+17/21]  [do_writepages+24/48]  [generic_vm_writeback+50/64]  [shrink_list+564/960]  [__pagevec_release+21/32]  [__pagevec_lru_add_active+131/144]  [__pagevec_release+21/32]  [shrink_cache+333/560]  [shrink_zone+108/128]  [balance_pgdat+155/256]  [kswapd+257/267]  [kswapd+0/267]  [autoremove_wake_function+0/64]  [autoremove_wake_function+0/64]  [kernel_thread_helper+5/16] 

Mike.

