Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUBQQBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUBQQBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:01:36 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:40066 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S266246AbUBQQBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:01:24 -0500
Subject: Re: 2.6.2: "-" or "_", thats the question
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Harald Dunkel <harald.dunkel@t-online.de>,
       Rusty Russell <rusty@rustcorp.com.au>, Ryan Reich <ryanr@uchicago.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040217160226.GB2178@mars.ravnborg.org>
References: <1pw4i-hM-27@gated-at.bofh.it> <1pw4i-hM-29@gated-at.bofh.it>
	 <1pw4i-hM-31@gated-at.bofh.it> <1pw4i-hM-25@gated-at.bofh.it>
	 <1pLmG-4E7-5@gated-at.bofh.it> <1pRLz-21o-33@gated-at.bofh.it>
	 <1pRVi-2am-27@gated-at.bofh.it> <1pWi8-65a-11@gated-at.bofh.it>
	 <40315225.3010104@uchicago.edu> <4031B01B.80006@t-online.de>
	 <20040217160226.GB2178@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZfkjybrSRKqEEQLCgYUB"
Organization: Red Hat, Inc.
Message-Id: <1077033661.6331.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Feb 2004 17:01:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZfkjybrSRKqEEQLCgYUB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> When 2.7 opens I will try to find out if we can rename all victims.
> I can tweak kbuild to warn for modules using '-', so we in the
> end can get rid of this inconsistency.
>=20
> Rusty - do you see any problems with this?

well I'm not Rusty by a long shot, but I do see a problem with this, or
at least a subtlety that needs taking into account: the pcmcia subsystem
(I include cardmgr in that) has an internal declaration of the module
name inside the module, and the filename of the module *HAS* to match
that or things just won't work. ide-cs is the one at risk here; I've had
to debug what turned out to be a mismatch during 2.4.2-era on this one
and believe me, that's not funny.=20



--=-ZfkjybrSRKqEEQLCgYUB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAMjq7xULwo51rQBIRAm8qAJ0TQnwdEq9F6RavaRsVjX6vFkVr7ACeND9A
3ZYAF9E8mrUialsa3PdH1aQ=
=azGN
-----END PGP SIGNATURE-----

--=-ZfkjybrSRKqEEQLCgYUB--
