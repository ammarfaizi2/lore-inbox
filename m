Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSLCCEY>; Mon, 2 Dec 2002 21:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbSLCCEY>; Mon, 2 Dec 2002 21:04:24 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:32386 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S265851AbSLCCET>; Mon, 2 Dec 2002 21:04:19 -0500
Date: Tue, 3 Dec 2002 13:11:33 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50: floppy/buffer related oops
Message-ID: <20021203021133.GD617@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was dding to a floppy disc that had errors on it. Since I couldn't ^c
dd and the floppy drive was making a lot of noise I ejected the floppy.
This stopped dd but also produced the following in dmesg (oopses towards
the end):

end_request: I/O error, dev fd0, sector 273
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 278
Buffer I/O error on device fd(2,0), logical block 34
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 283
Buffer I/O error on device fd(2,0), logical block 35
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 288
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 293
Buffer I/O error on device fd(2,0), logical block 36
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 298
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 303
Buffer I/O error on device fd(2,0), logical block 37
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 308
Buffer I/O error on device fd(2,0), logical block 38
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 313
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 318
Buffer I/O error on device fd(2,0), logical block 39
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 323
Buffer I/O error on device fd(2,0), logical block 40
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 328
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 333
Buffer I/O error on device fd(2,0), logical block 41
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 338
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 343
Buffer I/O error on device fd(2,0), logical block 42
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 348
Buffer I/O error on device fd(2,0), logical block 43
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 353
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 358
Buffer I/O error on device fd(2,0), logical block 44
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 363
Buffer I/O error on device fd(2,0), logical block 45
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 368
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 373
Buffer I/O error on device fd(2,0), logical block 46
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 378
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 383
Buffer I/O error on device fd(2,0), logical block 47
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 388
Buffer I/O error on device fd(2,0), logical block 48
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 393
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 398
Buffer I/O error on device fd(2,0), logical block 49
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 403
Buffer I/O error on device fd(2,0), logical block 50
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 408
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 413
Buffer I/O error on device fd(2,0), logical block 51
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 418
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 423
Buffer I/O error on device fd(2,0), logical block 52
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 428
Buffer I/O error on device fd(2,0), logical block 53
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 433
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 438
Buffer I/O error on device fd(2,0), logical block 54
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 443
Buffer I/O error on device fd(2,0), logical block 55
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 448
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 453
Buffer I/O error on device fd(2,0), logical block 56
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 458
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 463
Buffer I/O error on device fd(2,0), logical block 57
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 468
Buffer I/O error on device fd(2,0), logical block 58
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 473
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 478
Buffer I/O error on device fd(2,0), logical block 59
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 483
Buffer I/O error on device fd(2,0), logical block 60
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 488
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 493
Buffer I/O error on device fd(2,0), logical block 61
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 496
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 501
Buffer I/O error on device fd(2,0), logical block 62
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 506
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 511
Buffer I/O error on device fd(2,0), logical block 63
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 516
Buffer I/O error on device fd(2,0), logical block 64
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 521
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 526
Buffer I/O error on device fd(2,0), logical block 65
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 531
Buffer I/O error on device fd(2,0), logical block 66
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 536
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 541
Buffer I/O error on device fd(2,0), logical block 67
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 546
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 551
Buffer I/O error on device fd(2,0), logical block 68
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 556
Buffer I/O error on device fd(2,0), logical block 69
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 561
floppy0: disk absent or changed during operation
end_request: I/O error, dev fd0, sector 566
Buffer I/O error on device fd(2,0), logical block 70
buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146a69>] check_ttfb_buffer+0x41/0x48
 [<c0146a99>] drop_buffers+0x29/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146ad1>] drop_buffers+0x61/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146a69>] check_ttfb_buffer+0x41/0x48
 [<c0146a99>] drop_buffers+0x29/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146ad1>] drop_buffers+0x61/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146a69>] check_ttfb_buffer+0x41/0x48
 [<c0146a99>] drop_buffers+0x29/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146ad1>] drop_buffers+0x61/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146a69>] check_ttfb_buffer+0x41/0x48
 [<c0146a99>] drop_buffers+0x29/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146ad1>] drop_buffers+0x61/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146a69>] check_ttfb_buffer+0x41/0x48
 [<c0146a99>] drop_buffers+0x29/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2690
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146ad1>] drop_buffers+0x61/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2641
Pass this trace through ksymoops for reporting
Call Trace:
 [<c0143c03>] __buffer_error+0x33/0x38
 [<c0146a69>] check_ttfb_buffer+0x41/0x48
 [<c0146a99>] drop_buffers+0x29/0xa8
 [<c0146b7b>] try_to_free_buffers+0x63/0xbc
 [<c0144fb9>] try_to_release_page+0x41/0x48
 [<c013e626>] invalidate_complete_page+0x22/0x98
 [<c013e9ba>] invalidate_inode_pages+0x6e/0xcc
 [<c01441a9>] invalidate_bdev+0x19/0x20
 [<c01488b9>] kill_bdev+0xd/0x28
 [<c014991a>] blkdev_put+0x7e/0x1a4
 [<c0149a52>] blkdev_close+0x12/0x18
 [<c0143977>] __fput+0x37/0x10c
 [<c014393f>] fput+0x13/0x14
 [<c0142525>] filp_close+0x99/0xa4
 [<c0142588>] sys_close+0x58/0x80
 [<c010892b>] syscall_call+0x7/0xb


-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
