Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131861AbRAOXqX>; Mon, 15 Jan 2001 18:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131860AbRAOXqN>; Mon, 15 Jan 2001 18:46:13 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:34573 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S131833AbRAOXqC>;
	Mon, 15 Jan 2001 18:46:02 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Oops with 4GB memory setting in 2.4.0 stable
Date: Tue, 16 Jan 2001 08:45:25 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGKENHCMAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C07F98.ABC14320"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.21.0101151946400.834-100000@freak.distro.conectiva>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C07F98.ABC14320
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I knew that, I was just testing you all.  ;-)

\e hides his head in shame



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Marcelo Tosatti
> Sent: Tuesday, January 16, 2001 6:47 AM
> To: Rainer Mager
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Oops with 4GB memory setting in 2.4.0 stable
>
>
>
>
> On Tue, 16 Jan 2001, Rainer Mager wrote:
>
> > 	Attached is my oops.txt and the result sent through
> ksymoops. The results
> > don't look particularly useful to me so perhaps I'm doing
> something wrong.
> > PLEASE tell me if I should parse this differently. Likewise, if there is
> > anything else I can do to help debug this, please tell me.
>
> It seems you forgot to attach oops.txt.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

------=_NextPart_000_0000_01C07F98.ABC14320
Content-Type: application/octet-stream;
	name="oops.parsed"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oops.parsed"

ksymoops 0.7c on i686 2.4.0.  Options used=0A=
     -v /boot/vmlinux-2.4.0-bigmem (specified)=0A=
     -K (specified)=0A=
     -L (specified)=0A=
     -o /lib/modules/2.4.0/ (default)=0A=
     -m /boot/System.map-2.4.0-bigmem (specified)=0A=
=0A=
No modules in ksyms, skipping objects=0A=
Unable to handle kernel NULL pointer dereference at virtual address =
00000000=0A=
f889e044=0A=
*pde =3D 00000000=0A=
Oops: 0002=0A=
CPU:    1=0A=
EIP:    0010:[<f889e044>]=0A=
Using defaults from ksymoops -t elf32-i386 -a i386=0A=
EFLAGS: 00010246=0A=
eax: 00000000   ebx: d5762800   ecx: 00000400   edx: c19665fc=0A=
esi: d55be120   edi: 00000000   ebp: d5764260   esp: d5505f1c=0A=
ds: 0018   es: 0018   ss: 0018=0A=
Process ls (pid: 865, stackpage=3Dd5505000)=0A=
Stack: d5762800 d55be120 d5764260 d5764260 d55be120 00000000 f889d966 =
d55be120=0A=
       d5762800 d5504000 d5764260 fffffffe fffffffb d5762800 d5764260 =
d55be120=0A=
       00000000 d5764260 bffffa40 00000006 c0140c10 d5764260 d5505fb0 =
c0140e7c=0A=
Call Trace: [<f889d966>] [<c0140c10>] [<c0140e7c>] [<c0140f9e>] =
[<c0140e7c>] [<c0108f4b>]=0A=
Code: f3 ab e9 8b 00 00 00 90 8d 74 26 00 8b 44 24 14 c7 00 00 00=0A=
=0A=
>>EIP; f889e044 <END_OF_CODE+385bfe34/????>   <=3D=3D=3D=3D=3D=0A=
Trace; f889d966 <END_OF_CODE+385bf756/????>=0A=
Trace; c0140c10 <vfs_readdir+90/ec>=0A=
Trace; c0140e7c <filldir+0/d8>=0A=
Trace; c0140f9e <sys_getdents+4a/98>=0A=
Trace; c0140e7c <filldir+0/d8>=0A=
Trace; c0108f4b <system_call+33/38>=0A=
Code;  f889e044 <END_OF_CODE+385bfe34/????>=0A=
00000000 <_EIP>:=0A=
Code;  f889e044 <END_OF_CODE+385bfe34/????>   <=3D=3D=3D=3D=3D=0A=
   0:   f3 ab                     repz stos %eax,%es:(%edi)   =
<=3D=3D=3D=3D=3D=0A=
Code;  f889e046 <END_OF_CODE+385bfe36/????>=0A=
   2:   e9 8b 00 00 00            jmp    92 <_EIP+0x92> f889e0d6 =
<END_OF_CODE+385bfec6/????>=0A=
Code;  f889e04b <END_OF_CODE+385bfe3b/????>=0A=
   7:   90                        nop    =0A=
Code;  f889e04c <END_OF_CODE+385bfe3c/????>=0A=
   8:   8d 74 26 00               lea    0x0(%esi,1),%esi=0A=
Code;  f889e050 <END_OF_CODE+385bfe40/????>=0A=
   c:   8b 44 24 14               mov    0x14(%esp,1),%eax=0A=
Code;  f889e054 <END_OF_CODE+385bfe44/????>=0A=
  10:   c7 00 00 00 00 00         movl   $0x0,(%eax)=0A=
=0A=

------=_NextPart_000_0000_01C07F98.ABC14320
Content-Type: text/plain;
	name="oops.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="oops.txt"

Unable to handle kernel NULL pointer dereference at virtual address =
00000000=0A=
 printing eip:=0A=
f889e044=0A=
*pde =3D 00000000=0A=
Oops: 0002=0A=
CPU:    1=0A=
EIP:    0010:[<f889e044>]=0A=
EFLAGS: 00010246=0A=
eax: 00000000   ebx: d5762800   ecx: 00000400   edx: c19665fc=0A=
esi: d55be120   edi: 00000000   ebp: d5764260   esp: d5505f1c=0A=
ds: 0018   es: 0018   ss: 0018=0A=
Process ls (pid: 865, stackpage=3Dd5505000)=0A=
Stack: d5762800 d55be120 d5764260 d5764260 d55be120 00000000 f889d966 =
d55be120=0A=
       d5762800 d5504000 d5764260 fffffffe fffffffb d5762800 d5764260 =
d55be120=0A=
       00000000 d5764260 bffffa40 00000006 c0140c10 d5764260 d5505fb0 =
c0140e7c=0A=
Call Trace: [<f889d966>] [<c0140c10>] [<c0140e7c>] [<c0140f9e>] =
[<c0140e7c>] [<c0108f4b>]=0A=
=0A=
Code: f3 ab e9 8b 00 00 00 90 8d 74 26 00 8b 44 24 14 c7 00 00 00=0A=
Segmentation fault=0A=

------=_NextPart_000_0000_01C07F98.ABC14320--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
