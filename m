Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVHYODx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVHYODx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVHYODx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:03:53 -0400
Received: from sipsolutions.net ([66.160.135.76]:14599 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S965000AbVHYODw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:03:52 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Johannes Berg <johannes@sipsolutions.net>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124977672.32272.10.camel@phantasy>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>  <1124977672.32272.10.camel@phantasy>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uEG20bAZqiV7ksvkAoRF"
Date: Thu, 25 Aug 2005 16:03:34 +0200
Message-Id: <1124978614.6301.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uEG20bAZqiV7ksvkAoRF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-25 at 09:47 -0400, Robert Love wrote:

> Let's just pass zero for the "above" parameter in idr_get_new_above(),
> which is I believe the behavior of the other interface, and see if the
> 1024-multiple problem goes away.  We definitely did not have that
> before.

Will we then need to test if it fails for more than 1024 watches?

If I adjust the program to

1) create /tmp/test/%d
2) watch /tmp/test/%d
3) repeat

it fails on 2.6.13-rc6 as soon as the device is full and doesn't hold
any more directories.

johannes

--=-uEG20bAZqiV7ksvkAoRF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQw3PtKVg1VMiehFYAQI9lQ//dyhK1rN9GhIQrn8/J7wjh4LlOv9LcRzE
FafI0COJp04IOAbWwPBWMqcTRF8UIgSRlimSzs5Y7P5mibCHJmLdNeD2mV+hVicT
8I0szFL4Z88q7zz6aTO2i6K5+3p3kSpabsMTPx8bn3qq9yq8+d0K1SOUvGFkFf1N
Z8F9ccSnhRpWPIUymrPUMGUjEDfWxTJ7aU5+iyuuGgoHi7uhnZFoJGRyYISAfCo2
B1FNSqwn0tsLQWxUtPibRNXtZI2NpWfchj0XU0y4uHl+ieN0OF14pMSdtZ2fJ98J
mdy7+lPRW3R+kyD6vKGB4h7peOiAHGEbaEgh9ri9klKkv1PoU4gEWrd1YeNFga1E
aHO/LEOMrsUq3IyltRnhnIV0YiLmkX7D/7JgYq4SGHahpOYNDQXULPQhk4vPfIks
LOKEhNml7/aAHTBMX75T4qUucsxerb7rqpE9babkEFTLk3AzlEGZQ2yfUTw46J4/
e1LaW8D4DWQr0SIoRB6FRHyWKYNEeVtBiDSxbIEHARIIdKOoygm5gKJxX4Fz+SLr
QAtXJ7aBtKH192O0oBffFjv4Ug/emdvbBE0zjtWeqo87X5gBh7SfAGU6JdC5GU3c
zc0W+6zgYa2VGmCFOqDV1WDc6BhQjj+D1PfikmhfJ3ygjYcIpKswI/mK72Q/GA8F
iGqHcmLNh1M=
=wOC/
-----END PGP SIGNATURE-----

--=-uEG20bAZqiV7ksvkAoRF--

