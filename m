Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261798AbTCVBfn>; Fri, 21 Mar 2003 20:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261800AbTCVBfm>; Fri, 21 Mar 2003 20:35:42 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:10807
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261798AbTCVBfk>; Fri, 21 Mar 2003 20:35:40 -0500
Date: Fri, 21 Mar 2003 20:43:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2
In-Reply-To: <Pine.LNX.4.50.0303211842370.28519-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303212042000.28519-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303210202080.2133-100000@montezuma.mastecende.com>
 <411800000.1048276482@aslan.btc.adaptec.com>
 <Pine.LNX.4.50.0303211842370.28519-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a boot with your latest from the URL.

Starting xfs: SCSI disk error : host 1 channel 0 id 0 lun 0 return code = 6000000
end_request: I/O error, dev sda, sector 21496
SCSI disk error : host 1 channel 0 id 0 lun 0 return code = 6030000
end_request: I/O error, dev sda, sector 786536
Buffer I/O error on device sd(8,1), logical block 98313
SCSI disk error : host 1 channel 0 id 0 lun 0 return code = 6000000
end_request: I/O error, dev sda, sector 796424
Buffer I/O error on device sd(8,1), logical block 99549
Debug: sleeping function called from illegal context at 
include/linux/rwsem.h:43
Call Trace:
 [<c011ed18>] __might_sleep+0x58/0x60
 [<c028ec00>] __bdevname+0x50/0xc0
 [<c015cb41>] buffer_io_error+0x11/0x30
 [<c015d406>] end_buffer_async_write+0x166/0x190
 [<c0160101>] end_bio_bh_io_sync+0x21/0x30
 [<c0161515>] bio_endio+0x35/0x60
 [<c028df8f>] __end_that_request_first+0x1ff/0x220
 [<c028dfc7>] end_that_request_first+0x17/0x20
 [<c028a864>] elv_next_request+0x84/0xe0
 [<c02e187f>] scsi_request_fn+0x3f/0x2a0
 [<c028c442>] __blk_run_queue+0x12/0x20
 [<c02e022d>] scsi_restart_operations+0xbd/0x120
 [<c02e05b8>] scsi_error_handler+0x138/0x1a0
 [<c02e0480>] scsi_error_handler+0x0/0x1a0
 [<c0107095>] kernel_thread_helper+0x5/0x10

Buffer I/O error on device sd(8,1), logical block 720900
Buffer I/O error on device sd(8,1), logical block 65708
Buffer I/O error on device sd(8,1), logical block 753672
Buffer I/O error on device sd(8,1), logical block 98306
Buffer I/O error on device sd(8,1), logical block 98307
Buffer I/O error on device sd(8,1), logical block 98314
Buffer I/O error on device sd(8,1), logical block 524288
Buffer I/O error on device sd(8,1), logical block 524289
Buffer I/O error on device sd(8,1), logical block 524804
Buffer I/O error on device sd(8,1), logical block 524292
Buffer I/O error on device sd(8,1), logical block 524301
Buffer I/O error on device sd(8,1), logical block 884746
Buffer I/O error on device sd(8,1), logical block 720896
Buffer I/O error on device sd(8,1), logical block 720897
Buffer I/O error on device sd(8,1), logical block 722105
Buffer I/O error on device sd(8,1), logical block 720904
Buffer I/O error on device sd(8,1), logical block 720905
Buffer I/O error on device sd(8,1), logical block 720912
Buffer I/O error on device sd(8,1), logical block 720913
Buffer I/O error on device sd(8,1), logical block 393221
Buffer I/O error on device sd(8,1), logical block 786438
Buffer I/O error on device sd(8,1), logical block 557062
Buffer I/O error on device sd(8,1), logical block 589831
Buffer I/O error on device sd(8,1), logical block 327694
Buffer I/O error on device sd(8,1), logical block 65536
Buffer I/O error on device sd(8,1), logical block 65537
Buffer I/O error on device sd(8,1), logical block 66054
Buffer I/O error on device sd(8,1), logical block 65540
Buffer I/O error on device sd(8,1), logical block 425998
Buffer I/O error on device sd(8,1), logical block 425999
Unable to handle kernel paging request at virtual address 6b6b6bd3
 printing eip:
c02e92f9
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c02e92f9>]    Not tainted
EFLAGS: 00010002 VLI
EIP is at aic7xxx_done+0x19/0x570
eax: 6b6b6b6b   ebx: c152040c   ecx: c1521868   edx: c161e4c0
esi: c152040c   edi: c153c54c   ebp: c153c54c   esp: c93f5a14
ds: 007b   es: 007b   ss: 0068
Process S90xfs (pid: 917, threadinfo=c93f4000 task=c977c660)
Stack: c161e4c0 c152040c 00000016 c153c54c 00000001 c02e989d c153c54c c152040c 
       00000001 00000006 c153c54c 00000000 00000000 c02f2550 c153c54c 00000001 
       c153c54c 00000000 00000000 ffffffff 000000ff 00000000 00000000 c153c54c 
Call Trace:
 [<c02f2d98>] do_aic7xxx_isr+0x78/0x120
 [<c01106c4>] timer_interrupt+0xd4/0x1f0
 [<c010bb0d>] handle_IRQ_event+0x2d/0x50
 [<c010be49>] do_IRQ+0x109/0x210
 [<c010a398>] common_interrupt+0x18/0x20
 [<c011ef4e>] .text.lock.sched+0x10a/0x12c
 [<c011c5c0>] schedule+0x320/0x610
 [<c01a80b6>] do_get_write_access+0x5d6/0x720
 [<c011c900>] default_wake_function+0x0/0x20
 [<c015e2a4>] __bread+0x14/0x30
 [<c01a8249>] journal_get_write_access+0x49/0x70
 [<c019efd0>] ext3_reserve_inode_write+0x50/0xb0
 [<c01aebec>] __jbd_kmalloc+0x1c/0x70
 [<c019f048>] ext3_mark_inode_dirty+0x18/0x40
 [<c019f1ba>] ext3_dirty_inode+0x14a/0x180
 [<c017e7f3>] __mark_inode_dirty+0x143/0x150
 [<c0177fb5>] update_atime+0xb5/0xc0
 [<c013c79e>] __generic_file_aio_read+0x18e/0x1d0
 [<c013c4d0>] file_read_actor+0x0/0x140
 [<c013c821>] generic_file_aio_read+0x41/0x60
 [<c015b2cd>] do_sync_read+0x7d/0xb0
 [<c011f6f1>] mm_init+0xe1/0x120
 [<c015b3b1>] vfs_read+0xb1/0x1b0
 [<c01665db>] kernel_read+0x3b/0x50
 [<c0167508>] prepare_binprm+0xb8/0xd0
 [<c0167c77>] do_execve+0x1a7/0x240
 [<c0107865>] sys_execve+0x35/0x70
 [<c0109477>] syscall_call+0x7/0xb

Code: 89 01 8b 41 04 85 c0 75 05 8b 01 89 41 04 c3 90 89 f6 55 57 56 53 53 8b 74 24 1c 8b 6c 24 18 8b 46 04 89 04 24 8b  
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

