Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWBPVkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWBPVkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWBPVkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:40:41 -0500
Received: from admingilde.org ([213.95.32.146]:9355 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932199AbWBPVkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:40:41 -0500
Date: Thu, 16 Feb 2006 22:40:34 +0100
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Subject: RFC: more documentation in source files
Message-ID: <20060216214033.GA5517@admingilde.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I'd like to move some of the documentation which sleeps in Documentation/
into the .c files that contain the documented code in the hope that
somebody who changes the code also changes the documentation in one go.

We already have a system to generate documentation from the .c files,
so I made a little experiment and tried to use kernel-doc to build
the complete documentation after all text from the template files got
moved to the source files.
I haven't really succeeded in generating valid docbook output from
the source files alone. So I looked at other tools to do this job.

Doxygen looks fairly promising and is even already used by some
kernel files.
You can get a first impression of Doxygen output here:
http://tali.admingilde.org/linux-doxygen/html/group__drivermodel.html
For these pages I stuffed some files from Documentation/driver-model/
into drivers/base/*.c and changed some kernel-doc comments to Doxygen
comments.

However there are several drawbacks when using Doxygen:
 * it doesn't generate DocBook
 * the source markup does not look as nice as kernel-doc:
	/**
	 * foo - short description
	 * @param1: parameter description
	 * long description
	 */
	gets:
	/**
	 * short description.
	 * \param param1 parameter description.
	 * long description
	 */
   but on the other side it's much more powerful, too.
 * we need some transition strategy

Are there other nice and powerful source documentation systems?
Is it even worth trying to integrate parts of the documentation into
the source code?

What do you think?

--=20
Martin Waitz

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD9PFRj/Eaxd/oD7IRAj9yAJ99qNX9Df+t0Z3ylQu1QzetkxUy9ACfdItL
XDvnTM+ZTTftV4DHyKOKtqE=
=HaCb
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
