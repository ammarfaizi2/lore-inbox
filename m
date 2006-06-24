Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932828AbWFXF0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbWFXF0E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 01:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932836AbWFXF0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 01:26:04 -0400
Received: from home.keithp.com ([63.227.221.253]:31492 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932828AbWFXF0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 01:26:03 -0400
Subject: Re: i915 vsync interrupt fix
From: Keith Packard <keithp@keithp.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: keithp@keithp.com, airlied@linux.ie,
       Alan Hourihane <alanh@fairlite.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
In-Reply-To: <449C891E.6010405@goop.org>
References: <449C891E.6010405@goop.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wUz+ToYHIVaBaNaKeN7d"
Date: Fri, 23 Jun 2006 22:25:03 -0700
Message-Id: <1151126703.1668.10.camel@neko.keithp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wUz+ToYHIVaBaNaKeN7d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-23 at 17:36 -0700, Jeremy Fitzhardinge wrote:
> I need this patch from Alan Hourihane=20
> <mailto:alanh@fairlite.demon.co.uk> to make direct rendering work=20
> properly on my 945GM-based laptop. It comes from=20
> https://bugs.freedesktop.org/show_bug.cgi?id=3D7233.  This change is=20
> immediately useful to me now, but I don't know if the development DRM is=20
> going to be merged with the kernel any time soon (I notice CVS has a=20
> variant of this patch).

CVS has a more comprehensive patch where the X server tells the DRI
module which pipe it should use to signal vblank. With the patch posted,
a dual-head environment will generate interrupts on *both* pipes, which
will reduce performance while negating the desired synchronized
behaviour.

The more complete fix requires updated DRI bits and an updated
xf86-video-intel 2D driver, but no changes are needed in the Mesa GL
driver. This bumps the i915 DRM version to 1.5.

When we start looking at mergedfb environments, we may want to consider
an even more sophisticated fix where the vblank used depends on the
dominant monitor displaying the window. The patch I made won't help with
that, unfortunately.

--=20
keith.packard@intel.com

--=-wUz+ToYHIVaBaNaKeN7d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEnMyvQp8BWwlsTdMRAjFNAKCa/XJhkoFHOVJ+YaLn+eGP2uDxowCgslnT
lD2GztAFB+JQRcMrTkFNqlI=
=SM4a
-----END PGP SIGNATURE-----

--=-wUz+ToYHIVaBaNaKeN7d--
