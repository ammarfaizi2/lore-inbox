Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTITMjt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 08:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTITMjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 08:39:49 -0400
Received: from 4demon.com ([217.160.186.4]:46998 "EHLO pro-linux.de")
	by vger.kernel.org with ESMTP id S261858AbTITMjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 08:39:46 -0400
Date: Sat, 20 Sep 2003 14:39:44 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Subject: 2.4.22 Oops in NFS write
Message-ID: <20030920123944.GA2378@kiwi.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

while dd'ing a CD to my server, I got the following oops. I had to
reboot because several processes stuck in D state.

System: Dual Athlon MP 2000+, AMD 760 MP chipset, 512 MB ECC RAM,
Intel eepro100 network card with e100 driver. Kernel compiled with
gcc 2.95.4.


Sep 20 13:12:40 kiwi kernel: Unable to handle kernel paging request at virt=
ual address e0000004
Sep 20 13:12:40 kiwi kernel: e88d4070
Sep 20 13:12:40 kiwi kernel: *pde =3D 00000000
Sep 20 13:12:40 kiwi kernel: Oops: 0000
Sep 20 13:12:40 kiwi kernel: CPU:    1
Sep 20 13:12:40 kiwi kernel: EIP:    0010:[nfs:__insmod_nfs_O/lib/modules/2=
=2E4.22/kernel/fs/nfs/nfs.o_M3F5C+-126864/96]    Not tainted
Sep 20 13:12:40 kiwi kernel: EFLAGS: 00010207
Sep 20 13:12:40 kiwi kernel: eax: 02894c59   ebx: cbb59d38   ecx: cbb59d98 =
  edx: cbb59d3c
Sep 20 13:12:40 kiwi kernel: esi: cbb59d50   edi: 470ca3b2   ebp: 00000000 =
  esp: cbb59d00
Sep 20 13:12:40 kiwi kernel: ds: 0018   es: 0018   ss: 0018
Sep 20 13:12:40 kiwi kernel: Process dd (pid: 15449, stackpage=3Dcbb59000)
Sep 20 13:12:40 kiwi kernel: Stack: 00000000 dc1ba178 dc1ba1b4 dc1ba120 cbb=
59d38 c0000000 cbb58000 00002078=20
Sep 20 13:12:40 kiwi kernel:        dc1ba138 ddbba74c 00000000 dc1ba000 dc1=
ba120 dfae17bc d5254800 00000078=20
Sep 20 13:12:40 kiwi kernel:        cd706000 00001000 d8cdc000 00001000 000=
00001 c1589e00 00000001 c1589e78=20
Sep 20 13:12:40 kiwi kernel: Call Trace:    [kmalloc+175/736] [nfs:__insmod=
_nfs_S.text_L59648+52612/59648] [nfs:__insmod_nfs_O/lib/modules/2.4.22/kern=
el/fs/nfs/nfs.o_M3F5C+-127238/96] [nfs:__insmod_nfs_O/lib/modules/2.4.22/ke=
rnel/fs/nfs/nfs.o_M3F5C+-136045/96] [nfs:__insmod_nfs_O/lib/modules/2.4.22/=
kernel/fs/nfs/nfs.o_M3F5C+-118394/96]
Sep 20 13:12:40 kiwi kernel: Code: 03 3c c2 40 39 f0 72 f8 8b 5c 24 24 31 c=
0 f0 0f b3 43 04 57=20
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   03 3c c2                  add    (%edx,%eax,8),%edi
Code;  00000003 Before first symbol
   3:   40                        inc    %eax
Code;  00000004 Before first symbol
   4:   39 f0                     cmp    %esi,%eax
Code;  00000006 Before first symbol
   6:   72 f8                     jb     0 <_EIP>
Code;  00000008 Before first symbol
   8:   8b 5c 24 24               mov    0x24(%esp,1),%ebx
Code;  0000000c Before first symbol
   c:   31 c0                     xor    %eax,%eax
Code;  0000000e Before first symbol
   e:   f0 0f b3 43 04            lock btr %eax,0x4(%ebx)
Code;  00000013 Before first symbol
  13:   57                        push   %edi


Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/bEqQLbySPj3b3eoRAkkFAJ9ORp427w1ANLqsTsbpVbY53HKN7gCgimGu
09b+PkE+TjokSjL6hgV4krE=
=mKob
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
