Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273562AbRIQKpI>; Mon, 17 Sep 2001 06:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRIQKpB>; Mon, 17 Sep 2001 06:45:01 -0400
Received: from warande3094.warande.uu.nl ([131.211.123.94]:50035 "EHLO
	xar.sliepen.oi") by vger.kernel.org with ESMTP id <S273562AbRIQKoz>;
	Mon, 17 Sep 2001 06:44:55 -0400
Date: Mon, 17 Sep 2001 12:45:00 +0200
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk errors and Reiserfs
Message-ID: <20010917124500.A30176@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <200109162329.f8GNTY918084@demai05.mw.mediaone.net> <E15imSi-00068f-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <E15imSi-00068f-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2001 at 01:40:36AM +0100, Alan Cox wrote:

> > Is it possible for the kernel to handle this with enough grace that you=
=20
> > can kill the processes and unmount the partition?  (Thus allowing the b=
ox=20
> > to continue in a hobbled, but function manner.)  Failing that, is it=20
> > possible for the kernel to handle it well enough for 'shutdown' to clea=
nly=20
> > shutdown the box?
>=20
> Killing the process isnt neccessary, its been halted in its tracks. As to
> a clean shutdown - no chance. You've just hit a disk failure, the on disk
> state is not precisely known, writes have been lost. Nothing is going to
> make a clean shutdown possible under such circumstances.

Of course. But I did notice that (for ext2) the filesystem dirty flag is not
set if there are errors from the underlying block device, only when it actu=
ally
detects some corruption. So these errors will not trigger an appropiate
response like remounting read-only or fscking on reboot.

--=20
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7pdQrAxLow12M2nsRAqqvAJ9JsLntuCcPqUZFIc9681bz0Ej8EACgpFrX
Jo6DNKuclU/6HdPbFl2GdSY=
=wBx1
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
