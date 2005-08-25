Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVHYOmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVHYOmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVHYOmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:42:18 -0400
Received: from sipsolutions.net ([66.160.135.76]:51463 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1750927AbVHYOmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:42:17 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Johannes Berg <johannes@sipsolutions.net>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Robert Love <rml@novell.com>, Reuben Farrelly <reuben-lkml@reub.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1124979228.5039.38.camel@vertex>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>  <1124977672.32272.10.camel@phantasy>
	 <1124979228.5039.38.camel@vertex>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-x2LPFMJoF61GhTYJ7z7p"
Date: Thu, 25 Aug 2005 16:41:47 +0200
Message-Id: <1124980907.19546.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-x2LPFMJoF61GhTYJ7z7p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-25 at 10:13 -0400, John McCutchan wrote:

> I really don't want 2.6.13 to go out with this bug or the compromise. If
> we use 0, we will have a lot of wd re-use. Which will cause "strange"
> problems in inotify using applications that cleanup upon receipt of an
> IN_IGNORE event.

What happens when, given bug-free code that doesn't reuse, you hit the
8192 limit with wd, even if they're not all open at the same time? Does
it still add them, or will inotify give an error? And does the idr layer
handle something like that gracefully without using lots of memory?

The background is that the process using this is potentially quite
long-running and keeps opening/closing wds, so 8192 doesn't sound like a
high barrier, after all Reuben observed hitting the 1024 limit after 15
minutes or so.

johannes

--=-x2LPFMJoF61GhTYJ7z7p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQw3YqaVg1VMiehFYAQLRXBAAtbLSxIoIRh6uAKbw9CnZ5ceWD1iayYQe
wCUCYOcKq7Ln7KhmUNj021k1++akN/tTfQp2h9aiYf7qZcUvda0Aroz8PYcY79La
FKunCGoXoO8MfcyUU8zz0nqaNaEgtrGL7fu5jLgUIUnwjJozgyb056P4EYDOkpSz
7M488zIWB5HxJyETXwvJhUH2oDqE2/oel+3Fyyb3MnI8ZktGIEp6Qxwzw3XxVXXa
uJId/zTOlJt9Ni+R8hLitNUbnxxra4u4DDximgQfxfuYot0ye45VfXxFHtLgHLOn
GoHmcH7/MGqWbiRZbWurPgAZZoMWdQ0v0wD5Ky/tDDKjLcftekdGGxfotH16UnQF
v9jM/rEgbfHZ+QU+xTBPPvA6mCcUnsFnUML4tN41BbRR7tPTRFyIusJxiBRlKN1H
zsyWIpb+SKQ/6OwsMlwRbk7wvW6HLZUJwXLfWGhIXaByaDVcU5l0e5gVKDjHM5WS
aSbRwyexYbgPZIQwPUIDD1cPBRaqXbVAuW+djDAbahRuB2TY6ye8pKYesBOJl/Ls
V2blMEulyvlOanhZrFAhA/xFfPu9i0KK0Pe7Yk9Wm5UFtOaunckqKrF9gVyco/og
F71BQiZZkfmeM4ainFA8RyMYn20us/64cGy0llj1BH6F1RU8LMuR3hVAxS8ruIqJ
IkJI2ZbVVPo=
=RgKV
-----END PGP SIGNATURE-----

--=-x2LPFMJoF61GhTYJ7z7p--

