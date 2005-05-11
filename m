Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVEKThm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVEKThm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVEKThm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:37:42 -0400
Received: from zak.futurequest.net ([69.5.6.152]:5826 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S262030AbVEKTh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:37:28 -0400
Date: Wed, 11 May 2005 13:37:26 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: How to diagnose a kernel memory leak
Message-ID: <20050511193726.GA29463@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050509035823.GA13715@em.ca> <1115627361.936.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <1115627361.936.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2005 at 10:29:21AM +0200, Alexander Nyberg wrote:
> the patch below might help as it works on a lower
> level. It accounts for bare pages in the system available
> from /proc/page_owner. So a cat /proc/page_owner > tmpfile would be good
> when the system starts to go low. There's a sorting program in
> Documentation/page_owner.c used to sort the rather large output.

I've been running this for a day and a half now, and a few hundred megs
of memory is now missing:

# free
             total       used       free     shared    buffers     cached
Mem:       2055648    2001884      53764          0     259024     868484
-/+ buffers/cache:     874376    1181272
Swap:      1028152         56    1028096

I've put the output from the sorting program up at
	http://untroubled.org/misc/page_owner_sorted

Is this useful information yet, or is there still too much in cached
pages to really identify the source?
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCgl726W+y3GmZgOgRAiwpAJ9+y4Fn7yZ8X3bFV4CxWIves6YK6ACfY+4E
/ionH0SKummgPnfLCCJ2bEI=
=hQj2
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
