Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVCIRdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVCIRdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVCIRdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:33:24 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:22230 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262103AbVCIRWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:22:53 -0500
Subject: Re: Average power consumption in S3?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Moritz Muehlenhoff <jmm@inutil.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050309142612.GA6049@informatik.uni-bremen.de>
References: <20050309142612.GA6049@informatik.uni-bremen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Q4WyGQzXDYBYF2tPT8Du"
Date: Wed, 09 Mar 2005 18:22:50 +0100
Message-Id: <1110388970.1076.48.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q4WyGQzXDYBYF2tPT8Du
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-03-09 at 15:26 +0100, Moritz Muehlenhoff wrote:
> Hi,
> I'm using an IBM Thinkpad X31. With stock 2.6.11 and the additional
> radeontool to power-off the backlight in suspend, S3 works very well
> and reliable. During S3 I've measured a power consumption of 1400
> to 1500 mWh (using 512 megabytes of RAM). Is there still room for
> optimization? What's the typical amount of energy required for suspend-
> to-ram? From friends using iBooks with MacOS X I've heard that they
> left the notebook in suspend when leaving for a week and could still
> use it after return.

I also have an X31 and I noticed that the e1000 has Wake-On-Lan enabled
by default and the S3 code doesn't disable that (kind of defeats the
purpose :)
Disabling that will make the e1000 driver power down the chip during S3.

ethtool -s ethX wol d

I don't know if you have the e1000 or e100 in your machine, but I think
the e100 driver does the same.

I've had mine suspended for 2-3 days at most, actually havn't left it
alone for longer than that in S3 so I'm not really sure how much power
it consumes, but I'd say it's 1-2 percent of the total capacity per
hour, so somewhere below 1000mW.

I also use the standard radeontool to disable the backlight, I'll test
the version Matthew pointed out some day.

--=20
/Martin

--=-Q4WyGQzXDYBYF2tPT8Du
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCLzDpWm2vlfa207ERAvZsAJ99JQbVX++eSVVaRsa6OcauHgw9GwCgkxHd
6h5xVJzWjBiXhjjfO7hCg+0=
=ypuv
-----END PGP SIGNATURE-----

--=-Q4WyGQzXDYBYF2tPT8Du--
