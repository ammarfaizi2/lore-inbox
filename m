Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTKOTWY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 14:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTKOTWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 14:22:24 -0500
Received: from coruscant.franken.de ([193.174.159.226]:29887 "EHLO
	dagobah.gnumonks.org") by vger.kernel.org with ESMTP
	id S261936AbTKOTWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 14:22:22 -0500
Date: Sat, 15 Nov 2003 18:33:10 +0100
From: Harald Welte <laforge@netfilter.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: seq_file and exporting dynamically allocated data
Message-ID: <20031115173310.GA4786@obroa-skai.de.gnumonks.org>
References: <20031115093833.GB656@obroa-skai.de.gnumonks.org> <20031115171843.GN24159@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <20031115171843.GN24159@parcelfarce.linux.theplanet.co.uk>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Prickle-Prickle, the 27th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2003 at 05:18:44PM +0000, viro@parcelfarce.linux.theplanet.=
co.uk wrote:
> On Sat, Nov 15, 2003 at 10:38:33AM +0100, Harald Welte wrote:
> > that doesn't help.  As I am aware, the seq_file structure is only
> > allocated in the seq_open() call.  How does seq_open() know which
> > private data (i.e. hash table) to associate with struct file?
>=20
> Why should seq_open() know that?  Its caller does and it can set the damn
> thing to whatever it wants.

So who is the caller? it's the ->open() member of struct
file_operations.  and struct file_operations doesn't have some private
member where I could hide my pointer before saving it to
seq_file.private in seq_open().

> Wrong.

Hm, maybe somebody could enlighten me then.  Maybe this is a stupid
qestion, but I wasn't able to figure that out after reading all the
structures, etc.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tmNWXaXGVTD0i/8RAiDQAJ97HCvvPcD5dMwmBIeNi4e9d1MgBQCgo94u
JaFVuCj5UdvVgRd5VGss0/o=
=p/Wi
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
