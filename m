Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132394AbRAVQAy>; Mon, 22 Jan 2001 11:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132490AbRAVQAp>; Mon, 22 Jan 2001 11:00:45 -0500
Received: from picard.csihq.com ([204.17.222.1]:35713 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S132394AbRAVQAi>;
	Mon, 22 Jan 2001 11:00:38 -0500
Message-ID: <031d01c0848c$7561b780$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        "raid" <linux-raid@vger.rutgers.edu>
Subject: RAID oops 2.4.0ac10
Date: Mon, 22 Jan 2001 11:00:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of rebuilding a RAID1 mirror set:

Oops: 0000
CPU: 0
EIP: 0010:[<c01ba01f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0010286
eax: 00000000 ebx: f7ab284c ecx: 00000000 edx: 00000002
esi: f7a6ef60 edi: ffffffff ebp: f7a63300 esp: f7a71ed8
ds: 0018 es: 0018 ss: 0018
Process mdrecoveryd (pid: 7, stackpage=f7a71000)
Stack: f7a64f18 f7a64ec0 f7a63000 f7a71fb0 00000286 00000001 f7a63280
f7a63000
        f7a62828 f7a62800 00000001 00000000 f7a71bf0 f7a71f3c 00000000
f7a71f3c
        f7a64f2c 00000006 09009e0a 00000000 01388ac0 c01716ce 00000000
c028e5e0
Call Trace: c01716ce c01c048b c01fb37a c01074c4
Code: 8b 41 38 89 46 38 89 51 38 8d 7c 24 30 89 ee fc b9 20 00 00

>>EIP; c01ba01f <raid1_diskop+2f7/4f8>   <=====
Trace; c01716ce <vt_console_print+2c2/2d8>
Trace; c01c048b <md_do_recovery+1ef/25c>
Trace; c01fb37a <translate_table+266/5bc>
Trace; c01074c4 <kernel_thread+28/38>
Code;  c01ba01f <raid1_diskop+2f7/4f8>
00000000 <_EIP>:
Code;  c01ba01f <raid1_diskop+2f7/4f8>   <=====
Code;  c01ba01f <raid1_diskop+2f7/4f8>   <=====
   0:   8b 41 38                  mov    0x38(%ecx),%eax   <=====
Code;  c01ba022 <raid1_diskop+2fa/4f8>
   3:   89 46 38                  mov    %eax,0x38(%esi)
Code;  c01ba025 <raid1_diskop+2fd/4f8>
   6:   89 51 38                  mov    %edx,0x38(%ecx)
Code;  c01ba028 <raid1_diskop+300/4f8>
   9:   8d 7c 24 30               lea    0x30(%esp,1),%edi
Code;  c01ba02c <raid1_diskop+304/4f8>
   d:   89 ee                     mov    %ebp,%esi
Code;  c01ba02e <raid1_diskop+306/4f8>
   f:   fc                        cld
Code;  c01ba02f <raid1_diskop+307/4f8>
  10:   b9 20 00 00 00            mov    $0x20,%ecx


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
