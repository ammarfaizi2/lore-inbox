Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbSLEUiC>; Thu, 5 Dec 2002 15:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbSLEUiC>; Thu, 5 Dec 2002 15:38:02 -0500
Received: from coruscant.franken.de ([193.174.159.226]:40939 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S267388AbSLEUiA>; Thu, 5 Dec 2002 15:38:00 -0500
Date: Thu, 5 Dec 2002 21:07:57 +0100
From: Harald Welte <laforge@gnumonks.org>
To: jpiszcz <jpiszcz@lucidpixels.com>
Cc: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Question with printk warnings in ip_conntrack with 2.4.20.]
Message-ID: <20021205200756.GB11068@naboo.club.berlin.ccc.de>
References: <1038618763.22065.1.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <1038618763.22065.1.camel@rth.ninka.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux naboo 2.4.19-pre4-ben0
X-Date: Today is Prickle-Prickle, the 47th day of The Aftermath in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Nov 29 03:29:26 lucidpixels kernel: ip_conntrack: max number of expected=
=20
> connections 1 of ftp reached for 192.168.xxx.xxx->129.128.5.191, reusing
> Nov 29 03:29:30 lucidpixels kernel: ip_conntrack: max number of expected=
=20
> connections 1 of ftp reached for 192.168.xxx.xxx->129.132.7.170, reusing
> Nov 29 03:29:36 lucidpixels kernel: ip_conntrack: max number of expected=
=20
> connections 1 of ftp reached for 192.168.xxx.xxx->195.113.31.123, reusing
>=20
> These fill up my logs (kern.info) which I use for logging iptables=20
> blocked packets.

the issue is that somebody is doing something very strange to your ftp
server.  Inside an FTP session, there's always only one expectation,
since there is only one unestablished data session per control session
at any given point in time.

> Is there anyway to turn this feature off dynamically or should one just=
=20
> comment out line #970 in=20
> /usr/src/linux/net/ipv4/netfilter/ip_conntrack_core.c ?

feel free to remove the comment.  but in normal ftp protocol behaviour,
the lines above should never be printed.

--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M-=
=20
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE977IcXaXGVTD0i/8RAtvtAJ9nLCvbzdrkrNaIRldtBNqwVA8NygCfSKbX
iM8HHSXBZptNcwpsw/EAUMc=
=edML
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
