Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUATXxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUATXxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:53:00 -0500
Received: from coruscant.franken.de ([193.174.159.226]:4749 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S265833AbUATXw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:52:57 -0500
Date: Mon, 19 Jan 2004 19:53:38 -0500
From: Harald Welte <laforge@gnumonks.org>
To: Harald Staub <staub@switch.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filemap.c bad pmd
Message-ID: <20040120005338.GA8642@obroa-skai.de.gnumonks.org>
References: <4007B9F4.9000203@switch.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <4007B9F4.9000203@switch.ch>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.6.1-rc1-ben1
X-Date: Today is Prickle-Prickle, the 19th day of Chaos in the YOLD 3170
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2004 at 11:16:20AM +0100, Harald Staub wrote:
> Hello Harald Welte
>=20
> Sorry for asking you directly, please give me a hint if I should ask on a=
=20
> mailing list or so.

no problem.

> One of our news servers just had a kernel panic that has similarities to =
a=20
> problem you had in August:
>=20
> <http://www.ussg.iu.edu/hypermail/linux/kernel/0308.1/0778.html>
> "2.4.18/2.4.20 filemap.c pmd bug (was Re: Problem with mm in 2.4.19 and=
=20
> 2.4.20)"

mh.  So we can acknowledge that there is a problem. =20
=20
> Since I could not find a solution, I would like to ask you if you have a=
=20
> hint for me.  Below are some details.

No, I didn't receive any hint from one of the filesystem/mm developers :(

> Harald Staub
> staub@switch.ch

Hey, you are one of the admins of the switch.ch newsservers?  They're
one of the biggest in europe (besides belnet.be and garr.it), aren't
they?

> filemap.c:2228: bad pmd 214001e3.
> Unable to handle kernel paging request at virtual address e15dc264
>  printing eip:
> f88ac2e4
> *pde =3D 214001e3
> *pte =3D bf8ed65a
> Oops: 0000
> CPU:    1
> EIP:    0060:[<f88ac2e4>]    Tainted: P
> EFLAGS: 00010202
> eax: 00005e00   ebx: 6a5605ea   ecx: 0000000a   edx: 17a82000
> esi: 00010000   edi: 00000020   ebp: e15dc200   esp: c1c15ee0
> ds: 0068   es: 0068   ss: 0068
> Process swapper (pid: 0, stackpage=3Dc1c15000)
> Stack: f7910000 00010000 00000020 0000000b 00000001 c02303d9 00002ae0=20
> 00000000
>        c037998c c0379960 000005ea f7906d80 01000040 f88ab30c f7910000=20
>        f7917bec
>        00000001 f7c33dc0 04000001 c0395a88 c0108cd1 0000000b f79a3c00=20
>        c1c15f7c
> Call Trace:    [<c02303d9>] [<f88ab30c>] [<c0108cd1>] [<c0108ef7>]=20
> [<c01052b0>]
>   [<c01052b0>] [<c01052b0>] [<c01052b0>] [<c01052dc>] [<c0105342>]=20
>   [<c0117b7f>]
>   [<c0117a8e>]
>=20
> Code: 83 7d 64 00 74 0a 68 1d 03 00 00 e8 78 b0 86 c7 8b 44 24 28
>  <0>Kernel panic: Aiee, killing interrupt handler!

that oops is not very helpful as long as it isn't processed by ksymoops
(which only you can do with your original kernel binary and system.map)

> ProLiant DL380, dual PIII 1GHz, 1GB RAM, kernel 2.4.24 with some patches=
=20
> (usagi, exec_shield; not used on this machine, but patched in: xfs,=20
> cryptoloop), highmem (4GB) support, inn 2.4.1
> Disks connected to "Compaq Smart Array 5300 Controller" (SCSI) and aic7xx=
x=20
> (IDE RAID)

mh, as indicated in my original posting, I was running a pretty standard
configuration (no patches, no highmem, not even SMP) and had the same
problem with an inn (2.3.x) server.

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFADHwSXaXGVTD0i/8RAq4NAJ4lcweEwr/EuSfGgBnf55MxGSza5wCeMF2v
1D9RajVN9P0aJdFX3PT3iHw=
=h1Kq
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
