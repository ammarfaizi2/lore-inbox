Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269621AbUINSMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbUINSMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269660AbUINSJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:09:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16537 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269436AbUINRyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:54:47 -0400
Date: Tue, 14 Sep 2004 12:52:45 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, paulmck@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
Message-ID: <20040914175241.GI4178@sgi.com>
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com> <200408201324.32464.jbarnes@engr.sgi.com> <41265CCE.3070808@colorfullife.com> <20040910190153.GA32062@sgi.com> <4145E50E.2020300@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <4145E50E.2020300@colorfullife.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Manfred,

Lockstat output attached from 2.6.9-rc2 at 512p and 2.6.9-rc2 + your two
remaining RCU patches at 512p.  kernbench was run without any arguments.

The difference for RCU looks great.

Greg

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lockstat-2.6.9-rc2.txt"

___________________________________________________________________________________________
System: Linux ascender 2.6.9-rc2 #1 SMP Tue Sep 14 11:05:18 CDT 2004 ia64
Total counts

All (512) CPUs

Start time: Tue Sep 14 12:04:25 2004
End   time: Tue Sep 14 12:10:51 2004
Delta Time: 386.62 sec.
Hash table slots in use:      350.
Global read lock slots in use: 612.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

       0.57%  2.4us(  67ms)   41ms(  86ms)(26.7%) 227047021 99.4% 0.57% 0.00%  *TOTAL*

 0.00%    0%  0.3us( 134us)    0us                    46295  100%    0%    0%  [0xe00000b003726dd0]
 0.00%    0%  0.0us( 0.0us)    0us                        1  100%    0%    0%    xfs_log_move_tail+0x310
 0.00%    0%  0.9us(  16us)    0us                       90  100%    0%    0%    xfs_log_need_covered+0x100
 0.00%    0%  0.1us(  11us)    0us                     4988  100%    0%    0%    xfs_log_notify+0x40
 0.00%    0%  4.8us(  38us)    0us                      238  100%    0%    0%    xlog_state_do_callback+0x40
 0.00%    0%  0.0us( 0.1us)    0us                      238  100%    0%    0%    xlog_state_do_callback+0x210
 0.00%    0%  4.2us( 134us)    0us                      238  100%    0%    0%    xlog_state_do_callback+0x300
 0.00%    0%  0.2us( 5.8us)    0us                      239  100%    0%    0%    xlog_state_done_syncing+0x40
 0.00%    0%  0.5us(  43us)    0us                    10111  100%    0%    0%    xlog_state_get_iclog_space+0x30
 0.00%    0%  0.2us( 6.7us)    0us                     4757  100%    0%    0%    xlog_state_put_ticket+0x20
 0.00%    0%  0.1us(  17us)    0us                    10212  100%    0%    0%    xlog_state_release_iclog+0x50
 0.00%    0%  2.6us(  37us)    0us                      148  100%    0%    0%    xlog_state_sync_all+0x30
 0.00%    0%  0.2us( 6.7us)    0us                       66  100%    0%    0%    xlog_state_sync_all+0x440
 0.00%    0%  4.6us(  16us)    0us                       46  100%    0%    0%    xlog_state_sync+0x40
 0.00%    0%  0.9us( 7.0us)    0us                       35  100%    0%    0%    xlog_state_sync+0x3f0
 0.00%    0%  0.4us( 7.2us)    0us                       21  100%    0%    0%    xlog_state_want_sync+0x20
 0.00%    0%  0.5us(  18us)    0us                     4757  100%    0%    0%    xlog_ticket_get+0x50
 0.00%    0%  0.1us(  34us)    0us                     9974  100%    0%    0%    xlog_write+0x5f0
 0.00%    0%  0.8us( 6.8us)    0us                       21  100%    0%    0%    xlog_write+0x6c0
 0.00%    0%  0.4us(  15us)    0us                      115  100%    0%    0%    xlog_write+0x800

 0.00%    0%  0.2us(  64us)    0us                    43424  100%    0%    0%  [0xe00000b003726e70]
 0.00%    0%  0.1us(  16us)    0us                    14949  100%    0%    0%    xfs_log_move_tail+0x70
 0.00%    0%  0.0us( 8.0us)    0us                    10212  100%    0%    0%    xlog_assign_tail_lsn+0x50
 0.00%    0%  1.0us(  64us)    0us                     4757  100%    0%    0%    xlog_grant_log_space+0x40
 0.00%    0%  0.2us(  19us)    0us                     6588  100%    0%    0%    xlog_grant_push_ail+0x50
 0.00%    0%  0.1us( 7.9us)    0us                     1831  100%    0%    0%    xlog_regrant_reserve_log_space+0x50
 0.00%    0%  3.7us(  16us)    0us                       92  100%    0%    0%    xlog_regrant_write_log_space+0x90
 0.00%    0%  0.1us( 6.5us)    0us                      238  100%    0%    0%    xlog_state_do_callback+0x1c0
 0.00%    0%  0.3us(  17us)    0us                     4757  100%    0%    0%    xlog_ungrant_log_space+0x50

    0%    0%                   0us                        1  100%    0%    0%  [0xe000023003875d80]
    0%    0%                   0us                        1  100%    0%    0%    credit_entropy_store+0x40

    0%    0%                   0us                     8849  100%    0%    0%  [0xe00005b00387a080]
    0%    0%                   0us                     8849  100%    0%    0%    sn_dma_flush+0x1e0

    0%    0%                   0us                     8849  100%    0%    0%  [0xe00006307b8f2018]
    0%    0%                   0us                     8849  100%    0%    0%    scsi_put_command+0xe0

 0.04% 0.28%  3.5us(  90us)   16us(  91us)(0.00%)     44253 99.7% 0.28%    0%  [0xe00006307b8f2040]
 0.04% 0.16%   17us(  90us)   19us(  50us)(0.00%)      8857 99.8% 0.16%    0%    qla1280_intr_handler+0x30
 0.00% 0.31%  0.3us(  30us)  4.6us(  15us)(0.00%)      8849 99.7% 0.31%    0%    scsi_device_unbusy+0x50
    0% 0.29%                 9.3us(  85us)(0.00%)      8849 99.7% 0.29%    0%    scsi_dispatch_cmd+0x340
    0% 0.44%                  21us(  91us)(0.00%)      8849 99.6% 0.44%    0%    scsi_request_fn+0x2d0
    0% 0.20%                  31us(  87us)(0.00%)      8849 99.8% 0.20%    0%    scsi_run_queue+0xa0

 0.00% 0.10%  0.1us(  67us)   10us(  44us)(0.00%)     40574 99.9% 0.10%    0%  [0xe00008b003eb7024]
 0.00%    0%  0.2us( 7.3us)    0us                      442  100%    0%    0%    xfs_buf_iodone+0x30
 0.00%    0%  0.2us( 4.2us)    0us                       47  100%    0%    0%    xfs_buf_item_unpin+0x160
 0.00%    0%  0.1us( 2.6us)    0us                      138  100%    0%    0%    xfs_efi_item_unpin+0x30
 0.00%    0%  0.2us(  12us)    0us                      138  100%    0%    0%    xfs_efi_release+0x30
 0.00%    0%  0.1us( 4.6us)    0us                     3901  100%    0%    0%    xfs_iflush_done+0xc0
 0.00% 0.97%  0.2us(  30us)   10us(  44us)(0.00%)      3903 99.0% 0.97%    0%    xfs_iflush_int+0x430
 0.00% 0.01%  0.1us(  67us)  2.4us( 2.9us)(0.00%)     19342  100% 0.01%    0%    xfs_trans_chunk_committed+0x210
 0.00%    0%   32us(  32us)    0us                        1  100%    0%    0%    xfs_trans_push_ail+0x40
 0.00%    0%  0.5us(  21us)    0us                     2450  100%    0%    0%    xfs_trans_push_ail+0x2c0
 0.00% 0.01%  0.1us(  16us)   24us(  24us)(0.00%)     10212  100% 0.01%    0%    xfs_trans_tail_ail+0x20

 0.00%    0%  0.3us(  55us)    0us                    13977  100%    0%    0%  [0xe00008b003eb7110]
 0.00%    0%  0.3us(  55us)    0us                    10099  100%    0%    0%    xfs_mod_incore_sb+0x20
 0.00%    0%  0.1us(  23us)    0us                     3878  100%    0%    0%    xfs_mod_incore_sb_batch+0x30

 0.01% 0.38%  0.3us( 474us)   14us( 246us)(0.00%)    139387 99.6% 0.38%    0%  [0xe00009b003cbf034]
    0% 0.24%                  13us(  79us)(0.00%)      8212 99.8% 0.24%    0%    __cfq_get_queue+0x1f0
    0% 0.66%                  18us( 203us)(0.00%)     19020 99.3% 0.66%    0%    __make_request+0x150
 0.00% 0.45%  0.0us(  36us)   11us(  50us)(0.00%)      8849 99.5% 0.45%    0%    blk_run_queue+0x40
    0% 0.33%                  10us(  75us)(0.00%)     17061 99.7% 0.33%    0%    cfq_get_queue+0x50
 0.01% 0.32%  2.6us( 474us)   18us( 187us)(0.00%)     17382 99.7% 0.32%    0%    generic_unplug_device+0x40
    0% 0.27%                 7.6us(  91us)(0.00%)     17061 99.7% 0.27%    0%    get_request+0x80
    0% 0.33%                 7.2us(  31us)(0.00%)      8212 99.7% 0.33%    0%    get_request+0x4d0
    0% 0.18%                  28us( 216us)(0.00%)      8849 99.8% 0.18%    0%    scsi_device_unbusy+0xb0
    0% 0.18%                  25us( 120us)(0.00%)      8849 99.8% 0.18%    0%    scsi_end_request+0x160
 0.00%  1.2%  0.1us(  48us)   12us( 246us)(0.00%)      8849 98.8%  1.2%    0%    scsi_request_fn+0x520
    0% 0.15%                 6.5us(  17us)(0.00%)     17043 99.8% 0.15%    0%    scsi_request_fn+0x5b0

 0.00%    0%  0.0us( 0.3us)    0us                    17698  100%    0%    0%  [0xe00009b003cbf038]
    0%    0%                   0us                     8849  100%    0%    0%    scsi_get_command+0x110
 0.00%    0%  0.1us( 0.3us)    0us                     8849  100%    0%    0%    scsi_put_command+0x70

 0.00%    0%  0.1us( 2.5us)    0us                       78  100%    0%    0%  [0xe0001330032bb504]
 0.00%    0%  0.1us( 2.5us)    0us                       78  100%    0%    0%    do_select+0x60

    0%    0%                   0us                       96  100%    0%    0%  [0xe00039b003d50380]
    0%    0%                   0us                       65  100%    0%    0%    qla2x00_intr_handler+0x70
    0%    0%                   0us                       31  100%    0%    0%    qla2x00_mailbox_command+0xe0

    0%    0%                   0us                       67  100%    0%    0%  [0xe00039b003d52480]
    0%    0%                   0us                       65  100%    0%    0%    qla2x00_next+0x80
    0%    0%                   0us                        1  100%    0%    0%    qla2x00_restart_queues+0x120
    0%    0%                   0us                        1  100%    0%    0%    qla2x00_restart_queues+0x390

    0%    0%                   0us                       93  100%    0%    0%  [0xe00039b003d54478]
    0%    0%                   0us                       31  100%    0%    0%    qla2x00_intr_handler+0x4e0
    0%    0%                   0us                       31  100%    0%    0%    qla2x00_mailbox_command+0x9c0
    0%    0%                   0us                       31  100%    0%    0%    qla2x00_mailbox_command+0xba0

 0.00%    0%  0.3us( 3.0us)    0us                       14  100%    0%    0%  [0xe0004a3079d2d930]
 0.00%    0%  0.3us( 3.0us)    0us                       14  100%    0%    0%    unmap_mapping_range+0xc0

    0%    0%                   0us                        4  100%    0%    0%  [0xe0004db003d47e18]
    0%    0%                   0us                        2  100%    0%    0%    __down_interruptible+0xc0
    0%    0%                   0us                        2  100%    0%    0%    __down_interruptible+0x240

 0.00%    0%   27us( 369us)    0us                       16  100%    0%    0%  [0xe000603003bd634c]
 0.00%    0%  0.3us( 1.5us)    0us                        8  100%    0%    0%    rwsem_down_read_failed+0x60
 0.00%    0%   53us( 369us)    0us                        8  100%    0%    0%    rwsem_wake+0x30

 0.00%    0%  251us( 251us)    0us                        1  100%    0%    0%  [0xe00071b07882b6e8]
 0.00%    0%  251us( 251us)    0us                        1  100%    0%    0%    unmap_vmas+0x540

    0%    0%                   0us                        3  100%    0%    0%  batch_lock
    0%    0%                   0us                        3  100%    0%    0%    batch_entropy_store+0x80

 0.01% 0.32%   10us(  85us)   63us( 169us)(0.00%)      3152 99.7% 0.32%    0%  bdev_lock
 0.01% 0.32%   10us(  85us)   63us( 169us)(0.00%)      3152 99.7% 0.32%    0%    nr_blockdev_pages+0x20

 0.03% 0.01%  4.9us(  64ms)   94us(  94us)(0.00%)     19863  100% 0.01%    0%  cdev_lock
 0.03% 0.01%  4.9us(  64ms)   94us(  94us)(0.00%)     19863  100% 0.01%    0%    chrdev_open+0x40

 0.01%    0%   47us( 582us)    0us                      512  100%    0%    0%  cpe_history_lock.4
 0.01%    0%   47us( 582us)    0us                      512  100%    0%    0%    ia64_mca_cpe_int_handler+0xa0

 0.10% 0.04%  0.2us(  29ms)  6.0us(  68us)(0.00%)   2646492  100% 0.04%    0%  dcache_lock
 0.00% 0.02%  0.6us(  40us)  3.7us( 5.6us)(0.00%)      9152  100% 0.02%    0%    d_alloc+0x260
 0.00%    0%  0.4us( 8.5us)    0us                     1184  100%    0%    0%    d_delete+0x40
 0.00% 0.04%  0.1us(  26us)  1.5us( 2.3us)(0.00%)     10353  100% 0.04%    0%    d_instantiate+0x50
 0.00%    0%  5.2us(  49us)    0us                       97  100%    0%    0%    d_move+0x60
 0.01% 0.07%   20us(  23ms)   12us(  12us)(0.00%)      1341  100% 0.07%    0%    d_path+0x110
 0.00% 0.04%  0.8us(3300us)  1.2us( 2.3us)(0.00%)      9151  100% 0.04%    0%    d_rehash+0xc0
 0.00%    0%  0.7us( 3.6us)    0us                        6  100%    0%    0%    d_splice_alias+0xc0
 0.09% 0.04%  0.1us(  29ms)  6.1us(  68us)(0.00%)   2564665  100% 0.04%    0%    dput+0x50
 0.00%    0%  0.1us(  25us)    0us                    24437  100%    0%    0%    link_path_walk+0x1000
 0.00%    0%  0.1us( 9.5us)    0us                    18468  100%    0%    0%    link_path_walk+0x1ed0
 0.00%    0%  1.5us(  19us)    0us                      149  100%    0%    0%    proc_pid_unhash+0x50
 0.00%    0%  1.7us(  20us)    0us                      298  100%    0%    0%    prune_dcache+0x50
 0.00%    0%  0.0us( 0.1us)    0us                      149  100%    0%    0%    prune_dcache+0x380
 0.00%    0%  0.5us( 8.9us)    0us                      447  100%    0%    0%    select_parent+0x30
 0.01%    0%  3.1us(  78us)    0us                     6595  100%    0%    0%    sys_getcwd+0x210

 0.02% 0.05%  0.1us(  39us)  9.6us(  40us)(0.00%)    516030  100% 0.05%    0%  files_lock
 0.00% 0.07%  0.1us(  31us)  8.2us( 9.9us)(0.00%)      2812  100% 0.07%    0%    check_tty_count+0x20
 0.01% 0.06%  0.1us(  28us)  9.9us(  40us)(0.00%)    255906  100% 0.06%    0%    file_kill+0x70
 0.01% 0.05%  0.2us(  39us)  9.3us(  32us)(0.00%)    257312  100% 0.05%    0%    file_move+0x40

    0%    0%                   0us                      252  100%    0%    0%  filp_count_lock
    0%    0%                   0us                      189  100%    0%    0%    filp_ctor+0x70
    0%    0%                   0us                       63  100%    0%    0%    filp_dtor+0x40

    0% 0.01%                 5.8us( 9.8us)(0.00%)     91110  100% 0.01%    0%  ia64_ctx
    0% 0.02%                 5.0us( 7.1us)(0.00%)     29917  100% 0.02%    0%    exec_mmap+0x4f0
    0% 0.00%                 9.8us( 9.8us)(0.00%)     20988  100% 0.00%    0%    schedule+0xde0
    0%    0%                   0us                    40205  100%    0%    0%    smp_flush_tlb_mm+0x310

    0%    0%                   0us                      512  100%    0%    0%  ia64_state_log+0x60
    0%    0%                   0us                      512  100%    0%    0%    ia64_log_get+0x80

 0.00%    0%  0.6us( 1.4us)    0us                        3  100%    0%    0%  inet_peer_unused_lock
 0.00%    0%  0.6us( 1.4us)    0us                        3  100%    0%    0%    cleanup_once+0x60

 0.10% 0.09%  1.2us( 173us)   36us( 514us)(0.00%)    314539  100% 0.09%    0%  inode_lock
 0.00% 0.06%  0.4us(  44us)   19us(  92us)(0.00%)     47856  100% 0.06%    0%    __mark_inode_dirty+0xf0
 0.02% 0.22%  1.2us( 132us)   55us( 514us)(0.00%)     74226 99.8% 0.22%    0%    __sync_single_inode+0x100
 0.00%    0%   12us(  12us)    0us                        1  100%    0%    0%    __wait_on_freeing_inode+0x170
 0.00%    0%  0.1us( 8.9us)    0us                     4761  100%    0%    0%    generic_delete_inode+0x1f0
 0.00% 0.07%  1.1us(  24us)  6.1us( 7.3us)(0.00%)      4597  100% 0.07%    0%    get_new_inode_fast+0x50
 0.00% 0.15%  1.6us(  40us)   31us(  68us)(0.00%)      4597 99.8% 0.15%    0%    iget_locked+0xb0
 0.00% 0.03%  0.1us(  21us)  7.3us( 9.8us)(0.00%)      6259  100% 0.03%    0%    igrab+0x20
 0.01% 0.04%  0.3us(  72us)  8.7us(  30us)(0.00%)     91317  100% 0.04%    0%    iput+0xa0
 0.00% 0.15%  0.4us(  20us)  9.2us(  20us)(0.00%)      4710 99.9% 0.15%    0%    new_inode+0x70
 0.00%  1.2%  0.7us(  99us)  5.5us(  12us)(0.00%)       810 98.8%  1.2%    0%    sync_inodes_sb+0x140
 0.06% 0.04%  3.0us( 173us)  5.3us(  26us)(0.00%)     74701  100% 0.04%    0%    sync_sb_inodes+0x630
 0.00% 0.14%  3.0us( 107us)  0.4us( 0.4us)(0.00%)       704 99.9% 0.14%    0%    writeback_inodes+0x20

 0.09% 0.03%  9.0us(1040us)  163us( 631us)(0.00%)     37441  100% 0.03%    0%  kernel_flag
 0.02% 0.03%  4.5us( 415us)  226us( 631us)(0.00%)     19863  100% 0.03%    0%    chrdev_open+0x1e0
 0.00% 0.06%  0.3us(  20us)   61us(  85us)(0.00%)      3279  100% 0.06%    0%    de_put+0x50
 0.00%    0%  0.1us( 0.1us)    0us                      696  100%    0%    0%    linvfs_ioctl+0x140
 0.04% 0.03%   48us(1040us)   40us(  40us)(0.00%)      3429  100% 0.03%    0%    proc_lookup+0x60
 0.00%    0%   37us(  37us)    0us                        1  100%    0%    0%    schedule+0xc20
 0.00%    0%  3.8us( 224us)    0us                     2121  100%    0%    0%    sys_ioctl+0xa0
 0.01%    0%  3.5us( 139us)    0us                     6592  100%    0%    0%    sys_sysctl+0xd0
 0.01% 0.28%   26us( 266us)  150us( 290us)(0.00%)      1406 99.7% 0.28%    0%    tty_release+0x50
 0.00%    0%  257us( 706us)    0us                       54  100%    0%    0%    tty_write+0x440

    0%    0%                   0us                        7  100%    0%    0%  logbuf_lock
    0%    0%                   0us                        5  100%    0%    0%    release_console_sem+0x50
    0%    0%                   0us                        2  100%    0%    0%    vprintk+0x60

 0.01% 0.15%  0.4us(7663us)   10us(  31us)(0.00%)    110845 99.9% 0.15%    0%  mmlist_lock
 0.00% 0.04%  0.1us(  15us)  5.0us(  14us)(0.00%)     20988  100% 0.04%    0%    copy_mm+0x2a0
 0.01% 0.05%  0.8us(  24us)   15us(  29us)(0.00%)     29917  100% 0.05%    0%    exec_mmap+0x40
 0.01% 0.24%  0.3us(7663us)   10us(  31us)(0.00%)     59940 99.8% 0.24%    0%    mmput+0x30

    0%    0%                   0us                     1051  100%    0%    0%  page_uptodate_lock.1
    0%    0%                   0us                     1051  100%    0%    0%    end_buffer_async_write+0xc0

 0.00% 0.01%  0.3us(  75us)  0.8us( 0.8us)(0.00%)      9500  100% 0.01%    0%  pbd_delwrite_lock
 0.00%    0%  7.0us(  75us)    0us                      383  100%    0%    0%    pagebuf_daemon+0x200
 0.00% 0.01%  0.1us(  12us)  0.8us( 0.8us)(0.00%)      8618  100% 0.01%    0%    pagebuf_delwri_dequeue+0x30
 0.00%    0%  0.3us(  19us)    0us                      499  100%    0%    0%    pagebuf_delwri_queue+0x30

    0%    0%                   0us                      276  100%    0%    0%  pdflush_lock
    0%    0%                   0us                       92  100%    0%    0%    __pdflush+0x220
    0%    0%                   0us                       92  100%    0%    0%    __pdflush+0x320
    0%    0%                   0us                       92  100%    0%    0%    pdflush_operation+0x60

 26.8% 89.9%   73us(  13ms)   41ms(  86ms)(26.7%)   1418535 10.1% 89.9%    0%  rcu_state
 0.01% 16.5%   17us(1146us) 9116us(  66ms)(0.00%)      2790 83.5% 16.5%    0%    __rcu_process_callbacks+0x260
 26.8% 90.1%   73us(  13ms)   41ms(  86ms)(26.7%)   1415745  9.9% 90.1%    0%    rcu_check_quiescent_state+0xf0

 0.00%    0%  0.9us( 6.9us)    0us                       54  100%    0%    0%  redirect_lock
 0.00%    0%  0.9us( 6.9us)    0us                       54  100%    0%    0%    redirected_tty_write+0x30

 0.00%    0%  3.9us(  46us)    0us                       97  100%    0%    0%  rename_lock+0x4
 0.00%    0%  3.9us(  46us)    0us                       97  100%    0%    0%    d_move+0x80

    0%  3.8%                  78us( 259us)(0.00%)       629 96.2%  3.8%    0%  sal_console_port+0x40
    0%    0%                   0us                        2  100%    0%    0%    sn_sal_console_write+0x380
    0%  7.9%                  78us( 259us)(0.00%)       303 92.1%  7.9%    0%    sn_sal_interrupt+0x200
    0%    0%                   0us                      108  100%    0%    0%    uart_put_char+0xa0
    0%    0%                   0us                      162  100%    0%    0%    uart_start+0x50
    0%    0%                   0us                       54  100%    0%    0%    uart_write+0x400

 0.00%    0%  0.9us( 154us)    0us                     3471  100%    0%    0%  sb_lock
 0.00%    0%  0.6us(  51us)    0us                      855  100%    0%    0%    get_super_to_sync+0x30
 0.00%    0%  2.0us( 6.7us)    0us                       15  100%    0%    0%    get_super_to_sync+0x30
 0.00%    0%  0.1us(  16us)    0us                      903  100%    0%    0%    put_super+0x20
 0.00%    0%  6.6us(  92us)    0us                       45  100%    0%    0%    set_sb_syncing+0x20
 0.00%    0%  1.7us(  10us)    0us                       30  100%    0%    0%    sync_filesystems+0x70
 0.00%    0%  1.6us(  46us)    0us                       60  100%    0%    0%    sync_filesystems+0x170
 0.00%    0%  2.5us(  12us)    0us                      155  100%    0%    0%    sync_supers+0x30
 0.00%    0%  0.7us(  36us)    0us                      704  100%    0%    0%    writeback_inodes+0x40
 0.00%    0%  1.5us( 154us)    0us                      704  100%    0%    0%    writeback_inodes+0x210

 0.00%    0%  0.4us(  18us)    0us                     3152  100%    0%    0%  swaplock
 0.00%    0%  0.4us(  18us)    0us                     3152  100%    0%    0%    si_swapinfo+0x20

 0.00%    0%  0.1us(  22us)    0us                    30023  100%    0%    0%  uidhash_lock
 0.00%    0%  0.1us(  22us)    0us                    30023  100%    0%    0%    free_uid+0x30

 0.00% 0.04%  3.1us(  41us)   11us(  13us)(0.00%)      4593  100% 0.04%    0%  vfsmount_lock
 0.00%    0%  0.1us(  13us)    0us                     1192  100%    0%    0%    __d_path+0x2b0
 0.00% 0.06%  4.2us(  41us)   11us(  13us)(0.00%)      3401  100% 0.06%    0%    lookup_mnt+0x80

 0.00%    0%  0.5us( 9.6us)    0us                     1318  100%    0%    0%  vnumber_lock
 0.00%    0%  0.5us( 9.6us)    0us                     1318  100%    0%    0%    vn_initialize+0xd0

 0.69%    0%  6.7us(1939us)    0us                   395897  100%    0%    0%  xtime_lock+0x4
 0.69%    0%  6.7us(1939us)    0us                   395897  100%    0%    0%    timer_interrupt+0x330

 0.07% 0.01%  0.2us(  55ms)  8.0us( 273us)(0.00%)   1705215  100% 0.01%    0%  __d_lookup+0x190
    0% 14.2%                  14us(  33us)(0.00%)       353 85.8% 14.2%    0%  __down+0x200
    0%  3.0%                 4.1us( 8.4us)(0.00%)       460 97.0%  3.0%    0%  __down+0xc0
    0% 0.94%                  16us(  98us)(0.00%)     12398 99.1% 0.94%    0%  __down_trylock+0x40
 0.00%    0%  0.3us(  18us)    0us                    30023  100%    0%    0%  __exit_signal+0x80
 0.00%    0%  0.1us(  23us)    0us                   115382  100%    0%    0%  __mod_timer+0x120
    0%    0%                   0us                   115382  100%    0%    0%  __mod_timer+0xa0
    0% 0.07%                 2.6us(  53us)(0.00%)   1174525  100% 0.07%    0%  __page_cache_release+0x70
    0% 0.05%                  21us(  21us)(0.00%)      1968  100% 0.05%    0%  __pagevec_lru_add+0xe0
    0% 0.09%                 8.9us(  66us)(0.00%)    195389  100% 0.09%    0%  __pagevec_lru_add_active+0xe0
 0.01%    0%  0.1us(  21us)    0us                   203620  100%    0%    0%  __pmd_alloc+0x60
    0%    0%                   0us                    97005  100%    0%    0%  __queue_work+0x30
    0%    0%                   0us                     2050  100%    0%    0%  __set_page_dirty_nobuffers+0xd0
    0% 0.02%                 5.9us(  13us)(0.00%)    228098  100% 0.02%    0%  __wake_up+0x30
    0% 0.00%                 6.5us( 6.5us)(0.00%)     30105  100% 0.00%    0%  __wake_up_sync+0x50
 0.01%    0%  0.9us(  54us)    0us                    49332  100%    0%    0%  _pagebuf_find+0xd0
    0%    0%                   0us                    25797  100%    0%    0%  activate_page+0x70
    0%    0%                   0us                       11  100%    0%    0%  add_entropy_words+0xc0
    0%    0%                   0us                     2284  100%    0%    0%  add_to_page_cache+0x80
    0% 0.00%                 3.3us( 3.6us)(0.00%)    146682  100% 0.00%    0%  add_wait_queue+0x50
    0%    0%                   0us                       46  100%    0%    0%  add_wait_queue_exclusive+0x50
 0.00%    0%  0.1us(  23us)    0us                   264078  100%    0%    0%  anon_vma_link+0x30
 0.05%    0%  0.6us(  58ms)    0us                   281091  100%    0%    0%  anon_vma_prepare+0xc0
 0.01% 0.09%  0.1us(  34us)   14us(  48us)(0.00%)    562320  100% 0.09%    0%  anon_vma_unlink+0x30
    0% 0.02%                  10us(  27us)(0.00%)     30023  100% 0.02%    0%  buffered_rmqueue+0x3f0
 0.02% 0.03%  6.8us( 195us)   15us(  31us)(0.00%)     10608  100% 0.03%    0%  cache_alloc_refill+0xb0
 0.00% 0.04%  6.5us(  48us)  9.9us( 9.9us)(0.00%)      2544  100% 0.04%    0%  cache_flusharray+0x30
 0.00%    0%  0.1us(  10us)    0us                      646  100%    0%    0%  cache_grow+0x260
 0.00%    0%  0.9us(  12us)    0us                      646  100%    0%    0%  cache_grow+0xf0
    0% 0.00%                  12us(  67us)(0.00%)   9825514  100% 0.00%    0%  cache_reap+0x230
    0%    0%                   0us                      572  100%    0%    0%  cache_reap+0x430
 0.01%    0%  1.0us(  39us)    0us                    42316  100%    0%    0%  change_protection+0x90
    0%    0%                   0us                    29157  100%    0%    0%  complete+0x40
 0.00%    0%  0.4us(  49us)    0us                    29917  100%    0%    0%  compute_creds+0x20
 0.02%    0%  2.8us(8472us)    0us                    30023  100%    0%    0%  copy_files+0x1c0
 0.00%    0%  0.1us(  16us)    0us                    17408  100%    0%    0%  copy_files+0x200
 0.05%    0%   10us(  61ms)    0us                    17408  100%    0%    0%  copy_files+0x2c0
 0.01% 0.01%  0.1us(  30us) 1696us(  29ms)(0.00%)    362934  100% 0.01%    0%  copy_mm+0x5a0
 0.77%    0%  5.9us(  67ms)    0us                   506486  100%    0%    0%  copy_mm+0x5e0
  1.1%    0%  9.1us(  67ms)    0us                   485498  100%    0%    0%  copy_page_range+0x2a0
 0.00%    0%  0.5us(  23us)    0us                     2050  100%    0%    0%  create_empty_buffers+0xa0
 0.00%    0%  0.1us( 3.1us)    0us                     1184  100%    0%    0%  d_delete+0x50
 0.00%    0%  2.5us(  19us)    0us                       97  100%    0%    0%  d_move+0x100
 0.00%    0%  3.0us(  19us)    0us                       44  100%    0%    0%  d_move+0x560
 0.00%    0%  2.7us(  17us)    0us                       53  100%    0%    0%  d_move+0xe0
 0.00%    0%  0.1us( 4.7us)    0us                     9151  100%    0%    0%  d_rehash+0xd0
    0% 0.00%                 2.0us( 2.0us)(0.00%)     25856  100% 0.00%    0%  del_timer+0x80
 0.02% 0.02%  0.5us(  46ms)  6.0us(  20us)(0.00%)    179791  100% 0.02%    0%  deny_write_access+0x40
 0.00%    0%  0.1us(  20us)    0us                    46631  100%    0%    0%  dnotify_flush+0xa0
 0.02% 0.02%  0.3us(  92us)  7.8us(  43us)(0.00%)    330662  100% 0.02%    0%  dnotify_parent+0x60
 0.00%    0%  0.6us(  23us)    0us                     9194  100%    0%    0%  do_IRQ+0x1d0
 0.00%    0%  0.4us(  23us)    0us                     9194  100%    0%    0%  do_IRQ+0x2b0
 0.03%    0%  0.3us( 105us)    0us                   384053  100%    0%    0%  do_anonymous_page+0x270
 0.00%    0%  0.1us(  16us)    0us                    30023  100%    0%    0%  do_exit+0x3d0
 0.00%    0%  0.0us( 9.4us)    0us                    30023  100%    0%    0%  do_exit+0x460
 0.00%    0%  0.1us(  21us)    0us                    30023  100%    0%    0%  do_exit+0x4b0
 0.00%    0%  0.0us( 2.5us)    0us                    30023  100%    0%    0%  do_exit+0x6d0
 0.00%    0%  0.1us( 8.6us)    0us                      933  100%    0%    0%  do_fcntl+0xb0
 0.12%    0%  3.0us(  50ms)    0us                   153060  100%    0%    0%  do_munmap+0x220
 0.17%    0%  0.3us(  31ms)    0us                  2399811  100%    0%    0%  do_no_page+0x220
    0% 0.02%                  22us(  52us)(0.00%)     30023  100% 0.02%    0%  do_notify_parent+0x2e0
    0% 0.05%                 8.1us( 156us)(0.00%)    158742  100% 0.05%    0%  do_page_cache_readahead+0x140
    0%    0%                   0us                      296  100%    0%    0%  do_page_cache_readahead+0x270
    0% 0.00%                 3.7us( 4.6us)(0.00%)    283293  100% 0.00%    0%  do_sigaction+0x110
    0%    0%                   0us                    36528  100%    0%    0%  do_sigaction+0x2a0
 0.11%    0%  0.8us(  65ms)    0us                   497135  100%    0%    0%  do_wp_page+0x2d0
 0.01%  2.3%  1.3us( 242us)    0us                    26957 97.7%    0%  2.3%  double_lock_balance+0x20
 0.00% 85.4%   26us( 188us)  445us(6065us)(0.00%)       321 14.6% 85.4%    0%  double_lock_balance+0x80
 0.00% 43.9%   10us( 534us)  144us(3411us)(0.00%)       626 56.1% 43.9%    0%  double_lock_balance+0xa0
 0.00%    0%  1.0us( 575us)    0us                    12101  100%    0%    0%  double_rq_lock+0x40
 0.00% 0.13%  0.1us( 4.4us)  270us( 574us)(0.00%)     20122 99.9% 0.13%    0%  double_rq_lock+0x60
 0.00% 0.25%  0.3us(  25us)  293us( 619us)(0.00%)      8021 99.8% 0.25%    0%  double_rq_lock+0x90
 0.02% 0.01%  0.2us(  29ms)   10us(  20us)(0.00%)    412261  100% 0.01%    0%  dput+0xb0
 0.00%    0%  0.8us(  34us)    0us                      373  100%    0%    0%  dupfd+0x30
 0.03%    0%  4.1us(  64ms)    0us                    29917  100%    0%    0%  exec_mmap+0x110
  6.7%    0%  512us(  64ms)    0us                    50905  100%    0%    0%  exit_mmap+0x50
 0.00%    0%  0.3us( 101us)    0us                    17660  100%    0%    0%  expand_fd_array+0x130
 0.00%    0%  0.1us( 4.4us)    0us                      252  100%    0%    0%  expand_fd_array+0x240
 0.00%    0%  1.9us(  23us)    0us                      925  100%    0%    0%  expand_stack+0x60
    0%    0%                   0us                        2  100%    0%    0%  extract_entropy+0xc0
 0.00%    0%  0.1us(  15us)    0us                   234897  100%    0%    0%  fd_install+0x30
 0.01%    0%  0.1us(  38us)    0us                   438553  100%    0%    0%  fget+0x30
    0% 0.11%                 7.7us( 347us)(0.00%)   2673613 99.9% 0.11%    0%  find_get_page+0x40
    0%    0%                   0us                     4235  100%    0%    0%  find_get_pages+0x40
    0% 0.00%                 4.7us( 4.7us)(0.00%)    128465  100% 0.00%    0%  find_get_pages_tag+0x40
    0% 0.00%                 1.3us( 1.3us)(0.00%)     47999  100% 0.00%    0%  find_lock_page+0x40
    0%    0%                   0us                      204  100%    0%    0%  find_trylock_page+0x40
    0% 0.05%                 6.9us(  15us)(0.00%)      8255  100% 0.05%    0%  finish_wait+0x90
 0.00%    0%  0.2us(  39us)    0us                    38641  100%    0%    0%  flush_old_exec+0x4f0
    0% 0.09%                 6.4us(  45us)(0.00%)     80146  100% 0.09%    0%  force_page_cache_readahead+0x170
    0% 0.09%                 8.7us(  54us)(0.00%)    245613  100% 0.09%    0%  free_pages_bulk+0x90
    0% 0.19%                  11us(  63us)(0.00%)     27877 99.8% 0.19%    0%  get_signal_to_deliver+0x60
 0.02%    0%  0.3us(  70us)    0us                   281834  100%    0%    0%  get_unused_fd+0x40
 0.00%    0%  0.1us( 2.8us)    0us                    21471  100%    0%    0%  get_write_access+0x30
 0.24%    0%  0.3us(  60ms)    0us                  3599784  100%    0%    0%  handle_mm_fault+0x160
    0%    0%                   0us                    27877  100%    0%    0%  handle_signal+0x100
    0%    0%                   0us                    27877  100%    0%    0%  ia64_rt_sigreturn+0x1b0
 0.00%    0%  0.2us(  22us)    0us                    29917  100%    0%    0%  install_arg_page+0xc0
    0%    0%                   0us                    30038  100%    0%    0%  k_getrusage+0x530
    0%    0%                   0us                      356  100%    0%    0%  k_getrusage+0xd0
 0.00%    0%  0.1us( 0.5us)    0us                      696  100%    0%    0%  linvfs_ioctl+0xe0
 0.00%  9.0%  3.6us(  73us)  314us(3478us)(0.00%)       659 91.0%  9.0%    0%  load_balance+0x170
  103% 0.00%  9.7us(4462us)   17us(  99us)(0.00%)  41140382  100% 0.00%    0%  load_balance+0x30
    0%    0%                   0us                    74225  100%    0%    0%  mapping_tagged+0x40
 0.00% 0.03%  0.3us(1546us)   89us( 310us)(0.00%)     40373  100% 0.03%    0%  migration_thread+0x130
 0.00%    0%  1.7us(  19us)    0us                      149  100%    0%    0%  mounts_open+0xa0
 0.00% 0.00%  0.1us(  30us)   25us(  25us)(0.00%)     61530  100% 0.00%    0%  pagebuf_rele+0x60
 0.00%    0%  0.1us( 0.9us)    0us                      149  100%    0%    0%  pid_base_iput+0x30
    0%    0%                   0us                     4650  100%    0%    0%  prepare_to_wait+0x60
    0% 0.01%                 3.8us( 3.8us)(0.00%)      8336  100% 0.01%    0%  prepare_to_wait_exclusive+0x60
 0.00%    0%  0.1us( 6.0us)    0us                      149  100%    0%    0%  proc_pid_lookup+0x1e0
 0.00%    0%  0.9us(  16us)    0us                      298  100%    0%    0%  prune_dcache+0x130
 0.45%    0%  6.8us(  62ms)    0us                   254542  100%    0%    0%  pte_alloc_map+0x140
 0.00%    0%  0.1us( 6.1us)    0us                    47310  100%    0%    0%  put_unused_fd+0x30
    0%    0%                   0us                     6546  100%    0%    0%  qla2x00_timer+0x2c0
    0% 0.22%                  13us(  21us)(0.00%)     17605 99.8% 0.22%    0%  release_pages+0x180
 0.17%    0%   22us(  66ms)    0us                    30023  100%    0%    0%  release_task+0x60
    0%    0%                   0us                     1992  100%    0%    0%  remove_from_page_cache+0x70
 0.05% 0.21%  0.3us(  60us)  9.7us(  84us)(0.00%)    748151 99.8% 0.21%    0%  remove_vm_struct+0x50
    0% 0.00%                  27us(  27us)(0.00%)    146728  100% 0.00%    0%  remove_wait_queue+0x30
    0% 0.09%                 6.9us(  41us)(0.00%)    221875  100% 0.09%    0%  rmqueue_bulk+0x40
 0.00%    0%  0.5us( 2.7us)    0us                        6  100%    0%    0%  rt_check_expire+0xe0
    0%    0%                   0us                    89527  100%    0%    0%  run_timer_softirq+0x2c0
    0% 0.00%                 6.7us(  16us)(0.00%) 145797886  100% 0.00%    0%  run_timer_softirq+0xb0
 0.11%  1.3%  1.1us(1286us)  2.4us( 251us)(0.00%)    369207 98.7%  1.3%    0%  schedule+0x260
    0%    0%                   0us                   363195  100%    0%    0%  schedule+0x680
 0.03% 0.03%  0.4us( 105us)   27us( 296us)(0.00%)    350681  100% 0.03%    0%  scheduler_tick+0x520
 0.00%    0%  0.1us( 6.8us)    0us                    40135  100%    0%    0%  set_close_on_exec+0x30
 0.00%    0%  0.2us(  20us)    0us                    29917  100%    0%    0%  set_task_comm+0x20
    0% 0.07%                  23us(  61us)(0.00%)     18710  100% 0.07%    0%  sigprocmask+0x50
 0.01%    0%  0.2us(  12ms)    0us                   286514  100%    0%    0%  sys_close+0x30
 0.00%    0%  0.2us(  48us)    0us                    23261  100%    0%    0%  sys_dup2+0x50
 0.00%    0%  0.2us(  19us)    0us                      149  100%    0%    0%  task_dumpable+0x20
    0% 0.52%                  24us( 846us)(0.00%)    290102 99.5% 0.52%    0%  task_rq_lock+0xa0
    0%    0%                   0us                     4285  100%    0%    0%  test_clear_page_dirty+0x90
    0%    0%                   0us                      301  100%    0%    0%  test_clear_page_writeback+0x90
    0%    0%                   0us                      301  100%    0%    0%  test_set_page_writeback+0x90
 0.00%    0%  7.6us(  12ms)    0us                     1992  100%    0%    0%  try_to_free_buffers+0x90
 0.04% 0.09%  1.1us(  82us)   11us(  79us)(0.00%)    129318  100% 0.09%    0%  vma_adjust+0x140
 0.00%    0%  0.3us(  47us)    0us                    67196  100%    0%    0%  vma_adjust+0x2d0
 0.10% 0.06%  1.5us(  57ms)   11us(  45us)(0.00%)    255899  100% 0.06%    0%  vma_link+0x60
 0.00%    0%  0.4us(  62us)    0us                     6259  100%    0%    0%  vn_hold+0x70
 0.00%    0%  0.5us(  19us)    0us                     1184  100%    0%    0%  vn_purge+0x30
 0.00%    0%  0.1us( 4.1us)    0us                     1184  100%    0%    0%  vn_reclaim+0x100
 0.00%    0%  0.1us( 6.1us)    0us                     1184  100%    0%    0%  vn_rele+0x130
 0.00%    0%  0.1us( 5.5us)    0us                     1184  100%    0%    0%  vn_rele+0x70
 0.00%    0%  0.0us( 1.1us)    0us                     5046  100%    0%    0%  vn_revalidate+0xf0
 0.00%    0%  0.1us( 0.1us)    0us                     1184  100%    0%    0%  vn_wakeup+0x20
    0%    0%                   0us                    29157  100%    0%    0%  wait_for_completion+0x1d0
    0%    0%                   0us                    29157  100%    0%    0%  wait_for_completion+0x50
    0%    0%                   0us                    30023  100%    0%    0%  wait_task_zombie+0x170
    0%    0%                   0us                    95968  100%    0%    0%  worker_thread+0x2a0
    0%    0%                   0us                    97005  100%    0%    0%  worker_thread+0x430
 0.00% 0.72%  1.0us(  12us)  2.7us( 2.7us)(0.00%)       138 99.3% 0.72%    0%  xfs_alloc_clear_busy+0x60
 0.00%    0%  1.4us(  17us)    0us                      139  100%    0%    0%  xfs_alloc_mark_busy+0x60
 0.00%    0%  0.3us( 5.1us)    0us                      145  100%    0%    0%  xfs_alloc_search_busy+0x60
 0.00%    0%  0.9us(  21us)    0us                      144  100%    0%    0%  xfs_iextract+0xf0
 0.16% 0.01%   73us(2302us)  432us( 432us)(0.00%)      8249  100% 0.01%    0%  xfs_iflush+0x3c0
 0.00%    0%  3.4us(  64us)    0us                      309  100%    0%    0%  xfs_iget_core+0x430
 0.00%    0%  0.2us( 3.4us)    0us                       97  100%    0%    0%  xfs_map_blocks+0xf0

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL NOWAIT SPIN  NAME

       0.06%                                39us(1223us)(0.00%)    904473  100% 0.06%  *TOTAL*

 0.00%    0%   0.3us     2  0.3us(  44us)    0us                    30495  100%    0%  binfmt_lock
          0%                                 0us                    30206  100%    0%    search_binary_handler+0x80
          0%                                 0us                      289  100%    0%    search_binary_handler+0x420

 0.00%    0%  19.4us     1   19us( 186us)    0us                       97  100%    0%  file_systems_lock
          0%                                 0us                       97  100%    0%    get_filesystem_list+0x30

 0.12% 0.47%   4.2us     2  4.2us(  71ms)   39us(1223us)(0.00%)    114236 99.5% 0.47%  tasklist_lock
       0.04%                               113us(1223us)(0.00%)     36528  100% 0.04%    do_sigaction+0x260
       0.67%                                37us( 165us)(0.00%)     77182 99.3% 0.67%    do_wait+0x160
          0%                                 0us                      371  100%    0%    getrusage+0x40
          0%                                 0us                      149  100%    0%    proc_pid_lookup+0x80
          0%                                 0us                        6  100%    0%    session_of_pgrp+0x20

 21.1%    0% 238.3us     3   26ms(40450ms)    0us                     3152  100%    0%  vmlist_lock
          0%                                 0us                     3152  100%    0%    get_vmalloc_info+0x40

          0%                                 0us                    30023  100%    0%  copy_process+0x17d0
          0%                                 0us                     1341  100%    0%  d_path+0x30
          0%                                 0us                    18468  100%    0%  link_path_walk+0x1e50
          0%                                 0us                    24437  100%    0%  link_path_walk+0xf80
          0%                                 0us                   673103  100%    0%  path_lookup+0x60
          0%                                 0us                     6595  100%    0%  sys_getcwd+0x80
          0%                                 0us                     1318  100%    0%  xfs_iget_core+0x60
          0%                                 0us                     1208  100%    0%  xfs_inode_incore+0x60

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW) 
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL NOWAIT SPIN(  WW )  NAME

       0.11%  0.0us( 144us)  352us(  37ms)(0.00%)   63us( 636us)    144465 99.9% 0.00%(0.11%)  *TOTAL*

 0.00%    0%  0.1us( 1.0us)    0us                   0us                13  100%    0%(   0%)  [0xe000003036799a40]
 0.00%    0%  0.1us( 1.0us)    0us                   0us                13  100%    0%(   0%)    neigh_periodic_timer+0x140

 0.00%    0%   14us( 144us)    0us                   0us                13  100%    0%(   0%)  arp_tbl+0x17c
 0.00%    0%   14us( 144us)    0us                   0us                13  100%    0%(   0%)    neigh_periodic_timer+0x40

    0% 0.02%                  18us(  12us)(0.00%)  8.9us(  12us)     10230  100%    0%(0.02%)  fasync_lock
    0% 0.02%                  18us(  12us)(0.00%)  8.9us(  12us)     10230  100%    0%(0.02%)    fasync_helper+0x80

 0.00%    0%   56us(  56us)    0us                   0us                 1  100%    0%(   0%)  ipfrag_lock
 0.00%    0%   56us(  56us)    0us                   0us                 1  100%    0%(   0%)    ipfrag_secret_rebuild+0x40

    0% 0.18%                 356us(  37ms)(0.00%)   64us( 636us)     90073 99.8% 0.01%(0.17%)  tasklist_lock
    0% 0.02%                6260us(  37ms)(0.00%)   42us( 132us)     30023  100% 0.00%(0.02%)    copy_process+0xd40
    0% 0.50%                 128us( 636us)(0.00%)   66us( 636us)     30023 99.5% 0.01%(0.49%)    exit_notify+0xd0
    0% 0.01%                  43us(  32us)(0.00%)   22us(  32us)     30023  100%    0%(0.01%)    release_task+0xb0
    0%    0%                   0us                   0us                 4  100%    0%(   0%)    sys_setpgid+0x90

 0.00%    0%  0.1us(  24us)    0us                   0us             43567  100%    0%(   0%)  set_fs_pwd+0x20
 0.00%    0%  1.4us(  37us)    0us                   0us               144  100%    0%(   0%)  xfs_finish_reclaim+0x30
 0.00%    0%  0.1us( 0.2us)    0us                   0us               144  100%    0%(   0%)  xfs_iextract+0x30
 0.00%    0%  0.3us( 7.6us)    0us                   0us               280  100%    0%(   0%)  xfs_iget_core+0x230
_________________________________________________________________________________________________________________________
Number of read locks found=4

--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lockstat-2.6.9-rc2-rcu.txt"

___________________________________________________________________________________________
System: Linux ascender 2.6.9-rc2 #2 SMP Tue Sep 14 11:08:32 CDT 2004 ia64
Total counts

All (512) CPUs

Start time: Tue Sep 14 12:18:56 2004
End   time: Tue Sep 14 12:24:11 2004
Delta Time: 274.27 sec.
Hash table slots in use:      347.
Global read lock slots in use: 771.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

       0.07%  3.2us(  14ms) 2392us(  13ms)(0.29%) 240153544  100% 0.07% 0.00%  *TOTAL*

 0.00%    0%  0.2us( 2.0us)    0us                       15  100%    0%    0%  [0xe000003060e71e40]
 0.00%    0%  0.2us( 2.0us)    0us                       15  100%    0%    0%    unmap_mapping_range+0xc0

 0.00% 0.00%  0.2us(  23us)  0.9us( 0.9us)(0.00%)     47023  100% 0.00%    0%  [0xe00000b003746cd0]
 0.00%    0%  0.2us( 0.2us)    0us                        1  100%    0%    0%    xfs_log_move_tail+0x310
 0.00%    0%  0.5us(  23us)    0us                       79  100%    0%    0%    xfs_log_need_covered+0x100
 0.00%    0%  0.1us( 3.8us)    0us                     5080  100%    0%    0%    xfs_log_notify+0x40
 0.00%    0%  4.2us(  11us)    0us                      240  100%    0%    0%    xlog_state_do_callback+0x40
 0.00%    0%  0.0us( 0.1us)    0us                      240  100%    0%    0%    xlog_state_do_callback+0x210
 0.00% 0.42%  2.7us(  13us)  0.9us( 0.9us)(0.00%)       240 99.6% 0.42%    0%    xlog_state_do_callback+0x300
 0.00%    0%  0.2us( 0.2us)    0us                      241  100%    0%    0%    xlog_state_done_syncing+0x40
 0.00%    0%  0.3us(  12us)    0us                    10307  100%    0%    0%    xlog_state_get_iclog_space+0x30
 0.00%    0%  0.1us( 3.5us)    0us                     4804  100%    0%    0%    xlog_state_put_ticket+0x20
 0.00%    0%  0.1us( 4.4us)    0us                    10400  100%    0%    0%    xlog_state_release_iclog+0x50
 0.00%    0%  1.2us( 5.6us)    0us                      128  100%    0%    0%    xlog_state_sync_all+0x30
 0.00%    0%  0.1us( 2.4us)    0us                       55  100%    0%    0%    xlog_state_sync_all+0x440
 0.00%    0%  3.3us(  15us)    0us                       46  100%    0%    0%    xlog_state_sync+0x40
 0.00%    0%  1.1us( 5.5us)    0us                       38  100%    0%    0%    xlog_state_sync+0x3f0
 0.00%    0%  0.1us( 0.1us)    0us                       15  100%    0%    0%    xlog_state_want_sync+0x20
 0.00%    0%  0.4us(  18us)    0us                     4804  100%    0%    0%    xlog_ticket_get+0x50
 0.00%    0%  0.1us( 0.1us)    0us                    10160  100%    0%    0%    xlog_write+0x5f0
 0.00%    0%  0.1us( 0.5us)    0us                       15  100%    0%    0%    xlog_write+0x6c0
 0.00%    0%  0.1us( 0.1us)    0us                      130  100%    0%    0%    xlog_write+0x800

 0.00%    0%  0.1us(  25us)    0us                    34870  100%    0%    0%  [0xe00000b003746d70]
 0.00%    0%  0.1us(  10us)    0us                     5952  100%    0%    0%    xfs_log_move_tail+0x70
 0.00%    0%  0.0us(  12us)    0us                    10400  100%    0%    0%    xlog_assign_tail_lsn+0x50
 0.00%    0%  0.4us(  25us)    0us                     4804  100%    0%    0%    xlog_grant_log_space+0x40
 0.00%    0%  0.1us( 5.6us)    0us                     6680  100%    0%    0%    xlog_grant_push_ail+0x50
 0.00%    0%  0.1us( 0.4us)    0us                     1876  100%    0%    0%    xlog_regrant_reserve_log_space+0x50
 0.00%    0%  1.1us( 3.8us)    0us                      114  100%    0%    0%    xlog_regrant_write_log_space+0x90
 0.00%    0%  0.1us( 0.6us)    0us                      240  100%    0%    0%    xlog_state_do_callback+0x1c0
 0.00%    0%  0.1us( 4.4us)    0us                     4804  100%    0%    0%    xlog_ungrant_log_space+0x50

    0%    0%                   0us                    26867  100%    0%    0%  [0xe00005b00387a080]
    0%    0%                   0us                    26867  100%    0%    0%    sn_dma_flush+0x1e0

 0.00% 0.01%  0.1us( 4.6us)  2.4us( 2.6us)(0.00%)     32086  100% 0.01%    0%  [0xe0000c3003ea3024]
 0.00%    0%  0.2us( 1.5us)    0us                      435  100%    0%    0%    xfs_buf_iodone+0x30
 0.00%    0%  0.1us( 2.7us)    0us                       48  100%    0%    0%    xfs_buf_item_unpin+0x160
 0.00%    0%  0.0us( 0.1us)    0us                      161  100%    0%    0%    xfs_efi_item_unpin+0x30
 0.00%    0%  0.1us( 1.2us)    0us                      161  100%    0%    0%    xfs_efi_release+0x30
 0.00%    0%  0.1us( 1.4us)    0us                      595  100%    0%    0%    xfs_iflush_done+0xc0
 0.00%    0%  0.1us( 4.6us)    0us                      605  100%    0%    0%    xfs_iflush_int+0x430
 0.00%    0%  0.1us( 2.1us)    0us                    19681  100%    0%    0%    xfs_trans_chunk_committed+0x210
 0.00% 0.03%  0.1us( 3.9us)  2.4us( 2.6us)(0.00%)     10400  100% 0.03%    0%    xfs_trans_tail_ail+0x20

 0.00%    0%  0.2us(  11us)    0us                    14069  100%    0%    0%  [0xe0000c3003ea3110]
 0.00%    0%  0.2us(  11us)    0us                    10123  100%    0%    0%    xfs_mod_incore_sb+0x20
 0.00%    0%  0.1us( 3.9us)    0us                     3946  100%    0%    0%    xfs_mod_incore_sb_batch+0x30

    0%    0%                   0us                    26866  100%    0%    0%  [0xe0000cb07b91a018]
    0%    0%                   0us                    26866  100%    0%    0%    scsi_put_command+0xe0

 0.16% 0.04%  3.2us( 632us)  5.6us(  31us)(0.00%)    134334  100% 0.04%    0%  [0xe0000cb07b91a040]
 0.15% 0.01%   15us( 632us)  5.9us( 7.0us)(0.00%)     26867  100% 0.01%    0%    qla1280_intr_handler+0x30
 0.01% 0.04%  0.9us(  25us)  2.0us( 2.7us)(0.00%)     26867  100% 0.04%    0%    scsi_device_unbusy+0x50
    0% 0.04%                 2.6us( 3.4us)(0.00%)     26867  100% 0.04%    0%    scsi_dispatch_cmd+0x340
    0% 0.09%                 8.9us(  31us)(0.00%)     26867  100% 0.09%    0%    scsi_request_fn+0x2d0
    0%    0%                   0us                    26866  100%    0%    0%    scsi_run_queue+0xa0

 0.05% 0.14%  0.3us(  76us)  6.1us(  68us)(0.00%)    426645 99.9% 0.14%    0%  [0xe00011307be47034]
    0% 0.13%                 5.4us(  22us)(0.00%)     26015 99.9% 0.13%    0%    __cfq_get_queue+0x1f0
    0% 0.27%                 6.7us(  68us)(0.00%)     55197 99.7% 0.27%    0%    __make_request+0x150
 0.00%    0%  3.8us( 3.8us)    0us                        1  100%    0%    0%    blk_insert_request+0x80
 0.00% 0.04%  0.0us(  69us)  5.6us(  16us)(0.00%)     26866  100% 0.04%    0%    blk_run_queue+0x40
    0% 0.17%                 6.7us(  30us)(0.00%)     52881 99.8% 0.17%    0%    cfq_get_queue+0x50
 0.05% 0.14%  2.7us(  76us)  7.1us(  30us)(0.00%)     53331 99.9% 0.14%    0%    generic_unplug_device+0x40
    0% 0.17%                 4.7us(  18us)(0.00%)     52881 99.8% 0.17%    0%    get_request+0x80
    0% 0.12%                 7.9us(  56us)(0.00%)     26015 99.9% 0.12%    0%    get_request+0x4d0
    0% 0.02%                 2.6us( 5.0us)(0.00%)     26867  100% 0.02%    0%    scsi_device_unbusy+0xb0
    0% 0.02%                 7.3us(  19us)(0.00%)     26866  100% 0.02%    0%    scsi_end_request+0x160
 0.00% 0.36%  0.0us(  49us)  5.2us(  19us)(0.00%)     26867 99.6% 0.36%    0%    scsi_request_fn+0x520
    0% 0.03%                 4.7us( 8.7us)(0.00%)     52858  100% 0.03%    0%    scsi_request_fn+0x5b0

 0.00%    0%  0.0us( 0.8us)    0us                    53732  100%    0%    0%  [0xe00011307be47038]
    0%    0%                   0us                    26866  100%    0%    0%    scsi_get_command+0x110
 0.00%    0%  0.1us( 0.8us)    0us                    26866  100%    0%    0%    scsi_put_command+0x70

 0.00%    0%  0.2us( 6.1us)    0us                       63  100%    0%    0%  [0xe0001330032bb504]
 0.00%    0%  0.2us( 6.1us)    0us                       63  100%    0%    0%    do_select+0x60

    0%    0%                   0us                      192  100%    0%    0%  [0xe00040b003d38380]
    0%    0%                   0us                      130  100%    0%    0%    qla2x00_intr_handler+0x70
    0%    0%                   0us                       62  100%    0%    0%    qla2x00_mailbox_command+0xe0

    0%    0%                   0us                      134  100%    0%    0%  [0xe00040b003d3a480]
    0%    0%                   0us                      130  100%    0%    0%    qla2x00_next+0x80
    0%    0%                   0us                        2  100%    0%    0%    qla2x00_restart_queues+0x120
    0%    0%                   0us                        2  100%    0%    0%    qla2x00_restart_queues+0x390

    0%    0%                   0us                      186  100%    0%    0%  [0xe00040b003d3c478]
    0%    0%                   0us                       62  100%    0%    0%    qla2x00_intr_handler+0x4e0
    0%    0%                   0us                       62  100%    0%    0%    qla2x00_mailbox_command+0x9c0
    0%    0%                   0us                       62  100%    0%    0%    qla2x00_mailbox_command+0xba0

    0%    0%                   0us                        8  100%    0%    0%  [0xe00055b07bd2fe18]
    0%    0%                   0us                        4  100%    0%    0%    __down_interruptible+0xc0
    0%    0%                   0us                        4  100%    0%    0%    __down_interruptible+0x240

 0.00%    0%  6.8us(  22us)    0us                       12  100%    0%    0%  [0xe00058b07808924c]
 0.00%    0%  0.4us( 1.6us)    0us                        6  100%    0%    0%    rwsem_down_read_failed+0x60
 0.00%    0%   13us(  22us)    0us                        6  100%    0%    0%    rwsem_wake+0x30

    0%    0%                   0us                        1  100%    0%    0%  [0xe00062300376510c]
    0%    0%                   0us                        1  100%    0%    0%    pcibr_try_set_device+0x50

    0%    0%                   0us                        7  100%    0%    0%  batch_lock
    0%    0%                   0us                        7  100%    0%    0%    batch_entropy_store+0x80

 0.01% 0.03%  6.6us(  85us)  5.7us( 5.7us)(0.00%)      3155  100% 0.03%    0%  bdev_lock
 0.01% 0.03%  6.6us(  85us)  5.7us( 5.7us)(0.00%)      3155  100% 0.03%    0%    nr_blockdev_pages+0x20

 0.00%    0%  0.2us(  39us)    0us                    19868  100%    0%    0%  cdev_lock
 0.00%    0%  0.2us(  39us)    0us                    19868  100%    0%    0%    chrdev_open+0x40

 0.00%    0%  1.6us( 5.0us)    0us                      512  100%    0%    0%  cpe_history_lock.4
 0.00%    0%  1.6us( 5.0us)    0us                      512  100%    0%    0%    ia64_mca_cpe_int_handler+0xa0

 0.10% 0.03%  0.1us(  52us)  3.1us( 993us)(0.00%)   2701927  100% 0.03%    0%  dcache_lock
 0.00% 0.02%  0.1us(  19us)  1.9us( 3.4us)(0.00%)     27727  100% 0.02%    0%    d_alloc+0x260
 0.00%    0%  0.3us( 4.0us)    0us                     1207  100%    0%    0%    d_delete+0x40
 0.00% 0.02%  0.1us(  11us)  2.2us( 3.7us)(0.00%)     27890  100% 0.02%    0%    d_instantiate+0x50
 0.00%    0%  3.5us(  12us)    0us                       97  100%    0%    0%    d_move+0x60
 0.00% 0.19%  1.9us(  11us)  1.0us( 1.2us)(0.00%)      1043 99.8% 0.19%    0%    d_path+0x110
 0.00% 0.04%  0.3us(  31us)  1.7us( 4.4us)(0.00%)     27726  100% 0.04%    0%    d_rehash+0xc0
 0.00%    0%  0.1us( 0.1us)    0us                     1043  100%    0%    0%    d_splice_alias+0xc0
 0.09% 0.04%  0.1us(  52us)  3.1us( 993us)(0.00%)   2564651  100% 0.04%    0%    dput+0x50
 0.00%    0%  0.1us( 1.9us)    0us                    24437  100%    0%    0%    link_path_walk+0x1000
 0.00%    0%  0.1us( 2.3us)    0us                    18468  100%    0%    0%    link_path_walk+0x1ed0
 0.00%    0%  0.8us( 4.4us)    0us                      149  100%    0%    0%    proc_pid_unhash+0x50
 0.00%    0%  1.0us(  11us)    0us                      298  100%    0%    0%    prune_dcache+0x50
 0.00%    0%  0.1us( 4.1us)    0us                      149  100%    0%    0%    prune_dcache+0x380
 0.00%    0%  0.2us(  11us)    0us                      447  100%    0%    0%    select_parent+0x30
 0.00%    0%  0.8us(  23us)    0us                     6595  100%    0%    0%    sys_getcwd+0x210

 0.02% 0.01%  0.1us(  23us)  1.6us(  11us)(0.00%)    516145  100% 0.01%    0%  files_lock
 0.00% 0.04%  0.1us( 0.5us)  2.6us( 2.6us)(0.00%)      2818  100% 0.04%    0%    check_tty_count+0x20
 0.01% 0.02%  0.1us(  15us)  1.3us( 3.9us)(0.00%)    255959  100% 0.02%    0%    file_kill+0x70
 0.01% 0.01%  0.1us(  23us)  2.0us(  11us)(0.00%)    257368  100% 0.01%    0%    file_move+0x40

    0%    0%                   0us                      756  100%    0%    0%  filp_count_lock
    0%    0%                   0us                      441  100%    0%    0%    filp_ctor+0x70
    0%    0%                   0us                      315  100%    0%    0%    filp_dtor+0x40

    0% 0.00%                 3.1us( 3.1us)(0.00%)     89822  100% 0.00%    0%  ia64_ctx
    0% 0.00%                 3.1us( 3.1us)(0.00%)     29924  100% 0.00%    0%    exec_mmap+0x4f0
    0%    0%                   0us                    20994  100%    0%    0%    schedule+0xde0
    0%    0%                   0us                    38904  100%    0%    0%    smp_flush_tlb_mm+0x310

    0%    0%                   0us                      512  100%    0%    0%  ia64_state_log+0x60
    0%    0%                   0us                      512  100%    0%    0%    ia64_log_get+0x80

 0.00%    0%  0.1us( 0.2us)    0us                        2  100%    0%    0%  inet_peer_unused_lock
 0.00%    0%  0.1us( 0.2us)    0us                        2  100%    0%    0%    cleanup_once+0x60

 0.04% 0.06%  0.3us(  43us)  5.0us(  31us)(0.00%)    353580  100% 0.06%    0%  inode_lock
 0.00% 0.01%  0.2us(  13us)  1.8us( 2.2us)(0.00%)     47928  100% 0.01%    0%    __mark_inode_dirty+0xf0
 0.01% 0.13%  0.4us(  43us)  7.3us(  31us)(0.00%)     75399 99.9% 0.13%    0%    __sync_single_inode+0x100
 0.00%    0%  0.1us(  10us)    0us                     4746  100%    0%    0%    generic_delete_inode+0x1f0
 0.00% 0.01%  0.1us(  23us)  2.0us( 2.2us)(0.00%)     22314  100% 0.01%    0%    get_new_inode_fast+0x50
 0.00% 0.00%  0.3us(  23us)  2.5us( 2.5us)(0.00%)     22314  100% 0.00%    0%    iget_locked+0xb0
 0.00%    0%  0.2us(  12us)    0us                     6326  100%    0%    0%    igrab+0x20
 0.00% 0.06%  0.1us(  40us)  2.7us( 7.6us)(0.00%)     92603  100% 0.06%    0%    iput+0xa0
 0.00% 0.04%  0.3us(  18us)  2.1us( 2.4us)(0.00%)      4712  100% 0.04%    0%    new_inode+0x70
 0.00% 0.13%  0.2us( 5.9us)  5.1us( 5.1us)(0.00%)       765 99.9% 0.13%    0%    sync_inodes_sb+0x140
 0.02% 0.08%  0.6us(  37us)  3.6us(  13us)(0.00%)     75910  100% 0.08%    0%    sync_sb_inodes+0x630
 0.00% 0.18%  1.9us(  25us)  2.1us( 2.1us)(0.00%)       563 99.8% 0.18%    0%    writeback_inodes+0x20

 0.03% 0.01%  2.2us( 791us)  8.9us(  16us)(0.00%)     37374  100% 0.01%    0%  kernel_flag
 0.01%    0%  1.0us( 217us)    0us                    19868  100%    0%    0%    chrdev_open+0x1e0
 0.00% 0.03%  0.2us(  17us)  1.8us( 1.8us)(0.00%)      3241  100% 0.03%    0%    de_put+0x50
 0.00%    0%  0.1us( 0.1us)    0us                      696  100%    0%    0%    linvfs_ioctl+0x140
 0.02%    0%   13us( 791us)    0us                     3391  100%    0%    0%    proc_lookup+0x60
 0.00% 0.05%  1.1us(  67us)   16us(  16us)(0.00%)      2123  100% 0.05%    0%    sys_ioctl+0xa0
 0.00%    0%  0.9us(  24us)    0us                     6592  100%    0%    0%    sys_sysctl+0xd0
 0.00%    0%  4.5us( 164us)    0us                     1409  100%    0%    0%    tty_release+0x50
 0.00%    0%   73us( 477us)    0us                       54  100%    0%    0%    tty_write+0x440

    0%    0%                   0us                       12  100%    0%    0%  logbuf_lock
    0%    0%                   0us                        8  100%    0%    0%    release_console_sem+0x50
    0%    0%                   0us                        4  100%    0%    0%    vprintk+0x60

 0.01% 0.10%  0.3us(  26us)  2.0us(  17us)(0.00%)    110873 99.9% 0.10%    0%  mmlist_lock
 0.00% 0.04%  0.1us( 3.3us)  3.3us(  17us)(0.00%)     20994  100% 0.04%    0%    copy_mm+0x2a0
 0.01% 0.03%  0.8us(  26us)  1.2us( 2.8us)(0.00%)     29924  100% 0.03%    0%    exec_mmap+0x40
 0.00% 0.16%  0.2us(  16us)  2.0us(  14us)(0.00%)     59955 99.8% 0.16%    0%    mmput+0x30

    0%    0%                   0us                     1052  100%    0%    0%  page_uptodate_lock.1
    0%    0%                   0us                     1052  100%    0%    0%    end_buffer_async_write+0xc0

 0.00% 0.01%  0.2us(  20us)  0.2us( 0.2us)(0.00%)      9033  100% 0.01%    0%  pbd_delwrite_lock
 0.00%    0%  2.8us(  20us)    0us                      314  100%    0%    0%    pagebuf_daemon+0x200
 0.00% 0.01%  0.1us( 3.8us)  0.2us( 0.2us)(0.00%)      8232  100% 0.01%    0%    pagebuf_delwri_dequeue+0x30
 0.00%    0%  0.4us( 3.4us)    0us                      487  100%    0%    0%    pagebuf_delwri_queue+0x30

    0%    0%                   0us                      234  100%    0%    0%  pdflush_lock
    0%    0%                   0us                       78  100%    0%    0%    __pdflush+0x220
    0%    0%                   0us                       78  100%    0%    0%    __pdflush+0x320
    0%    0%                   0us                       78  100%    0%    0%    pdflush_operation+0x60

 0.85%  8.8%  1.3us(3489us) 2617us(  13ms)(0.29%)   1766106 91.2%  8.8%    0%  rcu_state
 0.01% 0.83%  4.7us( 369us)  828us(5897us)(0.00%)      6874 99.2% 0.83%    0%    __rcu_process_callbacks+0x260
 0.83%  8.8%  1.3us(3489us) 2617us(  13ms)(0.29%)   1759232 91.2%  8.8%    0%    cpu_quiet+0x2c0

 0.00%    0%  0.5us( 7.1us)    0us                       54  100%    0%    0%  redirect_lock
 0.00%    0%  0.5us( 7.1us)    0us                       54  100%    0%    0%    redirected_tty_write+0x30

 0.00%    0%  2.3us(  11us)    0us                       97  100%    0%    0%  rename_lock+0x4
 0.00%    0%  2.3us(  11us)    0us                       97  100%    0%    0%    d_move+0x80

    0% 0.64%                  22us(  26us)(0.00%)       627 99.4% 0.64%    0%  sal_console_port+0x40
    0%    0%                   0us                        4  100%    0%    0%    sn_sal_console_write+0x380
    0%  1.3%                  22us(  26us)(0.00%)       299 98.7%  1.3%    0%    sn_sal_interrupt+0x200
    0%    0%                   0us                      108  100%    0%    0%    uart_put_char+0xa0
    0%    0%                   0us                      162  100%    0%    0%    uart_start+0x50
    0%    0%                   0us                       54  100%    0%    0%    uart_write+0x400

 0.00%    0%  0.5us(  29us)    0us                     3069  100%    0%    0%  sb_lock
 0.00%    0%  0.4us( 6.7us)    0us                      810  100%    0%    0%    get_super_to_sync+0x30
 0.00%    0%  1.4us( 4.8us)    0us                       15  100%    0%    0%    get_super_to_sync+0x30
 0.00%    0%  0.1us( 1.1us)    0us                      850  100%    0%    0%    put_super+0x20
 0.00%    0%  1.2us( 6.4us)    0us                       45  100%    0%    0%    set_sb_syncing+0x20
 0.00%    0%  1.7us(  11us)    0us                       30  100%    0%    0%    sync_filesystems+0x70
 0.00%    0%  1.4us(  27us)    0us                       60  100%    0%    0%    sync_filesystems+0x170
 0.00%    0%  1.6us( 5.4us)    0us                      133  100%    0%    0%    sync_supers+0x30
 0.00%    0%  0.4us( 7.1us)    0us                      563  100%    0%    0%    writeback_inodes+0x40
 0.00%    0%  1.0us(  29us)    0us                      563  100%    0%    0%    writeback_inodes+0x210

 0.00%    0%  0.2us(  18us)    0us                     3155  100%    0%    0%  swaplock
 0.00%    0%  0.2us(  18us)    0us                     3155  100%    0%    0%    si_swapinfo+0x20

 0.00%    0%  0.1us( 3.6us)    0us                    30031  100%    0%    0%  uidhash_lock
 0.00%    0%  0.1us( 3.6us)    0us                    30031  100%    0%    0%    free_uid+0x30

 0.00% 0.02%  0.8us(  13us)  3.1us( 3.1us)(0.00%)      4298  100% 0.02%    0%  vfsmount_lock
 0.00%    0%  0.1us( 3.6us)    0us                      894  100%    0%    0%    __d_path+0x2b0
 0.00% 0.03%  1.1us(  13us)  3.1us( 3.1us)(0.00%)      3404  100% 0.03%    0%    lookup_mnt+0x80

 0.00%    0%  0.1us(  11us)    0us                    19073  100%    0%    0%  vnumber_lock
 0.00%    0%  0.1us(  11us)    0us                    19073  100%    0%    0%    vn_initialize+0xd0

 0.93%    0%  7.9us(1132us)    0us                   322268  100%    0%    0%  xtime_lock+0x4
 0.93%    0%  7.9us(1132us)    0us                   322268  100%    0%    0%    timer_interrupt+0x330

 0.07% 0.00%  0.1us(  25us)  3.1us(  11us)(0.00%)   1686850  100% 0.00%    0%  __d_lookup+0x190
    0% 0.28%                 3.2us( 4.8us)(0.00%)      1450 99.7% 0.28%    0%  __down+0x200
    0% 0.27%                 2.1us( 2.7us)(0.00%)      1498 99.7% 0.27%    0%  __down+0xc0
    0%    0%                   0us                     2761  100%    0%    0%  __down_trylock+0x40
 0.00%    0%  0.1us(  23us)    0us                    30031  100%    0%    0%  __exit_signal+0x80
 0.01%    0%  0.1us( 4.5us)    0us                   152486  100%    0%    0%  __mod_timer+0x120
    0%    0%                   0us                   152486  100%    0%    0%  __mod_timer+0xa0
    0% 0.03%                 1.5us(  12us)(0.00%)   1157082  100% 0.03%    0%  __page_cache_release+0x70
    0%    0%                   0us                    19600  100%    0%    0%  __pagevec_lru_add+0xe0
    0% 0.03%                 8.2us(  21us)(0.00%)    193047  100% 0.03%    0%  __pagevec_lru_add_active+0xe0
 0.01%    0%  0.1us(  17us)    0us                   203672  100%    0%    0%  __pmd_alloc+0x60
    0%    0%                   0us                    80491  100%    0%    0%  __queue_work+0x30
    0%    0%                   0us                     2050  100%    0%    0%  __set_page_dirty_nobuffers+0xd0
    0% 0.02%                 3.6us( 9.7us)(0.00%)    213353  100% 0.02%    0%  __wake_up+0x30
    0%    0%                   0us                    30031  100%    0%    0%  __wake_up_sync+0x50
 0.01%    0%  0.4us(  37us)    0us                    84165  100%    0%    0%  _pagebuf_find+0xd0
    0%    0%                   0us                     3631  100%    0%    0%  activate_page+0x70
    0%    0%                   0us                    27427  100%    0%    0%  add_to_page_cache+0x80
    0%    0%                   0us                   130349  100%    0%    0%  add_wait_queue+0x50
    0%    0%                   0us                       46  100%    0%    0%  add_wait_queue_exclusive+0x50
 0.01% 0.00%  0.1us(  12us)  1.3us( 1.9us)(0.00%)    264157  100% 0.00%    0%  anon_vma_link+0x30
 0.02%    0%  0.2us(  38us)    0us                   281171  100%    0%    0%  anon_vma_prepare+0xc0
 0.01% 0.00%  0.1us(  41us)  6.5us(  32us)(0.00%)    562479  100% 0.00%    0%  anon_vma_unlink+0x30
    0% 0.01%                 2.2us( 2.3us)(0.00%)     30031  100% 0.01%    0%  buffered_rmqueue+0x3f0
 0.02%    0%  2.2us(  55us)    0us                    18846  100%    0%    0%  cache_alloc_refill+0xb0
 0.01%    0%  2.0us(  36us)    0us                     7284  100%    0%    0%  cache_flusharray+0x30
 0.00%    0%  0.1us( 0.2us)    0us                     2461  100%    0%    0%  cache_grow+0x260
 0.00%    0%  0.5us(  11us)    0us                     2461  100%    0%    0%  cache_grow+0xf0
    0% 0.00%                 5.7us(  29us)(0.00%)   8444352  100% 0.00%    0%  cache_reap+0x230
    0%    0%                   0us                      354  100%    0%    0%  cache_reap+0x430
 0.01%    0%  0.5us(  23us)    0us                    42332  100%    0%    0%  change_protection+0x90
    0%    0%                   0us                    29462  100%    0%    0%  complete+0x40
 0.00%    0%  0.4us(  26us)    0us                    29924  100%    0%    0%  compute_creds+0x20
 0.01%    0%  1.0us(  82us)    0us                    30031  100%    0%    0%  copy_files+0x1c0
 0.00%    0%  0.1us(  10us)    0us                    17410  100%    0%    0%  copy_files+0x200
 0.05%    0%  7.3us(  33us)    0us                    17410  100%    0%    0%  copy_files+0x2c0
 0.01% 0.01%  0.1us(  14us)  4.2us( 9.1us)(0.00%)    363042  100% 0.01%    0%  copy_mm+0x5a0
 0.86%    0%  4.7us(2058us)    0us                   506636  100%    0%    0%  copy_mm+0x5e0
  1.2%    0%  6.6us(2058us)    0us                   485642  100%    0%    0%  copy_page_range+0x2a0
  155% 0.13%  121us(  13ms)  9.0us(1585us)(0.00%)   3518464 99.9% 0.13%    0%  cpu_quiet+0x60
 0.00%    0%  0.3us( 3.8us)    0us                     2050  100%    0%    0%  create_empty_buffers+0xa0
 0.00%    0%  0.1us( 0.1us)    0us                     1207  100%    0%    0%  d_delete+0x50
 0.00%    0%  1.5us( 2.4us)    0us                       97  100%    0%    0%  d_move+0x100
 0.00%    0%  1.9us( 2.7us)    0us                       49  100%    0%    0%  d_move+0x560
 0.00%    0%  1.8us( 3.6us)    0us                       48  100%    0%    0%  d_move+0xe0
 0.00%    0%  0.1us(  11us)    0us                    27726  100%    0%    0%  d_rehash+0xd0
    0% 0.00%                 1.0us( 1.0us)(0.00%)     79353  100% 0.00%    0%  del_timer+0x80
 0.01% 0.00%  0.1us(  27us)  2.8us( 3.0us)(0.00%)    179833  100% 0.00%    0%  deny_write_access+0x40
 0.00%    0%  0.1us( 9.7us)    0us                    46847  100%    0%    0%  dnotify_flush+0xa0
 0.03% 0.00%  0.2us( 212us)  4.1us(  16us)(0.00%)    330705  100% 0.00%    0%  dnotify_parent+0x60
 0.01%    0%  0.6us(  24us)    0us                    27234  100%    0%    0%  do_IRQ+0x1d0
 0.00%    0%  0.4us( 8.5us)    0us                    27234  100%    0%    0%  do_IRQ+0x2b0
 0.04%    0%  0.3us( 183us)    0us                   384104  100%    0%    0%  do_anonymous_page+0x270
 0.00%    0%  0.1us( 6.0us)    0us                    30031  100%    0%    0%  do_exit+0x3d0
 0.00%    0%  0.0us(  12us)    0us                    30031  100%    0%    0%  do_exit+0x460
 0.00%    0%  0.0us( 9.7us)    0us                    30031  100%    0%    0%  do_exit+0x4b0
 0.00%    0%  0.0us( 6.6us)    0us                    30031  100%    0%    0%  do_exit+0x6d0
 0.00%    0%  0.1us( 2.5us)    0us                      933  100%    0%    0%  do_fcntl+0xb0
 0.12%    0%  2.2us(  13ms)    0us                   153104  100%    0%    0%  do_munmap+0x220
 0.19%    0%  0.2us( 236us)    0us                  2400489  100%    0%    0%  do_no_page+0x220
    0%    0%                   0us                    30031  100%    0%    0%  do_notify_parent+0x2e0
    0% 0.06%                 3.5us(  12us)(0.00%)    158844  100% 0.06%    0%  do_page_cache_readahead+0x140
    0%    0%                   0us                    24872  100%    0%    0%  do_page_cache_readahead+0x270
    0%    0%                   0us                   283362  100%    0%    0%  do_sigaction+0x110
    0%    0%                   0us                    36542  100%    0%    0%  do_sigaction+0x2a0
 0.11%    0%  0.6us( 537us)    0us                   486122  100%    0%    0%  do_wp_page+0x2d0
 0.00%  1.9%  0.7us( 226us)    0us                    14714 98.1%    0%  1.9%  double_lock_balance+0x20
 0.00% 82.3%   12us( 137us)  212us(1619us)(0.00%)        96 17.7% 82.3%    0%  double_lock_balance+0x80
 0.00% 59.3%  2.9us(  87us)   27us( 562us)(0.00%)       285 40.7% 59.3%    0%  double_lock_balance+0xa0
 0.00%    0%  1.0us( 639us)    0us                    11554  100%    0%    0%  double_rq_lock+0x40
 0.00% 0.15%  0.1us( 3.1us)  237us( 639us)(0.00%)     20425 99.9% 0.15%    0%  double_rq_lock+0x60
 0.00% 0.32%  0.3us(  17us)  327us( 584us)(0.00%)      8871 99.7% 0.32%    0%  double_rq_lock+0x90
 0.02% 0.00%  0.1us(  52us)  4.3us( 6.8us)(0.00%)    417229  100% 0.00%    0%  dput+0xb0
 0.00%    0%  0.3us( 9.2us)    0us                      371  100%    0%    0%  dupfd+0x30
 0.01%    0%  1.1us(6130us)    0us                    29924  100%    0%    0%  exec_mmap+0x110
  7.3%    0%  392us(  14ms)    0us                    50918  100%    0%    0%  exit_mmap+0x50
 0.00%    0%  0.1us(  13us)    0us                    17662  100%    0%    0%  expand_fd_array+0x130
 0.00%    0%  0.3us( 2.0us)    0us                      252  100%    0%    0%  expand_fd_array+0x240
 0.00%    0%  0.5us( 5.3us)    0us                      928  100%    0%    0%  expand_stack+0x60
 0.00%    0%  0.1us(  13us)    0us                   234945  100%    0%    0%  fd_install+0x30
 0.02%    0%  0.1us(  23us)    0us                   438595  100%    0%    0%  fget+0x30
    0% 0.07%                 3.4us(  30us)(0.00%)   2674425  100% 0.07%    0%  find_get_page+0x40
    0%    0%                   0us                     4238  100%    0%    0%  find_get_pages+0x40
    0%    0%                   0us                   120515  100%    0%    0%  find_get_pages_tag+0x40
    0% 0.01%                 1.1us( 1.9us)(0.00%)     84291  100% 0.01%    0%  find_lock_page+0x40
    0%    0%                   0us                      204  100%    0%    0%  find_trylock_page+0x40
    0% 0.02%                 2.3us( 4.2us)(0.00%)     26066  100% 0.02%    0%  finish_wait+0x90
 0.00%    0%  0.1us(  20us)    0us                    38666  100%    0%    0%  flush_old_exec+0x4f0
    0% 0.08%                 3.8us(  16us)(0.00%)     80172  100% 0.08%    0%  force_page_cache_readahead+0x170
    0%    0%                   0us                       72  100%    0%    0%  force_page_cache_readahead+0x2a0
    0% 0.02%                 4.7us(  31us)(0.00%)    265111  100% 0.02%    0%  free_pages_bulk+0x90
    0% 0.10%                 4.1us(  18us)(0.00%)     27886 99.9% 0.10%    0%  get_signal_to_deliver+0x60
 0.02%    0%  0.2us(  28us)    0us                   281891  100%    0%    0%  get_unused_fd+0x40
 0.00%    0%  0.1us(  12us)    0us                    21477  100%    0%    0%  get_write_access+0x30
 0.25%    0%  0.2us( 703us)    0us                  3589052  100%    0%    0%  handle_mm_fault+0x160
    0%    0%                   0us                    27886  100%    0%    0%  handle_signal+0x100
    0%    0%                   0us                    27886  100%    0%    0%  ia64_rt_sigreturn+0x1b0
 0.00%    0%  0.2us(  12us)    0us                    29924  100%    0%    0%  install_arg_page+0xc0
    0%    0%                   0us                    30046  100%    0%    0%  k_getrusage+0x530
    0%    0%                   0us                      356  100%    0%    0%  k_getrusage+0xd0
 0.00%    0%  0.1us( 0.9us)    0us                      696  100%    0%    0%  linvfs_ioctl+0xe0
 0.00%  3.1%  1.1us(  56us)  460us( 979us)(0.00%)       228 96.9%  3.1%    0%  load_balance+0x170
  115% 0.00%  9.4us(1773us)  3.0us( 9.6us)(0.00%)  33485489  100% 0.00%    0%  load_balance+0x30
    0%    0%                   0us                    75399  100%    0%    0%  mapping_tagged+0x40
 0.00% 0.01%  0.1us( 586us)   76us( 207us)(0.00%)     40912  100% 0.01%    0%  migration_thread+0x130
 0.00%    0%  0.5us( 2.4us)    0us                      149  100%    0%    0%  mounts_open+0xa0
 0.00%    0%  0.1us(  11us)    0us                    97133  100%    0%    0%  pagebuf_rele+0x60
 0.00%    0%  0.1us( 0.1us)    0us                      149  100%    0%    0%  pid_base_iput+0x30
    0%    0%                   0us                     5044  100%    0%    0%  prepare_to_wait+0x60
    0% 0.00%                 0.2us( 0.3us)(0.00%)     43556  100% 0.00%    0%  prepare_to_wait_exclusive+0x60
 0.00%    0%  0.0us( 0.2us)    0us                      149  100%    0%    0%  proc_pid_lookup+0x1e0
 0.00%    0%  0.4us( 3.5us)    0us                      298  100%    0%    0%  prune_dcache+0x130
 0.38%    0%  4.0us( 446us)    0us                   254607  100%    0%    0%  pte_alloc_map+0x140
 0.00%    0%  0.1us( 3.3us)    0us                    47317  100%    0%    0%  put_unused_fd+0x30
    0%    0%                   0us                     5355  100%    0%    0%  qla2x00_timer+0x2c0
    0% 0.06%                  14us(  19us)(0.00%)     19499  100% 0.06%    0%  release_pages+0x180
 0.07%    0%  6.3us( 252us)    0us                    30031  100%    0%    0%  release_task+0x60
    0%    0%                   0us                     1993  100%    0%    0%  remove_from_page_cache+0x70
 0.06% 0.03%  0.2us(  44us)  4.6us(  26us)(0.00%)    748374  100% 0.03%    0%  remove_vm_struct+0x50
    0% 0.00%                 3.5us( 3.5us)(0.00%)    130395  100% 0.00%    0%  remove_wait_queue+0x30
    0% 0.03%                 2.1us( 5.4us)(0.00%)    247968  100% 0.03%    0%  rmqueue_bulk+0x40
 0.00%    0%  0.6us( 1.4us)    0us                        5  100%    0%    0%  rt_check_expire+0xe0
    0%    0%                   0us                    73133  100%    0%    0%  run_timer_softirq+0x2c0
    0% 0.00%                 1.0us( 2.0us)(0.00%) 163398664  100% 0.00%    0%  run_timer_softirq+0xb0
 0.13% 0.88%  0.9us( 375us)  1.3us( 825us)(0.00%)    373228 99.1% 0.88%    0%  schedule+0x260
    0%    0%                   0us                   368227  100%    0%    0%  schedule+0x680
 0.02% 0.01%  0.2us(  44us)   19us( 224us)(0.00%)    265492  100% 0.01%    0%  scheduler_tick+0x520
 0.00%    0%  0.1us( 0.2us)    0us                    40137  100%    0%    0%  set_close_on_exec+0x30
 0.00%    0%  0.2us(  13us)    0us                    29924  100%    0%    0%  set_task_comm+0x20
    0% 0.03%                  11us(  32us)(0.00%)     18665  100% 0.03%    0%  sigprocmask+0x50
 0.01%    0%  0.1us(  22us)    0us                   286782  100%    0%    0%  sys_close+0x30
 0.00%    0%  0.2us(  28us)    0us                    23247  100%    0%    0%  sys_dup2+0x50
 0.00%    0%  0.1us( 0.8us)    0us                      149  100%    0%    0%  task_dumpable+0x20
    0% 0.41%                  22us( 623us)(0.00%)    296779 99.6% 0.41%    0%  task_rq_lock+0xa0
    0%    0%                   0us                     4287  100%    0%    0%  test_clear_page_dirty+0x90
    0%    0%                   0us                      302  100%    0%    0%  test_clear_page_writeback+0x90
    0%    0%                   0us                      302  100%    0%    0%  test_set_page_writeback+0x90
 0.00%    0%  1.0us( 5.7us)    0us                     1992  100%    0%    0%  try_to_free_buffers+0x90
 0.00%    0% 1176us(1190us)    0us                        2  100%    0%    0%  unmap_vmas+0x540
 0.03% 0.05%  0.7us(  29us)  5.4us(  24us)(0.00%)    129360  100% 0.05%    0%  vma_adjust+0x140
 0.00%    0%  0.2us(  16us)    0us                    67216  100%    0%    0%  vma_adjust+0x2d0
 0.06% 0.02%  0.7us( 749us)  6.1us(  36us)(0.00%)    255972  100% 0.02%    0%  vma_link+0x60
 0.00%    0%  0.4us(  12us)    0us                     6326  100%    0%    0%  vn_hold+0x70
 0.00%    0%  0.1us( 0.6us)    0us                     1207  100%    0%    0%  vn_purge+0x30
 0.00%    0%  0.1us( 3.3us)    0us                     1207  100%    0%    0%  vn_reclaim+0x100
 0.00%    0%  0.1us( 0.3us)    0us                     1207  100%    0%    0%  vn_rele+0x130
 0.00%    0%  0.1us( 3.6us)    0us                     1207  100%    0%    0%  vn_rele+0x70
 0.00%    0%  0.0us( 0.1us)    0us                     1236  100%    0%    0%  vn_revalidate+0xf0
 0.00%    0%  0.1us( 0.1us)    0us                     1207  100%    0%    0%  vn_wakeup+0x20
    0%    0%                   0us                    29462  100%    0%    0%  wait_for_completion+0x1d0
    0%    0%                   0us                    29462  100%    0%    0%  wait_for_completion+0x50
    0%    0%                   0us                    30031  100%    0%    0%  wait_task_zombie+0x170
    0%    0%                   0us                    79650  100%    0%    0%  worker_thread+0x2a0
    0%    0%                   0us                    80491  100%    0%    0%  worker_thread+0x430
 0.00%    0%  0.7us( 1.3us)    0us                      161  100%    0%    0%  xfs_alloc_clear_busy+0x60
 0.00%    0%  0.9us( 3.7us)    0us                      162  100%    0%    0%  xfs_alloc_mark_busy+0x60
 0.00%    0%  0.3us( 1.5us)    0us                      146  100%    0%    0%  xfs_alloc_search_busy+0x60
 0.00%    0%  0.1us( 1.2us)    0us                      136  100%    0%    0%  xfs_iextract+0xf0
 0.05%    0%   17us( 130us)    0us                     7869  100%    0%    0%  xfs_iflush+0x3c0
 0.00%    0%  0.4us(  28us)    0us                    18630  100%    0%    0%  xfs_iget_core+0x430
 0.00%    0%  0.3us( 4.2us)    0us                       98  100%    0%    0%  xfs_map_blocks+0xf0

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL NOWAIT SPIN  NAME

       0.01%                               7.9us( 186us)(0.00%)    922136  100% 0.01%  *TOTAL*

 0.00%    0%   0.2us     2  0.2us(1003us)    0us                    30502  100%    0%  binfmt_lock
          0%                                 0us                    30213  100%    0%    search_binary_handler+0x80
          0%                                 0us                      289  100%    0%    search_binary_handler+0x420

 0.00%    0%  16.5us     1   16us(  42us)    0us                       97  100%    0%  file_systems_lock
          0%                                 0us                       97  100%    0%    get_filesystem_list+0x30

 29.5% 0.11%   0.8us     2  708us(40446ms)  7.9us( 186us)(0.00%)    114336 99.9% 0.11%  tasklist_lock
       0.01%                               5.8us( 8.9us)(0.00%)     36542  100% 0.01%    do_sigaction+0x260
       0.17%                               7.9us( 186us)(0.00%)     77267 99.8% 0.17%    do_wait+0x160
          0%                                 0us                      371  100%    0%    getrusage+0x40
          0%                                 0us                      149  100%    0%    proc_pid_lookup+0x80
          0%                                 0us                        6  100%    0%    session_of_pgrp+0x20
          0%                                 0us                        1  100%    0%    wrap_mmu_context+0x70

 59.2%    0% 143.5us     2   52ms(40446ms)    0us                     3155  100%    0%  vmlist_lock
          0%                                 0us                     3155  100%    0%    get_vmalloc_info+0x40

          0%                                 0us                    30031  100%    0%  copy_process+0x17d0
          0%                                 0us                     1043  100%    0%  d_path+0x30
          0%                                 0us                    18468  100%    0%  link_path_walk+0x1e50
          0%                                 0us                    24437  100%    0%  link_path_walk+0xf80
          0%                                 0us                   673192  100%    0%  path_lookup+0x60
          0%                                 0us                     6595  100%    0%  sys_getcwd+0x80
          0%                                 0us                    19073  100%    0%  xfs_iget_core+0x60
          0%                                 0us                     1207  100%    0%  xfs_inode_incore+0x60

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW) 
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL NOWAIT SPIN(  WW )  NAME

       0.05%  0.0us( 142us)   15us(  23us)(0.00%)  8.1us(  23us)    162200  100% 0.00%(0.04%)  *TOTAL*

 0.00%    0%  0.1us( 0.1us)    0us                   0us                11  100%    0%(   0%)  [0xe000003073709040]
 0.00%    0%  0.1us( 0.1us)    0us                   0us                11  100%    0%(   0%)    neigh_periodic_timer+0x140

 0.00%    0%   15us( 142us)    0us                   0us                11  100%    0%(   0%)  arp_tbl+0x17c
 0.00%    0%   15us( 142us)    0us                   0us                11  100%    0%(   0%)    neigh_periodic_timer+0x40

    0%    0%                   0us                   0us             10237  100%    0%(   0%)  fasync_lock
    0%    0%                   0us                   0us             10237  100%    0%(   0%)    fasync_helper+0x80

    0% 0.09%                  15us(  23us)(0.00%)  8.1us(  23us)     90097  100% 0.01%(0.08%)  tasklist_lock
    0% 0.01%                 3.7us( 3.7us)(0.00%)  3.7us( 3.7us)     30031  100% 0.01%(0.00%)    copy_process+0xd40
    0% 0.23%                  15us(  23us)(0.00%)  8.3us(  23us)     30031 99.8% 0.02%(0.21%)    exit_notify+0xd0
    0% 0.03%                  14us(  12us)(0.00%)  7.1us(  12us)     30031  100%    0%(0.03%)    release_task+0xb0
    0%    0%                   0us                   0us                 4  100%    0%(   0%)    sys_setpgid+0x90

 0.00%    0%  0.1us(  10us)    0us                   0us             43567  100%    0%(   0%)  set_fs_pwd+0x20
 0.00%    0%  0.1us( 1.1us)    0us                   0us               136  100%    0%(   0%)  xfs_finish_reclaim+0x30
 0.00%    0%  0.1us( 1.3us)    0us                   0us               136  100%    0%(   0%)  xfs_iextract+0x30
 0.00%    0%  0.1us( 9.7us)    0us                   0us             18005  100%    0%(   0%)  xfs_iget_core+0x230
_________________________________________________________________________________________________________________________
Number of read locks found=4

--tNQTSEo8WG/FKZ8E--
