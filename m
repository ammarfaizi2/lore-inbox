Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274091AbRISPTD>; Wed, 19 Sep 2001 11:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274090AbRISPSx>; Wed, 19 Sep 2001 11:18:53 -0400
Received: from discord.ws.crane.stargate.net ([216.151.124.71]:64432 "EHLO
	discord") by vger.kernel.org with ESMTP id <S274089AbRISPSf>;
	Wed, 19 Sep 2001 11:18:35 -0400
Subject: encrypted swap on loop in 2.4.10-pre12?
From: "steve j. kondik" <shade@chemlab.org>
To: linux-kernel@vger.kernel.org
X-Mailer: Evolution/0.13 (Preview Release)
Date: 19 Sep 2001 11:18:59 -0400
Message-Id: <1000912739.17522.2.camel@discord>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_discord-18753-1000912739-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_discord-18753-1000912739-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

i've been using encrypted swap over loopdev using the new cryptoapi
patches.  i just built a 2.4.10-pre12 kernel and i got a panic doing
mkswap on the loopdev.  the mkswap process becomes unkillable after this
and never finishes.  this is repeatable everytime.  i've had no problems
whatsoever until this kernel even under high load..  any ideas? :>

Sep 19 11:06:13 discord kernel: Unabl
Sep 19 11:06:13 discord kernel: e to handle kernel NULL pointer
dereference at virtual address 00000000
Sep 19 11:06:13 discord kernel:  printing eip:
Sep 19 11:06:13 discord kernel: 00000000
Sep 19 11:06:13 discord kernel: *pde =3D 0f444067
Sep 19 11:06:13 discord kernel: *pte =3D 00000000
Sep 19 11:06:13 discord kernel: Oops: 0000
Sep 19 11:06:13 discord kernel: CPU:    0
Sep 19 11:06:13 discord kernel: EIP:    0010:[<00000000>]
Sep 19 11:06:13 discord kernel: EFLAGS: 00010206
Sep 19 11:06:13 discord kernel: eax: c02fbca0   ebx: cf47d000   ecx:
00000400   edx: cfb428c0
Sep 19 11:06:13 discord kernel: esi: 00001000   edi: 00000c00   ebp:
c1394d78   esp: cf447efc
Sep 19 11:06:13 discord kernel: ds: 0018   es: 0018   ss: 0018
Sep 19 11:06:13 discord kernel: Process mkswap (pid: 9902,
stackpage=3Dcf447000)
Sep 19 11:06:13 discord kernel: Stack: c012a371 cfb428c0 c1394d78
00000400 00001000 cfcd61b0 001828c4 00000000=20
Sep 19 11:06:13 discord kernel:        00000000 00001000 00000400
00000c00 fffffff4 00000000 00000400 00000000=20
Sep 19 11:06:13 discord kernel:        cfa9210c cfa92060 00000000
c01a1ba0 00126000 00001000 00000003 32000022=20
Sep 19 11:06:13 discord kernel: Call Trace: [<c012a371>] [<c01a1ba0>]
[<c01359c0>] [<c01357fe>] [<c0106ebb>]=20
Sep 19 11:06:13 discord kernel:=20
Sep 19 11:06:13 discord kernel: Code:  Bad EIP value.
Sep 19 11:06:13 discord kernel:  Unable to find swap-space signature

--=20
http://chemlab.org  -  email shade-pgpkey@chemlab.org for pgp public key
  chemlab radio!    -  drop out @ http://mp3.chemlab.org:8000   24-7-365

"i could build anything if i could just find my tools.."=09

--=_discord-18753-1000912739-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7qLdjq7nxKnD1kxkRAgdBAKCAUIMcsvLGu16QETpf4SbksXluNACeK88+
UFrqU6J9BCOpd0uhjC/WQEw=
=X7CT
-----END PGP SIGNATURE-----

--=_discord-18753-1000912739-0001-2--
