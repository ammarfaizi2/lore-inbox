Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbUABJul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 04:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbUABJul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 04:50:41 -0500
Received: from luli.rootdir.de ([213.133.108.222]:35715 "EHLO luli.rootdir.de")
	by vger.kernel.org with ESMTP id S265464AbUABJui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 04:50:38 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.20 (Clear:RC:1(217.186.137.29):SA:0(0.0/5.0):. Processed in 0.386796 secs)
Date: Fri, 2 Jan 2004 10:50:51 +0100
From: Claas Langbehn <claas@rootdir.de>
To: linux-kernel@vger.kernel.org
Subject: XFS forced shutdown with kernel 2.6.0
Message-ID: <20040102095051.GA19872@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: Mon Jan  5 10:38:34 CET 2004
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0 i686
X-No-archive: yes
X-Uptime: 10:38:34 up 2 days, 23:13,  6 users,  load average: 0.27, 0.16, 0.15
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


Last night one of my machines running xfs shut down my /homes partition.

That machine was running Azureus (a bittorrent client) with probably
high memory usage.

But even if the memory usage of one program is going near to 100% it
should not force the filesystem to shutdown. Instead it should crash
the application.

I could also think of bad memory, but we did test the SDRAM modules
only a week ago, and they passed memtest86.

After rebooting everything was working fine, again.

So, is this a bug of xfs?


regards,
Claas



kernel: Filesystem "hdb3": XFS internal error xfs_btree_check_lblock at line 222 of file fs/xfs/xfs_btree.c.  Caller 0xc01d770c
kernel: Call Trace:
kernel:  [<c01da8be>] xfs_btree_check_lblock+0x5e/0x190
kernel:  [<c01d770c>] xfs_bmbt_lookup+0x18c/0x550
kernel:  [<c01d770c>] xfs_bmbt_lookup+0x18c/0x550
kernel:  [<c01cabe9>] xfs_bmap_add_extent_delay_real+0x11b9/0x16a0
kernel:  [<c01cdc64>] xfs_bmap_alloc+0xb34/0x1870
kernel:  [<d0a9998d>] __nvsym00795+0x31/0x50 [nvidia]
kernel:  [<c01d957f>] xfs_bmbt_get_state+0x2f/0x40
kernel:  [<c01c989f>] xfs_bmap_add_extent+0x38f/0x520
kernel:  [<c01d2283>] xfs_bmapi+0x783/0x1600
kernel:  [<c01d957f>] xfs_bmbt_get_state+0x2f/0x40
kernel:  [<c01d033c>] xfs_bmap_do_search_extents+0xbc/0x3f0
kernel:  [<c02013dd>] xfs_log_reserve+0xbd/0xd0
kernel:  [<c02269f8>] xfs_iomap_write_allocate+0x2a8/0x4d0
kernel:  [<c01d1df3>] xfs_bmapi+0x2f3/0x1600
kernel:  [<c0225cec>] xfs_iomap+0x40c/0x550
kernel:  [<c0220ae2>] map_blocks+0x72/0x130
kernel:  [<c0221ba7>] page_state_convert+0x4c7/0x620
kernel:  [<c02223bc>] linvfs_writepage+0x5c/0x110
kernel:  [<c0174953>] mpage_writepages+0x203/0x2f0
kernel:  [<c0222360>] linvfs_writepage+0x0/0x110
kernel:  [<c013d846>] do_writepages+0x36/0x40
kernel:  [<c0137e7e>] __filemap_fdatawrite+0xbe/0xd0
kernel:  [<c0137ea7>] filemap_fdatawrite+0x17/0x20
kernel:  [<c01736f0>] generic_osync_inode+0x120/0x130
kernel:  [<c013a27f>] generic_file_aio_write_nolock+0x5af/0xb90
kernel:  [<c011cb10>] default_wake_function+0x0/0x20
kernel:  [<c01fdde0>] xfs_ichgtime+0x120/0x122
kernel:  [<c0211729>] xfs_trans_unlocked_item+0x39/0x60
kernel:  [<c0228e1b>] xfs_write+0x29b/0x860
kernel:  [<d0a99a8d>] __nvsym00727+0x31/0x38 [nvidia]
kernel:  [<c0109d16>] apic_timer_interrupt+0x1a/0x20
kernel:  [<c02228c1>] linvfs_write+0xb1/0x120
kernel:  [<c01536bb>] do_sync_write+0x8b/0xc0
kernel:  [<c0147ae9>] find_extend_vma+0x29/0x90
kernel:  [<c011cb10>] default_wake_function+0x0/0x20
kernel:  [<c0127fc6>] update_process_times+0x46/0x60
kernel:  [<c0127e2b>] update_wall_time+0xb/0x40
kernel:  [<c012829f>] do_timer+0xdf/0xf0
kernel:  [<c0153630>] do_sync_write+0x0/0xc0
kernel:  [<c01537a8>] vfs_write+0xb8/0x130
kernel:  [<c01538d2>] sys_write+0x42/0x70
kernel:  [<c0109387>] syscall_call+0x7/0xb
kernel: 
kernel: xfs_force_shutdown(hdb3,0x8) called from line 1070 of file fs/xfs/xfs_trans.c.  Return address = 0xc022aa0c
kernel: Filesystem "hdb3": Corruption of in-memory data detected.  Shutting down filesystem: hdb3
kernel: Please umount the filesystem, and rectify the problem(s)

- about 30mins later: -

kernel: Out of Memory: Killed process 2825 (java).


