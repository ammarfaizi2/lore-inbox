Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTFRKJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbTFRKJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:09:39 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:57083 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S265113AbTFRKJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:09:35 -0400
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like 
	Windows!
From: Anders Karlsson <anders@trudheim.com>
To: Karl Vogel <karl.vogel@seagha.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <E19SZ8v-0005Ie-00@relay-1.seagha.com>
References: <200306172030230870.01C9900F@smtp.comcast.net>
	 <3EF0214A.3000103@aitel.hist.no>  <E19SZ8v-0005Ie-00@relay-1.seagha.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nxjZDfVGirzY7xRd2og+"
Organization: Trudheim Technology Limited
Message-Id: <1055931810.2285.24.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 Rubber Turnip www.usr-local-bin.org 
Date: 18 Jun 2003 11:23:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nxjZDfVGirzY7xRd2og+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-06-18 at 10:22, Karl Vogel wrote:
> On 18 Jun 2003, you wrote in linux.kernel:
>=20
> > rmoser wrote:
> > [...]
[...]
> > Because the problem _is_ unsolvable.  You want the kernel
> > to go "oh, lots of free memory showed up, lets pull
> > everything in from swap just in case someone might need it."
>=20
>=20
> You might want to try Con Kolivas' patches on:
>    http://members.optusnet.com.au/ckolivas/kernel/
>=20
> More specifically the 'swap prefetch' patch. From this FAQ:
>=20
> --
> Swap prefetching? If you have >10% free physical ram and any used swap it=
=20
> will start swapping pages back into physical ram. Probably not of real=20
> benefit but many people like this idea. I have a soft spot for it and lik=
e=20
> using it.
> --
>=20
> The disadvantage is ofcourse that you will be using up more RAM than is=20
> really necessary.

Sorry for breaking in, but this is an interesting discussion. :-)

I find that the Linux VM tend to push things out in to swap-space when
it does not need it. This is fine. However, I was once told something
about AIX that has lodged itself in the back of my mind.

AIX uses (or used to use) the exact same way of reading/writing data
from/to disk for all I/O. AIX also makes a distinction between code and
data. If code in RAM is unused, it simply gets flushed. If it is needed
again at a later time, it is paged in from disk where it was originally
loaded from. Only dirty data is paged out into swap.

Is it feasible to tweak the Linux VM to behave in the same fashion? If
Linux already does it this way, I'll just shut up. :)

/A


--=-nxjZDfVGirzY7xRd2og+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+8D2iLYywqksgYBoRAilpAJ4srpP3rU+6yYaqMSgFuhueWzekzQCglNyZ
pJ9tMGhOq71W426BcxekyDI=
=3n8Z
-----END PGP SIGNATURE-----

--=-nxjZDfVGirzY7xRd2og+--

