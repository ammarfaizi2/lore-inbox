Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131745AbQJ2PrF>; Sun, 29 Oct 2000 10:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131784AbQJ2Pqz>; Sun, 29 Oct 2000 10:46:55 -0500
Received: from dialup308.canberra.net.au ([203.33.188.180]:9988 "EHLO
	didi.localnet") by vger.kernel.org with ESMTP id <S131745AbQJ2Pqq>;
	Sun, 29 Oct 2000 10:46:46 -0500
Message-ID: <029f01c041be$fab45d90$0200a8c0@W2K>
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: test9 oops (in block_read_full_page)
Date: Mon, 30 Oct 2000 02:43:25 +1100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_029C_01C0421B.2D367DF0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_029C_01C0421B.2D367DF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I apologise if this oops has already been fixed: it has happened twice but I
can't find the exact way to trigger it, I just want to make sure it is
reported ;)

Nick

------=_NextPart_000_029C_01C0421B.2D367DF0
Content-Type: application/octet-stream;
	name="oops"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oops"

Unable to handle kernel paging request at virtual address f8e400cc=0A=
c013020a=0A=
*pde =3D 00000000=0A=
Oops: 0000=0A=
CPU:    0=0A=
EIP:    0010:[<c013020a>]=0A=
Using defaults from ksymoops -t elf32-i386 -a i386=0A=
EFLAGS: 00010202=0A=
eax: f8e400c0   ebx: c3fdb3d0   ecx: c1a7c81f   edx: c1033c48=0A=
esi: c1033c48   edi: c1a7c8bc   ebp: 00000000   esp: c1b91ee4=0A=
ds: 0018   es: 0018   ss: 0018=0A=
Process bash (pid: 383, stackpage=3Dc1b91000)=0A=
Stack: c3fdb3d0 c1033c48 c1a7c8bc 00000000 c02677c0 c012a44a 00000000 =
c0267a58=0A=
       c1a7c8bc c1a7c81f c012a5b8 c0267a4c 00000000 00000001 00000001 =
00000000=0A=
       00000000 c1a7c8bc c014e33f c1033c48 c014dca0 c0123275 c1531cc0 =
c1033c48=0A=
Call Trace: [<c012a44a>] [<c012a5b8>] [<c014e33f>] [<c014dca0>] =
[<c0123275>] [<c012355b>] [<c01234a0>]=0A=
       [<c012db56>] [<c010a4d3>]=0A=
Code: 8b 68 0c 8b 44 24 4c 83 78 38 00 75 0b 55 51 50 e8 b1 fa ff=0A=
=0A=
>>EIP; c013020a <block_read_full_page+4a/1f0>   <=3D=3D=3D=3D=3D=0A=
Trace; c012a44a <__alloc_pages_limit+8a/b0>=0A=
Trace; c012a5b8 <__alloc_pages+148/300>=0A=
Trace; c014e33f <ext2_readpage+f/20>=0A=
Trace; c014dca0 <ext2_get_block+0/490>=0A=
Trace; c0123275 <do_generic_file_read+2a5/4d0>=0A=
Trace; c012355b <generic_file_read+5b/80>=0A=
Trace; c01234a0 <file_read_actor+0/60>=0A=
Trace; c012db56 <sys_read+96/d0>=0A=
Trace; c010a4d3 <system_call+33/38>=0A=
Code;  c013020a <block_read_full_page+4a/1f0>=0A=
00000000 <_EIP>:=0A=
Code;  c013020a <block_read_full_page+4a/1f0>   <=3D=3D=3D=3D=3D=0A=
   0:   8b 68 0c                  mov    0xc(%eax),%ebp   <=3D=3D=3D=3D=3D=0A=
Code;  c013020d <block_read_full_page+4d/1f0>=0A=
   3:   8b 44 24 4c               mov    0x4c(%esp,1),%eax=0A=
Code;  c0130211 <block_read_full_page+51/1f0>=0A=
   7:   83 78 38 00               cmpl   $0x0,0x38(%eax)=0A=
Code;  c0130215 <block_read_full_page+55/1f0>=0A=
   b:   75 0b                     jne    18 <_EIP+0x18> c0130222 =
<block_read_full_page+62/1f0>=0A=
Code;  c0130217 <block_read_full_page+57/1f0>=0A=
   d:   55                        push   %ebp=0A=
Code;  c0130218 <block_read_full_page+58/1f0>=0A=
   e:   51                        push   %ecx=0A=
Code;  c0130219 <block_read_full_page+59/1f0>=0A=
   f:   50                        push   %eax=0A=
Code;  c013021a <block_read_full_page+5a/1f0>=0A=
  10:   e8 b1 fa ff 00            call   fffac6 <_EIP+0xfffac6> c112fcd0 =
<_end+e539dc/4550d0c>=0A=
 =0A=

------=_NextPart_000_029C_01C0421B.2D367DF0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
