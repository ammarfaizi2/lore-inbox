Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbRGPQ2Z>; Mon, 16 Jul 2001 12:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbRGPQ2P>; Mon, 16 Jul 2001 12:28:15 -0400
Received: from mail.erste.de ([195.243.98.251]:58979 "EHLO RalfBurger.com")
	by vger.kernel.org with ESMTP id <S267452AbRGPQ2A>;
	Mon, 16 Jul 2001 12:28:00 -0400
Date: Mon, 16 Jul 2001 18:28:02 +0200 (CEST)
From: "Victoria W." <wicki@terror.de>
To: linux-kernel@vger.kernel.org
cc: volker@erste.de
Subject: oops in 2.4.6/2.4.5
In-Reply-To: <20010716161031Z267445-720+2808@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10107161814140.3877-100000@csb.terror.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

a fax-machine with cyclades-8-card (isa) 256MB, 1GB ext2, 1GB swap, 40GB
reiserfs hangs after a period of time (8-48h) with an oops.
It seems to hang on a "sync" but the messages are not the same every time.
(there was a dead "sync" process in "ps x")

the same behaviour occurs in 2.4.5 and 2.4.6.

I've tried to reproduce the crash by pushing the load up to >100 - but
nothing happens. But within 48h the machine hung again.

Do you have any hints or ideas what to do now ?

best regards
wicki



here is one oops-example:
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0005bed
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0005bed>]
EFLAGS: 00010246
eax: 00000000   ebx: cf3f2690   ecx: c9d80260   edx: c9d80260
esi: cab5dfb8   edi: cab5c000   ebp: 00000000   esp: cab5dfa8
ds: 0018   es: 0018   ss: 0018
Process loop5 (pid: 270, stackpage=cab5d000)
Stack: cab5c000 cecd5f28 cf3f258c c77c1500 00000001 cab5c000 cf3f269c
cf3f269c 
       c0105ca3 cf3f2690 c77c1500 d08288f6 00000f00 cecd5f28 cf3f258c
ffff0303 
       00000078 c010563b c0105644 cf3f258c 00000078 cf229860 
Call Trace: [<c0105ca3>] [<c010563b>] [<c0105644>] 

Code: 00 00 00 7c 67 13 08 32 00 00 00 21 cc 01 cc 61 cb 41 cb 61 

and here an other one from the same machine:

kernel: kernel BUG at page_alloc.c:75!
kernel: invalid operand: 0000
kernel: CPU:    0





