Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267432AbTBITam>; Sun, 9 Feb 2003 14:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTBITam>; Sun, 9 Feb 2003 14:30:42 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S267432AbTBITal>; Sun, 9 Feb 2003 14:30:41 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.4.20] segfault when unloading soundmodem-driver
Date: Sun, 9 Feb 2003 20:40:22 +0100
Message-ID: <005a01c2d073$163a2140$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to unload the soundmodem-driver (for hamradio) and got a segfault.
lsmod tells me:
soundmodem                 0   0  (deleted)

and dmesg tells me:
soundmodem: (C) 1996-2000 Thomas Sailer, HB9JNX/AE4WA
soundmodem: version 0.12 compiled 02:55:25 Feb  9 2003
sm: cleanup_module called
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
d032b642
*pde = 0496c067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d032b642>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: c66a6000   ecx: 00000000   edx: cac34d60
esi: d0330c60   edi: ffffffed   ebp: bfffea08   esp: c2565f58
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 12304, stackpage=c2565000)
Stack: 00000000 00000000 000000ff c66a6000 d0330c60 d0331074 d011e43f
d0330c60
       d0330c60 d0330cc8 d032c1a6 d0330c60 d032b000 fffffff0 d032b000
c0115343
       d032b000 fffffff0 c294d000 bfffea08 c01146e7 d032b000 00000000
c2564000
Call Trace:    [<d0330c60>] [<d0331074>] [<d011e43f>] [<d0330c60>]
[<d0330c60>]
  [<d0330cc8>] [<d032c1a6>] [<d0330c60>] [<c0115343>] [<c01146e7>]
[<c0106b63>]

Code: 8b 00 50 68 92 fc 32 d0 68 a0 ff 32 d0 e8 c4 81 de ef 89 f8
 <6>

Kernel version 2.4.20

