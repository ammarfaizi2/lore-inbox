Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbRESVtt>; Sat, 19 May 2001 17:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbRESVtj>; Sat, 19 May 2001 17:49:39 -0400
Received: from c1123685-a.crvlls1.or.home.com ([65.12.164.15]:22284 "EHLO
	inbetween.blorf.net") by vger.kernel.org with ESMTP
	id <S261367AbRESVt1>; Sat, 19 May 2001 17:49:27 -0400
Date: Sat, 19 May 2001 14:49:26 -0700 (PDT)
From: Jacob Luna Lundberg <kernel@gnifty.net>
Reply-To: jacob@chaos2.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 del_timer_sync oops in schedule_timeout
Message-ID: <Pine.LNX.4.21.0105191417490.2956-100000@inbetween.blorf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is 2.4.4 with the aic7xxx driver version 6.1.13 dropped in.
The oops got eaten by klogd, my apologies, but it seems sane even so.
I haven't tried newer -ac or -pre kernels so I'm sure it's probably
already fixed there but just in case it isn't...


kdm[350]: Server for display :0 terminated unexpectedly: 2816
Unable to handle kernel paging request at virtual address 78626970
printing eip:
c011bf13
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[del_timer_sync+47/132]
EFLAGS: 00010006
eax: 732e7872   ebx: 00000246   ecx: c651ff28   edx: 7862696c
esi: 00000000   edi: 00100000   ebp: c651df3c   esp: c651df0c
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 356, stackpage=c651d000)
Stack: c651ff28 0007edbb c0112b54 c651ff28 c651df28 00000000 c3b45260 c02ec12c
       c02ec12c 0007edbb c651c000 c0112a80 c651df70 c0140b7c 00000008 00000020
       c7aea140 00000000 00000304 c651c000 00002d24 00000015 00000000 00000000
Call Trace: [schedule_timeout+120/144] [process_timeout+0/92]
[do_select+456/512] [sys_select+816/1136] [system_call+55/64]
Code: 89 42 04 89 10 b8 01 00 00 00 01 c6 a1 68 20 30 c0 c7 41 04

