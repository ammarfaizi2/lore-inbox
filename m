Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVHSKzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVHSKzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 06:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbVHSKzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 06:55:46 -0400
Received: from sipsolutions.net ([66.160.135.76]:20490 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932616AbVHSKzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 06:55:46 -0400
Subject: Re: pmac_nvram problems
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1124401227.5182.14.camel@gaston>
References: <1124277416.6336.11.camel@localhost>
	 <1124341212.8848.78.camel@gaston>  <1124370184.30888.5.camel@localhost>
	 <1124401227.5182.14.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JSpEiK9aw6X5NUQUiE9G"
Date: Fri, 19 Aug 2005 12:55:20 +0200
Message-Id: <1124448920.24113.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JSpEiK9aw6X5NUQUiE9G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-19 at 07:40 +1000, Benjamin Herrenschmidt wrote:

> Just a question: Why do you want to have the nvram low level code as a
> module ? It's sort-of an intergral part of the arch code ...

Because I Can (TM). Actually, I just did this because of the suspend
issue where OSX would reset some values (notably the boot sound volume),
but Linux wouldn't see this. So I figured that if I can compile it as a
module (the Kconfig option is a tristate after all) I could just unload
it. But that failed because of the alloc_bootmem issue.

I wouldn't mind having it built-in at all, if it would re-read the
cached values when resuming from suspend.

johannes

--=-JSpEiK9aw6X5NUQUiE9G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQwW6l6Vg1VMiehFYAQKFgRAAooJeSH57Ba7zob4s0V2yDGmIuzD52SD6
ezI5PaxsfiP/nUsJJTFr5H4sGumi2EcTcBRdr2YPyWD9AVGmQRNXX43eR8wphf88
gu2XcYBO/sUrYfAut3peyljA83KoOYTULSkiH9n4ePyRrVVy+t4qfM3WhDDfyvW5
ChelkJEr+awiSX7uy1Oqgj8DEwkUSWIu8jyuw8XQNEKyOKuOlDspeqicRNxBDc2w
L5CvKnoolvcaXaSgYlc2IlGM/OYE4EBVHXGszmfgLqWcp9tS65Cu04wLg3wfS7YQ
T2A/wDagnJR7wU58fIq8fryChx1k6RO3USdChp/m+H9qQpJQ5kklap+tHmXGWhoA
4aOmVAeLtSI3A7+nJI8QbmJiIkvlGDiANiaRmHcxb/WKdbGjOVuBGcEZkr7AkBZ0
3LWqsZgZPLOdS9GPbjcgEnCftFpGYGaYrLnLowRjwuw6HX3q9B1RRBAUxZI+wf0H
iZoWtMc8isZxa2hSTp4IVANXaqAZ8GlLkT75+1WtTVLbPiGwqTbxPvh37aqydvG/
YbHlebCco6Pdu/6uPPQQvl+IXDERN1ZQFWHEM1AMmaXZSEZqnYBP7hkHCK5fO2j7
kp3cOikORkK4GjYxD46U/I+de/8p8tVPh9UukOw2cc5IHlF5tmvekXA2SuE/5BSm
v4g7lV8/yXo=
=CAkz
-----END PGP SIGNATURE-----

--=-JSpEiK9aw6X5NUQUiE9G--

