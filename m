Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbSJDLuG>; Fri, 4 Oct 2002 07:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261564AbSJDLuG>; Fri, 4 Oct 2002 07:50:06 -0400
Received: from fw.openss7.com ([142.179.197.31]:12558 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261560AbSJDLuF>;
	Fri, 4 Oct 2002 07:50:05 -0400
Date: Fri, 4 Oct 2002 05:55:37 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021004055537.B13743@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021003153943.E22418@openss7.org> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk> <20021003170608.A30759@openss7.org> <1033722612.1853.1.camel@localhost.localdomain> <20021004051932.A13743@openss7.org> <1033731087.1853.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033731087.1853.11.camel@localhost.localdomain>; from arjanv@redhat.com on Fri, Oct 04, 2002 at 01:31:27PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Arjan,

On Fri, 04 Oct 2002, Arjan van de Ven wrote:

> > 	static long asmlinkage sys_spipe(int *fd)
> > 	{
> > 		int ret =3D -ENOSYS;
> > 		read_lock(&streams_call_lock);
> > 		if (do_spipe)
> > 			ret =3D do_spipe(fd);
> > 		read_unlock(&streams_call_lock);
> > 		return ret;
> > 	}
>=20
> ehm sys_spipe doesn't exist, neither do all but 2 of the others you
> showed.

spipe, fattach, fdetach can sometimes be faked with ioctl().
Perhaps we can reserve these while we're at it.

>=20
> iBCS is dead. It's called linux-abi nowadays.....

AFAIK it lives on as socksys under sparc architecture.  See
for example solaris_putmsg and solaris_getmsg in 2.4.18
arch/sparc64/solaris/systbl.S and arch/sparc64/solaris/timod.c

> > But this is repetative and doesn't solve replacement of existing
> > system calls for profilers and such.
>=20
> Profilers don't actually NEED this.... OProfile is fixed for this for
> example in the 2.5 branch.=20

Fair enough.  I only really care about the STREAMS system calls...

--brian


--=20
Brian F. G. Bidulock    =A6 The reasonable man adapts himself to the =A6
bidulock@openss7.org    =A6 world; the unreasonable one persists in  =A6
http://www.openss7.org/ =A6 trying  to adapt the  world  to himself. =A6
                        =A6 Therefore  all  progress  depends on the =A6
                        =A6 unreasonable man. -- George Bernard Shaw =A6

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9nYG4MYOP2up1d2URAqRdAJ4tl9bVeeh/ymi24d+AgDJ4iOntKwCg5qlN
KpYDMbSLXvnNE8iXBFD0zcg=
=NqlG
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
