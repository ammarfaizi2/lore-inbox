Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUHTSNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUHTSNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268602AbUHTSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:11:37 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:43920 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268592AbUHTSEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:04:52 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3 lockmeter on 512p w/kernbench
Date: Fri, 20 Aug 2004 14:04:32 -0400
User-Agent: KMail/1.6.2
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com>
In-Reply-To: <200408201144.49522.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w0jJBqbJpj3EPCn"
Message-Id: <200408201404.32515.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_w0jJBqbJpj3EPCn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

More lockstats.  dcache is obviously still there, but for some reason the rcu 
stuff is gone (I didn't apply Manfred's patches).  I must have done some 
stuff prior to collecting the lockstat data last time that caused it.

Jesse

--Boundary-00=_w0jJBqbJpj3EPCn
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lockstat-4.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lockstat-4.txt"

___________________________________________________________________________________________
System: Linux ascender.americas.sgi.com 2.6.8.1-mm3 #7 SMP Fri Aug 20 10:29:32 PDT 2004 ia64
Total counts

All (512) CPUs
Selecting locks that meet ALL of the following:
        requests/sec:   >  0.00/sec
        contention  :   >  0.00%
        utilization :   >  0.00%


Start time: Fri Aug 20 12:49:08 2004
End   time: Fri Aug 20 12:59:08 2004
Delta Time: 640.61 sec.
Hash table slots in use:      463.
Global read lock slots in use: 999.
./lockstat: One or more warnings were printed with the report.

*************************** Warnings! ******************************
        Read Lock table overflowed.

        The data in this report may be in error due to this.
************************ End of Warnings! **************************


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

        3.1%  2.2us( 102ms)   12ms( 488ms)(35.1%) 320195677 96.9%  3.1% 0.00%  *TOTAL*

 0.20% 0.39%  1.6us(  45ms)  224us(  50ms)(0.00%)    820933 99.6% 0.39%    0%  [0xe000003034bc5ad0]
 0.00%    0%  2.1us(  24us)    0us                      143  100%    0%    0%    xfs_log_need_covered+0x100
 0.02% 0.22%  1.4us( 864us)   35us( 462us)(0.00%)     92024 99.8% 0.22%    0%    xfs_log_notify+0x40
 0.00% 0.14%  5.3us( 204us)  2.2us( 4.2us)(0.00%)      4379 99.9% 0.14%    0%    xlog_state_do_callback+0x50
 0.00%  3.6%  0.1us(  13us)  5.9us(  97us)(0.00%)      4379 96.4%  3.6%    0%    xlog_state_do_callback+0x410
 0.00% 0.55%  2.8us( 102us)   18us(  88us)(0.00%)      4376 99.5% 0.55%    0%    xlog_state_do_callback+0x480
 0.00%  1.1%  0.3us(  60us)   21us( 149us)(0.00%)      4407 98.9%  1.1%    0%    xlog_state_done_syncing+0x40
 0.08% 0.33%  2.8us(  45ms)  167us(  40ms)(0.00%)    188122 99.7% 0.33%    0%    xlog_state_get_iclog_space+0x30
 0.03% 0.31%  2.5us( 631us)   24us( 264us)(0.00%)     72666 99.7% 0.31%    0%    xlog_state_put_ticket+0x20
 0.02% 0.43%  0.6us(  11ms)   33us(1072us)(0.00%)    188343 99.6% 0.43%    0%    xlog_state_release_iclog+0x50
 0.00%  1.2%   20us(5636us) 1411us(  11ms)(0.00%)       648 98.8%  1.2%    0%    xlog_state_sync_all+0x30
 0.00% 0.69%  1.4us(  37us)   28us(  35us)(0.00%)       288 99.3% 0.69%    0%    xlog_state_sync_all+0x420
 0.00%    0%   14us(  93us)    0us                       43  100%    0%    0%    xlog_state_sync+0x40
 0.00%    0%  3.1us(  31us)    0us                       28  100%    0%    0%    xlog_state_sync+0x3d0
 0.00%    0%  0.7us(  50us)    0us                      451  100%    0%    0%    xlog_state_want_sync+0x20
 0.03% 0.64%  2.6us(3209us) 1160us(  50ms)(0.00%)     72666 99.4% 0.64%    0%    xlog_ticket_get+0x50
 0.02% 0.32%  0.5us( 434us)   24us(1019us)(0.00%)    183988 99.7% 0.32%    0%    xlog_write+0x590
 0.00%    0%  1.7us(  75us)    0us                      451  100%    0%    0%    xlog_write+0x660
 0.00% 0.65%  1.9us( 221us)   46us( 232us)(0.00%)      3531 99.3% 0.65%    0%    xlog_write+0x7a0

 0.34% 0.52%  3.7us(  62ms)  895us(  61ms)(0.00%)    584412 99.5% 0.52%    0%  [0xe000003034bc5b70]
 0.06% 0.19%  4.9us(  56ms)   70us( 409us)(0.00%)     82697 99.8% 0.19%    0%    xfs_log_move_tail+0x70
 0.00% 0.53%  0.2us( 330us)  261us(  44ms)(0.00%)    188343 99.5% 0.53%    0%    xlog_assign_tail_lsn+0x50
 0.13% 0.20%   12us(  54ms)  425us(  49ms)(0.00%)     72666 99.8% 0.20%    0%    xlog_grant_log_space+0x30
 0.03% 22.6%   84us(  42ms) 1071us(  51ms)(0.00%)      1912 77.4% 22.6%    0%    xlog_grant_log_space+0x270
 0.00%  4.0%  7.9us( 143us)   21us(  31us)(0.00%)        75 96.0%  4.0%    0%    xlog_grant_log_space+0x5e0
 0.07% 0.66%  4.0us(  62ms) 2515us(  61ms)(0.00%)    112412 99.3% 0.66%    0%    xlog_grant_push_ail+0x50
 0.01% 0.62%  1.0us( 466us)  148us(  10ms)(0.00%)     39671 99.4% 0.62%    0%    xlog_regrant_reserve_log_space+0x60
 0.01% 0.01%  6.3us(  48ms)   12us(  12us)(0.00%)      9591  100% 0.01%    0%    xlog_regrant_write_log_space+0x90
 0.00% 0.78%  0.1us( 3.5us)  796us(  20ms)(0.00%)      4379 99.2% 0.78%    0%    xlog_state_do_callback+0x3c0
 0.02% 0.42%  2.1us( 952us)   67us( 796us)(0.00%)     72666 99.6% 0.42%    0%    xlog_ungrant_log_space+0x50

 0.20%  2.4%  1.2us(  31ms)  100us(  37ms)(0.00%)   1111556 97.6%  2.4%    0%  [0xe0001bb003ec7024]
 0.00%  1.7%  0.5us( 147us)  438us(  17ms)(0.00%)      5855 98.3%  1.7%    0%    xfs_buf_iodone+0x30
 0.00%    0%  0.1us( 2.3us)    0us                      233  100%    0%    0%    xfs_buf_item_unpin+0x170
 0.00% 0.04%  0.1us( 4.6us)  3.5us( 4.8us)(0.00%)      9791  100% 0.04%    0%    xfs_efi_item_unpin+0x30
 0.00%  1.6%  0.1us(  23us)  4.2us(  24us)(0.00%)      9791 98.4%  1.6%    0%    xfs_efi_release+0x40
 0.00%  2.0%  0.1us(  63us)  191us(  30ms)(0.00%)     35651 98.0%  2.0%    0%    xfs_iflush_done+0xc0
 0.01%  2.4%  1.1us( 564us)   46us(1692us)(0.00%)     35705 97.6%  2.4%    0%    xfs_iflush_int+0x3f0
 0.01% 0.37%  0.2us(6576us)   13us(2534us)(0.00%)    348797 99.6% 0.37%    0%    xfs_trans_chunk_committed+0x220
 0.01%  3.1%  9.7us(  31ms)  710us(  25ms)(0.00%)      8586 96.9%  3.1%    0%    xfs_trans_push_ail+0x40
 0.16%  4.6%  2.2us(  19ms)   90us(  37ms)(0.00%)    468422 95.4%  4.6%    0%    xfs_trans_push_ail+0x2b0
 0.00% 24.6%  2.0us(  99us)   95us(1631us)(0.00%)       382 75.4% 24.6%    0%    xfs_trans_push_ail+0x420
 0.01% 0.59%  0.3us(1061us)  211us(  31ms)(0.00%)    188343 99.4% 0.59%    0%    xfs_trans_tail_ail+0x30

 0.11% 0.30%  0.9us(  59ms)  488us(  65ms)(0.00%)    780856 99.7% 0.30%    0%  [0xe0001bb003ec7110]
 0.10% 0.29%  0.9us(  59ms)  534us(  65ms)(0.00%)    713418 99.7% 0.29%    0%    xfs_mod_incore_sb+0x20
 0.01% 0.35%  1.2us(  39ms)   75us(5635us)(0.00%)     67427 99.7% 0.35%    0%    xfs_mod_incore_sb_batch+0x30
 0.00%    0%  2.6us(  14us)    0us                       11  100%    0%    0%    xfs_statvfs+0x40

 0.13% 0.26%  4.9us( 201us)   51us(1629us)(0.00%)    169465 99.7% 0.26%    0%  [0xe0004ab07bcca040]
 0.13% 0.22%   24us( 201us)  106us(1629us)(0.00%)     34037 99.8% 0.22%    0%    qla1280_intr_handler+0x30
 0.00% 0.16%  0.7us(  47us)   17us( 143us)(0.00%)     33913 99.8% 0.16%    0%    scsi_device_unbusy+0x40
    0% 0.18%                  23us( 202us)(0.00%)     33801 99.8% 0.18%    0%    scsi_dispatch_cmd+0x330
    0% 0.48%                  42us( 534us)(0.00%)     33801 99.5% 0.48%    0%    scsi_request_fn+0x260
    0% 0.27%                  62us( 296us)(0.00%)     33913 99.7% 0.27%    0%    scsi_run_queue+0xa0

 0.19% 0.80%  1.9us(3152us)   54us(2531us)(0.00%)    643460 99.2% 0.80%    0%  [0xe0004eb003b2f834]
 0.00% 0.59%  0.1us(1653us)   72us(1881us)(0.00%)    395190 99.4% 0.59%    0%    __make_request+0x150
    0%    0%                   0us                        2  100%    0%    0%    as_antic_timeout+0x50
 0.00%    0%  2.8us(  25us)    0us                       23  100%    0%    0%    as_work_handler+0x40
 0.03%  1.1%  4.8us( 399us)   25us( 376us)(0.00%)     33913 98.9%  1.1%    0%    blk_run_queue+0x40
 0.15% 0.75%   42us(3152us)   68us(1995us)(0.00%)     22257 99.2% 0.75%    0%    generic_unplug_device+0x40
    0% 0.57%                  36us( 641us)(0.00%)     33923 99.4% 0.57%    0%    get_request+0x80
    0% 0.68%                  89us(2531us)(0.00%)     33913 99.3% 0.68%    0%    scsi_device_unbusy+0xd0
    0%  1.0%                  56us( 832us)(0.00%)     33913 99.0%  1.0%    0%    scsi_end_request+0x160
 0.02%  4.1%  3.7us(1300us)   27us( 467us)(0.00%)     33801 95.9%  4.1%    0%    scsi_request_fn+0x4a0
    0% 0.16%                  26us( 309us)(0.00%)     56525 99.8% 0.16%    0%    scsi_request_fn+0x540

 0.03% 0.02%   32us( 819us)  2.8us( 2.8us)(0.00%)      6298  100% 0.02%    0%  [0xe0007db0041643c0]
 0.00% 0.41%  2.0us(  34us)  2.8us( 2.8us)(0.00%)       245 99.6% 0.41%    0%    tg3_poll+0x110
    0%    0%                   0us                      291  100%    0%    0%    tg3_start_xmit+0x90
 0.03%    0%   35us( 819us)    0us                     5762  100%    0%    0%    tg3_timer+0x50

 0.01% 0.24%   15us( 533us)   41us(  93us)(0.00%)      5084 99.8% 0.24%    0%  bdev_lock
 0.01% 0.24%   15us( 533us)   41us(  93us)(0.00%)      5084 99.8% 0.24%    0%    nr_blockdev_pages+0x40

 0.01% 0.09%   16us( 393us)   44us(  82us)(0.00%)      5379  100% 0.09%    0%  cdev_lock
 0.01% 0.09%   16us( 393us)   44us(  82us)(0.00%)      5379  100% 0.09%    0%    chrdev_open+0x40

 23.8% 67.3%   15us(  55ms) 2316us( 488ms)( 4.7%)   9955785 32.7% 67.3%    0%  dcache_lock
 0.06% 70.5%   21us(  23ms) 2338us(  81ms)(0.01%)     17068 29.5% 70.5%    0%    d_alloc+0x270
 0.02% 25.4%  6.5us( 405us) 1993us(  56ms)(0.00%)     15340 74.6% 25.4%    0%    d_delete+0x40
 0.06% 65.9%   12us(  23ms) 2399us( 327ms)(0.01%)     30485 34.1% 65.9%    0%    d_instantiate+0x90
 0.06% 78.0%   92us(  19ms) 2211us( 148ms)(0.00%)      4461 22.0% 78.0%    0%    d_move+0x60
 0.00%    0%  1.0us( 1.2us)    0us                        2  100%    0%    0%    d_path+0x120
 0.04% 52.5%   17us( 673us) 1583us( 132ms)(0.00%)     17068 47.5% 52.5%    0%    d_rehash+0xe0
 0.00% 26.7%  0.8us( 5.6us)   48us( 133us)(0.00%)        15 73.3% 26.7%    0%    d_splice_alias+0xc0
 0.00% 20.0%   23us( 112us)  117us( 117us)(0.00%)         5 80.0% 20.0%    0%    dentry_unhash+0x70
 0.00%    0%  0.9us( 3.5us)    0us                        4  100%    0%    0%    dentry_unhash+0xc0
 23.5% 67.5%   15us(  55ms) 2319us( 488ms)( 4.7%)   9827270 32.5% 67.5%    0%    dput+0x40
 0.09% 62.3%   15us(  30ms) 1697us( 152ms)(0.01%)     36875 37.7% 62.3%    0%    link_path_walk+0xef0
 0.00% 0.24%  0.2us(  23us)  2.7us( 9.8us)(0.00%)      5068 99.8% 0.24%    0%    link_path_walk+0x1cc0
 0.00% 33.3%  4.6us( 6.8us)  506us( 506us)(0.00%)         3 66.7% 33.3%    0%    proc_pid_unhash+0x50
 0.00%  7.1%   12us(  47us)  357us( 357us)(0.00%)        14 92.9%  7.1%    0%    prune_dcache+0x50
 0.00%    0%  0.3us(  11us)    0us                      167  100%    0%    0%    prune_dcache+0x3d0
 0.00%    0%  8.7us(  60us)    0us                       21  100%    0%    0%    select_parent+0x40
 0.00% 24.2%   12us( 189us) 1625us(  36ms)(0.00%)      1919 75.8% 24.2%    0%    sys_getcwd+0x210

  2.9% 10.1%  7.1us(  54ms) 1047us(  79ms)(0.08%)   2615560 89.9% 10.1%    0%  files_lock
 0.00%  4.9%  1.4us( 669us)  303us(  44ms)(0.00%)      9223 95.1%  4.9%    0%    check_tty_count+0x40
 0.28%  9.7%  1.4us(  54ms)  555us(  72ms)(0.02%)   1298848 90.3%  9.7%    0%    file_kill+0x60
  2.6% 10.5%   13us(  43ms) 1504us(  79ms)(0.06%)   1307489 89.5% 10.5%    0%    file_move+0x40

 0.83% 0.78%   11us(  67ms) 2034us(  65ms)(0.00%)    492079 99.2% 0.78%    0%  inode_lock
 0.07%  1.4%  6.0us(  48ms) 2709us(  64ms)(0.00%)     77788 98.6%  1.4%    0%    __mark_inode_dirty+0xf0
 0.40% 0.73%   56us(  67ms)  194us(  17ms)(0.00%)     45627 99.3% 0.73%    0%    __sync_single_inode+0xf0
 0.00%    0%   12us(  37us)    0us                        4  100%    0%    0%    __wait_on_freeing_inode+0x160
 0.00% 0.57%  1.0us( 244us)  815us(  23ms)(0.00%)     19026 99.4% 0.57%    0%    generic_delete_inode+0x260
 0.10% 0.04%   14us(  60ms)   21us(  47us)(0.00%)     45782  100% 0.04%    0%    generic_sync_sb_inodes+0x570
 0.04%  1.4%   16us(  15ms)  130us(5392us)(0.00%)     17176 98.6%  1.4%    0%    get_new_inode_fast+0x50
 0.04%  2.0%   14us(4938us) 4854us(  65ms)(0.00%)     17197 98.0%  2.0%    0%    iget_locked+0xd0
 0.04% 0.95%  3.2us(  60ms) 1963us(  60ms)(0.00%)     86325 99.1% 0.95%    0%    igrab+0x20
 0.10% 0.47%  3.7us(  54ms) 1202us(  50ms)(0.00%)    174179 99.5% 0.47%    0%    iput+0xb0
 0.03%  1.7%   27us(  18ms) 4304us(  54ms)(0.00%)      7862 98.3%  1.7%    0%    new_inode+0x60
 0.00%    0%  0.9us(  24us)    0us                      204  100%    0%    0%    sync_inodes_sb+0x130
 0.00% 0.11%   12us( 388us)  251us( 251us)(0.00%)       909 99.9% 0.11%    0%    writeback_inodes+0x30

 0.57%  1.1%   96us(  70ms) 3319us(  69ms)(0.00%)     37995 98.9%  1.1%    0%  kernel_flag
 0.00% 10.0%  0.2us( 0.5us)  256us( 256us)(0.00%)        10 90.0% 10.0%    0%    __break_lease+0x80
 0.00%    0%  5.0us( 5.6us)    0us                        2  100%    0%    0%    __posix_lock_file+0x90
 0.15%  1.4%  183us(  45ms) 3436us(  48ms)(0.00%)      5379 98.6%  1.4%    0%    chrdev_open+0x1c0
 0.00% 0.71%  2.6us( 361us) 1687us(  20ms)(0.00%)      3666 99.3% 0.71%    0%    de_put+0x50
 0.00%    0%  1.2us( 3.4us)    0us                        4  100%    0%    0%    disassociate_ctty+0x40
 0.00%    0%  0.4us(  12us)    0us                      119  100%    0%    0%    flock_lock_file+0x60
 0.00%    0%  0.2us( 5.2us)    0us                       66  100%    0%    0%    flock_lock_file+0x1f0
 0.00% 0.69%  0.8us( 154us)  163us( 749us)(0.00%)      2755 99.3% 0.69%    0%    linvfs_ioctl+0x150
 0.00%    0%  2.8us( 9.7us)    0us                       13  100%    0%    0%    locks_remove_flock+0x90
 0.00%    0%  0.5us( 3.9us)    0us                       17  100%    0%    0%    locks_remove_posix+0x180
 0.23% 0.57%  406us(  59ms) 4351us(  48ms)(0.00%)      3670 99.4% 0.57%    0%    proc_lookup+0x60
 0.00%    0%   62us(  78us)    0us                        2  100%    0%    0%    proc_pid_readlink+0x70
 0.00%    0%  104us( 160us)    0us                        4  100%    0%    0%    schedule+0xbb0
 0.00%    0%  0.5us( 7.8us)    0us                       20  100%    0%    0%    setfl+0x260
 0.00%    0%  3.8us( 3.8us)    0us                        1  100%    0%    0%    sock_ioctl+0x1b0
 0.08%  1.1%   30us(  61ms) 4825us(  69ms)(0.00%)     17646 98.9%  1.1%    0%    sys_ioctl+0xa0
 0.00%    0%   18us(  52us)    0us                        5  100%    0%    0%    tty_read+0x160
 0.10%  2.0%  139us(  70ms)  808us(  47ms)(0.00%)      4611 98.0%  2.0%    0%    tty_release+0x50
 0.00%    0%   36us(  66us)    0us                        5  100%    0%    0%    tty_write+0x3d0

 0.23%  1.2%   10us(  61ms) 1574us(  53ms)(0.00%)    145479 98.8%  1.2%    0%  mmlist_lock
 0.01% 0.97%  2.9us(  50ms) 3125us(  53ms)(0.00%)     31716 99.0% 0.97%    0%    copy_mm+0x290
 0.09%  1.3%   15us(  61ms) 1771us(  46ms)(0.00%)     38148 98.7%  1.3%    0%    exec_mmap+0x40
 0.00%    0%  0.1us( 0.1us)    0us                        2  100%    0%    0%    get_task_mm+0x60
 0.13%  1.3%   11us(  46ms)  985us(  46ms)(0.00%)     75613 98.7%  1.3%    0%    mmput+0x40

 0.01% 0.03%  2.1us(9155us)  8.8us(  16us)(0.00%)     23702  100% 0.03%    0%  pbd_delwrite_lock
 0.00%    0%   27us(9155us)    0us                      599  100%    0%    0%    pagebuf_daemon+0x1e0
 0.00% 0.04%  0.4us( 215us)  8.8us(  16us)(0.00%)     17078  100% 0.04%    0%    pagebuf_delwri_dequeue+0x30
 0.00%    0%  4.5us( 343us)    0us                     6025  100%    0%    0%    pagebuf_delwri_queue+0x30

 0.00% 0.08%  4.7us( 387us)   24us(  60us)(0.00%)      5084  100% 0.08%    0%  swaplock
 0.00% 0.08%  4.7us( 387us)   24us(  60us)(0.00%)      5084  100% 0.08%    0%    si_swapinfo+0x30

 0.03% 0.65%  3.3us(  42ms) 7855us(  60ms)(0.00%)     64429 99.4% 0.65%    0%  uidhash_lock
 0.00%    0%   12us(  12us)    0us                        1  100%    0%    0%    alloc_uid+0x40
 0.03% 0.65%  3.3us(  42ms) 7855us(  60ms)(0.00%)     64428 99.4% 0.65%    0%    free_uid+0x30

 0.01% 0.08%   16us(  48ms)   20ms(  44ms)(0.00%)      5261  100% 0.08%    0%  vfsmount_lock
 0.01% 0.08%   16us(  48ms)   20ms(  44ms)(0.00%)      5259  100% 0.08%    0%    lookup_mnt+0xb0
 0.00%    0%  3.0us( 5.7us)    0us                        2  100%    0%    0%    proc_check_root+0x150

 0.02% 0.20%  8.6us(  44ms) 2715us(  28ms)(0.00%)     13509 99.8% 0.20%    0%  vnumber_lock
 0.02% 0.20%  8.6us(  44ms) 2715us(  28ms)(0.00%)     13509 99.8% 0.20%    0%    vn_initialize+0xb0

  1.5% 0.70%  1.3us(  69ms) 1981us(  83ms)(0.03%)   7458470 99.3% 0.70%    0%  __d_lookup+0x1b0
 0.03% 0.00%  1.1us(3050us)  8.5us(  26us)(0.00%)    206771  100% 0.00%    0%  __mod_timer+0x3b0
 0.04% 54.4%   39us(7813us)   16ms(  77ms)(0.02%)      6534 45.6% 54.4%    0%  __rcu_process_callbacks+0x260
 0.22% 0.04%  2.0us(  59ms)  208us(  25ms)(0.00%)    704676  100% 0.04%    0%  _pagebuf_find+0xf0
 0.03% 0.00%  0.6us(  47ms)   16us(  32us)(0.00%)    318425  100% 0.00%    0%  anon_vma_link+0x40
 0.17% 0.03%  1.3us(2363us)   95us(  21ms)(0.00%)    831793  100% 0.03%    0%  anon_vma_unlink+0x40
 0.25% 0.08%   14us(4913us)   32us( 244us)(0.00%)    114653  100% 0.08%    0%  cache_alloc_refill+0xd0
 0.08% 0.11%   15us(2161us)   80us( 646us)(0.00%)     33793 99.9% 0.11%    0%  cache_flusharray+0x30
 0.00% 0.22%  0.8us( 349us)   29us( 161us)(0.00%)      9068 99.8% 0.22%    0%  cache_grow+0x200
 0.01% 0.22%  5.3us( 631us)   24us( 149us)(0.00%)      9068 99.8% 0.22%    0%  cache_grow+0x90
 0.07% 0.52%  1.2us(  61ms) 2402us(  63ms)(0.00%)    391800 99.5% 0.52%    0%  copy_mm+0x6b0
 0.08% 0.11%  2.3us(  54ms)  122us(  12ms)(0.00%)    228965 99.9% 0.11%    0%  deny_write_access+0x40
  2.9% 0.09%   13us(  81ms)  890us(  70ms)(0.00%)   1406292  100% 0.09%    0%  dnotify_parent+0x70
 0.02% 0.12%  4.9us(4694us)    0us                    28712 99.9%    0% 0.12%  double_lock_balance+0x20
 0.00% 89.5%  8.4us(  53us)   11us(  49us)(0.00%)        19 10.5% 89.5%    0%  double_lock_balance+0x90
 0.00% 38.2%  5.1us(  63us)   11us(  29us)(0.00%)        34 61.8% 38.2%    0%  double_lock_balance+0xb0
 0.02% 0.00%  3.6us(1802us)  7.5us( 7.5us)(0.00%)     29289  100% 0.00%    0%  double_rq_lock+0x40
 0.05% 0.13%  8.8us(2478us)   16us( 138us)(0.00%)     38442 99.9% 0.13%    0%  double_rq_lock+0x60
 0.05% 0.92%   33us(2491us)  181us(3490us)(0.00%)      9153 99.1% 0.92%    0%  double_rq_lock+0x90
 0.26% 0.01%  1.0us(  44ms)  251us(  33ms)(0.00%)   1661383  100% 0.01%    0%  dput+0x80
 0.02% 0.02%  4.7us(  39ms)  7.0us(  13us)(0.00%)     21307  100% 0.02%    0%  get_write_access+0x30
 0.00%  1.5%  0.1us(  17us)   29us(  58us)(0.00%)       407 98.5%  1.5%    0%  lock_sock+0x50
 0.01% 0.02%  0.9us( 559us)   31us(  74us)(0.00%)     61063  100% 0.02%    0%  migration_thread+0x110
 0.04% 0.01%  0.3us(2240us)  301us(  25ms)(0.00%)    781333  100% 0.01%    0%  pagebuf_rele+0x60
 31.2% 95.2%   71us(  10ms)   37ms( 146ms)(30.2%)   2828650  4.8% 95.2%    0%  rcu_check_quiescent_state+0xf0
 0.54% 0.37%  2.6us(  55ms) 1703us(  67ms)(0.00%)   1341785 99.6% 0.37%    0%  remove_vm_struct+0x60
 0.01% 0.51%   23us(  30ms)   58us( 144us)(0.00%)      1777 99.5% 0.51%    0%  rwsem_down_read_failed+0x60
 0.02% 0.33%  100us(  11ms) 5886us(  23ms)(0.00%)      1196 99.7% 0.33%    0%  rwsem_wake+0x30
  1.1% 0.43%  5.9us(6278us)   14us(1148us)(0.00%)   1205236 99.6% 0.43%    0%  schedule+0x280
 0.29% 0.68%   12us(  98ms)   77us(  15ms)(0.00%)    160866 99.3% 0.68%    0%  vma_adjust+0x140
  1.2% 0.26%  9.5us(  83ms) 2762us(  92ms)(0.00%)    796897 99.7% 0.26%    0%  vma_link+0x70
 0.00% 0.01%  0.4us(  38us)  7.8us( 7.8us)(0.00%)      9822  100% 0.01%    0%  xfs_alloc_clear_busy+0x50
 0.35% 0.05%  224us(  66ms)  250us( 474us)(0.00%)     10102  100% 0.05%    0%  xfs_iflush+0x2d0
 0.06% 0.01%   42us(1567us)  254us( 254us)(0.00%)      8622  100% 0.01%    0%  xfs_iget_core+0x3e0

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL NOWAIT SPIN  NAME

       0.08%                               745us(  68ms)(0.00%)   7514607  100% 0.08%  *TOTAL*

  271%  3.6%  90.5us     5   11ms(44766ms)  745us(  68ms)(0.00%)    166068 96.4%  3.6%  tasklist_lock
        2.3%                               558us(  57ms)(0.00%)     62393 97.7%  2.3%    do_sigaction+0x270
        4.6%                               820us(  68ms)(0.00%)     98360 95.4%  4.6%    do_wait+0x120
        2.4%                               138us(1072us)(0.00%)      4685 97.6%  2.4%    getrusage+0x40
          0%                                 0us                        1  100%    0%    kill_proc_info+0x40
          0%                                 0us                        3  100%    0%    proc_pid_lookup+0x80
        1.6%                               263us( 611us)(0.00%)       620 98.4%  1.6%    send_group_sig_info+0x30
          0%                                 0us                        6  100%    0%    session_of_pgrp+0x40

       0.00%                               9.0us(  11us)(0.00%)   6510587  100% 0.00%  find_get_page+0x40

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW)
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL NOWAIT SPIN(  WW )  NAME

       0.73%  0.0us(4934us) 6495us(  89ms)(0.02%)  193us(  17ms)   1053663 99.3% 0.35%(0.38%)  *TOTAL*
_________________________________________________________________________________________________________________________
Number of read locks found=1

--Boundary-00=_w0jJBqbJpj3EPCn--
