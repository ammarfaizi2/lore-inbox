Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUAFM7b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUAFM7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:59:31 -0500
Received: from emroute3.ornl.gov ([160.91.4.110]:50818 "EHLO emroute3.ornl.gov")
	by vger.kernel.org with ESMTP id S262038AbUAFM7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:59:21 -0500
Date: Tue, 06 Jan 2004 07:59:07 -0500
From: Lawrence MacIntyre <lpz@ornl.gov>
Subject: Re: Any changes in Multicast code between 2.4.20 and 2.4.22/23 ?
In-reply-to: <20040106022122.11388.qmail@web13906.mail.yahoo.com>
To: knobi@knobisoft.de
Cc: David Stevens <dlstevens@us.ibm.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <1073393946.5626.7.camel@nautique>
Organization: High Performance Information Infrastructure Group
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-UoBd3QHufYjF/Su/x/mE"
References: <20040106022122.11388.qmail@web13906.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UoBd3QHufYjF/Su/x/mE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Can you look on the adjacent multicast router(s) and see if your host is
listed as a group member?  Or is this done with just a flat IP network
(one subnet)?

On Mon, 2004-01-05 at 21:21, Martin Knoblauch wrote:
> --- David Stevens <dlstevens@us.ibm.com> wrote:
> >=20
> >
> Hi David,
> =20
> >=20
> >=20
> > Martin,
> >       If you have other hosts on that network that have sent IGMP
> > reports,
> > then
> > the reporter flag will be cleared-- only one member on a network
> > needs to
> > send
> > reports. That doesn't prevent the host from receiving multicasts--
> > presence
> > in
> > /proc/net/igmp indicates it did join the group.
>=20
> OK. I just wondered, because all hosts running the 2.4.20-18.7smp
> kernel (RH7.3 errata) show the "1" in the reporter field, while all
> hosts running 2.4.22/2.4.23 (vanilla plus NFS fixes from Trond) show
> "0".
>=20
> >       Please send me some details about your set-up and I may be able
> > to
> > help.
>=20
>  We are running 21 HP/DL380G3.Each has two internal Broadcom NICs. The
> second one (eth1) is used for the Ganglia multicast.
>=20
>  The kernels are 2.4.22 and 2.4.23 (now .24) with some NFS patches. In
> the case of 2.4.24 those are:
>=20
> 01-posix_race
> 02-fix_commit
> 03-fix_osx
> 04-fix_lockd3
> 06-fix_unlink
> 07_seekdir
>=20
>  from http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.23-rc1 None of
> those looks like it does something to multicasts. In the worst case I
> could try to run with plain 2.4.22/23, but that would have to ait until
> Wednesday.
>=20
>  The kernel-config file is included.
>=20
> >       First, are the sender and receiver on the same network, or are
> > you
> > using a multicast router?
>=20
>  No. All systems are on the same network.
>=20
> >       Second, can you send me a tcpdump-format packet trace
> > (preferrably
> > only the multicast traffic, and as small as you can make it)?
>=20
>  What exactely do you want to see? On which box should I run tcpdump?
> Which options (I'm not that deep into network debugging :-)?
>=20
>=20
> >       You mentioned tg3-- have you tried this with other hardware
> > that
> > worked?
> >
>=20
>  The tg3 works with the 2.4.20-18.7smp (and earlier) kernels. It just
> does not work with 2.4.22/23 (did not check 2.4.21).=20
>=20
>  Unfortunatelly I have no other boxes to test with. I only can say that
> Ganglia never failed in this particular way on any setup.
>=20
> Thanks
> Martin
>=20
> =3D=3D=3D=3D=3D
> ------------------------------------------------------
> Martin Knoblauch
> email: k n o b i AT knobisoft DOT de
> www:   http://www.knobisoft.de
--=20
    Lawrence MacIntyre     865.574.8696     lpz@ornl.gov
               Oak Ridge National Laboratory
High Performance Information Infrastructure Technology Group


--=-UoBd3QHufYjF/Su/x/mE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA/+rEaCNjP8rawCW4RAqJoAJsHErsbdxqV/AFrDOqs8qc6IPQi2wCfdFEq
KJNPpw9YsRklsAYTMoMeiKM=
=SRm4
-----END PGP SIGNATURE-----

--=-UoBd3QHufYjF/Su/x/mE--
