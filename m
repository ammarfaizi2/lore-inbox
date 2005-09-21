Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVIUJwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVIUJwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVIUJwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:52:31 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:9771 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750803AbVIUJwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:52:30 -0400
Date: Wed, 21 Sep 2005 11:52:29 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.6.14-rc1-git4/x86_64]: Kernel BUG at mm/slab.c:1876
Message-ID: <Pine.BSO.4.62.0509211139090.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-346508805-1127295564=:5000"
Content-ID: <Pine.BSO.4.62.0509211139460.5000@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-346508805-1127295564=:5000
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0509211139461.5000@rudy.mif.pg.gda.pl>


Hardware: two way AMD Opteron (Sun v20z)

Below call trace was cached during boot kernel but before start initrd:

Kernel BUG at mm/slab.c:1876
invalid operand: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 8, comm: events/0 Not tainted 2.6.13-1.1561_FC5 #1
RIP: 0010:[<ffffffff8016a0cf>] <ffffffff8016a0cf>{free_block+332}
RSP: 0018:ffff81007fec1d98  EFLAGS: 00010002
RAX: 0000000000000001 RBX: ffff8100fbf49000 RCX: 0000000000000320
RDX: 0000000000000000 RSI: ffff8100fbf48960 RDI: ffff8100fbf47580
RBP: ffff810081b55c80 R08: ffff8100fbf48530 R09: 0000000000000003
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff8100fbf49048
R13: 0000000000000000 R14: ffff8100fbf47580 R15: 0000000000000001
FS:  0000000000588850(0000) GS:ffffffff80554800(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 000000000040b5b0 CR3: 0000000000101000 CR4: 00000000000006e0
Process events/0 (pid: 8, threadinfo ffff81007fec0000, task ffff81007fe77860)
Stack: 0000000000000000 0000000000000002 ffff8100fbf48960 ffff8100fbf48960
        0000000000000002 ffff8100fbf48938 ffff8100fbf47580 0000000000000283
        ffff81000324a128 ffffffff8016a360
Call Trace:<ffffffff8016a360>{drain_array_locked+184} <ffffffff8016a46e>{cache_reap+218}
        <ffffffff8016a394>{cache_reap+0} <ffffffff80145c02>{worker_thread+481}
        <ffffffff80130e78>{default_wake_function+0} <ffffffff80145a21>{worker_thread+0}
        <ffffffff80149f0e>{kthread+205} <ffffffff80131326>{schedule_tail+70}
        <ffffffff8010ea22>{child_rip+8} <ffffffff80149e41>{kthread+0}
        <ffffffff8010ea1a>{child_rip+0}

Code: 0f 0b 68 2b b5 37 80 c2 54 07 48 89 de 4c 89 f7 e8 52 e8 ff
RIP <ffffffff8016a0cf>{free_block+332} RSP <ffff81007fec1d98>
  <6>hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-346508805-1127295564=:5000--
