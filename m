Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVAHQXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVAHQXl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVAHQXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:23:41 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:50922 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261204AbVAHQXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:23:38 -0500
Subject: Re: Swapoff inifinite loops on 2.6.10-bk (was: .6.10-bk8 swapoff
	after resume)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Hugh Dickins <hugh@veritas.com>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0501081547260.2688-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0501081547260.2688-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-95rVk1KI3gGkF7bSJ7wQ"
Date: Sat, 08 Jan 2005 17:23:34 +0100
Message-Id: <1105201414.4514.2.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-95rVk1KI3gGkF7bSJ7wQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-01-08 at 16:00 +0000, Hugh Dickins wrote:

> You're right, and yes, I could then reproduce it.  Looks like I'd only
> been testing on 3levels (HIGHMEM64G), and this only happens on 2levels.
>=20
> Patch below, please verify it fixes your problems.  And please, could
> someone else check I haven't screwed up swapoff on 4levels (x86_64)?
> From the likeness of the code at all levels I'd expect it to be fine,
> but there's nothing like a real test - thanks...

The patch fixes the problem completely here.
swapoff after running the memory hog works as expected.
and swapoff after suspend to disk and resume also works fine.

Thanks for tracking this down and fixing it.

--=20
/Martin

--=-95rVk1KI3gGkF7bSJ7wQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB4AkGWm2vlfa207ERAmXXAJ9p6NNRFVjPVq8cF4RBi0wmOEXylQCfdppD
gl8Ergh+tfYVL5YZ4xHn8/U=
=lXSK
-----END PGP SIGNATURE-----

--=-95rVk1KI3gGkF7bSJ7wQ--
