Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSGNUIo>; Sun, 14 Jul 2002 16:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSGNUIn>; Sun, 14 Jul 2002 16:08:43 -0400
Received: from mx-00.sil.at ([62.116.68.196]:52997 "EHLO mx-00.sil.at")
	by vger.kernel.org with ESMTP id <S317058AbSGNUIl>;
	Sun, 14 Jul 2002 16:08:41 -0400
Subject: [Fwd: Re: PROBLEM: Oops in 2.4.18 (swapper)]
From: Raphael Wegmann <wegmann@psi.co.at>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-2asGO9BQzVlZI3wbWmSv"
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Jul 2002 22:12:18 +0200
Message-Id: <1026677539.1428.7.camel@exodus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2asGO9BQzVlZI3wbWmSv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I've just forgot to cc THE LIST.


--=-2asGO9BQzVlZI3wbWmSv
Content-Disposition: inline
Content-Description: Weitergeleitete Nachricht - Re: PROBLEM: Oops in 2.4.18
	(swapper)
Content-Type: message/rfc822

Subject: Re: PROBLEM: Oops in 2.4.18 (swapper)
From: Raphael Wegmann <wegmann@psi.co.at>
To: Adrian Bunk <bunk@fs.tum.de>
In-Reply-To: 	<Pine.NEB.4.44.0207141637380.4981-100000@mimas.fachschaften.tu-muenchen.de>
References: 	<Pine.NEB.4.44.0207141637380.4981-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: multipart/mixed; boundary="=-Ha9Zc1L3ZuQv6zaOyVZ1"
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Jul 2002 22:03:48 +0200
Message-Id: <1026677029.1428.3.camel@exodus>
Mime-Version: 1.0


--=-Ha9Zc1L3ZuQv6zaOyVZ1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Son, 2002-07-14 um 16.39 schrieb Adrian Bunk:
> On 12 Jul 2002, Raphael Wegmann wrote:
> 
> > Hello,
> 
> Hi Raphael,
> 
> > my plain 2.4.18 is frequently/randomly oopsing in swapper:
> >...
> > Please tell me, if I can help you somehow.
> 
> could you check whether these Oopses still appear in 2.4.19-rc1?
> 

Hello.

I just got a very similar oops during startup w/ 2.4.19-rc1
(while e2fsck was running). Btw. all that oopses end with a crash.
I've checked my memory, which is fine too.

Attached is my ksymoops output.

best regards
-- 
Raphael Wegmann
raphael@wegmann.at

--=-Ha9Zc1L3ZuQv6zaOyVZ1
Content-Disposition: attachment; filename=ksymoops5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ksymoops5; charset=ISO-8859-15

ksymoops 2.4.5 on i686 2.4.19-rc1.  Options used
     -V (default)
     -k /var/log/ksymoops/20020714234646.ksyms (specified)
     -l /var/log/ksymoops/20020714234646.modules (specified)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m /boot/System.map-2.4.19-rc1 (default)

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0
c0106f96
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0106f96>]    Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c0106f70   ecx: cfd10000   edx: cfd10270
esi: c0276000   edi: c0106f70   ebp: c0277fd0   esp: c0277fd0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=3Dc0277000)
Stack: c0277fe4 c0107012 00000000 000a0600 c0105000 c0277fec c010502a c0277=
ff8=20
       c0278747 c02b0aa0 0008e000 c0100191
Call Trace: [<c0107018>] [<c0105000>] [<c010502a>]=20
Code: ab 01 fb 89 ec 5d c3 8d 76 00 55 89 e5 fb ba 00 e0 ff ff 21=20


>>EIP; c0106f96 <default_idle+26/30>   <=3D=3D=3D=3D=3D

>>ebx; c0106f70 <default_idle+0/30>
>>ecx; cfd10000 <_end+fa2c1ac/105431ac>
>>edx; cfd10270 <_end+fa2c41c/105431ac>
>>esi; c0276000 <init_task_union+0/2000>
>>edi; c0106f70 <default_idle+0/30>
>>ebp; c0277fd0 <init_task_union+1fd0/2000>
>>esp; c0277fd0 <init_task_union+1fd0/2000>

Trace; c0107018 <cpu_idle+48/60>
Trace; c0105000 <_stext+0/0>
Trace; c010502a <rest_init+2a/30>

Code;  c0106f96 <default_idle+26/30>
00000000 <_EIP>:
Code;  c0106f96 <default_idle+26/30>   <=3D=3D=3D=3D=3D
   0:   ab                        stos   %eax,%es:(%edi)   <=3D=3D=3D=3D=3D
Code;  c0106f97 <default_idle+27/30>
   1:   01 fb                     add    %edi,%ebx
Code;  c0106f99 <default_idle+29/30>
   3:   89 ec                     mov    %ebp,%esp
Code;  c0106f9b <default_idle+2b/30>
   5:   5d                        pop    %ebp
Code;  c0106f9c <default_idle+2c/30>
   6:   c3                        ret   =20
Code;  c0106f9d <default_idle+2d/30>
   7:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0106fa0 <poll_idle+0/30>
   a:   55                        push   %ebp
Code;  c0106fa1 <poll_idle+1/30>
   b:   89 e5                     mov    %esp,%ebp
Code;  c0106fa3 <poll_idle+3/30>
   d:   fb                        sti   =20
Code;  c0106fa4 <poll_idle+4/30>
   e:   ba 00 e0 ff ff            mov    $0xffffe000,%edx
Code;  c0106fa9 <poll_idle+9/30>
  13:   21 00                     and    %eax,(%eax)


--=-Ha9Zc1L3ZuQv6zaOyVZ1--


--=-2asGO9BQzVlZI3wbWmSv--

