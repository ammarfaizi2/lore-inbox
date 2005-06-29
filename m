Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVF2NB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVF2NB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVF2NBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:01:25 -0400
Received: from smtp.gentoo.org ([134.68.220.30]:59047 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261840AbVF2NAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:00:54 -0400
Subject: Re: [Ipw2100-devel] RE: ipw2200 can't compile under linux
	2.6.13-rc1
From: Henrik Brix Andersen <brix@gentoo.org>
To: abonilla@linuxwireless.org
Cc: "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jeff Chua'" <jeff96@silk.corp.fedex.com>,
       ipw2100-devel@lists.sourceforge.net,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <001101c57ca8$30c7d640$600cc60a@amer.sykes.com>
References: <001101c57ca8$30c7d640$600cc60a@amer.sykes.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aLZVBCBkf1aJMebDLJm8"
Organization: Gentoo Metadistribution
Date: Wed, 29 Jun 2005 15:00:40 +0200
Message-Id: <1120050040.12807.3.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aLZVBCBkf1aJMebDLJm8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-06-29 at 06:43 -0600, Alejandro Bonilla wrote:
> Probably the same reason why it won't compile in 2.6.12.
>=20
> Is it the is_multicast_ethr_addr error?
>=20
> http://ipw2200.sourceforge.net/#patches

No, it's due to the fact that someone decided to merge an old version of
the ieee80211 subsystem into Linus' tree:

commit 279385949ebb41ad166fd37505fe552cdb74ed59
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Jun 19 01:27:20 2005 +0200

    [PATCH] bring over ieee80211.h from mainline
   =20
    the prototypes and inlines aren't actually needed, but let's not diverg=
e
    from -mm too far.

This version of the ieee80211 subsystem is incompatible with current
ipw2100/ipw2200 drivers and break the compilation of these.

Sincerely,
Brix

PS: I'm not subscribed to LKML, please CC: me on any replies.
--=20
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd

--=-aLZVBCBkf1aJMebDLJm8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCwpt4v+Q4flTiePgRArHEAJoCzJfuAa8xkCiyMUynSP4W5+udJACfUKDP
MU/KXn3ofGDEN7eR5x5xuR8=
=kjmL
-----END PGP SIGNATURE-----

--=-aLZVBCBkf1aJMebDLJm8--

