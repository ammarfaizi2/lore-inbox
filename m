Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423043AbWAMWdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423043AbWAMWdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423044AbWAMWdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:33:17 -0500
Received: from sipsolutions.net ([66.160.135.76]:40465 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1423043AbWAMWdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:33:16 -0500
Subject: Re: wireless: recap of current issues (compatibility)
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060113222054.GK16166@tuxdriver.com>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213126.GF16166@tuxdriver.com>
	 <20060113222054.GK16166@tuxdriver.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zzmr2n7morzN+LTOxZYx"
Date: Fri, 13 Jan 2006 23:33:10 +0100
Message-Id: <1137191590.2520.65.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zzmr2n7morzN+LTOxZYx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> The netlink configuration mechanism needs compatibility code to
> translate wireless extension ioctls into netlink transactions.

I think we could restrict this to allow ioctl configuration only if
there's just a single active virtual dev [excluding some special cases
like changing the mode which would (see above) require deactivating one
and activating another virtual dev. or is that not possible without
screwing up naming etc? that might get tricky if we disallow mode
changing, but can probably be worked around easier than allowing mode
changing, especially since this is to be deprecated]

> Should a default wlan device be created at WiPHY init?  Should it
> enable translational bridging?  I'm inclined against this, but is it
> worthwhile for compatibility?  Could/should this be a configuration
> option for the stack?

If you want the old userspace API to 'just work' you have to create one
default wlan device at WiPHY init.

> How about if WiPHY initialization triggered a netlink broadcast?

It definitely should, in any case.

johannes

--=-zzmr2n7morzN+LTOxZYx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ8gqpKVg1VMiehFYAQLU7g//cW6KA0nnVHi0wxS4b4kLjqAOwxNeIKzc
GwCgCwLGCJjkfQFmmKpsKc5BQ3MPCbBuW8EeGuv1iT/57dCgjolduHlyxfCgSSRE
IpibMygL3TAp6HE2OkRnBjjhtw2qfSIMW+yJr1ClD2G5SzO4+uWwomRzRglND1q8
Y8Z4L6vxKN40QIKFRe/ywfblpZBY7CThRCu7cQEANSvu94TMBicI3tLa5Y2HIAPZ
oYUdR/yh8OVheL86u7dw/EAxBj7p8OfZFUwCKjXmQmh5G6kpDyxspMqY1uYqohNU
9s4Q9xAjTRLm3Na/wSgEHui/N6RyJHkQYUxJ/YyuJKLSVF3eyfY0gMOZ1xIPq+vW
5WHjSu8ZloUGuHOuI915Z6PpDv6b79Rfnl9Mf2t4zEXF2+7IxSDVv7UNWu8cFAgD
2PUmDFNZO6s9oRAFWCQ2COntJhzl5jSxog4WIGux/FUVE+ZcbLaJHuBYqMSoKvWO
PuB65hGoGN6XgqWmo+dfgp5QCX7yxdiJxaU/e2x3Sp1RNf8e1ZHTtrB9YWr02kjJ
Pw0qK7w18ZD9aCLAR52ET9llukkypqRVi0VeTefb7Ds6LFJm5iryDVgHgMj9Gkrz
rOOqAjzVZPCajWidhO2CoHYYUQA4Oz7Q1rOJgnmu0DPP0exQfKzFzpMAkSttNpnN
5TNlSGTKiZY=
=E+Y7
-----END PGP SIGNATURE-----

--=-zzmr2n7morzN+LTOxZYx--

