Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSKXOhL>; Sun, 24 Nov 2002 09:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSKXOhL>; Sun, 24 Nov 2002 09:37:11 -0500
Received: from services.cam.org ([198.73.180.252]:43028 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261330AbSKXOhK>;
	Sun, 24 Nov 2002 09:37:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: akpm@digeo.com
Subject: Re: hugetlb page patch for 2.5.48-bug fixes
Date: Sun, 24 Nov 2002 09:44:10 -0500
User-Agent: KMail/1.4.3
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <25282B06EFB8D31198BF00508B66D4FA03EA5B14@fmsmsx114.fm.intel.com>
In-Reply-To: <25282B06EFB8D31198BF00508B66D4FA03EA5B14@fmsmsx114.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211240944.10660.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just after or during an apt-get -u upgrade I found this in my log.  Not
susprisingly I had to reboot shortly after - X did not want to display
fonts.  This using up-to-date debian unstable and 2.5.49-mm1 shpte=y.

Hope this helps 
Ed Tomlinson

Nov 24 08:38:35 oscar -- MARK --
Nov 24 08:54:38 oscar kernel: bounds: 0000
Nov 24 08:54:38 oscar kernel: CPU:    0
Nov 24 08:54:38 oscar kernel: EIP:    0060:[i8042_exit+155901274/-1072694240]    Not tainted
Nov 24 08:54:38 oscar kernel: EFLAGS: 00010283
Nov 24 08:54:38 oscar kernel: EIP is at 0x94ae13a
Nov 24 08:54:38 oscar kernel: eax: dfdee040   ebx: c33151f4   ecx: c02b7ca2   edx: 094ae040
Nov 24 08:54:38 oscar kernel: esi: dfdce000   edi: 00000056   ebp: dfdce000   esp: dfdcfe80
Nov 24 08:54:38 oscar kernel: ds: 0068   es: 0068   ss: 0068
Nov 24 08:54:38 oscar kernel: Process kswapd0 (pid: 5, threadinfo=dfdce000 task=c151f840)
Nov 24 08:54:38 oscar kernel: Stack: 48094ae0 c015a7d8 c33151f4 dab225e0 c015965f c33151f4 dfdce000 0000004d
Nov 24 08:54:38 oscar kernel:        00000056 c015836f dab225e0 000001d0 00000000 c01586b6 00000056 c0134b5c
Nov 24 08:54:38 oscar kernel:        00000056 000001d0 01ee7b30 00000000 000186fe dffee760 00000212 c02b6cb4
Nov 24 08:54:38 oscar kernel: Call Trace:
Nov 24 08:54:38 oscar kernel:  [iput+88/128] iput+0x58/0x80
Nov 24 08:54:38 oscar kernel:  [prune_one_dentry+63/128] prune_one_dentry+0x3f/0x80
Nov 24 08:54:38 oscar kernel:  [prune_dcache+175/192] prune_dcache+0xaf/0xc0
Nov 24 08:54:38 oscar kernel:  [shrink_dcache_memory+54/64] shrink_dcache_memory+0x36/0x40
Nov 24 08:54:38 oscar kernel:  [shrink_slab+252/352] shrink_slab+0xfc/0x160
Nov 24 08:54:38 oscar kernel:  [balance_pgdat+243/352] balance_pgdat+0xf3/0x160
Nov 24 08:54:38 oscar kernel:  [kswapd+291/320] kswapd+0x123/0x140
Nov 24 08:54:38 oscar kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Nov 24 08:54:38 oscar kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Nov 24 08:54:38 oscar kernel:  [kswapd+0/320] kswapd+0x0/0x140
Nov 24 08:54:38 oscar kernel:  [kernel_thread_helper+5/36] kernel_thread_helper+0x5/0x24
Nov 24 08:54:38 oscar kernel:
Nov 24 08:54:38 oscar kernel: Code:  Bad EIP value.
Nov 24 08:54:38 oscar kernel:  <6>note: kswapd0[5] exited with preempt_count 1
Nov 24 08:54:38 oscar kernel: Call Trace:
Nov 24 08:54:38 oscar kernel:  [profile_exit_task+18/96] profile_exit_task+0x12/0x60
Nov 24 08:54:38 oscar kernel:  [do_exit+112/768] do_exit+0x70/0x300
Nov 24 08:54:38 oscar kernel:  [do_bounds+0/32] do_bounds+0x0/0x20
Nov 24 08:54:38 oscar kernel:  [die+105/128] die+0x69/0x80
Nov 24 08:54:38 oscar kernel:  [do_bounds+26/32] do_bounds+0x1a/0x20
Nov 24 08:54:38 oscar kernel:  [error_code+45/64] error_code+0x2d/0x40
Nov 24 08:54:38 oscar kernel:  [iput+88/128] iput+0x58/0x80
Nov 24 08:54:38 oscar kernel:  [prune_one_dentry+63/128] prune_one_dentry+0x3f/0x80
Nov 24 08:54:38 oscar kernel:  [prune_dcache+175/192] prune_dcache+0xaf/0xc0
Nov 24 08:54:38 oscar kernel:  [shrink_dcache_memory+54/64] shrink_dcache_memory+0x36/0x40
Nov 24 08:54:38 oscar kernel:  [shrink_slab+252/352] shrink_slab+0xfc/0x160
Nov 24 08:54:38 oscar kernel:  [balance_pgdat+243/352] balance_pgdat+0xf3/0x160
Nov 24 08:54:38 oscar kernel:  [kswapd+291/320] kswapd+0x123/0x140
Nov 24 08:54:38 oscar kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Nov 24 08:54:38 oscar kernel:  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
Nov 24 08:54:38 oscar kernel:  [kswapd+0/320] kswapd+0x0/0x140
Nov 24 08:54:38 oscar kernel:  [kernel_thread_helper+5/36] kernel_thread_helper+0x5/0x24
Nov 24 08:54:38 oscar 
