Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbULQAna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbULQAna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbULQAk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:40:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:60639 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262683AbULQAkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:40:04 -0500
Subject: 2.6.10-rc2-mm4 panic while running LTP tests
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1103242646.5383.31.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Dec 2004 16:17:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I get following panic while running LTP io tests.

I am going to try 2.6.10-rc3-mm1 next, but are
there are any recent changes in this area ?


Thanks,
Badari

Unable to handle kernel paging request at 0000000000100108 RIP:
<ffffffff801a4571>{__writeback_single_inode+881}
PML4 0
Oops: 0002 [1] SMP
CPU 0
Modules linked in:
Pid: 209, comm: kswapd0 Not tainted 2.6.10-rc2-mm4n
RIP: 0010:[<ffffffff801a4571>]
<ffffffff801a4571>{__writeback_single_inode+881}
RSP: 0018:ffff8101dff7dc48  EFLAGS: 00010246
RAX: 0000000000100100 RBX: 0000000000000000 RCX: 0000000000200200
RDX: ffff8101dd70cd80 RSI: 0000000000000292 RDI: ffff8101dd70cea8
RBP: ffff8101dd70cd70 R08: 00000000fffffffa R09: 0000000012bffd80
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8101dd70ce90 R14: ffff8101dff7dd18 R15: ffff8101dff87400
FS:  00002aaaaaf3b0a0(0000) GS:ffffffff8063c9c0(0000)
knlGS:000000005596c080
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000100108 CR3: 0000000000763000 CR4: 00000000000006e0
Process kswapd0 (pid: 209, threadinfo ffff8101dff7c000, task
ffff8101bff34860)
Stack: ffff810006356780 0000000100000056 ffff8100063567f0
0000000000000056
       0000000000000012 ffff8101dff58bc0 0000000000000007
ffff8101dee82180
       ffff8101dee82000 ffffffff80163a85
Call Trace:<ffffffff80163a85>{kmem_freepages+309}
<ffffffff8016411b>{slab_destroy+187}
       <ffffffff801a46a6>{write_inode_now+102}
<ffffffff8019b797>{generic_forget_inode+135}
       <ffffffff8019a72e>{iput+126} <ffffffff801995a8>{prune_dcache+424}
       <ffffffff80199627>{shrink_dcache_memory+23}
<ffffffff801687fc>{shrink_slab+204}
       <ffffffff80168aac>{balance_pgdat+572}
<ffffffff80168e27>{kswapd+327}
       <ffffffff8014d0f0>{autoremove_wake_function+0}
<ffffffff8014d0f0>{autoremove_wake_function+0}
       <ffffffff8010f11b>{child_rip+8} <ffffffff80168ce0>{kswapd+0}
       <ffffffff8010f113>{child_rip+0}
                                        
Code: 48 89 48 08 48 89 01 48 8b 05 51 d5 35 00 48 89 50 08 48 89
RIP <ffffffff801a4571>{__writeback_single_inode+881} RSP
<ffff8101dff7dc48>
CR2: 0000000000100108


