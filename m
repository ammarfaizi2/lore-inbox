Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTE2Vtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTE2Vtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:49:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:14806 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262742AbTE2Vtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:49:36 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
Date: Thu, 29 May 2003 14:52:09 -0700
User-Agent: KMail/1.4.1
References: <20030529012914.2c315dad.akpm@digeo.com>
In-Reply-To: <20030529012914.2c315dad.akpm@digeo.com>
Cc: nsharoff@us.ibm.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XQ4OTM0X5XJXF96XK9RK"
Message-Id: <200305291452.09041.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_XQ4OTM0X5XJXF96XK9RK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

2.5.70-mm2 seems to hang while running LTP.=20
Here are the sysrq-t output of all the processes.
Seems to be ext3 related...

(I applied your 2 ext3 patches on top of -mm2).

Thanks,
Badari


--------------Boundary-00=_XQ4OTM0X5XJXF96XK9RK
Content-Type: text/plain;
  charset="iso-8859-1";
  name="stacks"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="stacks"

SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 00000001     1      0     2               (NOTLB)
Call Trace:
 [<c012c621>] schedule_timeout+0x71/0xd0
 [<c012c5a0>] process_timeout+0x0/0x10
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c010984f>] syscall_call+0x7/0xb

migration/0   S 00000001     2      1             3       (L-TLB)
Call Trace:
 [<c01200a6>] migration_thread+0x4a6/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ksoftirqd/0   S C3856C04     3      1             4     2 (L-TLB)
Call Trace:
 [<c0127ab2>] tasklet_action+0x72/0xd0
 [<c0127d85>] ksoftirqd+0xa5/0x100
 [<c0127ce0>] ksoftirqd+0x0/0x100
 [<c01072cd>] kernel_thread_helper+0x5/0x18

migration/1   S 00000001     4      1             5     3 (L-TLB)
Call Trace:
 [<c01200a6>] migration_thread+0x4a6/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ksoftirqd/1   S C385EC04     5      1             6     4 (L-TLB)
Call Trace:
 [<c0127ab2>] tasklet_action+0x72/0xd0
 [<c0127d85>] ksoftirqd+0xa5/0x100
 [<c0127ce0>] ksoftirqd+0x0/0x100
 [<c01072cd>] kernel_thread_helper+0x5/0x18

migration/2   S 00000001     6      1             7     5 (L-TLB)
Call Trace:
 [<c01200a6>] migration_thread+0x4a6/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ksoftirqd/2   S C3866C04     7      1             8     6 (L-TLB)
Call Trace:
 [<c0127ab2>] tasklet_action+0x72/0xd0
 [<c0127d85>] ksoftirqd+0xa5/0x100
 [<c0127ce0>] ksoftirqd+0x0/0x100
 [<c01072cd>] kernel_thread_helper+0x5/0x18

migration/3   S 00000001     8      1             9     7 (L-TLB)
Call Trace:
 [<c01200a6>] migration_thread+0x4a6/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ksoftirqd/3   S C386EC04     9      1            10     8 (L-TLB)
Call Trace:
 [<c0127ab2>] tasklet_action+0x72/0xd0
 [<c0127d85>] ksoftirqd+0xa5/0x100
 [<c0127ce0>] ksoftirqd+0x0/0x100
 [<c01072cd>] kernel_thread_helper+0x5/0x18

migration/4   S 00000001    10      1            11     9 (L-TLB)
Call Trace:
 [<c01200a6>] migration_thread+0x4a6/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ksoftirqd/4   S 00000001    11      1            12    10 (L-TLB)
Call Trace:
 [<c0127d85>] ksoftirqd+0xa5/0x100
 [<c0127ce0>] ksoftirqd+0x0/0x100
 [<c01072cd>] kernel_thread_helper+0x5/0x18

migration/5   S 00000001    12      1            13    11 (L-TLB)
Call Trace:
 [<c01200a6>] migration_thread+0x4a6/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ksoftirqd/5   S 00000001    13      1            14    12 (L-TLB)
Call Trace:
 [<c0127d85>] ksoftirqd+0xa5/0x100
 [<c0127ce0>] ksoftirqd+0x0/0x100
 [<c01072cd>] kernel_thread_helper+0x5/0x18

migration/6   S 00000001    14      1            15    13 (L-TLB)
Call Trace:
 [<c01200a6>] migration_thread+0x4a6/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ksoftirqd/6   S 00000001    15      1            16    14 (L-TLB)
Call Trace:
 [<c0127ab2>] tasklet_action+0x72/0xd0
 [<c0127d85>] ksoftirqd+0xa5/0x100
 [<c0127ce0>] ksoftirqd+0x0/0x100
 [<c01072cd>] kernel_thread_helper+0x5/0x18

migration/7   S 00000001    16      1            17    15 (L-TLB)
Call Trace:
 [<c01200a6>] migration_thread+0x4a6/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c011fc00>] migration_thread+0x0/0x4e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ksoftirqd/7   S 00000001    17      1            18    16 (L-TLB)
Call Trace:
 [<c0127d85>] ksoftirqd+0xa5/0x100
 [<c0127ce0>] ksoftirqd+0x0/0x100
 [<c01072cd>] kernel_thread_helper+0x5/0x18

events/0      S F7FD8030    18      1            19    17 (L-TLB)
Call Trace:
 [<c0133bba>] __call_usermodehelper+0x2a/0x70
 [<c01342d5>] worker_thread+0x355/0x380
 [<c0133b90>] __call_usermodehelper+0x0/0x70
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18


events/1      S 00000001    19      1            20    18 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c0290900>] batch_entropy_process+0x0/0xe0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

events/2      S 00000001    20      1            21    19 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c028a790>] flush_to_ldisc+0x0/0x160
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

events/3      S 00000001    21      1            22    20 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c028a790>] flush_to_ldisc+0x0/0x160
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

events/4      S 00000001    22      1            23    21 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c028a790>] flush_to_ldisc+0x0/0x160
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

events/5      S 00000001    23      1            24    22 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c028a790>] flush_to_ldisc+0x0/0x160
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

events/6      S 00000001    24      1            25    23 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c028a790>] flush_to_ldisc+0x0/0x160
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

events/7      S 00000001    25      1            26    24 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c028a790>] flush_to_ldisc+0x0/0x160
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kblockd/0     S 00000001    26      1            27    25 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c02cf350>] blk_unplug_work+0x0/0x20
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kblockd/1     S C3A96090    27      1            28    26 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c02cf350>] blk_unplug_work+0x0/0x20
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kblockd/2     S 00000001    28      1            29    27 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c02d7820>] as_work_handler+0x0/0xb0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kblockd/3     S 00000001    29      1            30    28 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c02d7820>] as_work_handler+0x0/0xb0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kblockd/4     S 00000001    30      1            31    29 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c02d7820>] as_work_handler+0x0/0xb0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18


kblockd/5     S 00000001    31      1            32    30 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c02d7820>] as_work_handler+0x0/0xb0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kblockd/6     S 00000001    32      1            33    31 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c02d7820>] as_work_handler+0x0/0xb0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kblockd/7     S 00000001    33      1            34    32 (L-TLB)
Call Trace:
 [<c01342d5>] worker_thread+0x355/0x380
 [<c02d7820>] as_work_handler+0x0/0xb0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

khubd         S 00000001    34      1            37    33 (L-TLB)
Call Trace:
 [<c0369c57>] usb_hub_thread+0x97/0xf0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0369bc0>] usb_hub_thread+0x0/0xf0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kswapd0       S C04D9F04    37      1            35    34 (L-TLB)
Call Trace:
 [<c014be33>] kswapd+0x123/0x160
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c014bd10>] kswapd+0x0/0x160
 [<c01072cd>] kernel_thread_helper+0x5/0x18

pdflush       S 00000001    35      1            36    37 (L-TLB)
Call Trace:
 [<c0144e97>] __pdflush+0xc7/0x320
 [<c01450f0>] pdflush+0x0/0x20
 [<c01450ff>] pdflush+0xf/0x20
 [<c01072c8>] kernel_thread_helper+0x0/0x18
 [<c01072cd>] kernel_thread_helper+0x5/0x18

pdflush       D 00000001    36      1            38    35 (L-TLB)
Call Trace:
 [<c01b3a7c>] start_this_handle+0x39c/0x570
 [<c011df90>] default_wake_function+0x0/0x30
 [<c01b3d49>] journal_start+0xa9/0xd0
 [<c01acdc4>] __ext3_journal_stop+0x24/0x50
 [<c01a876c>] ext3_writepage_trans_blocks+0x1c/0x90
 [<c01a65f5>] ext3_ordered_writepage+0x75/0x1e0
 [<c01a6570>] bput_one+0x0/0x10
 [<c0189cac>] mpage_writepages+0x2bc/0x3c4
 [<c0169880>] blkdev_writepage+0x0/0x30
 [<c01a6580>] ext3_ordered_writepage+0x0/0x1e0
 [<c0144986>] do_writepages+0x36/0x40
 [<c0187b54>] __sync_single_inode+0x114/0x2f0
 [<c0187da1>] __writeback_single_inode+0x71/0x110
 [<c018010f>] iput+0x3f/0x90
 [<c0187ffc>] sync_sb_inodes+0x1bc/0x300
 [<c01881ee>] writeback_inodes+0xae/0x1d0
 [<c0143837>] get_page_state+0x17/0x20
 [<c01447f8>] wb_kupdate+0xb8/0x130
 [<c0144f05>] __pdflush+0x135/0x320
 [<c01450f0>] pdflush+0x0/0x20
 [<c01450ff>] pdflush+0xf/0x20
 [<c0144740>] wb_kupdate+0x0/0x130
 [<c01072c8>] kernel_thread_helper+0x0/0x18
 [<c01072cd>] kernel_thread_helper+0x5/0x18

aio/0         S 00000000    38      1            39    36 (L-TLB)
Call Trace:
 [<c0130983>] do_sigaction+0x263/0x3f0
 [<c01342d5>] worker_thread+0x355/0x380
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

aio/1         S 00000001    39      1            40    38 (L-TLB)
Call Trace:
 [<c0130983>] do_sigaction+0x263/0x3f0
 [<c01342d5>] worker_thread+0x355/0x380
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

aio/2         S 00000001    40      1            41    39 (L-TLB)
Call Trace:
 [<c0130983>] do_sigaction+0x263/0x3f0
 [<c01342d5>] worker_thread+0x355/0x380
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

aio/3         S 00000001    41      1            42    40 (L-TLB)
Call Trace:
 [<c0130983>] do_sigaction+0x263/0x3f0
 [<c01342d5>] worker_thread+0x355/0x380
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

aio/4         S 00000001    42      1            43    41 (L-TLB)
Call Trace:
 [<c0130983>] do_sigaction+0x263/0x3f0
 [<c01342d5>] worker_thread+0x355/0x380
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

aio/5         S 00000001    43      1            44    42 (L-TLB)
Call Trace:
 [<c0130983>] do_sigaction+0x263/0x3f0
 [<c01342d5>] worker_thread+0x355/0x380
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

aio/6         S 00000001    44      1            45    43 (L-TLB)
Call Trace:
 [<c0130983>] do_sigaction+0x263/0x3f0
 [<c01342d5>] worker_thread+0x355/0x380
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

aio/7         S 00000001    45      1            46    44 (L-TLB)
Call Trace:
 [<c0130983>] do_sigaction+0x263/0x3f0
 [<c01342d5>] worker_thread+0x355/0x380
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0133f80>] worker_thread+0x0/0x380
 [<c01072cd>] kernel_thread_helper+0x5/0x18

scsi_eh_0     S 00000086    46      1            47    45 (L-TLB)
Call Trace:
 [<c010830b>] __down_interruptible+0xdb/0x1f0
 [<c011dffa>] __wake_up_common+0x3a/0x60
 [<c011df90>] default_wake_function+0x0/0x30
 [<c01084e3>] __down_failed_interruptible+0x7/0xc
 [<c031eb34>] .text.lock.scsi_error+0xbd/0xc9
 [<c0109876>] work_resched+0x5/0x16
 [<c031e6e0>] scsi_error_handler+0x0/0x1b0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ahc_dv_0      S 00000000    47      1            48    46 (L-TLB)
Call Trace:
 [<c010830b>] __down_interruptible+0xdb/0x1f0
 [<c011cb56>] wake_up_process+0x26/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0342014>] ahc_linux_release_simq+0xb4/0x140
 [<c01084e3>] __down_failed_interruptible+0x7/0xc
 [<c0342da5>] .text.lock.aic7xxx_osm+0x9e/0x209
 [<c033c6f0>] ahc_linux_dv_thread+0x0/0x540
 [<c033c6f0>] ahc_linux_dv_thread+0x0/0x540
 [<c01072cd>] kernel_thread_helper+0x5/0x18

scsi_eh_1     S 00000086    48      1            49    47 (L-TLB)
Call Trace:
 [<c010830b>] __down_interruptible+0xdb/0x1f0
 [<c011dffa>] __wake_up_common+0x3a/0x60
 [<c011df90>] default_wake_function+0x0/0x30
 [<c01084e3>] __down_failed_interruptible+0x7/0xc
 [<c031eb34>] .text.lock.scsi_error+0xbd/0xc9
 [<c0109762>] ret_from_fork+0x6/0x14
 [<c031e6e0>] scsi_error_handler+0x0/0x1b0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

ahc_dv_1      S FFFFFFFF    49      1            50    48 (L-TLB)
Call Trace:
 [<c010830b>] __down_interruptible+0xdb/0x1f0
 [<c011cb56>] wake_up_process+0x26/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0342014>] ahc_linux_release_simq+0xb4/0x140
 [<c01084e3>] __down_failed_interruptible+0x7/0xc
 [<c0342da5>] .text.lock.aic7xxx_osm+0x9e/0x209
 [<c033c6f0>] ahc_linux_dv_thread+0x0/0x540
 [<c033c6f0>] ahc_linux_dv_thread+0x0/0x540
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kseriod       S 00000001    50      1            51    49 (L-TLB)
Call Trace:
 [<c03874d7>] serio_thread+0xd7/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0387400>] serio_thread+0x0/0x1b0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kjournald     D 00000001    51      1           141    50 (L-TLB)
Call Trace:
 [<c01b7214>] journal_commit_transaction+0x164/0x17c3
 [<c012bfb6>] update_wall_time+0x16/0x40
 [<c012c490>] do_timer+0xc0/0xd0
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c011dbd0>] schedule+0x220/0x5e0
 [<c01bb6d8>] kjournald+0x358/0x3e0
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c01bb360>] commit_timeout+0x0/0x10
 [<c01bb380>] kjournald+0x0/0x3e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kjournald     S 00000001   141      1           142    51 (L-TLB)
Call Trace:
 [<c01bb65a>] kjournald+0x2da/0x3e0
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c01bb360>] commit_timeout+0x0/0x10
 [<c01bb380>] kjournald+0x0/0x3e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

kjournald     S 00000001   142      1           421   141 (L-TLB)
Call Trace:
 [<c01bb65a>] kjournald+0x2da/0x3e0
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c01bb360>] commit_timeout+0x0/0x10
 [<c01bb380>] kjournald+0x0/0x3e0
 [<c01072cd>] kernel_thread_helper+0x5/0x18

syslogd       S 00000001   421      1           425   142 (NOTLB)
Call Trace:
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c0176c91>] __pollwait+0x41/0xd0
 [<c03d879b>] datagram_poll+0x2b/0xd7
 [<c03d2575>] sock_poll+0x25/0x30
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c011766d>] smp_apic_timer_interrupt+0xcd/0x140
 [<c010984f>] syscall_call+0x7/0xb

klogd         R 00000001   425      1           436   421 (NOTLB)
Call Trace:
 [<c010a23e>] apic_timer_interrupt+0x1a/0x20
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c011007b>] alloc_ldt+0x16b/0x1c0
 [<c0123262>] do_syslog+0x252/0x4f0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011d695>] scheduler_tick+0xd5/0x3e0
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

portmap       S 00000000   436      1           455   425 (NOTLB)
Call Trace:
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c03d2575>] sock_poll+0x25/0x30
 [<c017771b>] do_pollfd+0x5b/0xa0
 [<c017781b>] do_poll+0xbb/0xe0
 [<c01779a0>] sys_poll+0x160/0x256
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c010984f>] syscall_call+0x7/0xb

rpc.statd     S 00000001   455      1           565   436 (NOTLB)
Call Trace:
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c03f39a3>] tcp_poll+0x33/0x190
 [<c03d2575>] sock_poll+0x25/0x30
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c015f947>] filp_close+0xc7/0x130
 [<c010984f>] syscall_call+0x7/0xb

sshd          S 00000000   565      1   706     581   455 (NOTLB)
Call Trace:
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c0176c91>] __pollwait+0x41/0xd0
 [<c03f39a3>] tcp_poll+0x33/0x190
 [<c03d2575>] sock_poll+0x25/0x30
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c015f947>] filp_close+0xc7/0x130
 [<c010984f>] syscall_call+0x7/0xb

xinetd        S 000001F7   581      1           606   565 (NOTLB)
Call Trace:
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c03f39a3>] tcp_poll+0x33/0x190
 [<c03d2575>] sock_poll+0x25/0x30
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c010984f>] syscall_call+0x7/0xb

sendmail      S 00000001   606      1           617   581 (NOTLB)
Call Trace:
 [<c012c621>] schedule_timeout+0x71/0xd0
 [<c012c5a0>] process_timeout+0x0/0x10
 [<c03d2575>] sock_poll+0x25/0x30
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c010984f>] syscall_call+0x7/0xb

sendmail      S 00000001   617      1           627   606 (NOTLB)
Call Trace:
 [<c0108b83>] sys_sigreturn+0xf3/0x170
 [<c0131094>] sys_pause+0x14/0x20
 [<c010984f>] syscall_call+0x7/0xb

gpm           S 00000001   627      1           636   617 (NOTLB)
Call Trace:
 [<c0143428>] __alloc_pages+0x348/0x3b0
 [<c012c621>] schedule_timeout+0x71/0xd0
 [<c012c5a0>] process_timeout+0x0/0x10
 [<c03d2575>] sock_poll+0x25/0x30
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c010984f>] syscall_call+0x7/0xb

crond         S 00000001   636      1           649   627 (NOTLB)
Call Trace:
 [<c0137391>] adjust_abs_time+0xc1/0x130
 [<c0138179>] do_clock_nanosleep+0x1c9/0x320
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0137d40>] nanosleep_wake_up+0x0/0x10
 [<c012fc11>] sys_rt_sigprocmask+0x91/0x1b0
 [<c0137dea>] sys_nanosleep+0x7a/0x110
 [<c010984f>] syscall_call+0x7/0xb

anacron       S 00000001   649      1           658   636 (NOTLB)
Call Trace:
 [<c0126ae1>] do_setitimer+0x151/0x180
 [<c010877d>] sys_rt_sigsuspend+0xfd/0x170
 [<c010984f>] syscall_call+0x7/0xb

atd           S 00000001   658      1           692   649 (NOTLB)
Call Trace:
 [<c0137391>] adjust_abs_time+0xc1/0x130
 [<c01a2f79>] ext3_readdir+0x3e9/0x530
 [<c0138179>] do_clock_nanosleep+0x1c9/0x320
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c0137d40>] nanosleep_wake_up+0x0/0x10
 [<c012fc11>] sys_rt_sigprocmask+0x91/0x1b0
 [<c0137dea>] sys_nanosleep+0x7a/0x110
 [<c010984f>] syscall_call+0x7/0xb

mingetty      S 00000001   692      1           693   658 (NOTLB)
Call Trace:
 [<c029c7bc>] con_flush_chars+0x3c/0x50
 [<c029c5e9>] con_write+0x39/0x50
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c028dfe3>] read_chan+0x2d3/0xb20
 [<c028e9bb>] write_chan+0x18b/0x280
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c014e2ee>] unmap_vmas+0xce/0x330
 [<c011df90>] default_wake_function+0x0/0x30
 [<c028dd10>] read_chan+0x0/0xb20
 [<c02879dc>] tty_read+0x18c/0x1e0
 [<c015268f>] unmap_vma_list+0x1f/0x30
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

mingetty      S 00000001   693      1           694   692 (NOTLB)
Call Trace:
 [<c029c7bc>] con_flush_chars+0x3c/0x50
 [<c029c5e9>] con_write+0x39/0x50
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c028dfe3>] read_chan+0x2d3/0xb20
 [<c028e9bb>] write_chan+0x18b/0x280
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c014e2ee>] unmap_vmas+0xce/0x330
 [<c011df90>] default_wake_function+0x0/0x30
 [<c028dd10>] read_chan+0x0/0xb20
 [<c02879dc>] tty_read+0x18c/0x1e0
 [<c015268f>] unmap_vma_list+0x1f/0x30
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

mingetty      S 00000001   694      1           695   693 (NOTLB)
Call Trace:
 [<c029c7bc>] con_flush_chars+0x3c/0x50
 [<c029c5e9>] con_write+0x39/0x50
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c028dfe3>] read_chan+0x2d3/0xb20
 [<c028e9bb>] write_chan+0x18b/0x280
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c014e2ee>] unmap_vmas+0xce/0x330
 [<c011df90>] default_wake_function+0x0/0x30
 [<c028dd10>] read_chan+0x0/0xb20
 [<c02879dc>] tty_read+0x18c/0x1e0
 [<c015268f>] unmap_vma_list+0x1f/0x30
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

mingetty      S 00000001   695      1           697   694 (NOTLB)
Call Trace:
 [<c029c7bc>] con_flush_chars+0x3c/0x50
 [<c029c5e9>] con_write+0x39/0x50
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c028dfe3>] read_chan+0x2d3/0xb20
 [<c028e9bb>] write_chan+0x18b/0x280
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010a23e>] apic_timer_interrupt+0x1a/0x20
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c028dd10>] read_chan+0x0/0xb20
 [<c02879dc>] tty_read+0x18c/0x1e0
 [<c015268f>] unmap_vma_list+0x1f/0x30
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

mingetty      S 00000001   697      1           698   695 (NOTLB)
Call Trace:
 [<c029c7bc>] con_flush_chars+0x3c/0x50
 [<c029c5e9>] con_write+0x39/0x50
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c028dfe3>] read_chan+0x2d3/0xb20
 [<c028e9bb>] write_chan+0x18b/0x280
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c014e2ee>] unmap_vmas+0xce/0x330
 [<c011df90>] default_wake_function+0x0/0x30
 [<c028dd10>] read_chan+0x0/0xb20
 [<c02879dc>] tty_read+0x18c/0x1e0
 [<c015268f>] unmap_vma_list+0x1f/0x30
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

mingetty      S 00000001   698      1           700   697 (NOTLB)
Call Trace:
 [<c029c7bc>] con_flush_chars+0x3c/0x50
 [<c029c5e9>] con_write+0x39/0x50
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c028dfe3>] read_chan+0x2d3/0xb20
 [<c028e9bb>] write_chan+0x18b/0x280
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010a23e>] apic_timer_interrupt+0x1a/0x20
 [<c011df90>] default_wake_function+0x0/0x30
 [<c011df90>] default_wake_function+0x0/0x30
 [<c028dd10>] read_chan+0x0/0xb20
 [<c02879dc>] tty_read+0x18c/0x1e0
 [<c015268f>] unmap_vma_list+0x1f/0x30
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

mingetty      D 00000001   700      1                 698 (NOTLB)
Call Trace:
 [<c0163ad7>] __getblk+0x37/0x70
 [<c01b3a7c>] start_this_handle+0x39c/0x570
 [<c011dbd0>] schedule+0x220/0x5e0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c01b3d49>] journal_start+0xa9/0xd0
 [<c013f854>] file_read_actor+0xe4/0xf0
 [<c01a8982>] ext3_dirty_inode+0x32/0x90
 [<c01879de>] __mark_inode_dirty+0x15e/0x170
 [<c0180304>] update_atime+0xe4/0xf0
 [<c013fa24>] __generic_file_aio_read+0x1c4/0x210
 [<c013f770>] file_read_actor+0x0/0xf0
 [<c013faca>] generic_file_aio_read+0x5a/0x80
 [<c01602d6>] do_sync_read+0xb6/0xf0
 [<c016cdfe>] cp_new_stat64+0xfe/0x110
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c015223b>] get_unmapped_area+0xcb/0x140
 [<c0152049>] do_mmap_pgoff+0x5f9/0x720
 [<c016cec7>] sys_fstat64+0x37/0x40
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

sshd          S 00000001   706    565   708     743       (NOTLB)
Call Trace:
 [<c01acdc4>] __ext3_journal_stop+0x24/0x50
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c0140a36>] generic_file_aio_write_nolock+0x1f6/0xb40
 [<c042f10e>] unix_stream_data_wait+0xfe/0x160
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c042f7ab>] unix_stream_recvmsg+0x63b/0x6f0
 [<c03d1e23>] sock_aio_read+0xd3/0xe0
 [<c01602d6>] do_sync_read+0xb6/0xf0
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c01b2e4f>] ext3_permission+0x1f/0x30
 [<c016c315>] cdev_get+0x45/0xa0
 [<c016158d>] __fput+0xad/0x100
 [<c016040e>] vfs_read+0xfe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

sshd          S 00000001   708    706   709               (NOTLB)
Call Trace:
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c028fd1c>] pty_chars_in_buffer+0x2c/0x50
 [<c028ebbc>] normal_poll+0x10c/0x167
 [<c0289472>] tty_poll+0x82/0xa0
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c010984f>] syscall_call+0x7/0xb

bash          S 00000001   709    708   810               (NOTLB)
Call Trace:
 [<c01264cf>] sys_wait4+0x1ff/0x2c0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c012fc5f>] sys_rt_sigprocmask+0xdf/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010984f>] syscall_call+0x7/0xb

sshd          S 00000001   743    565   745           706 (NOTLB)
Call Trace:
 [<c01acdc4>] __ext3_journal_stop+0x24/0x50
 [<c01a62ed>] ext3_ordered_commit_write+0xcd/0xe0
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c0140d38>] generic_file_aio_write_nolock+0x4f8/0xb40
 [<c042f10e>] unix_stream_data_wait+0xfe/0x160
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c042f7ab>] unix_stream_recvmsg+0x63b/0x6f0
 [<c03d1e23>] sock_aio_read+0xd3/0xe0
 [<c01602d6>] do_sync_read+0xb6/0xf0
 [<c0171b08>] link_path_walk+0x698/0x9f0
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c01b2e4f>] ext3_permission+0x1f/0x30
 [<c016c315>] cdev_get+0x45/0xa0
 [<c015f3bc>] dentry_open+0x13c/0x1f0
 [<c011d695>] scheduler_tick+0xd5/0x3e0
 [<c016040e>] vfs_read+0xfe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

sshd          S 00000001   745    743   746               (NOTLB)
Call Trace:
 [<c012c675>] schedule_timeout+0xc5/0xd0
 [<c028fd1c>] pty_chars_in_buffer+0x2c/0x50
 [<c028ebbc>] normal_poll+0x10c/0x167
 [<c0289472>] tty_poll+0x82/0xa0
 [<c0176ffd>] do_select+0x1ed/0x360
 [<c0176c50>] __pollwait+0x0/0xd0
 [<c017749e>] sys_select+0x2fe/0x520
 [<c010984f>] syscall_call+0x7/0xb

bash          S 00000001   746    745   780               (NOTLB)
Call Trace:
 [<c01264cf>] sys_wait4+0x1ff/0x2c0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c012fc5f>] sys_rt_sigprocmask+0xdf/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010984f>] syscall_call+0x7/0xb

su            S 00000001   780    746   781               (NOTLB)
Call Trace:
 [<c01264cf>] sys_wait4+0x1ff/0x2c0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c012fc11>] sys_rt_sigprocmask+0x91/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010984f>] syscall_call+0x7/0xb

bash          R current    781    780  3422               (NOTLB)
Call Trace:
 [<c011dfba>] default_wake_function+0x2a/0x30
 [<c011dffa>] __wake_up_common+0x3a/0x60
 [<c0135ce9>] kernel_text_address+0x39/0x50
 [<c010a4e9>] show_trace+0x59/0xa0
 [<c010a4e9>] show_trace+0x59/0xa0
 [<c011fa1d>] show_state+0x5d/0xa0
 [<c029dac3>] __handle_sysrq_nolock+0x73/0xf3
 [<c029da39>] handle_sysrq+0x49/0x60
 [<c019d7db>] write_sysrq_trigger+0x4b/0x50
 [<c01605ee>] vfs_write+0xbe/0x130
 [<c0160712>] sys_write+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

su            S 00000001   810    709   811               (NOTLB)
Call Trace:
 [<c01264cf>] sys_wait4+0x1ff/0x2c0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c012fc11>] sys_rt_sigprocmask+0x91/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010984f>] syscall_call+0x7/0xb

bash          S 00000001   811    810   866               (NOTLB)
Call Trace:
 [<c01264cf>] sys_wait4+0x1ff/0x2c0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c012fc5f>] sys_rt_sigprocmask+0xdf/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010984f>] syscall_call+0x7/0xb

bash          S 00000001   866    811   878               (NOTLB)
Call Trace:
 [<c01264cf>] sys_wait4+0x1ff/0x2c0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c012fc5f>] sys_rt_sigprocmask+0xdf/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010984f>] syscall_call+0x7/0xb

runalltests.s S 00000001   878    866   972               (NOTLB)
Call Trace:
 [<c01264cf>] sys_wait4+0x1ff/0x2c0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c012fc5f>] sys_rt_sigprocmask+0xdf/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010984f>] syscall_call+0x7/0xb

pan           S 00000001   972    878  3421               (NOTLB)
Call Trace:
 [<c017a4dd>] fcntl_setlk+0xed/0x2a0
 [<c01264cf>] sys_wait4+0x1ff/0x2c0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c012fc11>] sys_rt_sigprocmask+0x91/0x1b0
 [<c011df90>] default_wake_function+0x0/0x30
 [<c010984f>] syscall_call+0x7/0xb

readlink01    D 00000001  3421    972                     (NOTLB)
Call Trace:
 [<c0192448>] padzero+0x28/0x30
 [<c019317f>] load_elf_binary+0x54f/0xbc0
 [<c01b3a7c>] start_this_handle+0x39c/0x570
 [<c011df90>] default_wake_function+0x0/0x30
 [<c01b3d49>] journal_start+0xa9/0xd0
 [<c013f854>] file_read_actor+0xe4/0xf0
 [<c01a8982>] ext3_dirty_inode+0x32/0x90
 [<c01879de>] __mark_inode_dirty+0x15e/0x170
 [<c0180304>] update_atime+0xe4/0xf0
 [<c013fa24>] __generic_file_aio_read+0x1c4/0x210
 [<c013f770>] file_read_actor+0x0/0xf0
 [<c013faca>] generic_file_aio_read+0x5a/0x80
 [<c01602d6>] do_sync_read+0xb6/0xf0
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c0151535>] vma_link+0x85/0xf0
 [<c0151e73>] do_mmap_pgoff+0x423/0x720
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c01606a2>] sys_read+0x42/0x70
 [<c010984f>] syscall_call+0x7/0xb

bash          D 00FA089C  3422    781          3423       (NOTLB)
Call Trace:
 [<c01b3a7c>] start_this_handle+0x39c/0x570
 [<c02d0de4>] submit_bio+0x54/0xa0
 [<c0188f3d>] do_mpage_readpage+0x29d/0x490
 [<c011df90>] default_wake_function+0x0/0x30
 [<c01b3d49>] journal_start+0xa9/0xd0
 [<c013f854>] file_read_actor+0xe4/0xf0
 [<c01a8982>] ext3_dirty_inode+0x32/0x90
 [<c01879de>] __mark_inode_dirty+0x15e/0x170
 [<c0180304>] update_atime+0xe4/0xf0
 [<c013fa24>] __generic_file_aio_read+0x1c4/0x210
 [<c013f770>] file_read_actor+0x0/0xf0
 [<c013faca>] generic_file_aio_read+0x5a/0x80
 [<c01602d6>] do_sync_read+0xb6/0xf0
 [<c011b418>] pgd_alloc+0x18/0x20
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c016dbb0>] kernel_read+0x50/0x60
 [<c016eb54>] prepare_binprm+0xd4/0xf0
 [<c016f160>] do_execve+0x180/0x260
 [<c0107c30>] sys_execve+0x50/0x80
 [<c010984f>] syscall_call+0x7/0xb
 
bash          D 00000000  3423    781                3422 (NOTLB)
Call Trace:
 [<c01b3a7c>] start_this_handle+0x39c/0x570
 [<c011df90>] default_wake_function+0x0/0x30
 [<c01b3d49>] journal_start+0xa9/0xd0
 [<c013f854>] file_read_actor+0xe4/0xf0
 [<c01a8982>] ext3_dirty_inode+0x32/0x90
 [<c01879de>] __mark_inode_dirty+0x15e/0x170
 [<c0180304>] update_atime+0xe4/0xf0
 [<c013fa24>] __generic_file_aio_read+0x1c4/0x210
 [<c013f770>] file_read_actor+0x0/0xf0
 [<c013faca>] generic_file_aio_read+0x5a/0x80
 [<c01602d6>] do_sync_read+0xb6/0xf0
 [<c011b418>] pgd_alloc+0x18/0x20
 [<c0120ab0>] autoremove_wake_function+0x0/0x50
 [<c01603ce>] vfs_read+0xbe/0x130
 [<c016dbb0>] kernel_read+0x50/0x60
 [<c016eb54>] prepare_binprm+0xd4/0xf0
 [<c016f160>] do_execve+0x180/0x260
 [<c0107c30>] sys_execve+0x50/0x80
 [<c010984f>] syscall_call+0x7/0xb

--------------Boundary-00=_XQ4OTM0X5XJXF96XK9RK--

