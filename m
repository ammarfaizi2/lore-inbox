Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbUCYDxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 22:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUCYDxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 22:53:32 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:20421 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S263143AbUCYDwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 22:52:25 -0500
Date: Thu, 25 Mar 2004 03:52:11 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4 freeze [bttv/msp3400 related?]; dump from SysRq+T and P
Message-ID: <Pine.LNX.4.58.0403250331080.5973@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Another freeze (no dump), this time the machine wasn't under load and I
wasn't using bttv (in all other freezes I was using it), but it was
loaded and might be related, as msp3400 code is in X's call trace.

The .config file is at http://joel.ist.utl.pt/~rmps/config-2.6.4 and if
you need more information, just ask.

Regards,
  Rui Saraiva


Mar 25 03:17:21 somewhere kernel: SysRq : Show State
Mar 25 03:17:21 somewhere kernel:                                                sibling
Mar 25 03:17:21 somewhere kernel:   task             PC      pid father child younger older
Mar 25 03:17:21 somewhere kernel: init          S 00000282  5776     1      0     2               (NOTLB)
Mar 25 03:17:21 somewhere kernel: c12a5e78 00000086 00000002 00000282 00000163 00000000 c12a5e8c c12a5e78
Mar 25 03:17:21 somewhere kernel:        00000246 c12a5e50 c011fe26 c0372044 c5a199e0 c5a19a00 00003ab0 072ae74c
Mar 25 03:17:21 somewhere kernel:        000025fe c12eb9e0 c12ebbd0 027914cf c12a5e8c 0000000b c12a5ed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c01881e2>] pipe_poll+0x32/0x80
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: ksoftirqd/0   S 000003C3  6732     2      1             3       (L-TLB)
Mar 25 03:17:21 somewhere kernel: cff7ffb8 00000046 c013efb5 000003c3 c12e89e0 c12e8bd4 00000000 cff7e000
Mar 25 03:17:21 somewhere kernel:        00000000 caba69e0 cff7ff88 cff7ff88 c23229e0 c2322a00 0000011d 6882526e
Mar 25 03:17:21 somewhere kernel:        000025b3 c12e89e0 c12e8bd0 00000000 cff7e000 00000000 cff7ffc8 c012dbac
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c013efb5>] rcu_process_callbacks+0x185/0x230
Mar 25 03:17:21 somewhere kernel:  [<c012dbac>] ksoftirqd+0x8c/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0142aee>] kthread+0x8e/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c012db20>] ksoftirqd+0x0/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0142a60>] kthread+0x0/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: events/0      R running  5728     3      1     4       5     2 (L-TLB)
Mar 25 03:17:21 somewhere kernel: kblockd/0     S CF7EBFD8  5936     4      3             7       (L-TLB)
Mar 25 03:17:21 somewhere kernel: cf7c9f38 00000046 cf7c8000 cf7ebfd8 00000001 00000003 cf7ebfc0 00000086
Mar 25 03:17:21 somewhere kernel:        00000001 cf7c9f38 aab1d69d 000025f2 c4f989e0 c4f98a00 00000e2c aab1d69d
Mar 25 03:17:21 somewhere kernel:        000025f2 cf7ea9e0 cf7eabd0 cf7ebfa0 cf7ebf78 cf7c8000 cf7c9fc8 c013de91
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c013de91>] worker_thread+0x3e1/0x400
Mar 25 03:17:21 somewhere kernel:  [<c0272440>] blk_unplug_work+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0142aee>] kthread+0x8e/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c013dab0>] worker_thread+0x0/0x400
Mar 25 03:17:21 somewhere kernel:  [<c0142a60>] kthread+0x0/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: khubd         S 00000002  7420     5      1             8     3 (L-TLB)
Mar 25 03:17:21 somewhere kernel: cf7abfb0 00000046 cf7abf9c 00000002 00000002 cf25cef8 cf7abfb0 00000202
Mar 25 03:17:21 somewhere kernel:        cf7abfa2 c036c740 45bdeb40 00000246 c12eb9e0 c12eba00 0000d55d 512fc852
Mar 25 03:17:21 somewhere kernel:        00000006 cf7d09e0 cf7d0bd0 cf7aa000 ffffe000 cf7abfc0 cf7abfec c02a2e65
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c02a2e65>] hub_thread+0xc5/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02a2da0>] hub_thread+0x0/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: pdflush       S 00000000  5280     7      3             9     4 (L-TLB)
Mar 25 03:17:21 somewhere kernel: cf725f6c 00000046 00000000 00000000 00000000 00000000 00000000 00000000
Mar 25 03:17:21 somewhere kernel:        00000000 00000000 22bec12b 000025fd c18269e0 c1826a00 00000441 22bec12b
Mar 25 03:17:21 somewhere kernel:        000025fd cf74b9e0 cf74bbd0 cf724000 cf724000 cf725fa8 cf725fa0 c0153704
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0153704>] __pdflush+0x144/0x640
Mar 25 03:17:21 somewhere kernel:  [<c0121951>] __wake_up_common+0x31/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0153c0e>] pdflush+0xe/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0142aee>] kthread+0x8e/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0153c00>] pdflush+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0142a60>] kthread+0x0/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: aio/0         S 00010000  7828     9      3         29338     7 (L-TLB)
Mar 25 03:17:21 somewhere kernel: cf713f38 00000046 00000000 00010000 cf712000 cf73a9e0 00010000 cf713f38
Mar 25 03:17:21 somewhere kernel:        c0139bcb 00000000 cf73a9e0 00000246 cf6f59e0 cf6f5a00 000021f1 110c00c3
Mar 25 03:17:21 somewhere kernel:        00000006 cf73a9e0 cf73abd0 cf73bfa0 cf73bf78 cf712000 cf713fc8 c013de91
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0139bcb>] do_sigaction+0x2cb/0x6b0
Mar 25 03:17:21 somewhere kernel:  [<c013de91>] worker_thread+0x3e1/0x400
Mar 25 03:17:21 somewhere kernel:  [<c0121391>] schedule+0x391/0x8c0
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0142aee>] kthread+0x8e/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c013dab0>] worker_thread+0x0/0x400
Mar 25 03:17:21 somewhere kernel:  [<c0142a60>] kthread+0x0/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kswapd0       S C0372044  4836     8      1            11     5 (L-TLB)
Mar 25 03:17:21 somewhere kernel: cf723f08 00000046 00000102 c0372044 00000001 cf723f08 c015d6c9 00000080
Mar 25 03:17:21 somewhere kernel:        cf723ef8 cf723f20 00000246 00000001 cf723f1c 0000000b 000a1106 e503f378
Mar 25 03:17:21 somewhere kernel:        000025db cf7499e0 cf749bd0 cf722000 c037231c cf723f20 cf723fec c015d7ac
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c015d6c9>] balance_pgdat+0x1b9/0x1e0
Mar 25 03:17:21 somewhere kernel:  [<c015d7ac>] kswapd+0xbc/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0124910>] autoremove_wake_function+0x0/0x40
Mar 25 03:17:21 somewhere kernel:  [<c0109e56>] ret_from_fork+0x6/0x14
Mar 25 03:17:21 somewhere kernel:  [<c0124910>] autoremove_wake_function+0x0/0x40
Mar 25 03:17:21 somewhere kernel:  [<c015d6f0>] kswapd+0x0/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kseriod       S 00000000  7904    11      1            12     8 (L-TLB)
Mar 25 03:17:21 somewhere kernel: cf52ff98 00000046 cf52e000 00000000 cf52ff70 c0133639 00000296 cf52e000
Mar 25 03:17:21 somewhere kernel:        0000000e 0000000f cf52ff98 00000246 cf52ff80 c0129c62 000033fb 4204a06a
Mar 25 03:17:21 somewhere kernel:        00000006 cf2329e0 cf232bd0 cf52e000 ffffe000 cf52ffc0 cf52ffec c02be485
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0133639>] free_uid+0x19/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0129c62>] reparent_to_init+0xe2/0x160
Mar 25 03:17:21 somewhere kernel:  [<c02be485>] serio_thread+0x225/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02be260>] serio_thread+0x0/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kjournald     S CF13BEB4  5612    12      1            32    11 (L-TLB)
Mar 25 03:17:21 somewhere kernel: cf113f30 00000046 c0121951 cf13beb4 00000001 00000003 cf13be9c 00000282
Mar 25 03:17:21 somewhere kernel:        00000001 cf113f30 00000246 00000000 c5a199e0 c5a19a00 00001a2a 61e65848
Mar 25 03:17:21 somewhere kernel:        000025e2 cf1369e0 cf136bd0 cf112000 cf13bdf8 00000001 cf113fec c020764c
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0121951>] __wake_up_common+0x31/0x60
Mar 25 03:17:21 somewhere kernel:  [<c020764c>] kjournald+0x5ac/0x6e0
Mar 25 03:17:21 somewhere kernel:  [<c0124910>] autoremove_wake_function+0x0/0x40
Mar 25 03:17:21 somewhere kernel:  [<c0124910>] autoremove_wake_function+0x0/0x40
Mar 25 03:17:21 somewhere kernel:  [<c0207080>] commit_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02070a0>] kjournald+0x0/0x6e0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kjournald     S CEB18EB4  6432    32      1            33    12 (L-TLB)
Mar 25 03:17:21 somewhere kernel: ceb3df30 00000046 c14e9b1c ceb18eb4 00000001 00000003 ceb18e9c 00000282
Mar 25 03:17:21 somewhere kernel:        00000001 ceb3df30 00000246 00000000 c5a199e0 c5a19a00 00001ba9 b4e865a9
Mar 25 03:17:21 somewhere kernel:        000025e4 cec119e0 cec11bd0 ceb3c000 ceb18df8 00000001 ceb3dfec c020764c
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c020764c>] kjournald+0x5ac/0x6e0
Mar 25 03:17:21 somewhere kernel:  [<c0124910>] autoremove_wake_function+0x0/0x40
Mar 25 03:17:21 somewhere kernel:  [<c0124910>] autoremove_wake_function+0x0/0x40
Mar 25 03:17:21 somewhere kernel:  [<c0207080>] commit_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02070a0>] kjournald+0x0/0x6e0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kjournald     S CEB16EB4  6356    33      1            72    32 (L-TLB)
Mar 25 03:17:21 somewhere kernel: ceabdf30 00000046 c0121951 ceb16eb4 00000001 00000003 ceb16e9c 00000282
Mar 25 03:17:21 somewhere kernel:        00000001 ceabdf30 00000246 00000000 c5a199e0 c5a19a00 000004a4 af8846b2
Mar 25 03:17:21 somewhere kernel:        000025ea ceb249e0 ceb24bd0 ceabc000 ceb16df8 00000001 ceabdfec c020764c
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0121951>] __wake_up_common+0x31/0x60
Mar 25 03:17:21 somewhere kernel:  [<c020764c>] kjournald+0x5ac/0x6e0
Mar 25 03:17:21 somewhere kernel:  [<c0124910>] autoremove_wake_function+0x0/0x40
Mar 25 03:17:21 somewhere kernel:  [<c0124910>] autoremove_wake_function+0x0/0x40
Mar 25 03:17:21 somewhere kernel:  [<c0207080>] commit_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02070a0>] kjournald+0x0/0x6e0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: syslogd       S 00000163  5860    72      1            75    33 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cedd3e78 00000086 00000296 00000163 00000001 00000001 000000ef c109a3f8
Mar 25 03:17:21 somewhere kernel:        cedd3e4c c011fe26 c0372044 cedd3e94 c5a199e0 c5a19a00 00001f3a 00436372
Mar 25 03:17:21 somewhere kernel:        000025fd ceef09e0 ceef0bd0 00000000 7fffffff 00000001 cedd3ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c02ce285>] datagram_poll+0x15/0xd0
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c0109b3d>] handle_signal+0x14d/0x2e0
Mar 25 03:17:21 somewhere kernel:  [<c025bc90>] write_chan+0x0/0x210
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: klogd         R running  6672    75      1           102    72 (NOTLB)
Mar 25 03:17:21 somewhere kernel: dhcpcd        S CEB39080  6436   102      1           202    75 (NOTLB)
Mar 25 03:17:21 somewhere kernel: ce827f34 00000086 cdfa912c ceb39080 00000000 00000000 ce827f48 ce827f34
Mar 25 03:17:21 somewhere kernel:        00000246 ceb3ad50 ceb3ad70 ced01c00 c155c9e0 c155ca00 001ee543 17c3ef0b
Mar 25 03:17:21 somewhere kernel:        0000002b ce8469e0 ce846bd0 02913c54 ce827f48 029347a9 ce827f90 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0138313>] sigprocmask+0xf3/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0138558>] sys_rt_sigprocmask+0x98/0x300
Mar 25 03:17:21 somewhere kernel:  [<c013328f>] sys_nanosleep+0xff/0x1b0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: bash          S CF04DFB4  6156   202      1 23003     205   102 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cf04df58 00000086 cf1103fc cf04dfb4 c011ec2c 00000001 000003fc 00000001
Mar 25 03:17:21 somewhere kernel:        0810ea88 cf0719e0 00000282 00000246 00000000 cf04dfa8 000049d8 936b9786
Mar 25 03:17:21 somewhere kernel:        000002bb cf0719e0 cf071bd0 fffffe00 cf04c000 cf071a88 cf04dfbc c012c4e1
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011ec2c>] do_page_fault+0x31c/0x531
Mar 25 03:17:21 somewhere kernel:  [<c012c4e1>] sys_wait4+0x171/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: agetty        S C5A6CD68  6728   205      1           206   202 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c5ba7e20 00000086 c5ba7de4 c5a6cd68 00000000 c5ba7e50 00000286 010000f0
Mar 25 03:17:21 somewhere kernel:        c5a9ddf8 00000246 00000003 0000000a c5b769e0 c5b76a00 000d9b44 5eb35524
Mar 25 03:17:21 somewhere kernel:        0000000c c5bcb9e0 c5bcbbd0 c5a9f000 7fffffff c5ba7f04 c5ba7e7c c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c02668d9>] do_con_write+0x2b9/0x720
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c025bada>] read_chan+0xd5a/0xf10
Mar 25 03:17:21 somewhere kernel:  [<c02672d4>] con_write+0x24/0x30
Mar 25 03:17:21 somewhere kernel:  [<c025bdee>] write_chan+0x15e/0x210
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c015ab24>] __pagevec_lru_add_active+0x1b4/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02535cc>] tty_read+0x20c/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0164c61>] unmap_vma_list+0x11/0x20
Mar 25 03:17:21 somewhere kernel:  [<c0175992>] vfs_read+0xa2/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: agetty        S C5A68D68  6732   206      1           207   205 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c5b6de20 00000086 00001000 c5a68d68 00000000 c5b6de50 00000286 01000001
Mar 25 03:17:21 somewhere kernel:        c5a98df8 00000246 00000004 0000000a c5bcb9e0 c5bcba00 00002867 5ea5b9e0
Mar 25 03:17:21 somewhere kernel:        0000000c cead59e0 cead5bd0 c5a9a000 7fffffff c5b6df04 c5b6de7c c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c02668d9>] do_con_write+0x2b9/0x720
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c025bada>] read_chan+0xd5a/0xf10
Mar 25 03:17:21 somewhere kernel:  [<c02672d4>] con_write+0x24/0x30
Mar 25 03:17:21 somewhere kernel:  [<c025bdee>] write_chan+0x15e/0x210
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0132cc2>] run_timer_softirq+0x302/0x410
Mar 25 03:17:21 somewhere kernel:  [<c02535cc>] tty_read+0x20c/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0175992>] vfs_read+0xa2/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: agetty        S C5A64D68  6672   207      1         22945   206 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c5ae9e20 00000086 00001000 c5a64d68 00000000 c5ae9e50 00000286 01000001
Mar 25 03:17:21 somewhere kernel:        c5a93df8 00000246 00000005 0000000a cead59e0 cead5a00 000e4b46 5e8aaee4
Mar 25 03:17:21 somewhere kernel:        0000000c c99079e0 c9907bd0 c5a95000 7fffffff c5ae9f04 c5ae9e7c c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c02668d9>] do_con_write+0x2b9/0x720
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c025bada>] read_chan+0xd5a/0xf10
Mar 25 03:17:21 somewhere kernel:  [<c02672d4>] con_write+0x24/0x30
Mar 25 03:17:21 somewhere kernel:  [<c025bdee>] write_chan+0x15e/0x210
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c015ab24>] __pagevec_lru_add_active+0x1b4/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02535cc>] tty_read+0x20c/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0164c61>] unmap_vma_list+0x11/0x20
Mar 25 03:17:21 somewhere kernel:  [<c0175992>] vfs_read+0xa2/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: agetty        S 00000000  6356 22945      1         22946   207 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c5b09e20 00000086 00000007 00000000 c03a9f01 c12a1a60 00000286 c042bda0
Mar 25 03:17:21 somewhere kernel:        c5ae1df8 00000088 c042cf40 c5b09e80 c02954df 00000720 00495d2f e591c467
Mar 25 03:17:21 somewhere kernel:        000002a7 c5b639e0 c5b63bd0 c5ae3000 7fffffff c5b09f04 c5b09e7c c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c02954df>] fbcon_cursor+0x26f/0x380
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c025bada>] read_chan+0xd5a/0xf10
Mar 25 03:17:21 somewhere kernel:  [<c02672d4>] con_write+0x24/0x30
Mar 25 03:17:21 somewhere kernel:  [<c025bdee>] write_chan+0x15e/0x210
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c015ab24>] __pagevec_lru_add_active+0x1b4/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02535cc>] tty_read+0x20c/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0164c61>] unmap_vma_list+0x11/0x20
Mar 25 03:17:21 somewhere kernel:  [<c0175992>] vfs_read+0xa2/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: agetty        S 00000000  6672 22946      1         23024 22945 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c5b43e20 00000086 00000007 00000000 c03a9f01 c12a0a30 00000286 c042bde0
Mar 25 03:17:21 somewhere kernel:        c5aa2df8 00000088 c042cf40 c5b43e80 c02954df 00000720 0049b609 c6c5d372
Mar 25 03:17:21 somewhere kernel:        000002aa c5b769e0 c5b76bd0 c5aa4000 7fffffff c5b43f04 c5b43e7c c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c02954df>] fbcon_cursor+0x26f/0x380
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c025bada>] read_chan+0xd5a/0xf10
Mar 25 03:17:21 somewhere kernel:  [<c02672d4>] con_write+0x24/0x30
Mar 25 03:17:21 somewhere kernel:  [<c025bdee>] write_chan+0x15e/0x210
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c015ab24>] __pagevec_lru_add_active+0x1b4/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02535cc>] tty_read+0x20c/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0164c61>] unmap_vma_list+0x11/0x20
Mar 25 03:17:21 somewhere kernel:  [<c0175992>] vfs_read+0xa2/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: startx        S CEDD1FB4  6224 23003    202 23014               (NOTLB)
Mar 25 03:17:21 somewhere kernel: cedd1f58 00000086 c77dece4 cedd1fb4 c011ec2c 00000001 000002b2 00000001
Mar 25 03:17:21 somewhere kernel:        080e2b88 ceac09e0 00000282 00000246 00000000 cedd1fa8 0001a656 a1a54a6e
Mar 25 03:17:21 somewhere kernel:        000002bb ceac09e0 ceac0bd0 fffffe00 cedd0000 ceac0a88 cedd1fbc c012c4e1
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011ec2c>] do_page_fault+0x31c/0x531
Mar 25 03:17:21 somewhere kernel:  [<c012c4e1>] sys_wait4+0x171/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: xinit         S 00000001  6356 23014  23003 23015               (NOTLB)
Mar 25 03:17:21 somewhere kernel: ceb11f58 00000086 bffff4e0 00000001 ceaa29e0 c0121910 00100100 00200200
Mar 25 03:17:21 somewhere kernel:        000003a5 ceb10000 00000282 00000246 c5c2b9e0 c5c2ba00 0000233e b5367fba
Mar 25 03:17:21 somewhere kernel:        000002bc ceaa29e0 ceaa2bd0 fffffe00 ceb10000 ceaa2a88 ceb11fbc c012c4e1
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c012c4e1>] sys_wait4+0x171/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0107b3d>] sys_vfork+0x2d/0x30
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: X             R running  5360 23015  23014         23037       (NOTLB)
Mar 25 03:17:21 somewhere kernel: msp3410 [auto S 00005F25  7868 23024      1         23055 22946 (L-TLB)
Mar 25 03:17:21 somewhere kernel: c1431f6c 00000046 00005f25 00005f25 c1431f3c c01284af 34f115ec 00005f25
Mar 25 03:17:21 somewhere kernel:        00005f25 c1430000 c1431f74 00000246 c0121391 c040bbdf 00002823 165f5fd8
Mar 25 03:17:21 somewhere kernel:        000002bc cb5589e0 cb558bd0 c5721df8 c5721f64 ffffffff c1431fc4 d18720e2
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01284af>] call_console_drivers+0x7f/0x100
Mar 25 03:17:21 somewhere kernel:  [<c0121391>] schedule+0x391/0x8c0
Mar 25 03:17:21 somewhere kernel:  [<d18720e2>] msp34xx_sleep+0xc2/0xd0 [msp3400]
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c012a274>] daemonize+0xa4/0xb0
Mar 25 03:17:21 somewhere kernel:  [<d187276c>] msp3410d_thread+0x4c/0x520 [msp3400]
Mar 25 03:17:21 somewhere kernel:  [<d1872720>] msp3410d_thread+0x0/0x520 [msp3400]
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: xinitrc       S CEAA9FB4  6356 23037  23014 23039         23015 (NOTLB)
Mar 25 03:17:21 somewhere kernel: ceaa9f58 00000086 c77de280 ceaa9fb4 c011ec2c 00000001 0000032c 00000001
Mar 25 03:17:21 somewhere kernel:        0810a4f8 c5c2b9e0 00000282 00000246 00000000 ceaa9fa8 00013d1b b892c804
Mar 25 03:17:21 somewhere kernel:        000002bc c5c2b9e0 c5c2bbd0 fffffe00 ceaa8000 c5c2ba88 ceaa9fbc c012c4e1
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011ec2c>] do_page_fault+0x31c/0x531
Mar 25 03:17:21 somewhere kernel:  [<c012c4e1>] sys_wait4+0x171/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: startkde      S CF03DFB4  6356 23039  23037 23091               (NOTLB)
Mar 25 03:17:21 somewhere kernel: cf03df58 00000086 c5a22448 cf03dfb4 c011ec2c 00000001 00000395 00000001
Mar 25 03:17:21 somewhere kernel:        080e2b88 c82a19e0 00000282 00000246 cdbac9e0 cdbaca00 0001af41 ce79c29b
Mar 25 03:17:21 somewhere kernel:        000002bf c82a19e0 c82a1bd0 fffffe00 cf03c000 c82a1a88 cf03dfbc c012c4e1
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011ec2c>] do_page_fault+0x31c/0x531
Mar 25 03:17:21 somewhere kernel:  [<c012c4e1>] sys_wait4+0x171/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00200282  6272 23052      1 23057   23093 23090 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c5a13e78 00200086 c6573f50 00200282 00000163 00000001 00000001 000000ef
Mar 25 03:17:21 somewhere kernel:        c112d6a8 c557f9e0 f900bc74 000025f0 c9ea59e0 c9ea5a00 00000365 f903af55
Mar 25 03:17:21 somewhere kernel:        000025f0 c90969e0 c9096bd0 00000000 7fffffff 0000000a c5a13ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5952 23055      1         23060 23024 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c811be78 00200086 00200296 00000163 00000001 00000001 000000ef c10dc910
Mar 25 03:17:21 somewhere kernel:        c811be4c c90969e0 f8f14a5c 000025f0 c5a199e0 c5a19a00 000008b2 f903fd97
Mar 25 03:17:21 somewhere kernel:        000025f0 c9ea59e0 c9ea5bd0 00000000 7fffffff 00000020 c811bed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c02ca6f6>] sk_free+0x66/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0174cef>] filp_close+0x4f/0x80
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  6272 23057  23052         23076       (NOTLB)
Mar 25 03:17:21 somewhere kernel: c9547e78 00200086 00200296 00000163 00000001 00000000 c9547e8c c9547e78
Mar 25 03:17:21 somewhere kernel:        00200246 c011fe26 c0372044 c9547e94 c5a199e0 c5a19a00 00000f6c 9b01f587
Mar 25 03:17:21 somewhere kernel:        000025fc c557f9e0 c557fbd0 02791075 c9547e8c 0000002b c9547ed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5468 23060      1         23090 23055 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c5031e78 00200086 00200296 00000163 00000001 00000000 c5031e8c c5031e78
Mar 25 03:17:21 somewhere kernel:        00200246 c011fe26 c0372044 c5031e94 c5a199e0 c5a19a00 000016ed 2bf8b6d6
Mar 25 03:17:21 somewhere kernel:        000025fe c4f989e0 c4f98bd0 027903e3 c5031e8c 0000000f c5031ed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: artsd         S 00000282  5872 23076  23052         23094 23057 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c37bbe78 00000086 d1851000 00000282 00000163 00000000 c37bbe8c c37bbe78
Mar 25 03:17:21 somewhere kernel:        00000246 c37bbe50 c011fe26 c0372044 c5a199e0 c5a19a00 00002092 20c68f5b
Mar 25 03:17:21 somewhere kernel:        000025fe c40739e0 c4073bd0 027903bd c37bbe8c 0000000c c37bbed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c0109b3d>] handle_signal+0x14d/0x2e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5892 23090      1         23052 23060 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cde25e78 00000086 00000296 00000163 00000001 00000000 cde25e8c cde25e78
Mar 25 03:17:21 somewhere kernel:        00000246 c011fe26 c0372044 cde25e94 c5a199e0 c5a19a00 000010cf 2a3e4af4
Mar 25 03:17:21 somewhere kernel:        000025fe cdbac9e0 cdbacbd0 027903c6 cde25e8c 0000000e cde25ed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kwrapper      S 00000076  6356 23091  23039                     (NOTLB)
Mar 25 03:17:21 somewhere kernel: c973bf34 00000086 00000072 00000076 045c9228 00000000 c973bf48 c973bf34
Mar 25 03:17:21 somewhere kernel:        00000246 c5a199e0 27225f8a c973bf38 c5a199e0 c5a19a00 000007b4 ffc66ea5
Mar 25 03:17:21 somewhere kernel:        000025fd c1a119e0 c1a11bd0 027904b5 c973bf48 000003ea c973bf90 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0138313>] sigprocmask+0xf3/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0138558>] sys_rt_sigprocmask+0x98/0x300
Mar 25 03:17:21 somewhere kernel:  [<c010c96e>] do_IRQ+0x23e/0x380
Mar 25 03:17:21 somewhere kernel:  [<c013328f>] sys_nanosleep+0xff/0x1b0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  6296 23093      1         23096 23052 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c5591e78 00200086 00200296 00000163 00000001 00000001 000000ef c11f5518
Mar 25 03:17:21 somewhere kernel:        c5591e4c c011fe26 c0372044 c5591e94 c7cbf9e0 c7cbfa00 00005bc9 32209b9b
Mar 25 03:17:21 somewhere kernel:        000025dc c3f019e0 c3f01bd0 00000000 7fffffff 00000014 c5591ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5620 23094  23052         23099 23076 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c9d15e78 00200086 00200296 00000163 00000001 00000000 c9d15e8c c9d15e78
Mar 25 03:17:21 somewhere kernel:        00200246 c011fe26 c0372044 c9d15e94 c5a199e0 c5a19a00 00001abd 2ab8ac9f
Mar 25 03:17:21 somewhere kernel:        000025fe c7cbf9e0 c7cbfbd0 027903ce c9d15e8c 0000000b c9d15ed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5912 23096      1         23102 23093 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c6b5be78 00000086 00000296 00000163 00000001 00000001 000000ef c1156418
Mar 25 03:17:21 somewhere kernel:        c6b5be4c c011fe26 f65097d6 000025db cb09e9e0 cb09ea00 000055f2 f66a1143
Mar 25 03:17:21 somewhere kernel:        000025db c361f9e0 c361fbd0 00000000 7fffffff 00000005 c6b5bed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5324 23098      1         23106 23102 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cde79e78 00200086 00200296 00000163 00000001 00000001 000000ef c1228ff8
Mar 25 03:17:21 somewhere kernel:        cde79e4c c011fe26 f651935f 000025db c26e39e0 c26e3a00 00004afa f66cff0d
Mar 25 03:17:21 somewhere kernel:        000025db cb09e9e0 cb09ebd0 00000000 7fffffff 00000005 cde79ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  6012 23099  23052         23113 23094 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c2c67e78 00200086 00200296 00000163 00000001 00000001 000000ef c118dff8
Mar 25 03:17:21 somewhere kernel:        c2c67e4c c67389e0 b87a634c 000025d2 c557f9e0 c557fa00 000000b0 b882fec9
Mar 25 03:17:21 somewhere kernel:        000025d2 cde149e0 cde14bd0 00000000 7fffffff 00000004 c2c67ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kweatherservi S 00000163  6028 23102      1         23098 23096 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cc3a5e78 00000086 00000296 00000163 00000001 00000000 cc3a5e8c cc3a5e78
Mar 25 03:17:21 somewhere kernel:        00000246 c011fe26 c0372044 cc3a5e94 c5a199e0 c5a19a00 00001852 2aa95234
Mar 25 03:17:21 somewhere kernel:        000025fe c26e39e0 c26e3bd0 027903cd cc3a5e8c 00000009 cc3a5ed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c01881e2>] pipe_poll+0x32/0x80
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c010c96e>] do_IRQ+0x23e/0x380
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  6040 23106      1         23112 23098 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cb7dde78 00200086 00200296 00000163 00000001 00000000 cb7dde8c cb7dde78
Mar 25 03:17:21 somewhere kernel:        00200246 c011fe26 c0372044 cb7dde94 c5a199e0 c5a19a00 00000e46 2b50a745
Mar 25 03:17:21 somewhere kernel:        000025fe c360e9e0 c360ebd0 027903d8 cb7dde8c 00000009 cb7dded4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c01881e2>] pipe_poll+0x32/0x80
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<d18495cf>] rtl8139_poll+0x10f/0x270 [8139too]
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5740 23112      1         23187 23106 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c1c3fe78 00200086 00200296 00000163 00000001 00000000 c1c3fe8c c1c3fe78
Mar 25 03:17:21 somewhere kernel:        00200246 c011fe26 c0372044 c1c3fe94 c5a199e0 c5a19a00 000017a0 2bda3fc4
Mar 25 03:17:21 somewhere kernel:        000025fe c18269e0 c1826bd0 027903e1 c1c3fe8c 00000009 c1c3fed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c01881e2>] pipe_poll+0x32/0x80
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5604 23113  23052 23114   23173 23099 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cb7b5e78 00200086 00200296 00000163 00000001 00000000 cb7b5e8c cb7b5e78
Mar 25 03:17:21 somewhere kernel:        00200246 c011fe26 c0372044 cb7b5e94 c5a199e0 c5a19a00 00001101 2c16f87f
Mar 25 03:17:21 somewhere kernel:        000025fe cb1dc9e0 cb1dcbd0 027903df cb7b5e8c 00000010 cb7b5ed4 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c012cc84>] sys_gettimeofday+0x54/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: bash          S C365BFB4  6296 23114  23113 23149   23150       (NOTLB)
Mar 25 03:17:21 somewhere kernel: c365bf58 00200086 cf143954 c365bfb4 c011ec2c 00000001 000003fc 00000001
Mar 25 03:17:21 somewhere kernel:        08113248 c44859e0 00200282 00200246 c173d9e0 c173da00 0000c5e3 87c4aabf
Mar 25 03:17:21 somewhere kernel:        000002c4 c44859e0 c4485bd0 fffffe00 c365a000 c4485a88 c365bfbc c012c4e1
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011ec2c>] do_page_fault+0x31c/0x531
Mar 25 03:17:21 somewhere kernel:  [<c012c4e1>] sys_wait4+0x171/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: ssh           S 000000EF  5704 23149  23114                     (NOTLB)
Mar 25 03:17:21 somewhere kernel: c3b6fe78 00200086 00000001 000000ef c106fa18 c3b6fe40 c011fe26 c0372044
Mar 25 03:17:21 somewhere kernel:        c3b6fe88 cb1dc9e0 2b73e9a7 000025fe c5a199e0 c5a19a00 000000f0 2b761784
Mar 25 03:17:21 somewhere kernel:        000025fe c173d9e0 c173dbd0 00000000 7fffffff 00000005 c3b6fed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c025ce34>] pty_write_room+0x24/0x30
Mar 25 03:17:21 somewhere kernel:  [<c025bf9c>] normal_poll+0xfc/0x140
Mar 25 03:17:21 somewhere kernel:  [<c025bea0>] normal_poll+0x0/0x140
Mar 25 03:17:21 somewhere kernel:  [<c025543e>] tty_poll+0x6e/0x80
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: bash          S C71E6448  6384 23150  23113         29909 23114 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c1b6fe20 00200086 ce8fcd70 c71e6448 c1b6fe80 c011ec2c 00000001 c0168577
Mar 25 03:17:21 somewhere kernel:        00000001 bfffef64 22d8ef95 000024a3 c66009e0 c6600a00 0000d1c2 22d8ef95
Mar 25 03:17:21 somewhere kernel:        000024a3 c6a4b9e0 c6a4bbd0 c85fb000 7fffffff c1b6ff04 c1b6fe7c c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011ec2c>] do_page_fault+0x31c/0x531
Mar 25 03:17:21 somewhere kernel:  [<c0168577>] pte_chain_alloc+0x57/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0257fc9>] opost_block+0x109/0x1d0
Mar 25 03:17:21 somewhere kernel:  [<c025bada>] read_chan+0xd5a/0xf10
Mar 25 03:17:21 somewhere kernel:  [<c014c724>] unlock_page+0x14/0x50
Mar 25 03:17:21 somewhere kernel:  [<c0160f64>] do_wp_page+0x434/0x5b0
Mar 25 03:17:21 somewhere kernel:  [<c025bdee>] write_chan+0x15e/0x210
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c02535cc>] tty_read+0x20c/0x280
Mar 25 03:17:21 somewhere kernel:  [<c0175992>] vfs_read+0xa2/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: run-mozilla.s S C1E25FB4  6288 23173  23052 23180   24578 23113 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c1e25f58 00200086 c71e6a38 c1e25fb4 c011ec2c 00000001 000002a5 00000001
Mar 25 03:17:21 somewhere kernel:        080e2c3c cb46c9e0 00200282 00200246 00030002 c1e25fa8 00019da3 64a780e9
Mar 25 03:17:21 somewhere kernel:        000002cc cb46c9e0 cb46cbd0 fffffe00 c1e24000 cb46ca88 c1e25fbc c012c4e1
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011ec2c>] do_page_fault+0x31c/0x531
Mar 25 03:17:21 somewhere kernel:  [<c012c4e1>] sys_wait4+0x171/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: mozilla-bin   S 00000163  5504 23180  23173 23184               (NOTLB)
Mar 25 03:17:21 somewhere kernel: caffde78 00200086 00200296 00000163 00000001 00000001 000000ef c118f290
Mar 25 03:17:21 somewhere kernel:        caffde4c c011fe26 f760badb 000025db cb1dc9e0 cb1dca00 0004347a f848f42e
Mar 25 03:17:21 somewhere kernel:        000025db c57169e0 c5716bd0 00000000 7fffffff 00000004 caffded4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175bcf>] sys_read+0x4f/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: mozilla-bin   S C0372044  6108 23184  23180 23185   23193       (NOTLB)
Mar 25 03:17:21 somewhere kernel: c204feec 00200086 c011fe26 c0372044 c204feec 00000000 c204ff00 c204feec
Mar 25 03:17:21 somewhere kernel:        00200246 c5a199e0 9cc8d043 00000000 c5a199e0 c5a19a00 00000957 b777f8dc
Mar 25 03:17:21 somewhere kernel:        000025fd c70f39e0 c70f3bd0 027903de c204ff00 000007d1 c204ff48 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018fdc1>] do_poll+0x91/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c018ff51>] sys_poll+0x171/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: mozilla-bin   S C0372044  5320 23185  23184         23188       (NOTLB)
Mar 25 03:17:21 somewhere kernel: c7fd3eec 00200086 c011fe26 c0372044 c7fd3eec c0151a5f c002e810 cba04000
Mar 25 03:17:21 somewhere kernel:        00000000 c5a199e0 bcf0f1e7 00000000 c2eb59e0 c2eb5a00 00000f22 0381d1f3
Mar 25 03:17:21 somewhere kernel:        000025d9 c845b9e0 c845bbd0 00000000 7fffffff 7fffffff c7fd3f48 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0151a5f>] __alloc_pages+0x2df/0x340
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c01881e2>] pipe_poll+0x32/0x80
Mar 25 03:17:21 somewhere kernel:  [<c018fcec>] do_pollfd+0x5c/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c018fdc1>] do_poll+0x91/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c018ff51>] sys_poll+0x171/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: gconfd-2      S C0372044  5896 23187      1         23209 23112 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cc063eec 00200086 c011fe26 c0372044 cc063eec 00000000 cc063f00 cc063eec
Mar 25 03:17:21 somewhere kernel:        00200246 c5a199e0 319a8a87 000025fa c18269e0 c1826a00 00001990 319a8a87
Mar 25 03:17:21 somewhere kernel:        000025fa c43c09e0 c43c0bd0 0279ad0a cc063f00 0000ec23 cc063f48 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018fdc1>] do_poll+0x91/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c018ff51>] sys_poll+0x171/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: mozilla-bin   S 00030002  5904 23188  23184               23185 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c85ddf7c 00200086 c85dc000 00030002 c85ddfa8 c85ddf78 c0138313 c5dafebc
Mar 25 03:17:21 somewhere kernel:        00000000 00100100 00200200 0276f85e c5a199e0 c5a19a00 00000cfa 01db80bb
Mar 25 03:17:21 somewhere kernel:        000025df c7ef29e0 c7ef2bd0 c85ddfa8 00000000 c85dc000 c85ddfbc c0108c4d
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0138313>] sigprocmask+0xf3/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c0108c4d>] sys_rt_sigsuspend+0x1cd/0x2c0
Mar 25 03:17:21 somewhere kernel:  [<c0175b45>] vfs_write+0xb5/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0111cdc>] do_gettimeofday+0x1c/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: netstat       Z CFFE9B40  5896 23193  23180               23184 (L-TLB)
Mar 25 03:17:21 somewhere kernel: c7781f54 00200046 00000000 cffe9b40 00000000 00010c00 cffe9a80 00000000
Mar 25 03:17:21 somewhere kernel:        c7781f54 00200286 cda53d70 ca08ea38 c0194a3e ca08ea88 0001e915 414e4c3c
Mar 25 03:17:21 somewhere kernel:        000002d0 ca08e9e0 ca08ebd0 cffba448 ca08e9e0 cda53d70 c7781f88 c012b828
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0194a3e>] dput+0x1e/0x6f0
Mar 25 03:17:21 somewhere kernel:  [<c012b828>] do_exit+0x548/0x980
Mar 25 03:17:21 somewhere kernel:  [<c0164c61>] unmap_vma_list+0x11/0x20
Mar 25 03:17:21 somewhere kernel:  [<c012bd13>] do_group_exit+0x43/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: esd           S 00000163  5940 23209      1               23187 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c8027e78 00200086 00200296 00000163 00000001 00000001 000000ef c113d530
Mar 25 03:17:21 somewhere kernel:        c8027e4c c011fe26 c0372044 c8027e94 c0151a5f 00000000 000019cb 6cefc666
Mar 25 03:17:21 somewhere kernel:        000025b0 c8ed69e0 c8ed6bd0 00000000 7fffffff 00000038 c8027ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c0151a5f>] __alloc_pages+0x2df/0x340
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5760 24578  23052         29212 23173 (NOTLB)
Mar 25 03:17:21 somewhere kernel: ce17fe78 00200086 00200296 00000163 00000001 00000001 000000ef c1126830
Mar 25 03:17:21 somewhere kernel:        ce17fe4c c011fe26 32d31518 000025dc c9ea59e0 c9ea5a00 00007b74 3459e5a4
Mar 25 03:17:21 somewhere kernel:        000025dc c2eb59e0 c2eb5bd0 00000000 7fffffff 00000004 ce17fed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c02c7bf8>] sock_writev+0x38/0x40
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0176125>] sys_writev+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: xchat         S CAC73EE8  5872 29212  23052         29854 24578 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cac73eec 00000086 c0372044 cac73ee8 c0151a5f 00000000 cac73f00 cac73eec
Mar 25 03:17:21 somewhere kernel:        00000246 c5a199e0 00000000 00000000 c5a199e0 c5a19a00 000020b2 2b8e5c95
Mar 25 03:17:21 somewhere kernel:        000025fe c55729e0 c5572bd0 02790408 cac73f00 0000005e cac73f48 c0133065
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0151a5f>] __alloc_pages+0x2df/0x340
Mar 25 03:17:21 somewhere kernel:  [<c0133065>] schedule_timeout+0x85/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0132fd0>] process_timeout+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018fdc1>] do_poll+0x91/0xb0
Mar 25 03:17:21 somewhere kernel:  [<c018ff51>] sys_poll+0x171/0x2a0
Mar 25 03:17:21 somewhere kernel:  [<c018ea44>] sys_ioctl+0x194/0x3d0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: pdflush       S CCF0D9E0  6060 29338      3                   9 (L-TLB)
Mar 25 03:17:21 somewhere kernel: caeebf6c 00000046 00000000 ccf0d9e0 00000007 caeebf6c 00000286 c033429c
Mar 25 03:17:21 somewhere kernel:        c03363b1 0000075e ba4e3565 0000215b ccf0d9e0 ccf0da00 000000e3 ba4e38b9
Mar 25 03:17:21 somewhere kernel:        0000215b ca24f9e0 ca24fbd0 caeea000 caeea000 caeebfa8 caeebfa0 c0153704
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0153704>] __pdflush+0x144/0x640
Mar 25 03:17:21 somewhere kernel:  [<c0121951>] __wake_up_common+0x31/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0153c0e>] pdflush+0xe/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0142aee>] kthread+0x8e/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0153c00>] pdflush+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0142a60>] kthread+0x0/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c0107289>] kernel_thread_helper+0x5/0xc
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5212 29854  23052         29859 29212 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c7fdbe78 00200086 00200296 00000163 00000001 00000001 000000ef c118d418
Mar 25 03:17:21 somewhere kernel:        c7fdbe4c c4fea9e0 34979de1 000025dc c55529e0 c5552a00 000002e9 35cd7731
Mar 25 03:17:21 somewhere kernel:        000025dc cbb4f9e0 cbb4fbd0 00000000 7fffffff 00000004 c7fdbed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5700 29859  23052         29860 29854 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c6f33e78 00200086 00200296 00000163 00000001 00000001 000000ef c11519b8
Mar 25 03:17:21 somewhere kernel:        c6f33e4c c011fe26 34749134 000025dc c4fea9e0 c4feaa00 0000357c 35cd3cfe
Mar 25 03:17:21 somewhere kernel:        000025dc c85e09e0 c85e0bd0 00000000 7fffffff 00000004 c6f33ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  6092 29860  23052         29861 29859 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c9ba5e78 00200086 00200296 00000163 00000001 00000001 000000ef c1227270
Mar 25 03:17:21 somewhere kernel:        c9ba5e4c c85e09e0 34799d38 000025dc cbb4f9e0 cbb4fa00 0000038d 35cd5cfa
Mar 25 03:17:21 somewhere kernel:        000025dc c4fea9e0 c4feabd0 00000000 7fffffff 00000004 c9ba5ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5512 29861  23052         29862 29860 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c24b1e78 00200086 00200296 00000163 00000001 00000001 000000ef c1118500
Mar 25 03:17:21 somewhere kernel:        c24b1e4c c2eb59e0 321b35eb 000025dc c2eb59e0 c2eb5a00 00000249 341733c3
Mar 25 03:17:21 somewhere kernel:        000025dc ca2869e0 ca286bd0 00000000 7fffffff 00000004 c24b1ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5432 29862  23052         29896 29861 (NOTLB)
Mar 25 03:17:21 somewhere kernel: ce935e78 00200086 00200296 00000163 00000001 00000001 000000ef c11b4158
Mar 25 03:17:21 somewhere kernel:        ce935e4c c011fe26 340f9689 000025dc cdbac9e0 cdbaca00 00033c7b 340f9689
Mar 25 03:17:21 somewhere kernel:        000025dc c80479e0 c8047bd0 00000000 7fffffff 00000004 ce935ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011fe26>] kernel_map_pages+0x16/0x70
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5532 29896  23052         29900 29862 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c312de78 00200086 00200296 00000163 00000001 00000001 000000ef c123d138
Mar 25 03:17:21 somewhere kernel:        c312de4c c2eb59e0 080952b6 000025dc c2eb59e0 c2eb5a00 0000021c 34125399
Mar 25 03:17:21 somewhere kernel:        000025dc c7f109e0 c7f10bd0 00000000 7fffffff 00000004 c312ded4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: kdeinit       S 00000163  5608 29900  23052               29896 (NOTLB)
Mar 25 03:17:21 somewhere kernel: cc7b9e78 00200086 00200296 00000163 00000001 00000001 000000ef c10f7800
Mar 25 03:17:21 somewhere kernel:        cc7b9e4c cbb4f9e0 c0372044 cc7b9e94 c9ea59e0 c9ea5a00 00000291 35cd8e51
Mar 25 03:17:21 somewhere kernel:        000025dc c55529e0 c5552bd0 00000000 7fffffff 00000004 cc7b9ed4 c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0151ae2>] __get_free_pages+0x22/0x50
Mar 25 03:17:21 somewhere kernel:  [<c018f2e9>] __pollwait+0x79/0xc0
Mar 25 03:17:21 somewhere kernel:  [<d1894ae5>] unix_poll+0x15/0x90 [unix]
Mar 25 03:17:21 somewhere kernel:  [<c018f648>] do_select+0x238/0x3e0
Mar 25 03:17:21 somewhere kernel:  [<c018f270>] __pollwait+0x0/0xc0
Mar 25 03:17:21 somewhere kernel:  [<c018faa3>] sys_select+0x283/0x470
Mar 25 03:17:21 somewhere kernel:  [<c0175c15>] sys_write+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: bash          S C67B3FB4  6612 29909  23113 29945         23150 (NOTLB)
Mar 25 03:17:21 somewhere kernel: c67b3f58 00200086 c8840c4c c67b3fb4 c011ec2c 00000001 000003fc 00000001
Mar 25 03:17:21 somewhere kernel:        0810bf18 caba69e0 6e460dbe 000025ca c173d9e0 c173da00 0000254c 6e460dbe
Mar 25 03:17:21 somewhere kernel:        000025ca caba69e0 caba6bd0 fffffe00 c67b2000 caba6a88 c67b3fbc c012c4e1
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c011ec2c>] do_page_fault+0x31c/0x531
Mar 25 03:17:21 somewhere kernel:  [<c012c4e1>] sys_wait4+0x171/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: lynx          S 6B80AD9C  6216 29945  29909 29947               (NOTLB)
Mar 25 03:17:21 somewhere kernel: c8f6fe20 00200086 00200086 6b80ad9c 00973e3c c8f6fddc bf51bea6 c17f7000
Mar 25 03:17:21 somewhere kernel:        c8f6fe7c c5a199e0 0e36221b 000025d0 c7cbf9e0 c7cbfa00 0006612d 0e75d164
Mar 25 03:17:21 somewhere kernel:        000025d0 c56a09e0 c56a0bd0 c17f7000 7fffffff c8f6ff04 c8f6fe7c c01330b0
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c01330b0>] schedule_timeout+0xd0/0xe0
Mar 25 03:17:21 somewhere kernel:  [<c0257fc9>] opost_block+0x109/0x1d0
Mar 25 03:17:21 somewhere kernel:  [<c025bada>] read_chan+0xd5a/0xf10
Mar 25 03:17:21 somewhere kernel:  [<c025bdee>] write_chan+0x15e/0x210
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c025543e>] tty_poll+0x6e/0x80
Mar 25 03:17:21 somewhere kernel:  [<c0121910>] default_wake_function+0x0/0x10
Mar 25 03:17:21 somewhere kernel:  [<c018fcec>] do_pollfd+0x5c/0xa0
Mar 25 03:17:21 somewhere kernel:  [<c02535cc>] tty_read+0x20c/0x280
Mar 25 03:17:21 somewhere kernel:  [<c013a4f9>] sys_rt_sigaction+0x99/0x110
Mar 25 03:17:21 somewhere kernel:  [<c0175992>] vfs_read+0xa2/0xf0
Mar 25 03:17:21 somewhere kernel:  [<c0175bb5>] sys_read+0x35/0x60
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:21 somewhere kernel: lynx          Z CFFE9B40  6520 29947  29945                     (L-TLB)
Mar 25 03:17:21 somewhere kernel: c920df54 00200046 00000000 cffe9b40 00000000 00010c00 cffe9a80 00000000
Mar 25 03:17:21 somewhere kernel:        c920df54 00200286 cd8b3d70 c76efa38 c0194a3e c76efa88 000a3f26 6a27a9e9
Mar 25 03:17:21 somewhere kernel:        000025cd c76ef9e0 c76efbd0 cffba448 c76ef9e0 cd8b3d70 c920df88 c012b828
Mar 25 03:17:21 somewhere kernel: Call Trace:
Mar 25 03:17:21 somewhere kernel:  [<c0194a3e>] dput+0x1e/0x6f0
Mar 25 03:17:21 somewhere kernel:  [<c012b828>] do_exit+0x548/0x980
Mar 25 03:17:21 somewhere kernel:  [<c018810f>] pipe_write+0x1f/0x30
Mar 25 03:17:21 somewhere kernel:  [<c012bd13>] do_group_exit+0x43/0x220
Mar 25 03:17:21 somewhere kernel:  [<c0109f7f>] syscall_call+0x7/0xb
Mar 25 03:17:21 somewhere kernel:
Mar 25 03:17:23 somewhere kernel: SysRq : Show Regs
Mar 25 03:17:23 somewhere kernel:
Mar 25 03:17:23 somewhere kernel: Pid: 23015, comm:                    X
Mar 25 03:17:23 somewhere kernel: EIP: 0073:[<0869f462>] CPU: 0
Mar 25 03:17:23 somewhere kernel: EIP is at 0x869f462
Mar 25 03:17:23 somewhere kernel:  ESP: 007b:bffff0d8 EFLAGS: 00003246    Not tainted
Mar 25 03:17:23 somewhere kernel: EAX: 00000000 EBX: 083daca8 ECX: 00000000 EDX: 083daca8
Mar 25 03:17:23 somewhere kernel: ESI: 08c63df8 EDI: 08c63e84 EBP: bffff0d8 DS: 007b ES: 007b
Mar 25 03:17:23 somewhere kernel: CR0: 8005003b CR2: 4015d667 CR3: 0ed07000 CR4: 000006c0
Mar 25 03:17:23 somewhere kernel: Call Trace:
Mar 25 03:17:23 somewhere kernel:
Mar 25 03:17:26 somewhere kernel: Emergency Sync complete
