Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTDPNDx (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 09:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTDPNDx 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 09:03:53 -0400
Received: from iucha.net ([209.98.146.184]:54574 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S264343AbTDPNDv 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 09:03:51 -0400
Date: Wed, 16 Apr 2003 08:15:36 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030416131536.GF29143@iucha.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@codemonkey.org.uk
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net> <20030415154355.08ef6672.akpm@digeo.com> <20030416004556.GD29143@iucha.net> <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
In-Reply-To: <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2003 at 12:42:08PM +0100, Alan Cox wrote:
> On Mer, 2003-04-16 at 01:45, Florin Iucha wrote:
> > On Tue, Apr 15, 2003 at 03:43:55PM -0700, Andrew Morton wrote:
> > > florin@iucha.net (Florin Iucha) wrote:
> > > >
> > > > I think it has to do with the interaction between XFree86 4.3.0 and
> > > > the AGP code.
> > >=20
> > > Has anyone tried disabling kernel AGP support and retesting?
> >=20
> > Now that you suggested it, I disabled kernel AGP support and 4.3.0
> > (Daniel Stone Debian packages) works fine so far.
>=20
> Disablign AGP turned off 3D. There is a problem in a lot of the current
> DRI drivers where shared IRQs break as sometimes do restarts because
> the IRQ is not masked properly in the DRI module on close down. Its
> certainly true in the -ac tree (Radeon patch pending, someone apparently
> has other patches I need to chase).

I did a lspci -v and the Radeon has IRQ 5 all to itself. There is no
sharing.

I do suspect the=20
agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
might give us a clue, since lspci says
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev
01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL
[Radeon 8500 LE]

Maybe the AGP code is trying to push some bits in the wrong
port/address?

Thanks,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nVd4NLPgdTuQ3+QRAmwoAJoCtTPbftiuDcay6sMVi3CFHSUUpwCeI6d3
iPO/6P7LERmySyfEoYyIA6I=
=YpFj
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
