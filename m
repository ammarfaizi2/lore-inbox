Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSHUHzi>; Wed, 21 Aug 2002 03:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318036AbSHUHzi>; Wed, 21 Aug 2002 03:55:38 -0400
Received: from sauron.forwiss.uni-passau.de ([132.231.20.100]:12491 "EHLO
	sauron.forwiss.uni-passau.de") by vger.kernel.org with ESMTP
	id <S318035AbSHUHzh>; Wed, 21 Aug 2002 03:55:37 -0400
Date: Wed, 21 Aug 2002 09:59:43 +0200
From: M G Berberich <berberic@fmi.uni-passau.de>
To: linux-kernel@vger.kernel.org
Subject: bttv-driver: help required with new card
Message-ID: <20020821075942.GF11372@finarfin.forwiss.uni-passau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have a framegrabber to work with linux (2.4.18). It's a BT878
device and I have a lot of questions :(

a) It does not use the muxsel-bits in BT848_IFORM but some bits in
   BT848_GPIO_DATA to select video-input---so seems to be a quite
   unusual device.

   Should I make switch(btv->type) statments in bt848_muxsel?

b) several registers have to be initialised to other values then
   usual, to make the card work.

   At the moment I'm doing this in bt848_muxsel, but I would like to
   move to a place where it is not executed every time I switch input
   Is init_bt848 the right place?

   (The framegrabber should generate sync-signals and provide them to
   the cameras allowing to switch between cameras in 40ms, so
   initializing the chips every time would not work)

c) It does not identify with PCI_SUBSYSTEM_ID/PCI_SUBSYSTEM_VENDOR_ID
   (gives 0xffff). Any other way to autodetect it?

d) Who is the bttv-maintainer?!

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic@fmi.uni-passau.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  | www.fmi.uni-passau.de/~berberic

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (SunOS)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9Y0hsnp4msu7jrxMRA103AKCEhCYwrvbTyrsmRta/Ej8ovS9imACfWajm
eM42c5SZK6e62Y6jV0cT1n4=
=xiTS
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
