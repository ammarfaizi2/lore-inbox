Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274121AbRISRij>; Wed, 19 Sep 2001 13:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274122AbRISRia>; Wed, 19 Sep 2001 13:38:30 -0400
Received: from discord.ws.crane.stargate.net ([216.151.124.71]:46031 "EHLO
	discord") by vger.kernel.org with ESMTP id <S274121AbRISRiP>;
	Wed, 19 Sep 2001 13:38:15 -0400
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
From: "steve j. kondik" <shade@chemlab.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010919173725.B11991@suse.de>
In-Reply-To: <1000912739.17522.2.camel@discord> 
	<20010919173725.B11991@suse.de>
X-Mailer: Evolution/0.13 (Preview Release)
Date: 19 Sep 2001 13:38:39 -0400
Message-Id: <1000921119.2693.6.camel@discord>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_discord-11018-1000921120-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_discord-11018-1000921120-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

read in the wrong file.  here it is:

Sep 19 13:15:09 discord kernel: Unable to handle kernel NULL pointer
dereference at virtual=20
Sep 19 13:15:09 discord kernel: 00000000
Sep 19 13:15:09 discord kernel: *pde =3D 0f602067
Sep 19 13:15:09 discord kernel: Oops: 0000
Sep 19 13:15:09 discord kernel: CPU:    0
Sep 19 13:15:09 discord kernel: EIP:    0010:[<00000000>]
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 19 13:15:09 discord kernel: EFLAGS: 00010206
Sep 19 13:15:09 discord kernel: eax: c02fbca0   ebx: cf613000   ecx:
00000400   edx: cfb428c0
Sep 19 13:15:09 discord kernel: esi: 00001000   edi: 00000c00   ebp:
c139aca0   esp: cf605efc
Sep 19 13:15:09 discord kernel: ds: 0018   es: 0018   ss: 0018
Sep 19 13:15:09 discord kernel: Process mkswap (pid: 5695,
stackpage=3Dcf605000)
Sep 19 13:15:09 discord kernel: Stack: c012a371 cfb428c0 c139aca0
00000400 00001000 cfcd61b0 001828c4 00000000=20
Sep 19 13:15:09 discord kernel:        00000000 00001000 00000400
00000c00 fffffff4 00000000 00000400 00000000=20
Sep 19 13:15:09 discord kernel:        cfa9210c cfa92060 00000000
c01a1ba0 00126000 00001000 00000003 32000022=20
Sep 19 13:15:09 discord kernel: Call Trace: [<c012a371>] [<c01a1ba0>]
[<c01359c0>] [<c01357fe>] [<c0106ebb>]=20
Sep 19 13:15:09 discord kernel: Code:  Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c012a370 <generic_file_write+410/810>
Trace; c01a1ba0 <write_chan+0/1c0>
Trace; c01359c0 <sys_write+b0/d0>
Trace; c01357fe <sys_llseek+fe/140>
Trace; c0106eba <system_call+32/38>


On Wed, 2001-09-19 at 11:37, Jens Axboe wrote:
> On Wed, Sep 19 2001, steve j. kondik wrote:
> > i've been using encrypted swap over loopdev using the new cryptoapi
> > patches.  i just built a 2.4.10-pre12 kernel and i got a panic doing
> > mkswap on the loopdev.  the mkswap process becomes unkillable after thi=
s
> > and never finishes.  this is repeatable everytime.  i've had no problem=
s
> > whatsoever until this kernel even under high load..  any ideas? :>
> >=20
> > Sep 19 11:06:13 discord kernel: Unabl
> > Sep 19 11:06:13 discord kernel: e to handle kernel NULL pointer
> > dereference at virtual address 00000000
> > Sep 19 11:06:13 discord kernel:  printing eip:
> > Sep 19 11:06:13 discord kernel: 00000000
> > Sep 19 11:06:13 discord kernel: *pde =3D 0f444067
> > Sep 19 11:06:13 discord kernel: *pte =3D 00000000
> > Sep 19 11:06:13 discord kernel: Oops: 0000
> > Sep 19 11:06:13 discord kernel: CPU:    0
> > Sep 19 11:06:13 discord kernel: EIP:    0010:[<00000000>]
> > Sep 19 11:06:13 discord kernel: EFLAGS: 00010206
> > Sep 19 11:06:13 discord kernel: eax: c02fbca0   ebx: cf47d000   ecx:
> > 00000400   edx: cfb428c0
> > Sep 19 11:06:13 discord kernel: esi: 00001000   edi: 00000c00   ebp:
> > c1394d78   esp: cf447efc
> > Sep 19 11:06:13 discord kernel: ds: 0018   es: 0018   ss: 0018
> > Sep 19 11:06:13 discord kernel: Process mkswap (pid: 9902,
> > stackpage=3Dcf447000)
> > Sep 19 11:06:13 discord kernel: Stack: c012a371 cfb428c0 c1394d78
> > 00000400 00001000 cfcd61b0 001828c4 00000000=20
> > Sep 19 11:06:13 discord kernel:        00000000 00001000 00000400
> > 00000c00 fffffff4 00000000 00000400 00000000=20
> > Sep 19 11:06:13 discord kernel:        cfa9210c cfa92060 00000000
> > c01a1ba0 00126000 00001000 00000003 32000022=20
> > Sep 19 11:06:13 discord kernel: Call Trace: [<c012a371>] [<c01a1ba0>]
> > [<c01359c0>] [<c01357fe>] [<c0106ebb>]=20
> > Sep 19 11:06:13 discord kernel:=20
> > Sep 19 11:06:13 discord kernel: Code:  Bad EIP value.
> > Sep 19 11:06:13 discord kernel:  Unable to find swap-space signature
>=20
> ksymoops it please
>=20
--=20
http://chemlab.org  -  email shade-pgpkey@chemlab.org for pgp public key
  chemlab radio!    -  drop out @ http://mp3.chemlab.org:8000   24-7-365

"i could build anything if i could just find my tools.."=09

--=_discord-11018-1000921120-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7qNgfq7nxKnD1kxkRAsrLAKDTVM07r/fvKm3gEnGlmZrvqqsDtQCg0WQ6
1/VnaZmPYJlXOxhusgGXSzM=
=ogB9
-----END PGP SIGNATURE-----

--=_discord-11018-1000921120-0001-2--
