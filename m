Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUILH53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUILH53 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 03:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268528AbUILH53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 03:57:29 -0400
Received: from devel.lbsd.net ([196.25.111.100]:26597 "EHLO web.linuxrulz.org")
	by vger.kernel.org with ESMTP id S268527AbUILH5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 03:57:25 -0400
Date: Sun, 12 Sep 2004 09:57:05 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       daniel@lando.co.za
Subject: Re: CPU Context corruption
Message-ID: <20040912075705.GN10151@lbsd.net>
References: <4142DF44.7010900@lbsd.net> <1094906455.21088.2.camel@localhost.localdomain> <20040912063655.GB1444@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="thp9dqVshybL/zK/"
Content-Disposition: inline
In-Reply-To: <20040912063655.GB1444@alpha.home.local>
User-Agent: Mutt/1.4.2.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--thp9dqVshybL/zK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > CPU 0: Machine Check Exception: 0000000000000004
> > > Bank 0: 820000001040080F
> >=20
> > It normally indicates a hardware problem. The precise meaning of all the
> > bits is in the Intel chip docs (volume 3). If you've swapped the
> > mainboard/cpu it might just be bad RAM.
>=20
> He can also get precise info with Dave Jones' parsemce tool :
>=20
>     http://www.kernel.org/pub/linux/kernel/people/davej/tools/
>=20

yep, i found this a few hours ago... and got the same result as below


> It currently says :
>=20
> 	Status: (4) Machine Check in progress.
> 	Restart IP invalid.
> 	parsebank(0): 820000001040080f @ 0
> 		External tag parity error
> 		CPU state corrupt. Restart not possible
> 		Bus and interconnect error
> 		Participation: Local processor originated request
> 		Timeout: Request did not timeout
> 		Request: Generic error
> 		Transaction type : Invalid
> 		Memory/IO : Other
>=20
> Since it says it's neither memory nor I/O, I think it might be related to
> a PCI parity error with some card, either during transfers or config acce=
ss.
>=20

Thats the interesting part, I have 2 cards plugged in... 1 x SIS6326 AGP
graphics card, and 1 x Connexant PCI modem card.

If I put the modem card into the left most pci slot, I get a bios IRQ
routing error.

I've replaced the AGP card with another make, same problem, I've had my=20
supplier replace the motherboard, same problem. Replaced the CPU, same
problem.

I'm going to take the system back to the supplier tomorrow and ask him
to sort it out.... I'm not going to tell him anything apart from "It
does not work", its useless explaining to him the above if he not going
to understand a word of it.

Could this be an incompatibility issue between the CPU and the mobo?

Regards
Nigel

--=20
Nigel Kukard, PhD CompSc
(Chief Executive Officer)
Linux Based Systems Design (Non-Profit)
Web: www.lbsd.net          Email: nkukard@lbsd.net
Tel: (+27) 023 349 8000     Cell: (+27) 082 333 3723
Fax: (+27) 023 349 1395  Support: 086 747 7600
Address: LIGT House, 2 Klipdrift Rd, Rawsonville
Linux Systems Design & Technology Solutions

--thp9dqVshybL/zK/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBRAFRKoUGSidwLE4RAskrAKCPKzdnCLuqJgP8vbZ7mwnLf0qqtwCgtAF3
ao4M9+qRiHUHs5sVdaI2tW0=
=67ar
-----END PGP SIGNATURE-----

--thp9dqVshybL/zK/--
