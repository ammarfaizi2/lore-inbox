Return-Path: <linux-kernel-owner+w=401wt.eu-S1030337AbWLTUB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWLTUB1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWLTUB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:01:27 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58576 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030337AbWLTUB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:01:26 -0500
X-Sasl-enc: Ta11tn3rLQ+ZcsmAlhe8kc5i1piQIPbvi9mqS/iyNI+P 1166644876
Message-ID: <45899772.9000401@imap.cc>
Date: Wed, 20 Dec 2006 21:05:06 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] hrtimers: add state tracking, fix
References: <20061214225913.3338f677.akpm@osdl.org> <200612191815.kBJIFF4O018306@lx1.pxnet.com> <20061219195650.GA8797@elte.hu>
In-Reply-To: <20061219195650.GA8797@elte.hu>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig352EFD0D515D1FDA93DB1BBC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig352EFD0D515D1FDA93DB1BBC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 19.12.2006 20:56 schrieb Ingo Molnar:
> Could you try the fix below, does it fix your problem?

The system has been running for a whole day now without freezing,
convincing me that your patch does indeed fix my problem.

> -------------------------->
> Subject: [patch] hrtimers: add state tracking, fix
> From: Ingo Molnar <mingo@elte.hu>
>=20
> fix bug in hrtimer_is_queued(), introduced by a cleanup during
> the recent refactoring.
>=20
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Tilman Schmidt <tilman@imap.cc>

> ---
>  kernel/hrtimer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux/kernel/hrtimer.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/kernel/hrtimer.c
> +++ linux/kernel/hrtimer.c
> @@ -157,7 +157,7 @@ static void hrtimer_get_softirq_time(str
>  static inline int hrtimer_is_queued(struct hrtimer *timer)
>  {
>  	return timer->state &
> -		(HRTIMER_STATE_ENQUEUED || HRTIMER_STATE_PENDING);
> +		(HRTIMER_STATE_ENQUEUED | HRTIMER_STATE_PENDING);
>  }
> =20
>  /*

Thanks again
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig352EFD0D515D1FDA93DB1BBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiZd6MdB4Whm86/kRAhVDAJsEj6iFUnjP3m93mLNqAhNYaDDPewCdEAf2
E83QHAv8UeaWGLxFs6ccMNI=
=ephh
-----END PGP SIGNATURE-----

--------------enig352EFD0D515D1FDA93DB1BBC--
