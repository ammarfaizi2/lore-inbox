Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUHSHQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUHSHQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUHSHQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:16:36 -0400
Received: from ender.smtp.cz ([81.95.97.119]:58506 "EHLO out.smtp.cz")
	by vger.kernel.org with ESMTP id S262085AbUHSHQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:16:32 -0400
Subject: Re: network regression using 2.6.8.x behind Cisco 1712
From: =?iso-8859-2?Q?Ond=F8ej_Sur=FD?= <ondrej@sury.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1092849905.26056.17.camel@localhost.localdomain>
References: <1092817247.5178.6.camel@ondrej.sury.org>
	 <1092849905.26056.17.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-McZ160WfxTuibZB4nco8"
Date: Thu, 19 Aug 2004 09:16:29 +0200
Message-Id: <1092899789.5191.1.camel@ondrej.sury.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-McZ160WfxTuibZB4nco8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-18 at 18:25 +0100, Alan Cox wrote:
> On Mer, 2004-08-18 at 09:20, Ond=C5=99ej Sur=C3=BD wrote:
> > It could be some bug in IOS, but it is triggered by some change between
> > 2.6.7 and 2.6.8.  Any hints what should I try or where to look?
> > I could try some -pre and -rc kernel to locate where this was
> > introduced, but at least try to hint me which version should be
> > considered, I am not so willing to compile all -preX and -rcX, but coul=
d
> > do that if neccessary to hunt this regression.
>=20
> echo "0" >/proc/sys/net/ipv4/tcp_window_scaling see if that helps.

Yep, that helped.  Thanks a lot.

> If so then suspect something like the cisco or upstream router.

I will report this to my local Cisco support partner.

O.
--=20
Ond=C5=99ej Sur=C3=BD <ondrej@sury.org>

--=-McZ160WfxTuibZB4nco8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJFPM9OZqfMIN8nMRAv8XAKCHhCA6ymy0DE1EuA6kRZ8YloiMlACfRbIY
WNB/MOZCzOrYJkhgSn/+crk=
=50UK
-----END PGP SIGNATURE-----

--=-McZ160WfxTuibZB4nco8--

