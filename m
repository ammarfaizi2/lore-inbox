Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUCMWR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 17:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUCMWQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 17:16:59 -0500
Received: from studorgs.rutgers.edu ([128.6.24.131]:7149 "EHLO
	ruslug.rutgers.edu") by vger.kernel.org with ESMTP id S263201AbUCMWPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 17:15:30 -0500
Date: Sat, 13 Mar 2004 17:15:29 -0500
From: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: prism54-devel@prism54.org, netdev@oss.sgi.com, jgarzik@redhat.com
Subject: Prism54 in 2.6.4-bk2
Message-ID: <20040313221529.GC32439@ruslug.rutgers.edu>
Reply-To: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
Mail-Followup-To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	prism54-devel@prism54.org, netdev@oss.sgi.com, jgarzik@redhat.com
References: <5.1.0.14.2.20040313180709.00ab4250@pop.t-online.de> <1079199572.7111.0.camel@lapy.tuxslare.org> <20040313203058.GY32439@ruslug.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4IYkFBVPN84tP7K"
Content-Disposition: inline
In-Reply-To: <20040313203058.GY32439@ruslug.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4IYkFBVPN84tP7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 13, 2004 at 03:30:58PM -0500, Luis R. Rodriguez wrote:
> On Sat, Mar 13, 2004 at 05:39:32PM +0000, Andr? Ventura Lemos wrote:
> > ChangeSet@1.1608.81.1, 2004-03-12 12:55:33-05:00, jgarzik@redhat.com
> >   [wireless] Add new Prism54 wireless driver.
> >=20
> > :-)
> >=20
> > On Sat, 2004-03-13 at 17:08, Margit Schubert-While wrote:
> > > In case nobody noticed, the driver is in 2.6.4-bk2 !
> > >=20
> > > Margit
>=20
> Hmm. Now what? Should we create a new set of automated patchsets against =
the latest kernel
> snapshot? Or just not worry about that and keep on happilly with our stab=
le kernel
> patches?
>=20
> The prism54 driver snapshot that went into bk2 could be marked as our
> first testing snapshot... If so, we could also start a new ChangeLog.
>=20
> Ideas?
>=20
> 	Luis

I just checked out the bk2 snapshot and its diffs with our latest
prism54 tree. Here is the diff:

http://prism54.org/~mcgrof/bk2-up.diff

It seems jgarzik took a patch before 2004-03-09 changes and just nuked
WDS code. It's great that it's already on some official kernel snapshot=20
patch but prism54 driver project is a very active project and I think
someone jumped the gun. We were preparing the driver for proper
integration per the nevdev list discussion. Anyway, now onto dealing
with it.

Regarding WDS on prism54: on the netdev list we discussed this
but no one got back to me as to whether we should really just nuke this
code. Prism54 driver source *does* include WDS support because hey, the
firmware does. Why wouldn't it go in the driver? We haven't given WDS
much though anyway since it's also been low priority on our TODO list.

Is it already agreed among kdevelopers that even if certain chipsets
support WDS at the hardware/firmware level that another layer is going
to be used for it's support?

Now that prism54 driver is in bk2 if we (prism54 team) want to submit
patches for it, should we always patch against the latest bk snapshot?

Oh and if you get messages telling you your post is pending approval on
the prism54 list because you're not registered, don't worry, we're quick.

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--T4IYkFBVPN84tP7K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAU4gBat1JN+IKUl4RApJSAJwJK3PDlK8aa7uWAY3AMSGjfRn+rgCcD+Hs
3Lrmd7V9BpGYspRdky6bcJw=
=kPvv
-----END PGP SIGNATURE-----

--T4IYkFBVPN84tP7K--
