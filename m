Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVDGHr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVDGHr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVDGHr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:47:26 -0400
Received: from dea.vocord.ru ([217.67.177.50]:19127 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261916AbVDGHrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:47:05 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-00y2qTYuy9bKBTN3YUhE"
Organization: MIPT
Date: Thu, 07 Apr 2005 11:53:39 +0400
Message-Id: <1112860419.28858.76.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 07 Apr 2005 11:46:49 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-00y2qTYuy9bKBTN3YUhE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 09:36 +0200, Guillaume Thouvenin wrote:
> Hi Evgeniy,
>=20
>  I forgot to put you in the CC of the email so I'm forwarding a post
> about the connector sent on lkml.

Ok, I'm in.

> Best regards,
> Guillaume

> email message attachment, "Forwarded message - Re: connector is
> missing in 2.6.12-rc2-mm1"
> On Thu, 2005-04-07 at 09:36 +0200, Guillaume Thouvenin wrote:
> > Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> > >
> > > Hello,
> > >=20
> > >  I don't see the connector directory in the 2.6.12-rc2-mm1 tree. So i=
t
> > > seems that you removed the connector?
> >=20
> > Greg dropped it for some reason.  I think that's best because it needed=
 a
> > significant amount of rework.  I'd like to see it resubitted in totalit=
y so
> > we can take another look at it.

Hmm, what exactly do you think _must_ be changed?
Most of your comments are addressed in 4 patches I sent to you and Greg.
Others [mostly atomic allocation] are API extensions and will be added.
There also not included flush on callback removal.

> > It's a new piece of core kernel infrastructure and the barriers for tha=
t
> > are necessarily high.
> >=20
> > > Will you include it again in futur
> > > release? At the same time, will you include the fork connector?
> >=20
> > I could put the fork connector into -mm, but would like to be convinced
> > that it's acceptable to and useful for all system accounting requiremen=
ts,
> > not just the one project.  That means code, please.

SuperIO and kobject_uevent are also dropped as far as I can see.

Acrypto is being reviewed but it also depends on it, although=20
it takes to much time, probably will be dropped too.

Proper w1 notification also requires connector.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-00y2qTYuy9bKBTN3YUhE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVOcDIKTPhE+8wY0RAqOcAJ9tvF1v+oF9xgan33MAzqsMLDqzIgCbBXoN
4IVpktRLQ1sMaTEqrcHPipA=
=XEpb
-----END PGP SIGNATURE-----

--=-00y2qTYuy9bKBTN3YUhE--

