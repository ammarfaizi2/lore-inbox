Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVHNVYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVHNVYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 17:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVHNVYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 17:24:37 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:16264 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932306AbVHNVYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 17:24:37 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: linux-kernel@vger.kernel.org
Cc: hch@infradead.org, arian@infradead.org, lkml.hyoshiok@gmail.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+WHVD58LyIKj5Djda9+x"
Date: Sun, 14 Aug 2005 23:24:20 +0200
Message-Id: <1124054660.10376.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+WHVD58LyIKj5Djda9+x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, all

I might be missunderstanding things but...

First of all, machines with long pipelines will suffer from cache misses
(p4 in this case).

Depending on the size copied, (i don't know how large they are so..)
can't one run out of cachelines and/or evict more useful cache data?

Ie, if it's cached from begining to end, we generally only need 'some
of' the begining, the cpu's prefetch should manage the rest.

I might, as i said, not know all about things like this and i also
suffer from a fever but i still find Hiro's data interesting.

Isn't there some way to do the same test for the same time and measure
the differences in allround data? to see if we really are punished as
bad on accessing the data post copy? (could it be size dependant?)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-+WHVD58LyIKj5Djda9+x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBC/7aE7F3Euyc51N8RAjP+AJ9x36doGPtrF7WWZI0S/AaZSENtuwCfYocP
tMyQR5vpD06u+Stzxl6jicY=
=Ppx9
-----END PGP SIGNATURE-----

--=-+WHVD58LyIKj5Djda9+x--

