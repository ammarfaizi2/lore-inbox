Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUI0Qbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUI0Qbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUI0Qbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:31:36 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:15517 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S266582AbUI0Qbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:31:31 -0400
Subject: Re: [gamin] [RFC][PATCH] inotify 0.10.0 [u]
From: "Martin Schlemmer [c]" <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Robert Love <rml@ximian.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>, iggy@gentoo.org
In-Reply-To: <1096302248.30503.21.camel@betsy.boston.ximian.com>
References: <1096250524.18505.2.camel@vertex>
	 <1096302060.11535.54.camel@nosferatu.lan>
	 <1096302248.30503.21.camel@betsy.boston.ximian.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ER0AiVKkA9Eit9mba2pM"
Date: Mon, 27 Sep 2004 18:30:49 +0200
Message-Id: <1096302649.11535.69.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ER0AiVKkA9Eit9mba2pM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-09-27 at 12:24 -0400, Robert Love wrote:
> On Mon, 2004-09-27 at 18:21 +0200, Martin Schlemmer [c] wrote:
>=20
> > I have just looked quickly at the inotify backend this weekend, so not
> > really clued up yet, so excuse the stupid question:  Does this mean
> > inotify is now up to par with dnotify/poll feature wise?  Or should we
> > still look at getting inotify backend to use poll?
>=20
> inotify supports poll in the sense that you can poll() or select()
> on /dev/inotify.
>=20
> dnotify does not support poll() at all (it is signal based), so your
> question is kind of confusing.
>=20

(Sorry for double posting - keep forgetting with what email addy I am
 subscribed to this list)

Right, but using gamin, dnotify+poll support some things that inotify
do not support.  Basically the dnotify backend also use the poll backend
to enhance it to be able to monitor some events that dnotify by itself
cannot (Daniel will be the better person to ask here).  Here is a small
snippit from another thread:

----
> > > >   inotify should be able to fallback to poll too, otherwise it's
> > > > > a bug in the inotify back-end, think for example for NFS resource=
s.
> > > > >=20
> > > >=20
> > > > Hmm - well it does not use poll.  I will see if I can have a
> > > > look at at dnotify backend and cook something up.  I assume
> > > > John never got to it, or you added the poll support to dnotify
> > > > after inotify was added?
> > >=20
> > >    I added it after, yes.
> > >=20
> >=20
> > Ok, thanks.
> >=20
>=20
> Actually, initially the inotify backend did support using the poll
> backend as well. I got rid of it because at the time inotify provided
> everything we needed. Now gamin supports watching things that inotify
> can't, like directories that don't exist.
----


Thanks,

--=20
Martin Schlemmer

--=-ER0AiVKkA9Eit9mba2pM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBWEA5qburzKaJYLYRAopUAJ9VUHv59OQ5gXYSn+XwWb0WVHsDTACdEil9
wA7nv/BbUK9C9OiS0QzfN1g=
=xyO+
-----END PGP SIGNATURE-----

--=-ER0AiVKkA9Eit9mba2pM--

