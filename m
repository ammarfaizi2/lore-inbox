Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264804AbUE0Pek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264804AbUE0Pek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbUE0Pek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:34:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264804AbUE0Pei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:34:38 -0400
Subject: Re: 4k stacks in 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20040527152156.GI23194@wohnheim.fh-wedel.de>
References: <20040527145935.GE23194@wohnheim.fh-wedel.de>
	 <4382.1085670482@ocs3.ocs.com.au>
	 <20040527152156.GI23194@wohnheim.fh-wedel.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LKEr0nNXSZjouhIa17dy"
Organization: Red Hat UK
Message-Id: <1085672066.7179.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 17:34:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LKEr0nNXSZjouhIa17dy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-05-27 at 17:21, J=C3=B6rn Engel wrote:
> On Fri, 28 May 2004 01:08:02 +1000, Keith Owens wrote:
> > On Thu, 27 May 2004 16:59:35 +0200,=20
> > =3D?iso-8859-1?Q?J=3DF6rn?=3D Engel <joern@wohnheim.fh-wedel.de> wrote:
> > >
> > >Plus the script is wrong sometimes.  I have had trouble with sizes
> > >around 4G or 2G, and never found the time to really figure out what's
> > >going on.  Might be an alloca thing that got misparsed somehow.
> >=20
> > Some code results in negative adjustments to the stack size on exit,
> > which look like 4G sizes.  My script checks for those and ignores them.
> > /^[89a-f].......$/d;
>=20
> Ok, looks as if only my script is wrong.  Do you know what exactly
> causes such a negative adjustment?

you can write "add 100,%esp" as "sub -100, %esp" :)
compilers seem to do that at times, probably some cpu model inside the
compiler decides the later is better code in some cases  :)


--=-LKEr0nNXSZjouhIa17dy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtgqCxULwo51rQBIRAihgAJ0Qr2JmJ15/m/cYmolMgZxpEClUlQCaAt8k
FNNdKG833v5ZMmJKbva8MkU=
=KDdm
-----END PGP SIGNATURE-----

--=-LKEr0nNXSZjouhIa17dy--

