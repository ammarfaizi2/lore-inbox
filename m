Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVHYNu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVHYNu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVHYNu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:50:59 -0400
Received: from sipsolutions.net ([66.160.135.76]:64006 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S964988AbVHYNu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:50:58 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Johannes Berg <johannes@sipsolutions.net>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert Love <rml@novell.com>
In-Reply-To: <1124977253.5039.13.camel@vertex>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124972307.6307.30.camel@localhost>
	 <1124977253.5039.13.camel@vertex>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ARH8djpHFxyIwgeqctJG"
Date: Thu, 25 Aug 2005 15:50:07 +0200
Message-Id: <1124977807.6301.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ARH8djpHFxyIwgeqctJG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-25 at 09:40 -0400, John McCutchan wrote:

> On 2.6.13-rc7 the test program fails. It always fails when a wd =3D=3D 10=
24.
> If I skip inotify_rm_watch when wd =3D=3D 1024, it will fail at wd =3D=3D=
 2048.
> It seems the idr layer has an aversion to multiples of 1024.
>=20
> When I run your test program I get this a lot:

I forgot to mention this -- but I just get (on -rc6):

inotify_add_watch returned wd1 0
inotify_add_watch returned wd2 1
inotify_add_watch returned wd1 0
inotify_add_watch returned wd2 1
inotify_add_watch returned wd1 0
inotify_add_watch returned wd2 1

etc.

IOW, they are directly reused, not even with the +1 offset you were
seeing.

johannes

--=-ARH8djpHFxyIwgeqctJG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQw3MjaVg1VMiehFYAQJr2A//Ue1fV0PKNNyuvT+9E9WSb+/MoLAGRR3M
HxEzbL6Ik/dD8m3KLNtTcB+cenNYWktRNSc2b4dg5UV4OYDtA+m+ER1XsS++1/Ki
FUaYKREBLk1lqeH2jbIKXuY7b03QjvVSI+Dy8cU3PTTiStcPR5Qf4hvzGlQY8xNO
WS4A6HEMsjKMVaIav6iTnXQhrEvjdES+VqbovKN0iKGk+lRfv4sKHOyvFrF2nZf7
aFC7qDRyY2MwCAIlRe0H6svX7FDJNGIgldbNWFDnvDPwpPVNGGKxqxsXOqCbUJNZ
ISVITesjXHvJk0r1nfTnZGLjj+QjXTnnjn8zQP48uFrsVtbAE4/RnxL8H5AqKnYI
d+2RT8BbANYnzBZKLvu2cBgBwjzPZpVZy9SStYe06y2AHiosWHgEmoWdXZJs21aX
XdYJ6buYPLmn8XdlunO4ZhubNpxbFFHUjZY5xSV+BtvDMX9NdJ4brKcDuMjpFjKT
CMynOn4kkHyiQHmZxYtr08DdhJq+chJGV5bCc6bcQynMqvhlOxWfMwMEkToF8LDZ
9HQPRUFFgRC4TP+yzDRSdtP5/A4PBtY5XXg9ngwoLncztzFSrxjAxGVsqFNDlrfM
OjnWjccEh9D78e2MZRqTaeYIfRj7Rns0zhZ8Ch27RMlOZrG3/Y5kBiVLhJwgZq08
t90w3pIsuVM=
=yhOp
-----END PGP SIGNATURE-----

--=-ARH8djpHFxyIwgeqctJG--

