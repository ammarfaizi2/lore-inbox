Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbULDQjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbULDQjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 11:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbULDQjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 11:39:53 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.72]:60117 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262556AbULDQju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 11:39:50 -0500
Date: Sat, 04 Dec 2004 11:39:48 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: [PATCH] Time sliced CFQ #2
In-reply-to: <20041204104921.GC10449@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <20041204163948.GA20486@optonline.net>
MIME-version: 1.0
Content-type: multipart/signed; boundary=a8Wt8u1KmwUX3Y2C;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
References: <20041204104921.GC10449@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2004 at 11:49:21AM +0100, Jens Axboe wrote:
> Hi,
>=20
> Second version of the time sliced CFQ. Changes:
>=20
> - Sync io has a fixed time slice like before, async io has both a time
>   based and a request based slice limit. The queue slice is expired when
>   one of these limits are reached.
>=20
> - Fix a bug in invoking the request handler on a plugged queue.
>=20
> - Drop the ->alloc_limit wakeup stuff, I'm not so sure it's a good idea
>   and there are probably wakeup races buried there.
>=20
> With the async rq slice limit, it behaves perfectly here for me with
> readers competing with async writers. The main slice settings for a
> queue are:
>=20
> - slice_sync: How many msec a sync disk slice lasts
> - slice_idle: How long a sync slice is allowed to idle
> - slice_async: How many msec an async disk slice lasts
> - slice_async_rq: How many requests an async disk slice lasts

This looks very nice. And from your previous post (with version #1) it
would look like you made my attempt at io priorities easier. We'll see
;-)

Thanks,
Jeff.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBsehUwFP0+seVj/4RApETAKCdTx3wDxRmKh9SCUf2ifSyKpkt4gCg068U
AQNQeeRL1wGhNyogr0ef4Uo=
=TDnT
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
