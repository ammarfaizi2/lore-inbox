Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTJVIoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 04:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTJVIoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 04:44:22 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:64640 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S263462AbTJVIoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 04:44:20 -0400
Date: Wed, 22 Oct 2003 10:44:13 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8, oops, [__remove_from_page_cache+36/112] __remove_from_page_cache+0x24/0x70
Message-ID: <20031022084413.GA2773@finwe.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This machine has new RAM, but after about 7 hours of testing, memtest.86 didn't
show any errors... 

More system details below.

Unable to handle kernel NULL pointer dereference at virtual address 00000006
 printing eip:
c01acc43
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[radix_tree_delete+83/256]    Not tainted
EFLAGS: 00010206
EIP is at radix_tree_delete+0x53/0x100
eax: 00000006   ebx: 0000001e   ecx: 00000024   edx: 00000002
esi: c13a7d3c   edi: 00000000   ebp: c295f490   esp: c13a7d1c
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 8, threadinfo=c13a6000 task=c13aacc0)
Stack: cffe7b6c c3be4cb0 00000006 00000000 00000000 c295f498 c108e238 c108e23c 
       00000002 00000006 c10cdaa0 c108d518 c108d4a0 c108e4e0 c108e490 c108e440 
       c108e418 c108e3c8 c108e2b0 c10bfab8 c108e238 c295f48c 00000001 c13a6000 
Call Trace:
 [__remove_from_page_cache+36/112] __remove_from_page_cache+0x24/0x70
 [shrink_list+1032/1376] shrink_list+0x408/0x560
 [__pte_chain_free+113/128] __pte_chain_free+0x71/0x80
 [shrink_cache+416/800] shrink_cache+0x1a0/0x320
 [shrink_zone+126/176] shrink_zone+0x7e/0xb0
 [balance_pgdat+410/544] balance_pgdat+0x19a/0x220
 [kswapd+277/304] kswapd+0x115/0x130
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [kswapd+0/304] kswapd+0x0/0x130
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Code: 8b 10 85 d2 74 57 89 56 08 88 d9 89 f8 d3 e8 83 eb 06 83 e0 
 <6>note: kswapd0[8] exited with preempt_count 1


config: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test8/config

cpuinfo: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test8/cpuinfo
dmesg: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test8/dmesg
lsmod: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test8/lsmod
lspci: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test8/lspci
vmstat: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test8/vmstat

I can provide more information if needed. :)

bye

-- 
Jacek Kawa    **W Mys³owicach to wogóle nie ma przyci±gania ziemskiego.
            Tam trzeba pó³ litra wypiæ, ¿eby by³o przyci±ganie ziemskie.**
