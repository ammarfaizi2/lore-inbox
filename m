Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266691AbUF3QIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUF3QIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUF3QIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:08:38 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54413 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S266691AbUF3QH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:07:27 -0400
X-Sasl-enc: l/NCe+F8V7IjJBEmEivOyQ 1088611642
Message-ID: <007901c45ebc$5dc0b730$62afc742@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Chris Mason" <mason@suse.com>
Cc: <linux-kernel@vger.kernel.org>
References: <006a01c45de6$e4442930$62afc742@ROBMHP> <1088604723.1589.1387.camel@watt.suse.com>
Subject: Re: Processes stuck in unkillable D state (2.4 and 2.6)
Date: Wed, 30 Jun 2004 07:58:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2149
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2149
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi, could you please post the full sysrq-t output?

Sure. The 2 procs stuck in D state were 5873 and 15071.

Jun 29 08:01:52 server2 kernel:
sibling
Jun 29 08:01:52 server2 kernel:   task             PC      pid father child
younger older
Jun 29 08:01:52 server2 kernel: init          S 0000001D     0     1      0
2               (NOTLB)
Jun 29 08:01:52 server2 kernel: f7fdeebc 00000086 00000246 0000001d f7fdee9c
00000000 c1479f1c c03f5cc0
Jun 29 08:01:52 server2 kernel:        f7fdef38 00003437 00000000 f7fde000
c04acd80 c491c6e0 000008bb 898226b2
Jun 29 08:01:52 server2 kernel:        000173d9 c491c6e0 c494c5e0 c494d6f0
c494d8a8 000000d0 00000004 f7fdef38
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0125a81>] schedule_timeout+0xa1/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01259a0>] process_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c0158d72>] sys_stat64+0x22/0x30
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: migration/0   S 0000001E     0     2      1
3       (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fd3fa8 00000046 00000e1a 0000001e f7fd3f88
f7fd3f84 c4916ae0 c4913ce0
Jun 29 08:01:52 server2 kernel:        c49138e0 f7fd3fa0 c011865f f7fd3000
c04acd80 c4913ce0 00000218 606ef8d2
Jun 29 08:01:52 server2 kernel:        000173d5 c4913ce0 c03f11a0 c494c030
c494c1e8 c04c6a00 00000002 c49138e0
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c011865f>]
active_load_balance+0x22f/0x270
Jun 29 08:01:52 server2 kernel:  [<c011b067>] migration_thread+0xb7/0x110
Jun 29 08:01:52 server2 kernel:  [<c011afb0>] migration_thread+0x0/0x110
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: ksoftirqd/0   S 0000001E     0     3      1
4     2 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fd1fb4 00000046 00000e1a 0000001e f7fd1f94
f7fd1f90 f4598150 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 d2465730 f7fd1000
c04acd80 c4913ce0 000001e0 9a62b8a2
Jun 29 08:01:52 server2 kernel:        000173c5 c4913ce0 d2465730 c495f730
c495f8e8 00000002 00000002 fffff000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0121856>] ksoftirqd+0x66/0xd0
Jun 29 08:01:52 server2 kernel:  [<c01217f0>] ksoftirqd+0x0/0xd0
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: ksoftirqd/1   S 0000001F     0     4      1
5     3 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fcefb4 00000046 00000e1a 0000001f f7fcef94
f7fcef90 e7889910 c49166e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 f27732c0 f7fce000
c04acd80 c4916ae0 0000020c a2c0a745
Jun 29 08:01:52 server2 kernel:        0001734d c4916ae0 f27732c0 c495f180
c495f338 00000001 00000001 fffff000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0121856>] ksoftirqd+0x66/0xd0
Jun 29 08:01:52 server2 kernel:  [<c01217f0>] ksoftirqd+0x0/0xd0
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: migration/1   R running     0     5      1
6     4 (L-TLB)
Jun 29 08:01:52 server2 kernel: ksoftirqd/2   S 0000001C     0     6      1
7     5 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fc9fb4 00000046 00000e1a 0000001c f7fc9f94
f7fc9f90 eb9e78d0 c49194e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c8112c90 f7fc9000
c04acd80 c49198e0 00000233 a7e29de3
Jun 29 08:01:52 server2 kernel:        000173c5 c49198e0 c8112c90 c495e620
c495e7d8 00000008 00000008 c04d1800
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0121856>] ksoftirqd+0x66/0xd0
Jun 29 08:01:52 server2 kernel:  [<c01217f0>] ksoftirqd+0x0/0xd0
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: migration/2   S 0000001C     0     7      1
8     6 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fc8fa8 00000046 00000e1a 0000001c f7fc8f88
f7fc8f84 c4916ae0 c49198e0
Jun 29 08:01:52 server2 kernel:        c4918c60 f7fc8fa0 c011865f f7fc8000
c04acd80 c49198e0 00000200 59974ad6
Jun 29 08:01:52 server2 kernel:        000173c5 c49198e0 c494cb90 c495e070
c495e228 c04c6a78 00000008 c4918c60
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c011865f>]
active_load_balance+0x22f/0x270
Jun 29 08:01:52 server2 kernel:  [<c011b067>] migration_thread+0xb7/0x110
Jun 29 08:01:52 server2 kernel:  [<c011afb0>] migration_thread+0x0/0x110
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: ksoftirqd/3   S 0000001D     0     8      1
9     7 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fc2fb4 00000046 00000e1a 0000001d f7fc2f94
f7fc2f90 d4780640 c491c2e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 d2465730 f7fc2000
c04acd80 c491c6e0 0000019c a0978c28
Jun 29 08:01:52 server2 kernel:        000173c5 c491c6e0 d2465730 f7f9d770
f7f9d928 00000004 00000004 c04d1800
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0121856>] ksoftirqd+0x66/0xd0
Jun 29 08:01:52 server2 kernel:  [<c01217f0>] ksoftirqd+0x0/0xd0
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: migration/3   S 0000001D     0     9      1
10     8 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fc0fa8 00000046 00000e1a 0000001d f7fc0f88
f7fc0f84 c49198e0 c491c6e0
Jun 29 08:01:52 server2 kernel:        c491c2e0 f7fc0fa0 c011865f f7fc0000
c04acd80 c491c6e0 000001c9 9c01f050
Jun 29 08:01:52 server2 kernel:        000173d7 c491c6e0 c494c5e0 f7f9d1c0
f7f9d378 c04c6a24 00000004 c491c2e0
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c011865f>]
active_load_balance+0x22f/0x270
Jun 29 08:01:52 server2 kernel:  [<c011b067>] migration_thread+0xb7/0x110
Jun 29 08:01:52 server2 kernel:  [<c011afb0>] migration_thread+0x0/0x110
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: events/0      S 0000001E     0    10      1
14      11     9 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fb1f5c 00000046 00000293 0000001e f7fb1f3c
c4914660 c0124e7c c4914660
Jun 29 08:01:52 server2 kernel:        00000246 00000000 00000246 f7fb1000
c04acd80 c4913ce0 00000477 9f2a5cd9
Jun 29 08:01:52 server2 kernel:        000173d8 c4913ce0 c03f11a0 f7f9cc10
f7f9cdc8 00000286 00000002 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0124e7c>] __mod_timer+0xfc/0x130
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c010f060>] mce_work_fn+0x0/0x30
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: events/1      S 0000001F     0    11      1
12    10 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fb0f5c 00000046 00001586 0000001f 00000001
f7fb0f38 f7fb0f4c c49166e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 e931d180 00000001
ddb3bf64 c4916ae0 00001293 98868bd4
Jun 29 08:01:52 server2 kernel:        000148b8 c4916ae0 e931d180 f7f9c660
f7f9c818 00000001 f7fb0f5c c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0130250>]
keventd_create_kthread+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: events/2      S 0000001C     0    12      1
13    11 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7faef5c 00000046 00000000 0000001c f7faef3c
c00bdbc4 c494ae64 00000000
Jun 29 08:01:52 server2 kernel:        00000fa0 c04e007b 00000001 f7fae000
c04acd80 c49198e0 00159249 72c51cbb
Jun 29 08:01:52 server2 kernel:        00017236 c49198e0 c494cb90 f7f9c0b0
f7f9c268 00000246 00000008 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0259980>] console_callback+0x0/0xd0
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: events/3      S 0000001D     0    13      1
18    12 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7fadf5c 00000046 ed275300 0000001d f7fadf3c
c01518ac 00000286 ef3cb7e8
Jun 29 08:01:52 server2 kernel:        f7fb5800 c016718e ef3cb7e8 f7fad000
c04acd80 c491c6e0 000037a1 353ceb07
Jun 29 08:01:52 server2 kernel:        00017385 c491c6e0 c494c5e0 f7f8b7b0
f7f8b968 00000282 00000004 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01518ac>]
invalidate_inode_buffers+0xc/0x60
Jun 29 08:01:52 server2 kernel:  [<c016718e>] clear_inode+0xe/0xa0
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c037e540>] xprt_socket_autoclose+0x0/0x50
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kblockd/0     S 0000001E     0    14     10
15       (L-TLB)
Jun 29 08:01:52 server2 kernel: f7f71f5c 00000046 c4b3d800 0000001e f7f71f3c
c4b1e7c0 e2df15c0 c0274d19
Jun 29 08:01:52 server2 kernel:        c4b17800 e2df15c0 c4b0fc00 f7f71000
c04acd80 c4913ce0 00000556 4b5c8e05
Jun 29 08:01:52 server2 kernel:        000173c3 c4913ce0 c03f11a0 f7f8b200
f7f8b3b8 00000286 00000002 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0274d19>] elv_next_request+0xa9/0xe0
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0276950>] blk_unplug_work+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kblockd/1     S 0000001F     0    15     10
16    14 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7f6ff5c 00000046 c4b3d800 0000001f f7f6ff3c
c4b1e7c0 d0496940 c0274d19
Jun 29 08:01:52 server2 kernel:        c4b17800 d0496940 c4b0fc00 f7f6f000
c04acd80 c4916ae0 00000cbb 9819f3c8
Jun 29 08:01:52 server2 kernel:        000173cc c4916ae0 c494d140 f7f8ac50
f7f8ae08 00000286 00000001 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0274d19>] elv_next_request+0xa9/0xe0
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0276950>] blk_unplug_work+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kblockd/2     S 0000001C     0    16     10
17    15 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7f6ef5c 00000046 00000e1a 0000001c c027ebbe
f7f6ef38 f4586190 c49194e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 f4586170 c02c3273
c4b009a8 c49198e0 00000d95 aa5000dd
Jun 29 08:01:52 server2 kernel:        00017349 c49198e0 f4586170 f7f8a6a0
f7f8a858 00000008 f7f6ef5c c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c027ebbe>]
deadline_next_request+0x1e/0x30
Jun 29 08:01:52 server2 kernel:  [<c02c3273>] scsi_request_fn+0x293/0x2b0
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0276950>] blk_unplug_work+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kblockd/3     S 0000001D     0    17     10
23    16 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7f6df5c 00000046 c4b00c00 0000001d f7f6df3c
c4b1e540 f394dc00 c0274d19
Jun 29 08:01:52 server2 kernel:        c4b21000 f394dc00 c4b00800 f7f6d000
c04acd80 c491c6e0 00001031 9b41baa8
Jun 29 08:01:52 server2 kernel:        00017328 c491c6e0 c494c5e0 f7f8a0f0
f7f8a2a8 00000286 00000004 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0274d19>] elv_next_request+0xa9/0xe0
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0276950>] blk_unplug_work+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: khubd         S 0000001F     0    18      1
19    13 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7e5ffbc 00000046 00000000 0000001f f7e5ff9c
f7e1b7f0 c012d678 00000003
Jun 29 08:01:52 server2 kernel:        f7e1b7f0 f7e5f000 c012d678 f7e5f000
c04acd80 c4916ae0 000022e4 005b1554
Jun 29 08:01:52 server2 kernel:        00000000 c4916ae0 c494d140 f7e1b7f0
f7e1b9a8 f7e5f000 00000001 f7e5f000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c012d678>] attach_pid+0x18/0xc0
Jun 29 08:01:52 server2 kernel:  [<c012d678>] attach_pid+0x18/0xc0
Jun 29 08:01:52 server2 kernel:  [<c011ebae>] allow_signal+0x5e/0x80
Jun 29 08:01:52 server2 kernel:  [<c02fb914>] hub_thread+0x84/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c02fb890>] hub_thread+0x0/0xc0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kirqd         S 0000001D     0    19      1
22    18 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7e13fb4 00000046 00000e1a 0000001d f7e13f94
f7e13f90 f2e12150 c491c2e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 f4586170 f7e13000
c04acd80 c491c6e0 000003b9 fc2e0268
Jun 29 08:01:52 server2 kernel:        000173d9 c491c6e0 c494c5e0 f7e1b240
f7e1b3f8 00000000 00000004 c4b9e1e0
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0125a81>] schedule_timeout+0xa1/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01259a0>] process_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c0113ff3>] balanced_irq+0x53/0x80
Jun 29 08:01:52 server2 kernel:  [<c0113fa0>] balanced_irq+0x0/0x80
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: aio/0         S 0000001E     0    23     10
24    17 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4bc4f5c 00000046 00000e1a 0000001e 00000000
c4bc4f38 00000000 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c494d6f0 c4bc4f34
c0116ce4 c4913ce0 00000ae2 01509870
Jun 29 08:01:52 server2 kernel:        00000000 c4913ce0 c494d6f0 c4b99830
c4b999e8 00000002 c4b99d84 c4bc4000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0116ce4>] recalc_task_prio+0x154/0x160
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kswapd0       S 0000001F     0    22      1
27    19 (L-TLB)
Jun 29 08:01:52 server2 kernel: f7e0ce94 00000046 c145ba3c 0000001f f7e0ce74
c15cb0a4 c03f7074 00000685
Jun 29 08:01:52 server2 kernel:        c03f5cc0 00000001 00000001 f7e0c000
c04acd80 c4916ae0 001df2e5 bb3d54a7
Jun 29 08:01:52 server2 kernel:        00017346 c4916ae0 c494d140 f7e1a130
f7e1a2e8 ffffeecd 00000001 f7e0cea0
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c013e2a3>] kswapd+0x103/0x120
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c013e1a0>] kswapd+0x0/0x120
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: aio/1         S 0000001F     0    24     10
25    23 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4bc2f5c 00000046 00000000 0000001f c4bc2f3c
00000000 00000000 00000000
Jun 29 08:01:52 server2 kernel:        00000000 00000000 000052d0 c4bc2000
c04acd80 c4916ae0 00000e61 0150b13c
Jun 29 08:01:52 server2 kernel:        00000000 c4916ae0 c494d140 c4b99280
c4b99438 00010000 00000001 c4bc2000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: aio/2         S 0000001C     0    25     10
26    24 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4bc1f5c 00000046 00000000 0000001c c4bc1f3c
00000000 00000000 00000000
Jun 29 08:01:52 server2 kernel:        00000000 00000000 00004f1a c4bc1000
c04acd80 c49198e0 00001c5b 01510abd
Jun 29 08:01:52 server2 kernel:        00000000 c49198e0 c494cb90 c4b98cd0
c4b98e88 00010000 00000008 c4bc1000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: aio/3         S 0000001D     0    26     10
155    25 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4bc0f5c 00000046 00000000 0000001d c4bc0f3c
00000000 00000000 00000000
Jun 29 08:01:52 server2 kernel:        00000000 00000000 00006130 c4bc0000
c04acd80 c491c6e0 00001ed6 01515812
Jun 29 08:01:52 server2 kernel:        00000000 c491c6e0 c494c5e0 c4b98720
c4b988d8 00010000 00000004 c4bc0000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: scsi_eh_0     S 0000001F     0    27      1
28    22 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4b12f50 00000046 c4b12f04 0000001f c4b12f30
00000086 c0487000 c0112539
Jun 29 08:01:52 server2 kernel:        00000001 000000fc c494d6f0 c4b12000
c04acd80 c4916ae0 00003105 e989954f
Jun 29 08:01:52 server2 kernel:        00000000 c4916ae0 c494d140 c4b98170
c4b98328 00000000 00000001 00000002
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0112539>] smp_send_reschedule+0x19/0x20
Jun 29 08:01:52 server2 kernel:  [<c0105f08>]
__down_interruptible+0xa8/0x140
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0105ff7>]
__down_failed_interruptible+0x7/0xc
Jun 29 08:01:52 server2 kernel:  [<c02c2097>]
.text.lock.scsi_error+0xc9/0xd2
Jun 29 08:01:52 server2 kernel:  [<c0392fae>] work_resched+0x5/0x16
Jun 29 08:01:52 server2 kernel:  [<c02c1ca0>] scsi_error_handler+0x0/0x140
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: scsi_eh_1     S 0000001E     0    28      1
29    27 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4afcf50 00000046 00000e1a 0000001e c494d6f0
c4afcf2c ffffffff c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c494d6f0 c4afcf5c
c0117271 c4913ce0 000019ff eb936df7
Jun 29 08:01:52 server2 kernel:        00000000 c4913ce0 c494d6f0 c4ab5870
c4ab5a28 00000002 c4913ce0 00000002
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0117271>] try_to_wake_up+0x311/0x3e0
Jun 29 08:01:52 server2 kernel:  [<c0105f08>]
__down_interruptible+0xa8/0x140
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0105ff7>]
__down_failed_interruptible+0x7/0xc
Jun 29 08:01:52 server2 kernel:  [<c02c2097>]
.text.lock.scsi_error+0xc9/0xd2
Jun 29 08:01:52 server2 kernel:  [<c0392ea6>] ret_from_fork+0x6/0x14
Jun 29 08:01:52 server2 kernel:  [<c02c1ca0>] scsi_error_handler+0x0/0x140
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: khpsbpkt      S 0000001D     0    29      1
30    28 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4ab6f8c 00000046 00000000 0000001d c4ab6f6c
00000000 00000000 00000000
Jun 29 08:01:52 server2 kernel:        00000000 00000000 00000000 c4ab6000
c04acd80 c491c6e0 00003c52 f0099cea
Jun 29 08:01:52 server2 kernel:        00000000 c491c6e0 c494c5e0 c4ab52c0
c4ab5478 00000000 00000004 00000000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c012d678>] attach_pid+0x18/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0105f08>]
__down_interruptible+0xa8/0x140
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c02e4910>] hpsbpkt_thread+0x0/0xf0
Jun 29 08:01:52 server2 kernel:  [<c0105ff7>]
__down_failed_interruptible+0x7/0xc
Jun 29 08:01:52 server2 kernel:  [<c02e4a84>]
.text.lock.ieee1394_core+0x73/0x7f
Jun 29 08:01:52 server2 kernel:  [<c02e4910>] hpsbpkt_thread+0x0/0xf0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kseriod       S 0000001F     0    30      1
31    29 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4aaefbc 00000046 00000004 0000001f c4aaef9c
c4ab4d10 c012d678 00000003
Jun 29 08:01:52 server2 kernel:        c4ab4d10 c4aae000 c012d678 c4aae000
c04acd80 c4916ae0 1bbc057e 0b8f249a
Jun 29 08:01:52 server2 kernel:        00000001 c4916ae0 c494d140 c4ab4d10
c4ab4ec8 c4aae000 00000001 c4aae000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c012d678>] attach_pid+0x18/0xc0
Jun 29 08:01:52 server2 kernel:  [<c012d678>] attach_pid+0x18/0xc0
Jun 29 08:01:52 server2 kernel:  [<c011ebae>] allow_signal+0x5e/0x80
Jun 29 08:01:52 server2 kernel:  [<c031b4d4>] serio_thread+0xb4/0x120
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c031b420>] serio_thread+0x0/0x120
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kjournald     S 0000001E     0    31      1
154    30 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4a7ef78 00000046 00000e1a 0000001e c4a7ef58
c4a7ef54 00000082 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 e9f3a6a0 c4a7e000
c04acd80 c4913ce0 000001d2 319c0dd7
Jun 29 08:01:52 server2 kernel:        000173d9 c4913ce0 c03f11a0 c4ab4760
c4ab4918 c4a7efc0 00000002 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c01bd493>] kjournald+0x1b3/0x220
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0392ea6>] ret_from_fork+0x6/0x14
Jun 29 08:01:52 server2 kernel:  [<c01bd2c0>] commit_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c01bd2e0>] kjournald+0x0/0x220
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: kjournald     S 0000001E     0   154      1
551    31 (L-TLB)
Jun 29 08:01:52 server2 kernel: f75f6f78 00000046 00000e1a 0000001e f75f6f58
f75f6f54 00000082 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 f75388a0 f75f6000
c04acd80 c4913ce0 000014a9 2ab1474b
Jun 29 08:01:52 server2 kernel:        00000006 c4913ce0 c03f11a0 f7539400
f75395b8 f75f6fc0 00000002 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c01bd493>] kjournald+0x1b3/0x220
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0392ea6>] ret_from_fork+0x6/0x14
Jun 29 08:01:52 server2 kernel:  [<c01bd2c0>] commit_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c01bd2e0>] kjournald+0x0/0x220
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: reiserfs/0    S 0000001E     0   155     10
156    26 (L-TLB)
Jun 29 08:01:52 server2 kernel: f76faf5c 00000046 00000e1a 0000001e 00000000
f76faf38 c01198ad c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 dc2bc6a0 00000000
f90279d0 c4913ce0 00001229 16127b1a
Jun 29 08:01:52 server2 kernel:        00016f38 c4913ce0 dc2bc6a0 f7538e50
f7539008 00000002 f76faf5c c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c01a4bc0>]
reiserfs_journal_commit_task_func+0x0/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: reiserfs/1    S 0000001F     0   156     10
157   155 (L-TLB)
Jun 29 08:01:52 server2 kernel: c4a0ff5c 00000046 f8d1eaf0 0000001f c4a0ff3c
c4a0ff18 c01198ad f8d1eaf0
Jun 29 08:01:52 server2 kernel:        00000003 00000001 00000202 c4a0f000
c04acd80 c4916ae0 00003612 d3f40d58
Jun 29 08:01:52 server2 kernel:        00016b81 c4916ae0 c494d140 f755a2b0
f755a468 00000286 00000001 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c01a4bc0>]
reiserfs_journal_commit_task_func+0x0/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: reiserfs/2    S 0000001C     0   157     10
158   156 (L-TLB)
Jun 29 08:01:52 server2 kernel: f6ec6f5c 00000046 f8dd55e4 0000001c f6ec6f3c
f6ec6f18 c01198ad f8dd55e4
Jun 29 08:01:52 server2 kernel:        00000003 00000001 00000202 f6ec6000
c04acd80 c49198e0 00011e4e 3923692d
Jun 29 08:01:52 server2 kernel:        00016c35 c49198e0 c494cb90 f766f340
f766f4f8 00000286 00000008 c01198ad
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c01198ad>] __wake_up+0x1d/0x30
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c01a4bc0>]
reiserfs_journal_commit_task_func+0x0/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: reiserfs/3    S 0000001D     0   158     10
24230   157 (L-TLB)
Jun 29 08:01:52 server2 kernel: f6ec5f5c 00000046 00000000 0000001d f6ec5f3c
00000000 00000000 00000000
Jun 29 08:01:52 server2 kernel:        00000000 00000000 0000199b f6ec5000
c04acd80 c491c6e0 000016f6 1b416c18
Jun 29 08:01:52 server2 kernel:        00000003 c491c6e0 c494c5e0 f766ed90
f766ef48 00010000 00000004 f6ec5000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c012cdfe>] worker_thread+0x13e/0x230
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119945>] complete+0x25/0x40
Jun 29 08:01:52 server2 kernel:  [<c012ccc0>] worker_thread+0x0/0x230
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: syslogd       S 0000001E     0   551      1
556   154 (NOTLB)
Jun 29 08:01:52 server2 kernel: f4616ebc 00000086 00000e1a 0000001e f4616f38
f4616e98 00000000 00000000
Jun 29 08:01:52 server2 kernel:        00000020 00000000 f4599240 c0322a71
f7617e00 f4616f10 000003fe c0322ab8
Jun 29 08:01:52 server2 kernel:        000173da c4913ce0 00000064 f4599240
f4586328 00000002 c0136edd c1614aa8
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0322a71>] sys_recvfrom+0xa1/0x100
Jun 29 08:01:52 server2 kernel:  [<c0136edd>] __get_free_pages+0x2d/0x30
Jun 29 08:01:52 server2 kernel:  [<c0160f53>] __pollwait+0x33/0xa0
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0322049>] sock_poll+0x19/0x20
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c014ff97>] vfs_writev+0x47/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: klogd         R running     0   556      1
1017   551 (NOTLB)
Jun 29 08:01:52 server2 kernel: portmap       S 0000001D     0  1017      1
1054   556 (NOTLB)
Jun 29 08:01:52 server2 kernel: f476bf04 00000082 00000e1a 0000001d f46c8b90
f476bee0 c03f6cc0 c491c2e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 e8d821b0 f7556ec0
00000246 c491c6e0 0000d0eb 04c098d0
Jun 29 08:01:52 server2 kernel:        00000035 c491c6e0 e8d821b0 f46c8b90
f46c8d48 00000004 f7556ec0 f76f7c58
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01618e9>] do_pollfd+0x59/0x80
Jun 29 08:01:52 server2 kernel:  [<c016197f>] do_poll+0x6f/0xe0
Jun 29 08:01:52 server2 kernel:  [<c01619c2>] do_poll+0xb2/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0161c26>] sys_poll+0x236/0x300
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: sshd          S 0000001F     0  1054      1
21960    1086  1017 (NOTLB)
Jun 29 08:01:52 server2 kernel: f4653ebc 00000086 c0136c0a 0000001f f4653e9c
00000000 00000000 00000000
Jun 29 08:01:52 server2 kernel:        f46c85e0 00000010 c03f6cc0 f4653000
c04acd80 c4916ae0 00000f75 624558f5
Jun 29 08:01:52 server2 kernel:        000173d5 c4916ae0 c494d140 f46c85e0
f46c8798 00000246 00000001 f4666a40
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0136c0a>] __alloc_pages+0xba/0x360
Jun 29 08:01:52 server2 kernel:  [<c03422db>] tcp_poll+0x2b/0x150
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0322049>] sock_poll+0x19/0x20
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c01065bc>] sys_sigreturn+0xac/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: atd           S 0000001F     0  1086      1
1094  1054 (NOTLB)
Jun 29 08:01:52 server2 kernel: f46eff4c 00000086 40045000 0000001f f46eff2c
c4915ed0 00000001 00000000
Jun 29 08:01:52 server2 kernel:        00000001 c014b1bf c4915ed0 f46ef000
c04acd80 c4916ae0 000032db 0e768665
Jun 29 08:01:52 server2 kernel:        00017341 c4916ae0 c494d140 f75382f0
f75384a8 f46ef000 00000001 00000000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c014b1bf>]
free_pages_and_swap_cache+0x8f/0xb0
Jun 29 08:01:52 server2 kernel:  [<c0125a81>] schedule_timeout+0xa1/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01259a0>] process_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c0125c89>] sys_nanosleep+0x119/0x1c0
Jun 29 08:01:52 server2 kernel:  [<c014f0bc>] filp_close+0x5c/0x70
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: mingetty      S 0000001E     0  1094      1
1095  1086 (NOTLB)
Jun 29 08:01:52 server2 kernel: f4688e5c 00000082 00000e1a 0000001e 00000246
f4688e38 f4652000 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c4a201f0 f4688e64
00000000 c4913ce0 000379b8 a87cb818
Jun 29 08:01:52 server2 kernel:        0000000b c4913ce0 c4a201f0 f46c8030
f46c81e8 00000002 00000001 c0140338
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0140338>] zap_pte_range+0x288/0x2a0
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0136f4b>] __pagevec_free+0x1b/0x30
Jun 29 08:01:52 server2 kernel:  [<c024dcd2>] read_chan+0x4b2/0xa40
Jun 29 08:01:52 server2 kernel:  [<c0256455>] set_cursor+0x65/0x80
Jun 29 08:01:52 server2 kernel:  [<c024e443>] write_chan+0x1e3/0x200
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 last message repeated 3 times
Jun 29 08:01:52 server2 kernel:  [<c024908d>] tty_read+0xdd/0x140
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0144425>] do_munmap+0x115/0x120
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: mingetty      S 0000001D     0  1095      1
1096  1094 (NOTLB)
Jun 29 08:01:52 server2 kernel: c4a43e5c 00000082 00000e1a 0000001d 00000246
c4a43e38 f75c1000 c491c2e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c4a20d50 c4a43e64
00000000 c491c6e0 0001d0b2 a87d8a53
Jun 29 08:01:52 server2 kernel:        0000000b c491c6e0 c4a20d50 c4a218b0
c4a21a68 00000004 00000000 c0140338
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0140338>] zap_pte_range+0x288/0x2a0
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0136f4b>] __pagevec_free+0x1b/0x30
Jun 29 08:01:52 server2 kernel:  [<c024dcd2>] read_chan+0x4b2/0xa40
Jun 29 08:01:52 server2 kernel:  [<c024e443>] write_chan+0x1e3/0x200
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 last message repeated 3 times
Jun 29 08:01:52 server2 kernel:  [<c024908d>] tty_read+0xdd/0x140
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0144425>] do_munmap+0x115/0x120
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: mingetty      S 0000001D     0  1096      1
1097  1095 (NOTLB)
Jun 29 08:01:52 server2 kernel: f462be5c 00000086 00000002 0000001d f462be3c
00000008 f452f000 c0259f23
Jun 29 08:01:52 server2 kernel:        f452f000 f452f000 00000000 f462b000
c04acd80 c491c6e0 0001ad35 a87f3788
Jun 29 08:01:52 server2 kernel:        0000000b c491c6e0 c494c5e0 c4a20d50
c4a20f08 00000000 00000004 c0140338
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0259f23>] con_write+0x23/0x30
Jun 29 08:01:52 server2 kernel:  [<c0140338>] zap_pte_range+0x288/0x2a0
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0136f4b>] __pagevec_free+0x1b/0x30
Jun 29 08:01:52 server2 kernel:  [<c024dcd2>] read_chan+0x4b2/0xa40
Jun 29 08:01:52 server2 kernel:  [<c024e443>] write_chan+0x1e3/0x200
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 last message repeated 3 times
Jun 29 08:01:52 server2 kernel:  [<c024908d>] tty_read+0xdd/0x140
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0144425>] do_munmap+0x115/0x120
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: mingetty      S 0000001E     0  1097      1
1098  1096 (NOTLB)
Jun 29 08:01:52 server2 kernel: f75c2e5c 00000082 00000e1a 0000001e 00000246
f75c2e38 c4a17000 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c4a207a0 f75c2e64
00000000 c4913ce0 00015cde a87e14f6
Jun 29 08:01:52 server2 kernel:        0000000b c4913ce0 c4a207a0 c4a201f0
c4a203a8 00000002 00000001 c0140338
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0140338>] zap_pte_range+0x288/0x2a0
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0136f4b>] __pagevec_free+0x1b/0x30
Jun 29 08:01:52 server2 kernel:  [<c024dcd2>] read_chan+0x4b2/0xa40
Jun 29 08:01:52 server2 kernel:  [<c024e443>] write_chan+0x1e3/0x200
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 last message repeated 3 times
Jun 29 08:01:52 server2 kernel:  [<c024908d>] tty_read+0xdd/0x140
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0144425>] do_munmap+0x115/0x120
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: mingetty      S 0000001E     0  1098      1
1099  1097 (NOTLB)
Jun 29 08:01:52 server2 kernel: f467be5c 00000086 00000004 0000001e f467be3c
00000008 f4508000 c0259f23
Jun 29 08:01:52 server2 kernel:        f4508000 f4508000 00000000 f467b000
c04acd80 c4913ce0 00017919 a87f8e0f
Jun 29 08:01:52 server2 kernel:        0000000b c4913ce0 c03f11a0 c4a207a0
c4a20958 00000000 00000002 c0140338
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0259f23>] con_write+0x23/0x30
Jun 29 08:01:52 server2 kernel:  [<c0140338>] zap_pte_range+0x288/0x2a0
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0136f4b>] __pagevec_free+0x1b/0x30
Jun 29 08:01:52 server2 kernel:  [<c024dcd2>] read_chan+0x4b2/0xa40
Jun 29 08:01:52 server2 kernel:  [<c024e443>] write_chan+0x1e3/0x200
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 last message repeated 3 times
Jun 29 08:01:52 server2 kernel:  [<c024908d>] tty_read+0xdd/0x140
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0144425>] do_munmap+0x115/0x120
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: mingetty      S 0000001D     0  1099      1
1100  1098 (NOTLB)
Jun 29 08:01:52 server2 kernel: f7581e5c 00000086 00000e1a 0000001d 00000246
f7581e38 f4679000 c491c2e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c4a218b0 f7581e64
00000000 c491c6e0 0002ae56 a87bb9a1
Jun 29 08:01:52 server2 kernel:        0000000b c491c6e0 c4a218b0 c4ab41b0
c4ab4368 00000004 00000000 c0140338
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0140338>] zap_pte_range+0x288/0x2a0
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0136f4b>] __pagevec_free+0x1b/0x30
Jun 29 08:01:52 server2 kernel:  [<c024dcd2>] read_chan+0x4b2/0xa40
Jun 29 08:01:52 server2 kernel:  [<c024e443>] write_chan+0x1e3/0x200
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 last message repeated 3 times
Jun 29 08:01:52 server2 kernel:  [<c024908d>] tty_read+0xdd/0x140
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0144425>] do_munmap+0x115/0x120
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: svscanboot    S 0000001E     0  1100      1
1104    2337  1099 (NOTLB)
Jun 29 08:01:52 server2 kernel: c4a45f60 00000086 f466b380 0000001e c4a45f40
f466b380 080cf19c 00000001
Jun 29 08:01:52 server2 kernel:        00000001 080cf19c b1bfa41c c4a45000
c04acd80 c4913ce0 0000c504 b1c59835
Jun 29 08:01:52 server2 kernel:        0000000b c4913ce0 c03f11a0 f755b970
f755bb28 c0129bea 00000002 c4a45f70
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0129bea>] sys_rt_sigaction+0xfa/0x120
Jun 29 08:01:52 server2 kernel:  [<c0120238>] sys_wait4+0x228/0x260
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: svscan        S 0000001E     0  1104   1100
1106    1105       (NOTLB)
Jun 29 08:01:52 server2 kernel: f7607f4c 00000086 00000060 0000001e f7607f2c
f75ab1c0 c0486780 f7607f0c
Jun 29 08:01:52 server2 kernel:        00000000 f4509c54 c4a96000 f7607000
c04acd80 c4913ce0 00003178 334970d0
Jun 29 08:01:52 server2 kernel:        000173d9 c4913ce0 c03f11a0 c4a21300
c4a214b8 f7607000 00000002 00000000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0125a81>] schedule_timeout+0xa1/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01259a0>] process_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c0125c89>] sys_nanosleep+0x119/0x1c0
Jun 29 08:01:52 server2 kernel:  [<c014f0bc>] filp_close+0x5c/0x70
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: readproctitle S 0000001E     0  1105   1100
1104 (NOTLB)
Jun 29 08:01:52 server2 kernel: f4618e88 00000082 c0133ede 0000001e f4618e68
fffcf6d0 f4668400 00000246
Jun 29 08:01:52 server2 kernel:        000000d0 fffcf6d0 c0146b9c f4618000
c04acd80 c4913ce0 0009e8a5 b34f7a31
Jun 29 08:01:52 server2 kernel:        0000000b c4913ce0 c03f11a0 f755ae10
f755afc8 00000000 00000002 c4a6c1c0
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0133ede>] filemap_nopage+0x18e/0x350
Jun 29 08:01:52 server2 kernel:  [<c0146b9c>] pte_chain_alloc+0x1c/0x60
Jun 29 08:01:52 server2 kernel:  [<c015af58>] pipe_wait+0x98/0xd0
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0142277>] handle_mm_fault+0xc7/0x1e0
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c015b223>] pipe_readv+0x293/0x320
Jun 29 08:01:52 server2 kernel:  [<c0115a9d>] do_page_fault+0x13d/0x52a
Jun 29 08:01:52 server2 kernel:  [<c01431dc>] vma_link+0x5c/0x80
Jun 29 08:01:52 server2 kernel:  [<c015b2d7>] pipe_read+0x27/0x30
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0144425>] do_munmap+0x115/0x120
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: supervise     S 0000001C     0  1106   1104
1109    1107       (NOTLB)
Jun 29 08:01:52 server2 kernel: f45dbf04 00000082 c0136c0a 0000001c f45dbee4
00000000 c03938f4 00000000
Jun 29 08:01:52 server2 kernel:        f755b3c0 00000010 c03f6cc0 f45db000
c04acd80 c49198e0 00000979 4ac6cd13
Jun 29 08:01:52 server2 kernel:        00017384 c49198e0 c494cb90 f755b3c0
f755b578 00000246 00000008 c4a12900
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0136c0a>] __alloc_pages+0xba/0x360
Jun 29 08:01:52 server2 kernel:  [<c03938f4>] common_interrupt+0x18/0x20
Jun 29 08:01:52 server2 kernel:  [<c0125a81>] schedule_timeout+0xa1/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01259a0>] process_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c01619c2>] do_poll+0xb2/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0161c26>] sys_poll+0x236/0x300
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: supervise     S 0000001C     0  1107   1104
1111    1108  1106 (NOTLB)
Jun 29 08:01:52 server2 kernel: f7496f04 00000086 c0136c0a 0000001c f7496ee4
00000000 f00f7710 00000000
Jun 29 08:01:52 server2 kernel:        f766e7e0 00000010 c03f6cc0 f7496000
c04acd80 c49198e0 00000d31 49a57de0
Jun 29 08:01:52 server2 kernel:        00017384 c49198e0 c494cb90 f766e7e0
f766e998 00000246 00000008 f76c6500
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0136c0a>] __alloc_pages+0xba/0x360
Jun 29 08:01:52 server2 kernel:  [<c0125a81>] schedule_timeout+0xa1/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01259a0>] process_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c01619c2>] do_poll+0xb2/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0161c26>] sys_poll+0x236/0x300
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: supervise     S 0000001E     0  1108   1104
1107 (NOTLB)
Jun 29 08:01:52 server2 kernel: f4619f04 00000082 00000e1a 0000001e 00000000
f4619ee0 c4a96200 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 e8a44e90 00000000
000000d0 c4913ce0 00006d95 621fc7b8
Jun 29 08:01:52 server2 kernel:        0001734a c4913ce0 e8a44e90 f766e230
f766e3e8 00000002 f76aa0d4 f755c300
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0125a81>] schedule_timeout+0xa1/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01259a0>] process_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c01619c2>] do_poll+0xb2/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0161c26>] sys_poll+0x236/0x300
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: dnscache      S 0000001C     0  1109   1106
(NOTLB)
Jun 29 08:01:52 server2 kernel: f44c7f04 00000086 00000e1a 0000001c f44c7ee4
00000010 c03f6cc0 00000000
Jun 29 08:01:52 server2 kernel:        000000d0 000000d0 f44c7fa0 f44c7000
c04acd80 c49198e0 000011a0 deec5eb6
Jun 29 08:01:52 server2 kernel:        000173ce c49198e0 c494cb90 f766f8f0
f766faa8 c0327831 00000008 f75e3858
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0327831>] datagram_poll+0x21/0xd0
Jun 29 08:01:52 server2 kernel:  [<c0125a81>] schedule_timeout+0xa1/0xc0
Jun 29 08:01:52 server2 kernel:  [<c01259a0>] process_timeout+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c01619c2>] do_poll+0xb2/0xe0
Jun 29 08:01:52 server2 kernel:  [<c0161c26>] sys_poll+0x236/0x300
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: multilog      S 0000001C     0  1111   1107
(NOTLB)
Jun 29 08:01:52 server2 kernel: f4487e88 00000086 00000e1a 0000001c f4487e68
f4487e64 f766f910 c49194e0
Jun 29 08:01:52 server2 kernel:        00000020 e2c10348 00000151 f4487000
c04acd80 c49198e0 00001688 5d9433fa
Jun 29 08:01:52 server2 kernel:        00017343 c49198e0 c494cb90 f4598130
f45982e8 e2c102d4 00000008 d85b6cc0
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01aad3a>] ext3_file_write+0x2a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c015af58>] pipe_wait+0x98/0xd0
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c015b223>] pipe_readv+0x293/0x320
Jun 29 08:01:52 server2 kernel:  [<c015b2d7>] pipe_read+0x27/0x30
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: rpciod        S 0000001E     0  2337      1
2338  1100 (L-TLB)
Jun 29 08:01:52 server2 kernel: e7be2f98 00000046 00000e1a 0000001e c4bab584
e7be2f74 00000000 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 dc563400 e7be2000
c04acd80 c4913ce0 00000780 ed7a67ce
Jun 29 08:01:52 server2 kernel:        0001733b c4913ce0 dc563400 e7bd87e0
e7bd8998 00000002 c4bab584 e7be2000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0381f56>] rpciod+0x1f6/0x2d0
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0392ea6>] ret_from_fork+0x6/0x14
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0381d60>] rpciod+0x0/0x2d0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: lockd         S 0000001D     0  2338      1
5873  2337 (L-TLB)
Jun 29 08:01:52 server2 kernel: e7c4af48 00000046 00000e1a 0000001d 00000000
e7c4af24 00000000 c491c2e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 e8d821b0 00000000
00000000 c491c6e0 00007036 04c1cf77
Jun 29 08:01:52 server2 kernel:        00000035 c491c6e0 e8d821b0 e7bd8230
e7bd83e8 00000004 ed398a40 e7c4af50
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0384739>] svc_sock_release+0x189/0x1a0
Jun 29 08:01:52 server2 kernel:  [<c0385caa>] svc_recv+0x32a/0x4d0
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c0126094>] free_uid+0x14/0x70
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 kernel:  [<c020d5c5>] lockd+0x135/0x250
Jun 29 08:01:52 server2 kernel:  [<c020d490>] lockd+0x0/0x250
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: imapd         D 0000001E     0  5873      1
15071  2338 (NOTLB)
Jun 29 08:01:52 server2 kernel: eaad5bc4 00000082 00000e1a 0000001e eaad5ba4
eaad5ba0 ef64a640 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 e9f3a6a0 eaad5000
c04acd80 c4913ce0 00000328 0780a0cd
Jun 29 08:01:52 server2 kernel:        000173d1 c4913ce0 c03f11a0 d2464620
d24647d8 c4b21000 00000002 c4b21000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c011a878>] io_schedule+0x28/0x40
Jun 29 08:01:52 server2 kernel:  [<c0132feb>] __lock_page+0xbb/0xe0
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0133f6f>] filemap_nopage+0x21f/0x350
Jun 29 08:01:52 server2 kernel:  [<c0141dd4>] do_no_page+0xb4/0x390
Jun 29 08:01:52 server2 kernel:  [<c013fb57>] pte_alloc_map+0xf7/0x120
Jun 29 08:01:52 server2 kernel:  [<c0142277>] handle_mm_fault+0xc7/0x1e0
Jun 29 08:01:52 server2 kernel:  [<c0115a9d>] do_page_fault+0x13d/0x52a
Jun 29 08:01:52 server2 kernel:  [<c0150b80>] __wait_on_buffer+0xf0/0x100
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c013f3c5>] set_page_address+0x25/0x191
Jun 29 08:01:52 server2 kernel:  [<c013ecf4>] kmap_high+0x184/0x1c0
Jun 29 08:01:52 server2 kernel:  [<c0115960>] do_page_fault+0x0/0x52a
Jun 29 08:01:52 server2 kernel:  [<c0393a13>] error_code+0x2f/0x38
Jun 29 08:01:52 server2 kernel:  [<c019073f>]
reiserfs_copy_from_user_to_file_region+0x8f/0x100
Jun 29 08:01:52 server2 kernel:  [<c0191a07>]
reiserfs_file_write+0x617/0x730
Jun 29 08:01:52 server2 kernel:  [<c01a5f56>] journal_end+0x16/0x20
Jun 29 08:01:52 server2 kernel:  [<c0189b51>] reiserfs_link+0x171/0x1a0
Jun 29 08:01:52 server2 kernel:  [<c016522c>] dput+0x1c/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c016522c>] dput+0x1c/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c015c270>] path_release+0x10/0x30
Jun 29 08:01:52 server2 kernel:  [<c015e916>] sys_link+0xc6/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014fa5a>] vfs_write+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014f4e0>] default_llseek+0x0/0x110
Jun 29 08:01:52 server2 kernel:  [<c014fb0f>] sys_write+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: sshd          S 0000001F     0 21960   1054
22036       (NOTLB)
Jun 29 08:01:52 server2 kernel: ef959ebc 00000086 00000246 0000001f ef959e9c
00000000 c12f9eec c03f5cc0
Jun 29 08:01:52 server2 kernel:        ef959f38 00003437 00000000 ef959000
c04acd80 c4916ae0 000378ee 360ecdd5
Jun 29 08:01:52 server2 kernel:        000173d7 c4916ae0 c494d140 d2c55200
d2c553b8 00000246 00000001 de471240
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c03422db>] tcp_poll+0x2b/0x150
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0322049>] sock_poll+0x19/0x20
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: sshd          S 0000001F     0 22036   1054
31751 21960 (NOTLB)
Jun 29 08:01:52 server2 kernel: e36bdebc 00000082 00000246 0000001f e36bde9c
00000000 c1272f10 c03f5cc0
Jun 29 08:01:52 server2 kernel:        e36bdf38 00003437 00000000 e36bd000
c04acd80 c4916ae0 0001db0c 3615f7a5
Jun 29 08:01:52 server2 kernel:        000173d7 c4916ae0 c494d140 d3141730
d31418e8 00000246 00000001 da3e5ec0
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c03422db>] tcp_poll+0x2b/0x150
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0322049>] sock_poll+0x19/0x20
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: sshd          S 0000001D     0 31751   1054
8964 22036 (NOTLB)
Jun 29 08:01:52 server2 kernel: dbcebebc 00000082 00000e1a 0000001d c12c8680
dbcebe98 c494d710 c491c2e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c494d6f0 c0136c0a
c03f5cc0 c491c6e0 0004a991 36038755
Jun 29 08:01:52 server2 kernel:        000173d7 c491c6e0 c494d6f0 e9f3b200
e9f3b3b8 00000004 e82df400 d1639e40
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0136c0a>] __alloc_pages+0xba/0x360
Jun 29 08:01:52 server2 kernel:  [<c03422db>] tcp_poll+0x2b/0x150
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0322049>] sock_poll+0x19/0x20
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: sshd          S 0000001C     0  8964   1054
29897 31751 (NOTLB)
Jun 29 08:01:52 server2 kernel: eca12ebc 00000082 00000e1a 0000001c c15d16e0
eca12e98 c494d710 c49194e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 c494d6f0 c0136c0a
c03f5cc0 c49198e0 00040207 35dbbe65
Jun 29 08:01:52 server2 kernel:        000173d7 c49198e0 c494d6f0 f341a230
f341a3e8 00000008 eeed7800 d25a8080
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0136c0a>] __alloc_pages+0xba/0x360
Jun 29 08:01:52 server2 kernel:  [<c03422db>] tcp_poll+0x2b/0x150
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c0322049>] sock_poll+0x19/0x20
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: imapd         D 0000001D     0 15071      1
5873 (NOTLB)
Jun 29 08:01:52 server2 kernel: c9a3cbc4 00000082 c4b3d800 0000001d c9a3cba4
f4366e40 00000293 f4366e40
Jun 29 08:01:52 server2 kernel:        c4b0fc00 c4b3d800 c4b17800 c9a3c000
c04acd80 c491c6e0 0000044a cc1b4998
Jun 29 08:01:52 server2 kernel:        000173bb c491c6e0 c494c5e0 c80bc0f0
c80bc2a8 c4b17800 00000004 c4b17800
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c011a878>] io_schedule+0x28/0x40
Jun 29 08:01:52 server2 kernel:  [<c0132feb>] __lock_page+0xbb/0xe0
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c0133f6f>] filemap_nopage+0x21f/0x350
Jun 29 08:01:52 server2 kernel:  [<c0141dd4>] do_no_page+0xb4/0x390
Jun 29 08:01:52 server2 kernel:  [<c013fb57>] pte_alloc_map+0xf7/0x120
Jun 29 08:01:52 server2 kernel:  [<c0142277>] handle_mm_fault+0xc7/0x1e0
Jun 29 08:01:52 server2 kernel:  [<c0115a9d>] do_page_fault+0x13d/0x52a
Jun 29 08:01:52 server2 kernel:  [<c0150b80>] __wait_on_buffer+0xf0/0x100
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c011b7c0>]
autoremove_wake_function+0x0/0x40
Jun 29 08:01:52 server2 kernel:  [<c013f3c5>] set_page_address+0x25/0x191
Jun 29 08:01:52 server2 kernel:  [<c013ecf4>] kmap_high+0x184/0x1c0
Jun 29 08:01:52 server2 kernel:  [<c0115960>] do_page_fault+0x0/0x52a
Jun 29 08:01:52 server2 kernel:  [<c0393a13>] error_code+0x2f/0x38
Jun 29 08:01:52 server2 kernel:  [<c019073f>]
reiserfs_copy_from_user_to_file_region+0x8f/0x100
Jun 29 08:01:52 server2 kernel:  [<c0191a07>]
reiserfs_file_write+0x617/0x730
Jun 29 08:01:52 server2 kernel:  [<c01a5f56>] journal_end+0x16/0x20
Jun 29 08:01:52 server2 kernel:  [<c0189b51>] reiserfs_link+0x171/0x1a0
Jun 29 08:01:52 server2 kernel:  [<c016522c>] dput+0x1c/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c016522c>] dput+0x1c/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c015c270>] path_release+0x10/0x30
Jun 29 08:01:52 server2 kernel:  [<c015e916>] sys_link+0xc6/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014fa5a>] vfs_write+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014f4e0>] default_llseek+0x0/0x110
Jun 29 08:01:52 server2 kernel:  [<c014fb0f>] sys_write+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: pdflush       S 0000001E     0 24230     10
30209   158 (L-TLB)
Jun 29 08:01:52 server2 kernel: eb08ef8c 00000046 00001586 0000001e c0117271
eb08ef68 d9e96350 c49138e0
Jun 29 08:01:52 server2 kernel:        00000020 00000000 d9e96330 c01386b0
00000000 c4913ce0 000000ec 1805e059
Jun 29 08:01:52 server2 kernel:        0001733f c4913ce0 d9e96330 d0abb180
d0abb338 00000002 eb08efb8 eb08efac
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0117271>] try_to_wake_up+0x311/0x3e0
Jun 29 08:01:52 server2 kernel:  [<c01386b0>] pdflush+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c011734d>] wake_up_process+0xd/0x20
Jun 29 08:01:52 server2 kernel:  [<c013858e>] __pdflush+0x8e/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c01386b0>] pdflush+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c01386bb>] pdflush+0xb/0x10
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: sshd          S 0000001C     0 29897   1054
29907   30535  8964 (NOTLB)
Jun 29 08:01:52 server2 kernel: e7149ebc 00000086 c0136c0a 0000001c e7149e9c
00000000 e7149eb0 00000000
Jun 29 08:01:52 server2 kernel:        e01787a0 00000010 c03f6cc0 e7149000
c04acd80 c49198e0 00000f72 8c8e8948
Jun 29 08:01:52 server2 kernel:        00017359 c49198e0 c494cb90 e01787a0
e0178958 00000246 00000008 00000246
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c0136c0a>] __alloc_pages+0xba/0x360
Jun 29 08:01:52 server2 kernel:  [<c024f613>] pty_chars_in_buffer+0x23/0x50
Jun 29 08:01:52 server2 kernel:  [<c024f5e4>] pty_write_room+0x24/0x30
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c015b753>] pipe_poll+0x23/0x70
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c0112d6a>]
smp_apic_timer_interrupt+0x14a/0x160
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: bash          S 0000001D     0 29907  29897
(NOTLB)
Jun 29 08:01:52 server2 kernel: f1428e5c 00000082 d7b20000 0000001d f1428e3c
c01464c3 00000000 dbbfc6e0
Jun 29 08:01:52 server2 kernel:        00030002 c03f6ce0 00000000 f1428000
c04acd80 c491c6e0 000454e6 8bff455f
Jun 29 08:01:52 server2 kernel:        00017359 c491c6e0 c494c5e0 dbbfc6e0
dbbfc898 00000000 00000004 fff696a8
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c01464c3>] page_remove_rmap+0x13/0x270
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c024dcd2>] read_chan+0x4b2/0xa40
Jun 29 08:01:52 server2 kernel:  [<c0142327>] handle_mm_fault+0x177/0x1e0
Jun 29 08:01:52 server2 kernel:  [<c024e443>] write_chan+0x1e3/0x200
Jun 29 08:01:52 server2 kernel:  [<c0119810>] default_wake_function+0x0/0x20
Jun 29 08:01:52 server2 last message repeated 3 times
Jun 29 08:01:52 server2 kernel:  [<c024908d>] tty_read+0xdd/0x140
Jun 29 08:01:52 server2 kernel:  [<c014f8ca>] vfs_read+0xaa/0xe0
Jun 29 08:01:52 server2 kernel:  [<c014fabf>] sys_read+0x2f/0x50
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: pdflush       S 0000001F     0 30209     10
24230 (L-TLB)
Jun 29 08:01:52 server2 kernel: e23e6f8c 00000046 00000000 0000001f e23e6f6c
00000000 00000000 00000000
Jun 29 08:01:52 server2 kernel:        00000000 00000000 00000000 e23e6000
c04acd80 c4916ae0 000399de 25da6a0b
Jun 29 08:01:52 server2 kernel:        000173d9 c4916ae0 c494d140 d9e96330
d9e964e8 00000000 00000001 00000000
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c013858e>] __pdflush+0x8e/0x1b0
Jun 29 08:01:52 server2 kernel:  [<c01386b0>] pdflush+0x0/0x10
Jun 29 08:01:52 server2 kernel:  [<c01386bb>] pdflush+0xb/0x10
Jun 29 08:01:52 server2 kernel:  [<c013021a>] kthread+0x7a/0xb0
Jun 29 08:01:52 server2 kernel:  [<c01301a0>] kthread+0x0/0xb0
Jun 29 08:01:52 server2 kernel:  [<c010505d>] kernel_thread_helper+0x5/0x18
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: sshd          S 0000001E     0 30535   1054
30536         29897 (NOTLB)
Jun 29 08:01:52 server2 kernel: e7469ebc 00000086 00000246 0000001e e7469e9c
00000000 c140efd8 c03f5cc0
Jun 29 08:01:52 server2 kernel:        e7469f38 00003437 00000000 e7469000
c04acd80 c4913ce0 000034c5 05b0ffa4
Jun 29 08:01:52 server2 kernel:        000173da c4913ce0 c03f11a0 f341ad90
f341af48 00000246 00000002 00000246
Jun 29 08:01:52 server2 kernel: Call Trace:
Jun 29 08:01:52 server2 kernel:  [<c024f613>] pty_chars_in_buffer+0x23/0x50
Jun 29 08:01:52 server2 kernel:  [<c024f5e4>] pty_write_room+0x24/0x30
Jun 29 08:01:52 server2 kernel:  [<c01259f4>] schedule_timeout+0x14/0xc0
Jun 29 08:01:52 server2 kernel:  [<c024a3e9>] tty_poll+0x79/0x90
Jun 29 08:01:52 server2 kernel:  [<c016133f>] do_select+0x29f/0x2e0
Jun 29 08:01:52 server2 kernel:  [<c0160f20>] __pollwait+0x0/0xa0
Jun 29 08:01:52 server2 kernel:  [<c0161397>] select_bits_alloc+0x17/0x20
Jun 29 08:01:52 server2 kernel:  [<c01616f9>] sys_select+0x349/0x4e0
Jun 29 08:01:52 server2 kernel:  [<c0392f87>] syscall_call+0x7/0xb
Jun 29 08:01:52 server2 kernel:  [<c039007b>] svcauth_gss_accept+0x8b/0x720
Jun 29 08:01:52 server2 kernel:
Jun 29 08:01:52 server2 kernel: bash          R running     0 30536  30535
(NOTLB)

