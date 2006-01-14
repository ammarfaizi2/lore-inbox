Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWANJ3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWANJ3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 04:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWANJ3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 04:29:11 -0500
Received: from sipsolutions.net ([66.160.135.76]:58378 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1751119AbWANJ3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 04:29:10 -0500
Subject: Re: wireless: recap of current issues (configuration)
From: Johannes Berg <johannes@sipsolutions.net>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060114011726.GA19950@shaftnet.org>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213011.GE16166@tuxdriver.com>
	 <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost>
	 <20060114011726.GA19950@shaftnet.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TL8RaBOnN84tYNHX3RYT"
Date: Sat, 14 Jan 2006 10:28:09 +0100
Message-Id: <1137230889.2520.82.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TL8RaBOnN84tYNHX3RYT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-13 at 20:17 -0500, Stuffed Crust wrote:

> If you're talking about the former.. things get quite complicated, but=20
> that could be handled by having two WiPHY devices registered.

The former; and yes, I thought about that too -- having a driver that
shows two physical WiPHY devices as a single logical WiPHY device and
distributes virtual devices among them...

> As for the latter, when you factor in the needs of 802.11d and its
> dependents (802.11j, 802.11k, and others) the stack is going to need to
> be aware of the available channel sets; both in the sense of hardware
> support and also the various regulatory requirements.=20
>=20
> The hardware knows what frequencies it supports.  Unfortunately this has=20
> to be a somewhat dynamic thing, as this is often not queryable until the=20
> device firmware is up and running. =20
>=20
> This can be accomplished by passing a static table to the=20
> register_wiphy_device() call (or perhaps via a struct wiphy_dev=20
> parameter) or through a more explicit, dynamic interface like:
>=20
>   wiphy_register_supported_frequency(hw, 2412).=20

Yeah, this is about what I thought of -- and it makes me wonder if the
stack really should be aware of the channelization, or if the WiPHY
driver might better just handle it itself.

johannes

--=-TL8RaBOnN84tYNHX3RYT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ8jEJ6Vg1VMiehFYAQKcBg//SjtxxqYl0PYC4zCPhDvNifSoyzik7XLm
ujKq3bHegWSz+035COK/wpNY09BfXIyEzdoHUp7JRpYgyd7HB7+76AJC8sTteJGa
eYwvU30vbSQglmLKI0ElinUs5c1VE0jh30Xdg8h6L0vaJGy9Lc0sKF8bARz8MGUu
G3ZgPmpxpCIFAj9JjQ9E/AuPpFsyVo8li1iImlFmf65WvSQwLzatYTcSoJOzbV4p
WNxmqTepkmOedIm3UV3iAw+Oxh8BcnRnpfEqEaB5Qdq/Nv3eWb5zu+WNsNYAEvvX
Wg7b9SScPzaAUdxdeCT6EqxljJOJPkcjgMxAqj6wkoqhNSZLB5qFPCifR61mcgSo
2lRkyty1dtDimDWCQ1NL92f8EUEq8/qSLJoOrJFP9dojLRzVaiyOvViIToOmpqyq
o8atn5gwftLHCXumY0b2TFVl0KmO8YrsJ/sQeutV3+In+03ONIGmSJ8dRue5jTmJ
v1H+q1UqsiRuXjXuh4PKhjc344yeGdK0Dko8/qeOyeqlSEVorw/ZHGMH/c5rAnSH
aG0n+/ZgCmMIZqmYtn/FPzoL548e+UFyBnGQlLiLKp27SnRDBv5Ur6UmAuMAg0ek
eeDzOE5S1sS0Uckjvn/GGYA4hIglItdlKGofiwVxPNS1E4zwkimIeDoTEE5/mwgR
RJOjW/cJwmw=
=N4lU
-----END PGP SIGNATURE-----

--=-TL8RaBOnN84tYNHX3RYT--

