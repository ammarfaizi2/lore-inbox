Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVDAIWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVDAIWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVDAIWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:22:45 -0500
Received: from dea.vocord.ru ([217.67.177.50]:46248 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261594AbVDAIWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:22:42 -0500
Subject: Re: connector.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050401000215.6d85c477.akpm@osdl.org>
References: <20050331173026.3de81a05.akpm@osdl.org>
	 <1112339238.9334.66.camel@uganda> <20050331234213.0c06ba71.akpm@osdl.org>
	 <1112342595.9334.120.camel@uganda>  <20050401000215.6d85c477.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f0KWH8ch5eFSJ/2G1k0p"
Organization: MIPT
Date: Fri, 01 Apr 2005 12:28:54 +0400
Message-Id: <1112344134.9334.136.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 12:22:16 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f0KWH8ch5eFSJ/2G1k0p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 at 00:02 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > On Thu, 2005-03-31 at 23:42 -0800, Andrew Morton wrote:
> >  > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >  > >
> >  > > > What happens if we expect a reply to our message but userspace n=
ever sends
> >  > > > one?  Does the kernel leak memory?  Do other processes hang?
> >  > >=20
> >  > > It is only advice, one may easily skip seq/ack initialization.
> >  > > I could remove it totally from the header, but decided to=20
> >  > > place it to force people to use more reliable protocols over netli=
nk
> >  > > by introducing such overhead.
> >  >=20
> >  > hm.  I don't know what that means.
> >=20
> >  Messages that are passed between agents must have only id,
> >  but I decided to force people to use provided seq/ack fields
> >  to store there some information about message order.
> >  Neither kernel nor userspace requires that fields to be=20
> >  somehow initialized.
>=20
> Back to my original question.  If the kernel expects a reply from userspa=
ce
> to a particular message, and that reply never comes, what happens?

Nothing.
If reply message will be recived, it will be delivered to the requested=20
connector user, if reply will not be received just nothing happens.

Not connector, but it's users who may expect reply to theirs messages.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-f0KWH8ch5eFSJ/2G1k0p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTQZGIKTPhE+8wY0RAgqgAJ4op5b3kEMAxIlTI/CUZwX8qHfQhQCfQ/D3
UFuagQ+qM/HG/yM9I/D1UkU=
=euQs
-----END PGP SIGNATURE-----

--=-f0KWH8ch5eFSJ/2G1k0p--

