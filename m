Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUGLDvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUGLDvY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUGLDvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:51:24 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:44045 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S266703AbUGLDvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:51:21 -0400
Date: Sun, 11 Jul 2004 22:51:19 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: parport - interrupt sharing possible?
Message-ID: <20040712035119.GA1865@dbz.icequake.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

Does anyone know if the generic parport interrupt handler is okay (or not)
for sharing interrupts?  The reason I ask is that I have a PCI parallel
card with two ports on it.  Without a IRQ sharing capability, it is not
possible for both of them to operate in interrupt-driven mode.  I tested
a quick hack to enable IRQ sharing:
http://home.icequake.net/~nemesis/parport.diff

and it seems to work okay with both ports in use.  I'm hoping someone
more knowledgeable on the parallel port subject (Tim Waugh?) can shed
some light on whether this is acceptable or not.  The interrupt handler
eventually ends up in parport_ieee1284_interrupt which really doesn't do
much besides wake up sleepers.

Thanks!

PS: Heh, the power just went out and back on as I wrote this.  Giving thanks
for having multiple UPS units around!

--=20
Ryan Underwood, <nemesis@icequake.net>

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA8gq3IonHnh+67jkRApGpAJ4h7wIbreccTMfFhBs4fdeZQQnLjQCgjfr6
lGGwCKhK4y+mVwGe/btjxxg=
=Vyud
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
