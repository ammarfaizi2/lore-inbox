Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbSK3InZ>; Sat, 30 Nov 2002 03:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267225AbSK3InY>; Sat, 30 Nov 2002 03:43:24 -0500
Received: from p508EAC8A.dip.t-dialin.net ([80.142.172.138]:13800 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S267224AbSK3InX>; Sat, 30 Nov 2002 03:43:23 -0500
From: Martin Loschwitz <madkiss@madkiss.org>
Date: Sat, 30 Nov 2002 09:49:40 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Massive problems with 2.4.20 module loading
Message-ID: <20021130084940.GA4534@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marcelo, hello world,

I'm having massive problems with Linux 2.4.20 and modul loading. In fact,
it seems to have something to do with devfs. Everytime i try to load a
module which is supposed to create something new in /dev, i get an Oops.
I noticed that behaviour with vmware-module and now also with ALSA=20
0.9.0rc6. Is there a fix available for this yet?

Call trace (ksymoops):

EIP:    0010:[<c01185d5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: ddb67b34   ebx: 00000000   ecx: d3a13ef8   edx: d3a13ef0
esi: 00000246   edi: 00000000   ebp: ddb67a00   esp: d3a13eb8
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 4406, stackpage=3Dd3a13000)
Stack: d3a13ef0 ddb67b34 e292e6ea d70acb40 dba8c640 df6fb040 dba8c648 d309e=
ec0=20
       d309eed8 00000000 00000000 00000000 00000003 d309eec0 00000000 d3a12=
000=20
       d309eec0 d369a940 00000000 00000000 00000000 00000000 c017e500 e292c=
000=20
Call Trace:    [<e292e6ea>] [<c017e500>] [<c017f19f>] [<c014314e>] [<c01386=
a3>]
  [<c01385c7>] [<c0138963>] [<c010737f>]
Code: 89 4b 04 89 5a 08 89 41 04 89 08 56 9d 8b 1c 24 8b 74 24 04=20


>>EIP; c01185d5 <add_wait_queue+15/30>   <=3D=3D=3D=3D=3D

>>eax; ddb67b34 <_end+1d7d60d0/224e35fc>
>>ecx; d3a13ef8 <_end+13682494/224e35fc>
>>edx; d3a13ef0 <_end+1368248c/224e35fc>
>>ebp; ddb67a00 <_end+1d7d5f9c/224e35fc>
>>esp; d3a13eb8 <_end+13682454/224e35fc>

Trace; e292e6ea <[snd-pcm-oss]snd_pcm_oss_open+17a/250>
Trace; c017e500 <devfs_get_ops+60/90>
Trace; c017f19f <devfs_open+13f/1a0>
Trace; c014314e <vfs_permission+7e/140>
Trace; c01386a3 <dentry_open+d3/1d0>
Trace; c01385c7 <filp_open+67/70>
Trace; c0138963 <sys_open+53/a0>
Trace; c010737f <system_call+33/38>

Code;  c01185d5 <add_wait_queue+15/30>
00000000 <_EIP>:
Code;  c01185d5 <add_wait_queue+15/30>   <=3D=3D=3D=3D=3D
   0:   89 4b 04                  mov    %ecx,0x4(%ebx)   <=3D=3D=3D=3D=3D
Code;  c01185d8 <add_wait_queue+18/30>
   3:   89 5a 08                  mov    %ebx,0x8(%edx)
Code;  c01185db <add_wait_queue+1b/30>
   6:   89 41 04                  mov    %eax,0x4(%ecx)
Code;  c01185de <add_wait_queue+1e/30>
   9:   89 08                     mov    %ecx,(%eax)
Code;  c01185e0 <add_wait_queue+20/30>
   b:   56                        push   %esi
Code;  c01185e1 <add_wait_queue+21/30>
   c:   9d                        popf  =20
Code;  c01185e2 <add_wait_queue+22/30>
   d:   8b 1c 24                  mov    (%esp,1),%ebx
Code;  c01185e5 <add_wait_queue+25/30>
  10:   8b 74 24 04               mov    0x4(%esp,1),%esi

--=20
  .''`.   Name: Martin Loschwitz
 : :'  :  E-Mail: madkiss@madkiss.org
 `. `'`   www: http://www.madkiss.org/=20
   `-     Use Debian GNU/Linux - http://www.debian.org   =20

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE96HukHPo+jNcUXjARAuO3AKC3EgDx0YsEp8fkKvWy8TXTHtnvSQCfUNFf
ltdI5nodqaSAk8M9SbhMfRE=
=TLO9
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
