Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTFDTFt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTFDTFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:05:49 -0400
Received: from dsl-62-3-122-163.zen.co.uk ([62.3.122.163]:39040 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S263897AbTFDTFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:05:43 -0400
Subject: Oops kernel 2.4.21-rc6-ac1
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bWNxUKSyF/9VAfE3wAmB"
Organization: Trudheim Technology Limited
Message-Id: <1054754352.2371.12.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92Rubber Turnip www.usr-local-bin.org
	(Preview Release)
Date: 04 Jun 2003 20:19:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bWNxUKSyF/9VAfE3wAmB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I was running Galeon and browsing some of the web, when the window
just vanished. I checked dmesg output and found the following oops. I
have decoded it.

Unable to handle kernel NULL pointer dereference at virtual address
00000001
c0129d36
*pde =3D 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0129d36>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: e421e000   ecx: 00000020   edx: 000007f5
esi: bf3ffbe0   edi: 0857e96c   ebp: bfffd738   esp: e421ff34
ds: 0018   es: 0018   ss: 0018
Process galeon-bin (pid: 2037, stackpage=3De421f000)
Stack: 00000000 c02d8e7c c1000020 c14e50c0 00000020 e2d82780 000007f5
00000020=20
       c021a772 e2c8aa94 e421ff70 00000020 00000040 bfffeb20 00000000
00000000=20
       00000000 0000541b e2d82780 00000003 0000541b e2d82780 00000003
e421ffac=20
Call Trace:    [<c021a772>] [<c01234fb>] [<c0109127>]
Code: 00 00 89 0c 24 00 44 24 1c 8b 84 24 90 00 00 00 89 44 24 08=20


>>EIP; c0129d36 <sys_kill+36/60>   <=3D=3D=3D=3D=3D

>>ebx; e421e000 <_end+23e9bfbc/3149101c>
>>esp; e421ff34 <_end+23e9def0/3149101c>

Trace; c021a772 <sock_read+92/a0>
Trace; c01234fb <sys_gettimeofday+3b/80>
Trace; c0109127 <system_call+33/38>

Code;  c0129d36 <sys_kill+36/60>
00000000 <_EIP>:
Code;  c0129d36 <sys_kill+36/60>   <=3D=3D=3D=3D=3D
   0:   00 00                     add    %al,(%eax)   <=3D=3D=3D=3D=3D
Code;  c0129d38 <sys_kill+38/60>
   2:   89 0c 24                  mov    %ecx,(%esp,1)
Code;  c0129d3b <sys_kill+3b/60>
   5:   00 44 24 1c               add    %al,0x1c(%esp,1)
Code;  c0129d3f <sys_kill+3f/60>
   9:   8b 84 24 90 00 00 00      mov    0x90(%esp,1),%eax
Code;  c0129d46 <sys_kill+46/60>
  10:   89 44 24 08               mov    %eax,0x8(%esp,1)


If there is any more data anyone would like me to provide, give me a
shout and I'll make it available somehow.

/A




--=-bWNxUKSyF/9VAfE3wAmB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+3kYwLYywqksgYBoRArEzAJ9PxBSmzoT573R8NpsyzN2+gWcRRACfX/f0
Zn3prmESh5zvJOocqUEmvo0=
=6efW
-----END PGP SIGNATURE-----

--=-bWNxUKSyF/9VAfE3wAmB--

