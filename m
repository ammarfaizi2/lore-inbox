Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUAAMDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 07:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUAAMDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 07:03:14 -0500
Received: from komoseva.globalnet.hr ([213.149.32.250]:35588 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S261152AbUAAMDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 07:03:12 -0500
Date: Thu, 1 Jan 2004 12:48:24 +0100
From: Vid Strpic <vms@bofhlet.net>
To: Matthew Mastracci <mmastrac@canada.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removable USB device contents cached after removal?
Message-ID: <20040101114824.GG2432@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	Matthew Mastracci <mmastrac@canada.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-mm2
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2003 at 05:12:16PM -0700, Matthew Mastracci wrote:

[...]

> 1.  Insert card into reader.
> 2.  Mount card as directory somewhere in root filesystem, list contents=
=20
> of card
> 3.  dd if=3D/dev/sdd1 count=3D1024 bs=3D1024 | hexdump
> 	- results in correct filesystem dump
> 4.  Remove card from reader.
> 5.  dd if=3D/dev/sdd1 count=3D1024 bs=3D1024 | hexdump
> 	- same filesystem dump as before!
> 6.  cd to mountpoint, contents are still available
> 7.  dd if=3D/dev/sdd1 of=3D/dev/null
>          - approx 3MB of card data still available
> 8.  umount the mountpoint from before

Did you try `eject sdd` after this, and if not, try, and see how it
works.

> 9.  dd if=3D/dev/sdd1 of=3D/dev/null results in "No medium found"

usb-storage behaves differently in 2.6 than in 2.4, maybe this is the
problem for you now.

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-mm2 #1 Tue Dec 30 10:21:33 CET 2003 i686
 12:46:44 up 1 day, 23:08, 11 users,  load average: 0.94, 0.68, 0.69
UNIX programmers DO IT with forks.

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9AkIq1AzG0/iPGMRAtyXAJ9Eld0aj0Jtwcuf6M7jaASkW/MFTgCeJU//
az+PKiqYA26EZa0/di96Ikk=
=C7OG
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
