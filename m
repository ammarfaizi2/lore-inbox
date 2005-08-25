Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVHYTD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVHYTD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVHYTDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:03:42 -0400
Received: from sipsolutions.net ([66.160.135.76]:39690 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932500AbVHYTDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:03:40 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Johannes Berg <johannes@sipsolutions.net>
To: george@mvista.com
Cc: Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       jim.houston@ccur.com, Reuben Farrelly <reuben-lkml@reub.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <430E13D8.8070005@mvista.com>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124976814.5039.4.camel@vertex>
	 <1124983117.6810.198.camel@betsy>  <430E13D8.8070005@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PbA5LRkypvRqJISfnoR/"
Date: Thu, 25 Aug 2005 21:03:12 +0200
Message-Id: <1124996592.19546.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PbA5LRkypvRqJISfnoR/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-25 at 11:54 -0700, George Anzinger wrote:

> I think the best thing is to take idr into user space and emulate the=20
> problem usage. =20

Good plan, I guess. Do you think that's easy?

> To this end, from the log it appears that you _might_ be=20
> moving between 0, 1 and 2 entries increasing the number each time.  It=20
> also appears that the failure happens here:
> add 1023
> add 1024
> find 1024  or is it the remove that fails?  It also looks like 1024 got=20
> allocated twice.  Am I reading the log correctly?

Remove 1024 fails, but add(please make it >1024) seems to return 1024,
and find(1024) also seems to fail. Well, remove() probably has to
find(), but I'm not really sure what inotify does (maybe find first, to
see if it's valid).

> So, is it correct to assume that the tree is empty save these two at=20
> this time?  I am just trying to figure out what the test program needs=20
> to do.

Yes, but all the smaller ones have been in it at some point in time.

johannes

--=-PbA5LRkypvRqJISfnoR/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQw4V7qVg1VMiehFYAQKusQ/+ORQff2jTZWDVchb/RCwb7IMzA70R4let
3T5YmQwa+wpKgF+rj99lZhptsYikLGyIld1/tkYgEgamIWRLeQCVAc3vJq6jsHG/
EHAbQXY2WFHzBJ0sUYCMvhX8+LbDZwf3ZvtacD3rw967xQ0ZiMwWNMewB3CAHO2Y
GMBa9TIF6U7DnS0q+WwDCYUXLW7dcj2RVfsxoe2XBCtiGZ3q1XaADPmdTYXLNoQ8
P56hSsbgCd+xhqTKIMG1zIKSsacv70L92sbCmFbjonvOtMCeo3owbNFsgN413IAG
zHRJrTIMe55Uz0YkwgJwxiuOx+QBRAzwEicKrrKf7K/aSKCzb3sx0p7Q+QnAlezS
63nCOUXxuNhE+NJQnyOhLU7htIhoduuGSQJPpnsyVi+Q/UEP7VCZ3gNw+P1IhkbN
yc/+w4uTrVAVmF/ut0CtsaHwrxs/m3etESEkvcSych90lxe0TuaGvpKOOquKgYiE
nvyqzzFU4U9tuyhXS5+yCk3MSux20rRD/PNrTFiKrN9N/CMW/DOcv8goNE0Y4Hqh
exOBZE5kuFuTk+cLTkACo0Vu1QWGMMg+L7DFrKkRWEJDYcHgebah6datlKFijWX6
znMTHZuZsL1Sd+FZ4+NDKZ5JdJN7ARix2hnrEosJGeZt9HEdC2EtmbfcN31VbZIJ
ETBCX26T0uM=
=7aiV
-----END PGP SIGNATURE-----

--=-PbA5LRkypvRqJISfnoR/--

