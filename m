Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263474AbUCTQke (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUCTQke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:40:34 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:5834 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263474AbUCTQkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:40:25 -0500
Date: Sat, 20 Mar 2004 08:40:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <2696880000.1079800826@[10.10.2.4]>
In-Reply-To: <20040320161905.GT9009@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, first I did the whole of -aa2, it boots OK, but panics as soon as I try
to connect with ssh. I'll try the broken out bits next.

M.

Unable to handle kernel NULL pointer dereference at virtual address 00000003
 printing eip:
c013f504
*pde = 2e820001
*pte = 00000000
Oops: 0000 [#1]
SMP 
CPU:    15
EIP:    0060:[<c013f504>]    Not tainted
EFLAGS: 00010292   (2.6.5-rc1-aa2) 
EIP is at do_no_page+0xc4/0x45c
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: ee5eea60   edi: ee5a3ec8   ebp: ee9c52a0   esp: ee5a3e94
ds: 007b   es: 007b   ss: 0068
Process sshd (pid: 19069, threadinfo=ee5a2000 task=ee69a870)
Stack: 00000000 eeb43340 00000001 ee9c52a0 c3ba2820 00000000 40268000 ee5a3ec8 
       ee9c52a0 ee69a870 ee5eea60 00000000 ef6a6134 00000001 c013fa0f ee9c52a0 
       ee5eea60 40268000 00000001 eeb43340 eeea8008 ee9c52a0 ee69a870 ee5eea60 
Call Trace:
 [<c013fa0f>] handle_mm_fault+0xc7/0x190
 [<c0114fc3>] do_page_fault+0x13b/0x540
 [<c0114e88>] do_page_fault+0x0/0x540
 [<c0140feb>] do_mmap_pgoff+0x4b7/0x5fc
 [<c010d24b>] sys_mmap2+0x67/0x98
 [<c01075f9>] error_code+0x2d/0x38

Code: 0f b6 41 03 8b 14 85 80 a9 35 c0 89 c8 2b 82 84 0b 00 00 69 

