Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbTBJMKv>; Mon, 10 Feb 2003 07:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267788AbTBJMKv>; Mon, 10 Feb 2003 07:10:51 -0500
Received: from web41405.mail.yahoo.com ([66.218.93.71]:185 "HELO
	web41405.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264838AbTBJMKt>; Mon, 10 Feb 2003 07:10:49 -0500
Message-ID: <20030210122030.89851.qmail@web41405.mail.yahoo.com>
Date: Mon, 10 Feb 2003 23:20:30 +1100 (EST)
From: =?iso-8859-1?q?Con=20Kolivas?= <ckolivas@yahoo.com.au>
Subject: oops with 2.5.59-mm10
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After doing a contest benchmark had this show up on
the serial console when I sent the machine a reboot
command. This is with mm10 minus the smalldevfs patch.
It still proceeded as expected:

Unable to handle kernel paging request at virtual
address 8efe26fc
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c01673da>]    Not tainted
EFLAGS: 00010246
EIP is at ext3_readdir+0x92/0x468
eax: c78a02a0   ebx: c78a02a0   ecx: cfdd9000   edx:
c5086000
esi: c78a030c   edi: cfb1c760   ebp: 00000000   esp:
c5087eec
ds: 007b   es: 007b   ss: 0068
Process dbench (pid: 7267, threadinfo=c5086000
task=cee55300)
Stack: c78a02a0 c78a030c cfb1c760 00000000 c5087f80
c78a02a0 cfdd9000 c5086000
       c5087f10 00000302 00000000 00000000 00023a48
000041c0 0000000b 00000000
       00000000 00000000 00000000 00000000 00001000
00000000 00001000 00000008
Call Trace:
 [<c014a4ac>] vfs_readdir+0x4c/0x60
 [<c014a75c>] filldir64+0x0/0x104
 [<c014a8c7>] sys_getdents64+0x67/0xb2
 [<c014a75c>] filldir64+0x0/0x104
 [<c0149c5d>] sys_fcntl64+0x5d/0x70
 [<c0149c69>] sys_fcntl64+0x69/0x70
 [<c0108a43>] syscall_call+0x7/0xb

Code: 18 8b 5c 24 74 c7 44 24 20 00 00 00 00 8b 50 0c
8b 4b 20 4a
 <7>serio: kseriod exiting


http://greetings.yahoo.com.au - Yahoo! Greetings
- Send your seasons greetings online this year!
