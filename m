Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVEBRqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVEBRqp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVEBRqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:46:44 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:16787 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261366AbVEBRp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:45:29 -0400
Date: Mon, 2 May 2005 10:45:23 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Support multiply-LUN devices in ub
Message-ID: <20050502174523.GA23669@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20050501160540.5b2f4e61.zaitcev@redhat.com> <20050502040505.GA6914@one-eyed-alien.net> <20050501212438.08ae67f1.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20050501212438.08ae67f1.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 01, 2005 at 09:24:38PM -0700, Pete Zaitcev wrote:
> On Sun, 1 May 2005 21:05:05 -0700, Matthew Dharm <mdharm-kernel@one-eyed-=
alien.net> wrote:
> > On Sun, May 01, 2005 at 04:05:40PM -0700, Pete Zaitcev wrote:
>=20
> > >  /*
> > > + * This many LUNs per USB device.
> > > + * Every one of them takes a host, see UB_MAX_HOSTS.
> > >   */
> > > +#define UB_MAX_LUNS   4
> >=20
> > Why only 4 LUNs?
>=20
> This can be redefined at any moment, fortunately, so there's no need to
> agonize over this number. There is no backward or forward compatibility
> problem. The sole purpose of that limit is to make a probe loop bound,
> for initial testing.
>=20
> Why would you want more though? I have a 12-in-1 reader which only
> exports 4 LUNs. If someone attached enterprise storage arrays to USB,
> it might be a good idea to remove the limit completely.

I've seen 5 and 6 LUNs, but they aren't common.

The best reading of the specs suggest that 8 is the practical limit.

Since that's not far from 4, perhaps it would be best to set the number to
8 so we never have to revisit it again.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Hey, has anyone seen the Microsoft sales guy? It's his feeding time...
					-- Mike
User Friendly, 4/17/1998

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCdmczHL9iwnUZqnkRAp+tAJ9Q4VR2IF8bJTQDziIzoVd2ow40DACfXxS9
w0Zmf0haUwhORwq+lo4Bw6c=
=91ks
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
