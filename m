Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTBJAEg>; Sun, 9 Feb 2003 19:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTBJAEg>; Sun, 9 Feb 2003 19:04:36 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:33928 "EHLO
	humilis.humilis.net") by vger.kernel.org with ESMTP
	id <S267472AbTBJAEf>; Sun, 9 Feb 2003 19:04:35 -0500
Date: Mon, 10 Feb 2003 01:14:18 +0100
From: Ookhoi <ookhoi@humilis.net>
To: elmer@ylenurme.ee, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.59 Oops with insmod aironet4500_proc
Message-ID: <20030210011418.O19693@humilis>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Uptime: 19:47:27 up 13 days,  7:48, 22 users,  load average: 1.03, 0.93, 0.86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I try to insmod aironet4500_proc, I get an Oops. The driver 
itself is buildin (pci).

Kernel (2.5.59) is build with gcc (GCC) 3.2.2 20030131 (Debian prerelease)

module-init-tools version 0.9.9

Is there more info I should provide?

Can this have something to do with my patch for aironet4500_core.c ?
(I don't think so, but still ..)


Unable to handle kernel paging request at virtual address a0c02ee7
 printing eip:
c0125978
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0125978>]    Not tainted
EFLAGS: 00010093
EIP is at __find_symbol+0x38/0x70
eax: 00000001   ebx: c02e2f05   ecx: c037c9a0   edx: 00000000
esi: a0c02ee7   edi: c88f06c1   ebp: 00000624   esp: c7681ec8
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 161, threadinfo=c7680000 task=c771f2c0)
Stack: c7680000 c88f06c1 c88fa260 c88e4780 c012627d c88f06c1 c7681ee8 00000001 
       00000010 c88f014c 00000021 0000006a c01264de c88e4780 00000010 c88f05dc 
       c88f06c1 c88fa260 00000000 c88f05dc c88d6000 c88e4780 00000007 000002d0 
Call Trace:
 [<c012627d>] resolve_symbol+0x2d/0x80
 [<c01264de>] simplify_symbols+0xae/0x110
 [<c0126c41>] load_module+0x461/0x880
 [<c01270c9>] sys_init_module+0x69/0x1d0
 [<c0109157>] syscall_call+0x7/0xb

Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 74 16 
 <6>note: insmod[161] exited with preempt_count 1
