Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030512AbWBNIFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbWBNIFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWBNIFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:05:46 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:64974 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932256AbWBNIFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:05:44 -0500
Date: Tue, 14 Feb 2006 09:05:42 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mail@joachim-breitner.de, linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] [CM4000,CM4040] Add device class bits to enable udev device creation
Message-ID: <20060214080542.GB4605@sunbeam.de.gnumonks.org>
References: <1138536696.6509.9.camel@otto.ehbuehl.net> <1138541796.6395.8.camel@otto.ehbuehl.net> <20060131101046.GS4603@sunbeam.de.gnumonks.org> <20060131180927.6843c775.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20060131180927.6843c775.akpm@osdl.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2006 at 06:09:27PM -0800, Andrew Morton wrote:
> Harald Welte <laforge@gnumonks.org> wrote:
> >
> > Please apply this fix to the cm4000/4040 drivers, thanks!
> >=20
> >  [CM4000,CM4040] Add device class bits to enable udev device creation
> >=20
> >  Using this patch, Omnikey CardMan 4000 and 4040 devices automatically
> >  get their device nodes created by udev.
>=20
> Dominik has made quite widespread changes to these drivers - enough that
> I'm not confident to fix the rejects, make it compile and hope that it
> still works.

sorry for that.  I honestly don't have the time to track two trees, and
I do all my development work against Linus' main tree, therefore my
patches are against that tree, too.

> So can you please sort things out with Dominik?  I guess a tested patch
> against -mm4 would be ideal.

The question is: Why wouldn't my patch directly go mainline but rather
via -mm?  It is a very special-purpose device, the number of users are
small, it clearly fixes the bug that no device nodes are created, and
the fix came from the original maintainer.

> I note that these drivers forget to check for pcmcia_register_driver()
> failure.  That's a fairly good way of getting an oops in rmmod.

Thanks, I'll cook up a fix.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8Y9WXaXGVTD0i/8RAnNGAJ414UoBOfwb3XUypKEidcmc/fUADACcCQj/
KB0SMdFRq5e06caPyPhNncg=
=GY5Q
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
