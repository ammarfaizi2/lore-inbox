Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSKRXwi>; Mon, 18 Nov 2002 18:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSKRXwi>; Mon, 18 Nov 2002 18:52:38 -0500
Received: from dog.woaf.net ([193.201.71.2]:59654 "EHLO dog.woaf.net")
	by vger.kernel.org with ESMTP id <S264975AbSKRXwf>;
	Mon, 18 Nov 2002 18:52:35 -0500
Date: Mon, 18 Nov 2002 23:59:36 +0000
From: David Flynn <davidf@woaf.net>
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.4.17 + NFS patches
Message-ID: <20021118235936.GB18838@woaf.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Editor: Vim http://www.vim.org/
Organisation: Poor
X-Operating-System: Linux/2.2.20 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello lkml people,

The following is the output of an oops that occurred on an AMD Athlon XP
running kernel 2.4.17 with all the 2.4.17 NFS patches applied (from
http://nfs.sf.net/).  The kernel is optimised for P3(Cu).

Something which may be quite important is that we are seeing some quite
random behavior with this machine, it will be fine for a good few hours
then we will get random processes being killed with SIGSEGV / SIGBUS.
All RAM has been replaced in the machine, and we have changed kernels from
2.4.18 to 2.4.17, both show the same behavior.

Any information would be most appreciated!

Kind Regards,

David

--an oops--

Unable to handle kernel paging request at virtual address 3d3f3f4f
c0113211
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0113211>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 3d3f3f3b   ebx: cbd15e00   ecx: ca62c848   edx: 000000ef
esi: c6ee3b40   edi: cbd15e40   ebp: c16eb844   esp: cdac5f54
ds: 0018   es: 0018   ss: 0018
Process root (pid: 3140, stackpage=3Dcdac5000)
Stack: c999e000 cdac45a0 c999e5a0 00000011 00000008 00000100 ca62c848 c6ee3=
b00=20
       c0113552 00000011 c999e000 cdac4000 bffff8ec 00000000 cdac5fbc 00000=
000=20
       fffffff4 00000000 c012df24 cdac4000 bffff804 c01059e0 00000011 bffff=
850=20
Call Trace: [<c0113552>] [<c012df24>] [<c01059e0>] [<c0106d1b>]=20
Code: ff 40 14 89 45 00 83 c5 04 4a 75 e3 8b 43 08 2b 44 24 14 8d=20


>>EIP; c0113211 <copy_files+189/260>   <=3D=3D=3D=3D=3D

>>ebx; cbd15e00 <_end+ba343e4/1061f5e4>
>>ecx; ca62c848 <_end+a34ae2c/1061f5e4>
>>esi; c6ee3b40 <_end+6c02124/1061f5e4>
>>edi; cbd15e40 <_end+ba34424/1061f5e4>
>>ebp; c16eb844 <_end+1409e28/1061f5e4>
>>esp; cdac5f54 <_end+d7e4538/1061f5e4>

Trace; c0113552 <do_fork+26a/650>
Trace; c012df24 <sys_llseek+120/12c>
Trace; c01059e0 <sys_fork+14/1c>
Trace; c0106d1b <system_call+33/38>

Code;  c0113211 <copy_files+189/260>
00000000 <_EIP>:
Code;  c0113211 <copy_files+189/260>   <=3D=3D=3D=3D=3D
   0:   ff 40 14                  incl   0x14(%eax)   <=3D=3D=3D=3D=3D
Code;  c0113214 <copy_files+18c/260>
   3:   89 45 00                  mov    %eax,0x0(%ebp)
Code;  c0113217 <copy_files+18f/260>
   6:   83 c5 04                  add    $0x4,%ebp
Code;  c011321a <copy_files+192/260>
   9:   4a                        dec    %edx
Code;  c011321b <copy_files+193/260>
   a:   75 e3                     jne    ffffffef <_EIP+0xffffffef> c011320=
0 <copy_files+178/260>
Code;  c011321d <copy_files+195/260>
   c:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c0113220 <copy_files+198/260>
   f:   2b 44 24 14               sub    0x14(%esp,1),%eax
Code;  c0113224 <copy_files+19c/260>
  13:   8d 00                     lea    (%eax),%eax

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92X7o9hzCJ3SS/C4RAjMoAKCMReJLIrRDfofx6c3r0V11FLw86QCdHYHa
78KiHJ24xwB6k3JlvQOupvw=
=OD9Z
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
