Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVDHDfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVDHDfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVDHDf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:35:29 -0400
Received: from dea.vocord.ru ([217.67.177.50]:15027 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262679AbVDHDfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:35:06 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: James Morris <jmorris@redhat.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Ian Campbell <ijc@hellion.org.uk>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0504071145430.21159-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0504071145430.21159-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bUv5u5iYHHGG9BcThMPL"
Organization: MIPT
Date: Fri, 08 Apr 2005 07:41:35 +0400
Message-Id: <1112931695.28858.188.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 08 Apr 2005 07:34:43 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bUv5u5iYHHGG9BcThMPL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 11:47 -0400, James Morris wrote:
> On Thu, 7 Apr 2005, Kay Sievers wrote:
>=20
> > Sure, but seems I need to ask again: What is the exact reason not to im=
plement
> > the muticast message multiplexing/subscription part of the connector as=
 a
> > generic part of netlink? That would be nice to have and useful for othe=
r
> > subsystems too as an option to the current broadcast.
>=20
> This is a good point, in general, consider generically extending Netlink=20
> itself instead of creating these separate things.

I just do not understand, what does netlink multicasting means
and how it is different from what we have now.
Currently we have group registratin in bind(),=20
and then send data to the bound socket if it
has appropriate group.

Or should some error be propagated to the caller,=20
if there is no appropriate listener?

Connector requires it's own registration technique for
1. hide all transport [netlink] layer from higher protocols which use
connector
2. create different group appointment for the given connector's ID
[it was different, now new group which is eqal to idx field is appointed
to=20
the new callback]
3. provide more generic set of ids

>=20
> - James
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-bUv5u5iYHHGG9BcThMPL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVf1vIKTPhE+8wY0RAsFRAJ4laTyPtLAWTvB9iz+y5Omy2YT3TQCeLdJj
+dSDu12MLcVMdkpJBC6eRvw=
=3IEa
-----END PGP SIGNATURE-----

--=-bUv5u5iYHHGG9BcThMPL--

