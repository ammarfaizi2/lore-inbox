Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbRH0WFP>; Mon, 27 Aug 2001 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269395AbRH0WFF>; Mon, 27 Aug 2001 18:05:05 -0400
Received: from kyla.kiruna.se ([193.45.225.152]:34572 "EHLO kyla.kiruna.se")
	by vger.kernel.org with ESMTP id <S269390AbRH0WEw>;
	Mon, 27 Aug 2001 18:04:52 -0400
Date: Tue, 28 Aug 2001 00:05:07 +0200 (CEST)
From: Michael Liljeblad <mld@kyla.kiruna.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 oops in clear_inode()
Message-ID: <Pine.LNX.4.10.10108272350140.19881-100000@kyla.kiruna.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just received this oops while executing a 'dpkg --purge something'. The
system was under no load at all. I have not found a way to repeat it.
No fsck has been performed, yet.

Unpatched 2.4.9 UP
gcc version 2.95.4 20010506 (Debian prerelease)
AMD Athlon on ABIT KT7A (KT133A)
IDE only.

/Michael


Unable to handle kernel paging
request at virtual address 0005006b
printing eip:
c0142208
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[clear_inode+200/288]
EFLAGS: 00013202
eax: 0005003b   ebx: d18fd640   ecx: d18fd648   edx: c18bbfa0
esi: c18bbfa0   edi: c02892a4   ebp: c18bbfa8   esp: c18bbf70
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c18bb000)
Stack:
d18fd640 c014229f d18fd640 c6c74548 c6c74540 c0142522 c18bbfa0 00000006
000000c0 0000003f 00000000 0000000c c18bbfa0 c18bbfa0 00000001 c0142568
0000000a c01291b1 00000006 000000c0 00000006 000000c0 c18ba000 c02411b1

Call Trace:
[dispose_list+63/96]
[prune_icache+242/288]
[shrink_icache_memory+24/64]
[do_try_to_free_pages+81/176]
[kswapd+105/176]
[kernel_thread+40/64]

Code: 8b 40 30 85 c0 74 06 53 ff d0 83 c4 04 8b 83 e4 00 00 00 85




