Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbQLIOO0>; Sat, 9 Dec 2000 09:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130679AbQLIOOQ>; Sat, 9 Dec 2000 09:14:16 -0500
Received: from web1.clubnet.net ([206.126.128.3]:30224 "EHLO web1.clubnet.net")
	by vger.kernel.org with ESMTP id <S130241AbQLIOOC>;
	Sat, 9 Dec 2000 09:14:02 -0500
Message-ID: <002301c061e6$196b2b00$558d7ece@snowline.net>
From: "Eddy" <edmc@snowline.net>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.2.16 and 2.2.17 nfsroot boot problem with D-Link DE-220PCT
Date: Sat, 9 Dec 2000 05:44:04 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0020_01C061A3.0A76DF60"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0020_01C061A3.0A76DF60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Well heres my first attempt at kernel debugging the problem posted =
yesterday. I some magic sysrq-<P> on the 486 after the Donald Becker =
eth0 message displayed. I had to hand write the EIP trace and then enter =
it into ksysmoops. Don't know if it will help but I'll try recompiling =
the kernel without any APM stuff and see what happens.

sysrq<T>
                        free                        sibling
  task             PC    stack   pid father child younger older
swapper   -1 R current   6248     1      0     5
   sig: 0 0000000000000000 0000000000000000 : X
kflushed   2 S c0233fb0  7084     2      1            3
   sig: 0 0000000000000000 0000000000000000 : X
kupdate    3 S c0231fc8  7108     3      1            4      2
   sig: 0 0000000000000000 ffffffffffffffff : X
kpiod      4 S 00000f00     0     4      1            5      3
   sig: 0 0000000000000000 ffffffffffffffff : X
kswapd     5 S c009dfd4  3120     5      1                   4
   sig: 0 0000000000000000 ffffffffffffffff : X

sysrq<P>

ksymoops 0.7c on i686 2.2.16-Eds2nd.  Options used
     -v nfsroot-486-02-vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m nfsroot-486-02-System.map (specified)

EIP: 0010:[<c0106942>] EFLAGS: 00000286
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 00000000 EBX: 00000003 ECX: c0007f60 EDX: 00000003
ESI: c0106b00 EDI: c01ce564 EBP: c0007f60 DS: 0018 ES: 0018
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ad8c>] EFLAGS: 00000212
EAX: 00003636 EBX: 00000000 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0010:[<c01062d0>] EFLAGS: 00000296
EAX: c0007f08 EBX: c0007f26 ECX: 00000000 EDX: 00000000
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0018 ES: 0018
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000bf66>] EFLAGS: 00000202
EAX: 0000530b EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ada3>] EFLAGS: 00000282
EAX: 000036f3 EBX: 00000000 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000bf85>] EFLAGS: 00000212
EAX: 00000000 EBX: 00000016 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ad92>] EFLAGS: 00000212
EAX: 00003636 EBX: 00000050 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000bfb6>] EFLAGS: 00000202
EAX: 0000530b EBX: 00000050 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ada7>] EFLAGS: 00000282
EAX: 000036fe EBX: 00000050 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ad9f>] EFLAGS: 00000282
EAX: 0000fe36 EBX: 00000050 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000bfp6>] EFLAGS: 00000202
EAX: 0000530b EBX: 00000050 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ad9b>] EFLAGS: 00000282
EAX: 0000fe36 EBX: 00000050 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000c114>] EFLAGS: 00000202
EAX: 00000016 EBX: 00000003 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0000 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000bf85>] EFLAGS: 00000212
EAX: 00000000 EBX: 00000016 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ad9b>] EFLAGS: 00000282
EAX: 0000fe36 EBX: 00000000 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ada7>] EFLAGS: 00000282
EAX: 000036fe EBX: 00000000 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<0000ad8e>] EFLAGS: 00000212
EAX: 00003636 EBX: 00000000 ECX: 00000000 EDX: 00000050
ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: 0058 ES: 0000
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<c0106320>] EFLAGS: 00000202
EAX: c0007f0c EBX: c0007f14 ECX: c0007f14 EDX: 00000000
ESI: c0106b00 EDI: c0007508 EBP: c0007f10 DS: 0018 ES: 0018
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<c0106301>] EFLAGS: 00000202
EAX: c0007f0c EBX: c0007f14 ECX: c0007f14 EDX: 00000000
ESI: c0106b00 EDI: c0007508 EBP: c0007f10 DS: 0018 ES: 0018
CR0: 8005003b CR2: c0000000 CR3: 00101000
EIP: 0050:[<c01062c0>] EFLAGS: 00000202
EAX: c0007f0c EBX: c0007f14 ECX: c0007f14 EDX: 00000000
ESI: c0106b00 EDI: c0007508 EBP: c0007f10 DS: 0018 ES: 0018
CR0: 8005003b CR2: c0000000 CR3: 00101000
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0106942 <get_event+12/50>   <=3D=3D=3D=3D=3D
>>EIP; 0000ad8c Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; c01062d0 <apm_bios_call+10/80>   <=3D=3D=3D=3D=3D
>>EIP; 0000bf66 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000ada3 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000bf85 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000ad92 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000bfb6 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000ada7 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000ad9f Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000ad9b Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000c114 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000bf85 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000ad9b Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000ada7 Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; 0000ad8e Before first symbol   <=3D=3D=3D=3D=3D
>>EIP; c0106320 <apm_bios_call+60/80>   <=3D=3D=3D=3D=3D
>>EIP; c0106301 <apm_bios_call+41/80>   <=3D=3D=3D=3D=3D
>>EIP; c01062c0 <apm_bios_call+0/80>   <=3D=3D=3D=3D=3D


1 warning issued.  Results may not be reliable.




------=_NextPart_000_0020_01C061A3.0A76DF60
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4207.2601" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DTerminal size=3D2>Well heres my first attempt at =
kernel debugging=20
the problem posted yesterday. I some magic sysrq-&lt;P&gt; on the 486 =
after the=20
Donald Becker eth0 message displayed. I had to hand write the EIP trace =
and then=20
enter it into ksysmoops. Don't know if it will help but I'll try =
recompiling the=20
kernel without any APM stuff and see what happens.</FONT></DIV>
<DIV><FONT face=3DTerminal size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTerminal size=3D2>sysrq&lt;T&gt;</FONT></DIV>
<DIV><FONT size=3D2>
<P><FONT=20
face=3DTerminal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
free&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
sibling<BR>&nbsp;=20
task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;=20
PC&nbsp;&nbsp;&nbsp; stack&nbsp;&nbsp; pid father child younger=20
older<BR>swapper&nbsp;&nbsp; -1 R current&nbsp;&nbsp;=20
6248&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp; 5<BR>&nbsp;&nbsp; sig: 0 0000000000000000=20
0000000000000000 : X<BR>kflushed&nbsp;&nbsp; 2 S c0233fb0&nbsp;=20
7084&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
3<BR>&nbsp;&nbsp; sig: 0 0000000000000000 0000000000000000 :=20
X<BR>kupdate&nbsp;&nbsp;&nbsp; 3 S c0231fc8&nbsp; =
7108&nbsp;&nbsp;&nbsp;&nbsp;=20
3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>&nbsp;&nbsp; sig: 0 =
0000000000000000=20
ffffffffffffffff : X<BR>kpiod&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 S=20
00000f00&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;=20
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<BR>&nbsp;&nbsp; sig: 0 =
0000000000000000=20
ffffffffffffffff : X<BR>kswapd&nbsp;&nbsp;&nbsp;&nbsp; 5 S =
c009dfd4&nbsp;=20
3120&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
4<BR>&nbsp;&nbsp; sig: 0 0000000000000000 ffffffffffffffff : =
X</FONT></P>
<P><FONT face=3DTerminal>sysrq&lt;P&gt;</FONT></P>
<P><FONT face=3DTerminal>ksymoops 0.7c on i686 2.2.16-Eds2nd.&nbsp; =
Options=20
used<BR>&nbsp;&nbsp;&nbsp;&nbsp; -v nfsroot-486-02-vmlinux=20
(specified)<BR>&nbsp;&nbsp;&nbsp;&nbsp; -K=20
(specified)<BR>&nbsp;&nbsp;&nbsp;&nbsp; -L=20
(specified)<BR>&nbsp;&nbsp;&nbsp;&nbsp; -O=20
(specified)<BR>&nbsp;&nbsp;&nbsp;&nbsp; -m nfsroot-486-02-System.map=20
(specified)</FONT></P>
<P><FONT face=3DTerminal>EIP: 0010:[&lt;c0106942&gt;] EFLAGS: =
00000286<BR>Using=20
defaults from ksymoops -t elf32-i386 -a i386<BR>EAX: 00000000 EBX: =
00000003 ECX:=20
c0007f60 EDX: 00000003<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f60 DS: =
0018 ES:=20
0018<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ad8c&gt;] EFLAGS: 00000212<BR>EAX: 00003636 EBX: 00000000 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0010:[&lt;c01062d0&gt;] EFLAGS: 00000296<BR>EAX: c0007f08 EBX: c0007f26 =
ECX:=20
00000000 EDX: 00000000<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0018 ES:=20
0018<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000bf66&gt;] EFLAGS: 00000202<BR>EAX: 0000530b EBX: 00000000 =
ECX:=20
00000000 EDX: 00000000<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ada3&gt;] EFLAGS: 00000282<BR>EAX: 000036f3 EBX: 00000000 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000bf85&gt;] EFLAGS: 00000212<BR>EAX: 00000000 EBX: 00000016 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ad92&gt;] EFLAGS: 00000212<BR>EAX: 00003636 EBX: 00000050 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000bfb6&gt;] EFLAGS: 00000202<BR>EAX: 0000530b EBX: 00000050 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ada7&gt;] EFLAGS: 00000282<BR>EAX: 000036fe EBX: 00000050 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ad9f&gt;] EFLAGS: 00000282<BR>EAX: 0000fe36 EBX: 00000050 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000bfp6&gt;] EFLAGS: 00000202<BR>EAX: 0000530b EBX: 00000050 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ad9b&gt;] EFLAGS: 00000282<BR>EAX: 0000fe36 EBX: 00000050 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000c114&gt;] EFLAGS: 00000202<BR>EAX: 00000016 EBX: 00000003 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0000 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000bf85&gt;] EFLAGS: 00000212<BR>EAX: 00000000 EBX: 00000016 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ad9b&gt;] EFLAGS: 00000282<BR>EAX: 0000fe36 EBX: 00000000 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ada7&gt;] EFLAGS: 00000282<BR>EAX: 000036fe EBX: 00000000 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;0000ad8e&gt;] EFLAGS: 00000212<BR>EAX: 00003636 EBX: 00000000 =
ECX:=20
00000000 EDX: 00000050<BR>ESI: c0106b00 EDI: c01ce564 EBP: c0007f10 DS: =
0058 ES:=20
0000<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;c0106320&gt;] EFLAGS: 00000202<BR>EAX: c0007f0c EBX: c0007f14 =
ECX:=20
c0007f14 EDX: 00000000<BR>ESI: c0106b00 EDI: c0007508 EBP: c0007f10 DS: =
0018 ES:=20
0018<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;c0106301&gt;] EFLAGS: 00000202<BR>EAX: c0007f0c EBX: c0007f14 =
ECX:=20
c0007f14 EDX: 00000000<BR>ESI: c0106b00 EDI: c0007508 EBP: c0007f10 DS: =
0018 ES:=20
0018<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>EIP:=20
0050:[&lt;c01062c0&gt;] EFLAGS: 00000202<BR>EAX: c0007f0c EBX: c0007f14 =
ECX:=20
c0007f14 EDX: 00000000<BR>ESI: c0106b00 EDI: c0007508 EBP: c0007f10 DS: =
0018 ES:=20
0018<BR>CR0: 8005003b CR2: c0000000 CR3: 00101000<BR>Warning =
(Oops_read): Code=20
line not seen, dumping what data is available</FONT></P>
<P><FONT face=3DTerminal>&gt;&gt;EIP; c0106942 =
&lt;get_event+12/50&gt;&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ad8c Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; c01062d0 =
&lt;apm_bios_call+10/80&gt;&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000bf66 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ada3 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000bf85 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ad92 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000bfb6 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ada7 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ad9f Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ad9b Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000c114 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000bf85 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ad9b Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ada7 Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; 0000ad8e Before first =
symbol&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; c0106320 =
&lt;apm_bios_call+60/80&gt;&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; c0106301 =
&lt;apm_bios_call+41/80&gt;&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D<BR>&gt;&gt;EIP; c01062c0 =
&lt;apm_bios_call+0/80&gt;&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D</FONT></P>
<P><BR><FONT face=3DTerminal>1 warning issued.&nbsp; Results may not be=20
reliable.</FONT></P>
<P><FONT face=3DTerminal></FONT>&nbsp;</P></FONT></DIV></BODY></HTML>

------=_NextPart_000_0020_01C061A3.0A76DF60--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
