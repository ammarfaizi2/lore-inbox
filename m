Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSIDXGO>; Wed, 4 Sep 2002 19:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSIDXGO>; Wed, 4 Sep 2002 19:06:14 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:6927 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S315928AbSIDXGL>; Wed, 4 Sep 2002 19:06:11 -0400
Date: Wed, 4 Sep 2002 16:10:42 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Feiya 5-in-1 Card Reader
Message-ID: <20020904161042.O13478@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, greg@kroah.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <UTC200209042256.g84Mu0w15389.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200209042256.g84Mu0w15389.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Sep 05, 2002 at 12:56:00AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nope, not confused.

I'm trying to find out why Windows doesn't choke on the strange
READ_CAPACITY value.  My guess is that there is code somewhere to
universally fixup READ_CAPACITY, and I'd like to know what the magic
formula is.

The MODE_SENSE bit is fine by me.  But it's a SCSI change, so I'm not the
person to ask.  The fix to sddr09.c for that seems reasonable, but you put
it all together and I haven't had time to split it up.  Of course, I fully
expect the changes to MODE_SENSE in the SCSI layer to break other USB
devices, but there is only one way to find out....

Matt

On Thu, Sep 05, 2002 at 12:56:00AM +0200, Andries.Brouwer@cwi.nl wrote:
> >> Matt, is it ok with you for me to add this patch to the tree?
>=20
> > I'd like to hold off a few more days while I try to find out what the
> > 'secret sauce' that the other OSes use for a device like this.
>=20
> Hmm. You do not confuse two situations, do you?
> In the past few days I made two devices work.
>=20
> One was a Feiya 5-in-1 CF / SM / SD card reader
> (Vendor Id: 090c, Product Id: 1132, Revision 1.00).
> It returned a capacity that is one too large, and becomes
> very unhappy if one tries to read a sector past the end.
> So, a flag was needed to tell that the result of READ CAPACITY
> needs fixing.
>=20
> The other was a Travelmate CF / SM / SD card reader
> (Vendor Id: 3538, Product Id: 0001, Revision 2.05).
> It became unhappy when MODE_SENSE asked for too much data.
> A patch on sd.c solved this.
>=20
> Andries

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's not that hard.  No matter what the problem is, tell the customer=20
to reinstall Windows.
					-- Nurse
User Friendly, 3/22/1998

--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9dpLyIjReC7bSPZARAr1mAJoCC83Ug2/4sRfsX2eXRgIh4xOKYwCfcS7r
JxVb1ywNZXmxe2Adix6otTg=
=hRZc
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--
