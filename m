Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUAMLIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUAMLIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:08:42 -0500
Received: from mail.actcom.co.il ([192.114.47.15]:13512 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263937AbUAMLIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:08:40 -0500
Date: Tue, 13 Jan 2004 13:08:31 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: James Pearson <james-p@moving-picture.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040113110830.GG680@actcom.co.il>
References: <4002B1D9.872714FE@moving-picture.com> <1073920950.1639.39.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GhOjTe89cQfBPqWP"
Content-Disposition: inline
In-Reply-To: <1073920950.1639.39.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GhOjTe89cQfBPqWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2004 at 10:22:31AM -0500, Trond Myklebust wrote:
> P? m? , 12/01/2004 klokka 09:40, skreiv James Pearson:
> > If mount defaults to trying TCP first then UDP if the TCP mount fails,
> > should there be separate options for [rw]size depending on what type of
> > mount actually takes place? e.g. 'ursize' and 'uwsize' for UDP and
> > 'trsize' and 'twsize' for TCP ?
>=20
> No. The number of "mount" options is complex enough as it is. I don't
> see the above as being useful.
> If you need the above tweak, you should be able to get round the above
> problem by first attempting to force the TCP protocol yourself, and then
> retrying using UDP if it fails.

I have a patch, sent to the util-linux maintainer, that adds a couple
of new mount options to nfsmount. Those allow you to force either of
tcp, udp, tcp then udp, and udp then tcp, using the existing proto=3Dxxx
syntax. It's available at=20
http://www.mulix.org/code/patches/util-linux/tcp-udp-mount-ordering-A3.diff

It also cleans up nfsmount() somewhat, although it could certainly do
with further rewrite^Wcleanups. I'm waiting to hear from the
util-linux maintainer before embarking on that, though.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--GhOjTe89cQfBPqWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAA9GuKRs727/VN8sRAjFIAJ9xI1BHDFzonA+EHyKx+Lv8gjnv9ACgvboV
cJa5+Ge/MOK3O8vvH8fbiGU=
=My7P
-----END PGP SIGNATURE-----

--GhOjTe89cQfBPqWP--
