Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265666AbSJSTMj>; Sat, 19 Oct 2002 15:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSJSTMj>; Sat, 19 Oct 2002 15:12:39 -0400
Received: from [210.224.164.100] ([210.224.164.100]:35337 "EHLO sh.7501.net")
	by vger.kernel.org with ESMTP id <S265666AbSJSTML>;
	Sat, 19 Oct 2002 15:12:11 -0400
Date: Sun, 20 Oct 2002 04:18:12 +0900 (JST)
From: date <nobu@7501.net>
Message-Id: <200210191918.g9JJICT3032735@sh.7501.net>
To: linux-kernel@vger.kernel.org
Subject: Fragmentation DoS?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To whom this may concern:

 It seems that when I run fragrouter-1.7 with a combination of
 -F3, -F4, -F5, and -T7 options, my linux kernel 2.4.18 will
 crash. I've tested this with fragrouter's 1.6 and 1.5, but have
 not yet been able to crash my kernel. To crash my 2.4.18 remotely
 with fragrouter 1.7 it usually takes about 15-20 tries. Maybe there
 is some sort of race condition occuring? I have also tried to
 crash my linux 2.2.x series kernals but have failed.

 Here are the sources I have been testing with:
 www.anzen.com/archive/research/fragrouter-1.7.tar.gz
 www.anzen.com/archive/research/fragrouter-1.6.tar.gz

 Here is the kernel oops message that I grabbed from messages:

general protection fault: 0000
CPU:    0
EIP:    0010:[<c0141099>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: ffffffff   ecx: 00000018   edx: c0141080
esi: c12c3e30   edi: ffffffff   ebp: ffffffff   esp: cfc95db0
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 59, stackpage=cfc95000)
Stack: 00000000 c0feb020 c01284ca ffffffff c12c3e30 00000001 00000001
000000f0
       c0feb000 c139c1a0 00000080 00000000 00000008 c12c3e30 00000246
c12c3e38
       000000f0 c01285f9 c12c3e30 000000f0 c0178612 00000000 00000000
00000008
Call Trace:    [<c01284ca>] [<c01285f9>] [<c0178612>] [<c0131a84>]
[<c0131b46>]
  [<c0131d88>] [<c0132428>] [<c01231fd>] [<c0123298>] [<c0151aa0>]
[<c01238a5>]
  [<c0123c03>] [<c012403c>] [<c0123f40>] [<c012fd56>] [<c012fca9>]
[<c01087eb>]

Code: f3 ab c7 43 48 00 00 00 00 8d 53 48 8d 43 4c 89 42 04 89 42

 Thanks for your time

 - nobu
