Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSLCSF3>; Tue, 3 Dec 2002 13:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbSLCSF3>; Tue, 3 Dec 2002 13:05:29 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:19660 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S265382AbSLCSFY>;
	Tue, 3 Dec 2002 13:05:24 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Tue, 3 Dec 2002 19:12:27 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.5.50-bk: floppy: buffer layout error ...
X-mailer: Pegasus Mail v3.50
Message-ID: <94A09B0451B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  is there some known problem with error handling in floppy driver?
It complains loudly that "buffer layer error at fs/buffer.c:2641"
and fs/buffer.c:2690. It happened during floppy write. After reformatting
floppy write succeeded without any complaints.
                                            Thanks,
                                                   Petr Vandrovec
                                                   
  
end_request: I/O error, dev fd0, sector 2872
Buffer I/O error on device fd(2,0), logical block 359
buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c0150171>] check_ttfb_buffer+0x41/0x48
 [<c01501a7>] drop_buffers+0x2f/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c01501df>] drop_buffers+0x67/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c0150171>] check_ttfb_buffer+0x41/0x48
 [<c01501a7>] drop_buffers+0x2f/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c01501df>] drop_buffers+0x67/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c0150171>] check_ttfb_buffer+0x41/0x48
 [<c01501a7>] drop_buffers+0x2f/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c01501df>] drop_buffers+0x67/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c0150171>] check_ttfb_buffer+0x41/0x48
 [<c01501a7>] drop_buffers+0x2f/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c01501df>] drop_buffers+0x67/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c0150171>] check_ttfb_buffer+0x41/0x48
 [<c01501a7>] drop_buffers+0x2f/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c01501df>] drop_buffers+0x67/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c014cdf3>] __buffer_error+0x33/0x38
 [<c0150171>] check_ttfb_buffer+0x41/0x48
 [<c01501a7>] drop_buffers+0x2f/0xb0
 [<c01502bc>] try_to_free_buffers+0x94/0x108
 [<c01311cd>] __remove_from_page_cache+0x2d/0x68
 [<c014e586>] try_to_release_page+0x42/0x48
 [<c0139b4d>] invalidate_complete_page+0x25/0xa4
 [<c0139eeb>] invalidate_inode_pages+0x6f/0xcc
 [<c014d415>] invalidate_bdev+0x19/0x20
 [<c01525b5>] kill_bdev+0xd/0x28
 [<c0153a12>] blkdev_put+0xbe/0x208
 [<c0153b6e>] blkdev_close+0x12/0x18
 [<c014c9e4>] __fput+0x30/0x144
 [<c014c9b0>] fput+0x14/0x18
 [<c014b45d>] filp_close+0x101/0x10c
 [<c014b4d6>] sys_close+0x6e/0x8c
 [<c0108dc7>] syscall_call+0x7/0xb

