Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267046AbRGYWSp>; Wed, 25 Jul 2001 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267053AbRGYWS0>; Wed, 25 Jul 2001 18:18:26 -0400
Received: from [194.102.102.3] ([194.102.102.3]:12548 "EHLO ns1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S267046AbRGYWSY>;
	Wed, 25 Jul 2001 18:18:24 -0400
Date: Thu, 26 Jul 2001 01:19:17 +0300 (EEST)
From: <lk@Aniela.EU.ORG>
To: <linux-kernel@vger.kernel.org>
Subject: kernel bug : file.c at line 72
Message-ID: <Pine.LNX.4.33.0107260115060.868-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

I get this message:

kernel BUG at file.c:72!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01522e6>]
EFLAGS: 00010286
eax: 00000019   ebx: 00000000   ecx: c1472000   edx: c02aada0
esi: 00001743   edi: c04f22a0   ebp: c18d8960   esp: c1473e54
ds: 0018   es: 0018   ss: 0018
Process wget (pid: 812, stackpage=c1473000)
Stack: c024e18c c024e26d 00000048 00000793 00000800 000002e8 c1473eb0
c08bdc00
       c012da58 c04f22a0 00001743 c18d8960 00000001 00000793 c1473f58
000002e8
       00000bc7 c19a4000 c18d8a80 00000200 00001743 00000600 c18d8960
c0124a76
Call Trace: [<c012da58>] [<c0124a76>] [<c012e073>] [<c0152274>]
[<c0153a66>] [<c0152274>] [<c0121332>]
       [<c01523c2>] [<c0152399>] [<c012b6fb>] [<c0106b43>]

Code: 0f 0b 83 c4 0c b8 fb ff ff ff eb 72 8b 87 8c 00 00 00 31 d2

Jul 26 01:13:29 ns1 kernel: Call Trace: [__block_prepare_write+240/584]
[reclaim_page+806/1044] [cont_prepare_write+459/652] [fat_get_block+0/248]
[fat_prepare_write+38/44] [fat_get_block+0/248]
[generic_file_write+954/1336]
Jul 26 01:13:29 ns1 kernel:        [default_fat_file_write+34/80]
[fat_file_write+45/52] [sys_write+143/196] [system_call+51/64]
Jul 26 01:13:29 ns1 kernel:



This happens while I try to download many files using wget on a fat32
partition on a 30GB IBM disk (IBM-DTLA-307030).

This message never appeard before. I mention that the kernel is 2.4.7
patched against ipsec and vlan. With previous kernels I had no problem.




