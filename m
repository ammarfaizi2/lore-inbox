Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUAVJJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266202AbUAVJJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:09:00 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:24225 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S266201AbUAVJI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:08:58 -0500
Date: Thu, 22 Jan 2004 22:10:57 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH: Shutdown IDE before powering off.
In-reply-to: <20040122004554.26536158.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: john@grabjohn.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074762656.12774.33.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-EkQKKHt3BgxPjz1csCQE";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1074735774.31963.82.camel@laptop-linux>
 <20040121234956.557d8a40.akpm@osdl.org>
 <200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
 <1074759964.12536.65.camel@laptop-linux>
 <20040122004554.26536158.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EkQKKHt3BgxPjz1csCQE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Thu, 2004-01-22 at 21:45, Andrew Morton wrote:
> A couple of thoughts come to mind:
>=20
> a) Don't do it if the user typed reboot - only do it if we're powering do=
wn.

You'd think a parameter called shutdown would do that :>

> b) Try to do a cache flush instead.  If that fails (do we know?) then
>    power down the disk instead.

We're calling drivers_suspend and then sys_reboot for powering down, and
only calling sys_reboot when rebooting. Shouldn't cache flushes already
be happening?

Regards,

Nigel
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-EkQKKHt3BgxPjz1csCQE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAD5OgVfpQGcyBBWkRAjYFAJ9yNd06+NI+3VuPKaA6KwgStre7RQCeIaV4
pFGNnhpr/lWf3Ltzc5U1/hk=
=/1pt
-----END PGP SIGNATURE-----

--=-EkQKKHt3BgxPjz1csCQE--

