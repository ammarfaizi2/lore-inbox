Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWJTJy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWJTJy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWJTJy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:54:59 -0400
Received: from smtp19.orange.fr ([80.12.242.19]:53608 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S1751702AbWJTJy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:54:58 -0400
X-ME-UUID: 20061020095457149.248CF1C00081@mwinf1924.orange.fr
Date: Fri, 20 Oct 2006 11:54:56 +0200
From: Julien Kirmaier <julien.kirmaier@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/swap.c:340
Message-ID: <20061020095456.GA24360@thabor.lan.ah2d.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Conspiracy Inc.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel maintainers,

  while processing with gs rather large postscript files (~1Go) the kernel 
pulled this message in the console:

<<<<<
kernel BUG at mm/swap.c:340!
invalid opcode: 0000 [#1]
Modules linked in: parport_serial bsd_comp ppp_deflate zlib_deflate 
ppp_synctty ppp_generic slhc via_rhine nfs lockd sunrpc smbfs ntfs vfat fat 
genrtc
CPU:    0
EIP:    0060:[<c01367b2>]    Not tainted VLI
EFLAGS: 00010202   (2.6.18 #2) 
EIP is at __pagevec_release_nonlru+0x26/0x71
eax: ffffffff   ebx: c1ad7e24   ecx: 00000007   edx: c158f848
esi: f1d57ca0   edi: f1d57ca0   ebp: c1ad7f2c   esp: c1ad7dc0
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 79, ti=c1ad6000 task=c19e8570 task.ti=c1ad6000)
Stack: 00000007 00000001 c148c1e0 c15a5c80 c1691b80 c134a800 c1336120 c117c340 
       c10a5600 00018a8e c10f3040 c10f3040 c0137389 c10f3040 c10f3040 c10f3040 
       c10f3040 c013764c c1ad7e24 00000001 00000001 0000001c 00000000 c1ad7e1c 
Call Trace:
 [<c0137389>] remove_mapping+0x4a/0x5c
 [<c013764c>] shrink_page_list+0x2b1/0x33d
 [<c013780c>] shrink_inactive_list+0x78/0x1bb
 [<c0137071>] shrink_slab+0x61/0x18c
 [<c013718d>] shrink_slab+0x17d/0x18c
 [<c0137d37>] shrink_zone+0xa9/0xc6
 [<c01380f4>] balance_pgdat+0x1b5/0x2c0
 [<c01382f4>] kswapd+0xf5/0xf9
 [<c0121206>] autoremove_wake_function+0x0/0x3a
 [<c0121206>] autoremove_wake_function+0x0/0x3a
 [<c01381ff>] kswapd+0x0/0xf9
 [<c0120f26>] kthread+0x7c/0xa2
 [<c0120eaa>] kthread+0x0/0xa2
 [<c0100d19>] kernel_thread_helper+0x5/0xb
Code: 00 00 00 5b c3 53 31 c9 83 ec 40 8b 5c 24 48 c7 04 24 00 00 00 00 3b 
0b 8b 43 04 89 44 24 04 73 3b 8b 54 8b 08 8b 02 a8 20 74 08 <0f> 0b 54 01 5b 
f5 2e c0 8b 42 04 85 c0 75 08 0f 0b 2c 01 ba f4 
EIP: [<c01367b2>] __pagevec_release_nonlru+0x26/0x71 SS:ESP 0068:c1ad7dc0
>>>>>

  The machine did not halt after this message as it did two weeks ago. I 
thought at the time that bad RAM was involved so I replaced it; memtest86 
did not return anything wrong with the new 1Go RAM module.

  I'm running 2.6.18 vanilla kernel on Debian Sarge, raid-1 software, the 
swap space is also on raid1.

  Tell me if you need more informations (or to whom I should address this
message if linux.kernel is not relevant).

  Sincerely,

JKr

-- 
Julien Kirmaier <julien.kirmaier@gmail.com>
   -+-  Only the paranoid survive -+-

