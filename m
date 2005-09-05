Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVIEJOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVIEJOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVIEJOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:14:11 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:4804 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932292AbVIEJOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:14:10 -0400
Date: Mon, 5 Sep 2005 11:14:08 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Message-ID: <20050905091408.GB20386@sunbeam.de.gnumonks.org>
References: <20050904101218.GM4415@rama.de.gnumonks.org> <200509041458.33341.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <200509041458.33341.ioe-lkml@rameria.de>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 04, 2005 at 02:58:27PM +0200, Ingo Oeser wrote:

> just use
> 	return nonseekable_open(inode, filp);
>=20
> to really disable any file pointer positioning (e.g. pwrite/pread too).
>=20
> Addtionally cmx_llseek() is implement already as "no_llseek()"
> by the VFS, so you delete it from the driver an use no_llseek() from
> the VFS instead.

great, thanks,  I've merged your suggested changes into my local tree.
Stay tuned for a re-submit later today.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHAxgXaXGVTD0i/8RArqdAJ4k9Vnp2IzIsAdDUFcNhnSzlBOLwACfdiAS
yO2XMp2ezi/WX0dWOyg0PzA=
=u5+6
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
