Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFNM6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFNM6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 08:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFNM6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 08:58:34 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:8326 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261220AbVFNM6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 08:58:31 -0400
Date: Tue, 14 Jun 2005 14:58:28 +0200
From: Martin Waitz <tali@admingilde.org>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is one sync() not enough?
Message-ID: <20050614125828.GM446@admingilde.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
References: <20050614094141.GE1467@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="20XocjIeMTCm4X0r"
Content-Disposition: inline
In-Reply-To: <20050614094141.GE1467@schottelius.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--20XocjIeMTCm4X0r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Jun 14, 2005 at 11:41:41AM +0200, Nico Schottelius wrote:
> When my system shuts down and init calls sync() and after that
> umount and then reboot, the filesystem is left in an unclean state.
>=20
> If I do sync() two times (one before umount, one after umount) it
> seems to work.

unmounting the filesystem writes to the disk.
If you don't wait for those writes to reach the disk, then
you still have a dirty filesystem.

--=20
Martin Waitz

--20XocjIeMTCm4X0r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCrtR0j/Eaxd/oD7IRAnSFAJ92ifN+bFNldxsrftYewBb4Z4XcDQCdHJoY
5SD41xZyv642ch1odF52ezA=
=3M7i
-----END PGP SIGNATURE-----

--20XocjIeMTCm4X0r--
