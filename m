Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266251AbUBDFEC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 00:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUBDFD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 00:03:59 -0500
Received: from adsl-67-124-158-125.dsl.pltn13.pacbell.net ([67.124.158.125]:6272
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S266232AbUBDFDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 00:03:53 -0500
Date: Tue, 3 Feb 2004 21:03:52 -0800
To: alsa-user@lists.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ALSA in 2.6 -- no snd-au8830?
Message-ID: <20040204050352.GD4394@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	alsa-user@lists.sourceforge.net,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040204035336.GC4394@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20040204035336.GC4394@triplehelix.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2004 at 07:53:36PM -0800, Joshua Kwan wrote:
> $SUBJECT. The driver seems to be present in alsa-driver but not the
> in-kernel version. Is it very new? Does it need to be converted? Is it=20
> deprecated in 2.6 in favor of a better driver? May I help out?

Let me eat my words. Here is what I did to get it working (at least for
au8830):

1. Check out alsa-driver from CVS.
2. cp -r alsa-driver/pci/au88x0 /usr/src/linux/sound/pci
3. edit Kconfig to add SND_AU8830 entry
4. edit Makefile to add au88x0/ subdir for obj-$(CONFIG_SND)
5. edit au88x0/Makefile to remove 2.4 build cruft

And it works! :) I can submit a diff if desired.

--=20
Joshua Kwan

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQCB9NqOILr94RG8mAQLVuA//cMmbt/oB18yHmj46j8fAhvYfXOOX4CVf
MXcTHyuz+f0mDZTuwfVkinC+CIRTqUPdsg/fZoCYuESDgpuvodE4Ynw3ox34AY85
nQiChjJ64jpEase/s44xqIh03doVJtLtgctVoBPyzwx3H3fXLgop39LktmqVwII4
MnXwHWFojrodgWRaPprKdxMbnRH193lVzqzDtQVSp3pdbxuoiR1QIpKM82p/sNKg
A4BAlhxctdOzQxXF6DsVUYJTBA56DNRDybPkvPuBOToYHikeOOB3Ob04HSjvaeUt
uCJqlGTDyPOqPNwY3ta41y/yEn3gQAtRZ4ra0ANvlwiqLkbOfGXJOKATmLy6q4+O
eNhMfdM6vflUYhtsz99pn0/DkLsVtMOVXlq3m3osjzXV99rOhFaUfYazUg9OYzdx
rOMs8kditZjA4HTsX6cO++ECFMi4lVT2oY+u8sOVU/fxs4qp8NHORxdW9hPwzkJY
bbl4iX3VCtCt1DOtsPaXS7yn/FnEzqyf/CzAlQVKQ6B+0uVxLm3iRWdyKMXo5JK+
CIOqiAeBX9+aSMmRadm3YwweXNJbBtWa8VNLxW/XcoCCm1EXqW3Q351t0cM/s3jp
UK6RqG8EJjKqoPLylrvEPT4q1h79qIntRFy17hAaXoCAGDjyLj1/pL+1YWKZU6Zy
eE7GsQ6+yvI=
=DHm+
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
