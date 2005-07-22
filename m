Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVGVRRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVGVRRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 13:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVGVRRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 13:17:08 -0400
Received: from flawless.real.com ([207.188.23.141]:29858 "EHLO
	flawless.real.com") by vger.kernel.org with ESMTP id S262119AbVGVRRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 13:17:02 -0400
Date: Fri, 22 Jul 2005 10:16:57 -0700
From: Tom Marshall <tmarshall@real.com>
To: linux-kernel@vger.kernel.org
Cc: pmarques@grupopie.com
Subject: itimer oddness in 2.6.12
Message-ID: <20050722171657.GG4311@real.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_flawless.real.com-17186-1122052615-0001-2"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_flawless.real.com-17186-1122052615-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The patch to fix "setitimer timer expires too early" is causing issues for
the Helix server.  We have a timer processs that updates the server's
timestamp on an itimer and it expects the signal to be delivered at roughly
the interval retrieved from getitimer.  This is very consistent on every
platform, including Linux up to 2.6.11, but breaks on 2.6.12.  On 2.6.12,
setting the itimer to 10ms and retrieving the actual interval from getitimer
reports 10.998ms, but the timer interrupts are consistently delivered at
roughly 11.998ms.  This behavior was pointed out as problematic in the patch
submission:

  http://www.kernel.org/hg/linux-2.6/?cmd=3Dchangeset;node=3D36e9195dc9f434=
67671344332f4c342f183647f7

Would it be possible to resolve this discrepancy for 2.6.13?

Please cc: me on replies, I am not subscribed.

--=20
I stayed up all night playing poker with tarot cards.  I got a full
house and four people died.
        -- Steven Wright

--=_flawless.real.com-17186-1122052615-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC4SoJqznSmcYu2m8RAh7GAJ9gFTryhNkq3g2SKV9kKb+BG/XDGACcCXMh
yZAIqBG1+mPvrtJ+atlDBzo=
=Yiv4
-----END PGP SIGNATURE-----

--=_flawless.real.com-17186-1122052615-0001-2--
