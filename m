Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUCHKRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 05:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCHKRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 05:17:49 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:42457 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S262438AbUCHKRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 05:17:47 -0500
Date: Mon, 8 Mar 2004 11:17:12 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 kernel BUG at slab.c:1439
Message-ID: <20040308101712.GA2704@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Caught this one:

kernel: kernel BUG at slab.c:1439!
kernel: invalid operand: 0000
kernel: CPU:    0
kernel: EIP:    0010:[kmem_cache_free_one+141/528]    Not tainted
kernel: EFLAGS: 00010006
kernel: eax: 178fc2a5   ebx: c2e3b020   ecx: 00008ab1   edx: c11873d8
kernel: esi: c2e3b23c   edi: c11873d8   ebp: c11e3ef0   esp: c11e3edc
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process kswapd (pid: 4, stackpage=c11e3000)
kernel: Stack: 01000108 c2e3b020 00000246 c2e3b240 c11873d8 c11e3f0c c013324d c11873d8 
kernel:        c2e3b240 c2e3b240 c2e3b240 c11e3f4c c11e3f20 c014f222 c11873d8 c2e3b240 
kernel:        c2e3b248 c11e3f3c c014fa2e c2e3b240 00000325 c4310a38 0000b1b0 00002389 
kernel: Call Trace:    [kmem_cache_free+109/192] [destroy_inode+66/80] [dispose_list+110/176] [prune_icache+102/224] [shrink_icache_memory+39/64]
kernel:   [try_to_free_pages_zone+116/208] [kswapd_balance_pgdat+108/176] [kswapd_balance+23/48] [kswapd+158/192] [rest_init+0/48] [arch_kernel_thread+38/64]
kernel:   [kswapd+0/192]
kernel: 

-- 
Frank
