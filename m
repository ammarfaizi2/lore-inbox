Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRB1TEZ>; Wed, 28 Feb 2001 14:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRB1TEF>; Wed, 28 Feb 2001 14:04:05 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:45072 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129184AbRB1TEE>; Wed, 28 Feb 2001 14:04:04 -0500
Message-ID: <3A9D4BCE.5E92C965@t-online.de>
Date: Wed, 28 Feb 2001 20:04:46 +0100
From: KFPieper@t-online.de (Klaus Pieper)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ISDN Router Oopses
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I  use an older pc as ISDN router (Debian potato, kernel 2.2.17pre stock
from the distro, isdnutils 3.0-20, ssh-nonfree 1.2.27-6.1, wwwoffle).
The thing has never worked properly. I suspected hardware problems and
swapped the ram modules, but still have oopses.

I checked the memory with memtest86, was Ok. Had a kernel compilation
loop for one hour, also ok.

How can I make shure if the hardware is Ok?
What could be wrong with the software?

Here are some recent examples of the crashes.

TIA
Klaus

------------------------

Feb 26 19:25:16 groucho kernel: Oops: 0000
Feb 26 19:25:16 groucho kernel: CPU:    0
Feb 26 19:25:16 groucho kernel: EIP:    0010:[kfree+110/396]
Feb 26 19:25:16 groucho kernel: EFLAGS: 00010086
Feb 26 19:25:16 groucho kernel: eax: 00000210   ebx: c1fff080   ecx:
24548a53   edx: c123cbac
Feb 26 19:25:16 groucho kernel: esi: c123cb80   edi: 00000202   ebp:
000003cc   esp: c04cbe7c
Feb 26 19:25:16 groucho kernel: ds: 0018   es: 0018   ss: 0018
Feb 26 19:25:16 groucho kernel: Process find (pid: 1026, process nr: 27,
stackpage=c04cb000)
Feb 26 19:25:16 groucho kernel: Stack: c1cb0770 000003cc c08d7b80
c0131a57 c123cb80 00000000 c03231c8 00000403
Feb 26 19:25:16 groucho kernel:        c04cbecc 00000001 00000403
c01329ff ffffffc9 00000403 00000000 c03231c8
Feb 26 19:25:16 groucho kernel:        c02b7604 c03231c8 c08d0db0
c0848330 c04cbecc c04cbecc c0132a65 00000403
Feb 26 19:25:16 groucho kernel: Call Trace: [prune_dcache+203/280]
[try_to_free_inodes+183/248] [grow_inodes+29/416]
[get_new_inode+177/292] [get_new_inode+193/292] [iget+88/96]
[ext2_lookup+82/124]
Feb 26 19:25:16 groucho kernel:        [real_lookup+79/156]
[lookup_dentry+292/476] [__namei+38/88] [sys_newlstat+13/96]
[system_call+52/56]
Feb 26 19:25:16 groucho kernel: Code: 8b 41 08 3d 2b 2f c3 a5 0f 85 c4
00 00 00 8b 41 0c 85 c0 74

-------------

Feb 27 19:13:14 groucho kernel: Oops: 0000
Feb 27 19:13:14 groucho kernel: CPU:    0
Feb 27 19:13:14 groucho kernel: EIP:    0010:[sock_poll+24/36]
Feb 27 19:13:14 groucho kernel: EFLAGS: 00010282
Feb 27 19:13:14 groucho kernel: eax: c180e5ec   ebx: 00000000   ecx:
ffffffff   edx: c0a89ec0
Feb 27 19:13:14 groucho kernel: esi: 00000000   edi: 00000020   ebp:
00000005   esp: c0951f34
Feb 27 19:13:14 groucho kernel: ds: 0018   es: 0018   ss: 0018
Feb 27 19:13:14 groucho kernel: Process sshd (pid: 813, process nr: 23,
stackpage=c0951000)
Feb 27 19:13:14 groucho kernel: Stack: 00000000 c012f85f c0a89ec0
00000000 00000001 00000004 c1882a78 00000000
Feb 27 19:13:14 groucho kernel:        c0950000 c0950000 7fffffff
00000000 c19f9000 00000007 c012fd27 00000007
Feb 27 19:13:14 groucho kernel:        c0951fa8 c0951fa4 c0950000
00000000 00000000 bffff27c c1714be4 00000000
Feb 27 19:13:14 groucho kernel: Call Trace: [do_select+283/516]
[sys_select+991/1280] [system_call+52/56]
Feb 27 19:13:14 groucho kernel: Code: 8b 41 20 ff d0 83 c4 0c c3 8d 76
00 53 8b 5c 24 08 85 db 75


