Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265525AbTLHRsb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbTLHRsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:48:31 -0500
Received: from [68.114.43.143] ([68.114.43.143]:4754 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S265525AbTLHRsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:48:24 -0500
Date: Mon, 8 Dec 2003 12:48:20 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Dan Yocum <yocum@fnal.gov>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS merged in 2.4
Message-ID: <20031208174820.GA18504@rdlg.net>
Mail-Followup-To: Dan Yocum <yocum@fnal.gov>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312080916220.889-100000@logos.cnet> <3FD4AA4C.7080102@fnal.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <3FD4AA4C.7080102@fnal.gov>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Thus spake Dan Yocum (yocum@fnal.gov):

> Marcelo, Christoph, et al.,
>=20
> Thanks for finally including XFS in the vanilla 2.4 tree.  We greatly=20
> appreciate it.
>=20
> I hear that the acls and dmapi bits were excluded, but our ~300TB are use=
d=20
> mainly for online data caching so we don't generally use these features.
>=20
> Again, thanks for making my life somewhat easier.  :-)
>=20
> Cheers,
> Dan
>=20
>=20
> Marcelo Tosatti wrote:
> >FYI
> >
> >Christoph reviewed XFS patch which changed generic code, and it was
> >stripped down later to a set of changes which dont modify the code
> >behaviour (except for a few bugfixes which should have been included
> >separately anyway) and are pretty obvious.
> >
> >So its that has been merged, along with fs/xfs/.
> >
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
>=20


While I think this is a good idea in general:
make bzImage gives this:
make[4]: Leaving directory `/exp/src1/kernels/2.4.23/Desktop/linux-2.4.23/f=
s/vfat'
make -C xfs fastdep
make: *** xfs: No such file or directory.  Stop.
make: Entering an unknown directorymake: Leaving an unknown directorymake[3=
]: *** [_sfdep_xfs] Error 2
make[3]: Leaving directory `/exp/src1/kernels/2.4.23/Desktop/linux-2.4.23/f=
s'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/exp/src1/kernels/2.4.23/Desktop/linux-2.4.23/f=
s'
make[1]: *** [_sfdep_fs] Error 2
make[1]: Leaving directory `/exp/src1/kernels/2.4.23/Desktop/linux-2.4.23'
make: *** [dep-files] Error 2

The main problem?

root:/usr/src/kernels/2.4.23/Desktop/linux-2.4.23# grep -i xfs .config  =20
# CONFIG_XFS_FS is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set




:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1Llk8+1vMONE2jsRAnm1AKDHrojciEO5aKaFSfQlGQGrlWBpIACfUZ/5
s1/vTsEstkNmHU8D1zy99+o=
=pf9G
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
