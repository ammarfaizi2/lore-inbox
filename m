Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276587AbRJCR1C>; Wed, 3 Oct 2001 13:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276589AbRJCR0x>; Wed, 3 Oct 2001 13:26:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60412 "EHLO
	DwarfGoat.MVista.COM") by vger.kernel.org with ESMTP
	id <S276587AbRJCR0r>; Wed, 3 Oct 2001 13:26:47 -0400
Date: Wed, 3 Oct 2001 10:27:23 -0700
From: Paul Mundt <pmundt@mvista.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Huge console switching lags
Message-ID: <20011003102723.A17423@mvista.com>
In-Reply-To: <20011003101944.29249@smtp.adsl.oleane.com> <Pine.LNX.4.10.10110030955470.32026-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.10.10110030955470.32026-100000@transvirtual.com>; from jsimmons@transvirtual.com on Wed, Oct 03, 2001 at 09:58:30AM -0700
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2001 at 09:58:30AM -0700, James Simmons wrote:
> > Well, there are indeed a few improvements to get with machine specific
> > optimisations on unaccelerated framebuffer.
> [snip]...
>=20
> Neat trick. Please note also that no read operations to the framebuffer
> are done by the fbcon layer. Such reads should be to the shadow buffers
> (vc_screenbuffer) instead. Reading the framebuffer is a userland operation
> and as such you really only tricks for reading in userland.=20
>=20
And while we're on the subject of architecture specific optimizations for
unaccelerated framebuffers (or framebuffers in general for that matter),
on SH4 you can remap the video memory area through a store queue and perform
all writes through the remapped store queue area (there are two store queue=
s,
each are 32bytes, and are flushed to the memory they were mapped to on a
prefetch instruction). This allows for very high speed writes to external
memory, as it was designed for.

Regards,

--=20
Paul Mundt <pmundt@mvista.com>
MontaVista Software, Inc.


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAju7SnoACgkQYLvqhoOEA4EGwwCgjyHdzPI+LIFpAsgVeeGgL02p
DKQAnjieE89eXQ1KAilvuherDR4Ma1+v
=WCqx
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
