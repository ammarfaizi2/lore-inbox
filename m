Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTEOKic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 06:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263954AbTEOKib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 06:38:31 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:8221 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S263953AbTEOKia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 06:38:30 -0400
Subject: RE: Two RAID1 mirrors are faster than three
From: Anders Karlsson <anders@trudheim.com>
To: Riley Williams <Riley@Williams.Name>
Cc: Clemens Schwaighofer <cs@tequila.co.jp>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BKEGKPICNAKILKJKMHCACEECDAAA.Riley@Williams.Name>
References: <BKEGKPICNAKILKJKMHCACEECDAAA.Riley@Williams.Name>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xJYY6flrGFMKqQNFjRgR"
Organization: Trudheim Technology Limited
Message-Id: <1052995874.3248.20.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 15 May 2003 11:51:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xJYY6flrGFMKqQNFjRgR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Riley,

>  > With normal mirroring (one original, one copy) you do have the
>  > redundancy and the speed boost at reads, but at mirroring with one
>  > original and two copies (I know AIX does this), you get in to a
>  > scenario that is quite handy. Say you run a large database in a
>  > 24/7 operation. You want to back the database up, but you can only
>  > get 5-10 minutes downtime on it. You then quiesce the database,
>  > split off the second copy from the mirror, mount that as a
>  > separate file system and back that up while the original with its
>  > first copy has already stepped back into full use.
>  >
>  > Once you finished your backup, you add your split-off copy back to
>  > the original and primary copy and you are back where you started.
>=20
> Does this cause any problems, with the third disc now being out of
> date compared to the first two?

No, it should not cause problems as when you add the split-off copy back
into the mirror, it is treated as 'stale' and will get synchronised with
the original.=20

I would be very surprised if the Linux software md driver worked any
diffrently than this. Perhaps someone that knows it in-depth can add to
the conversation?

With the facilities of LVM 'snapshots' now being available, this
practice of splitting off one copy from a three-way mirror is perhaps
becoming redundant, but people will likely take the approach of "if it
ain't broken, don't fix it" and leave old backup methods as they are.
So if you work in the sysadm field, you might well come across this
practice.

Regards,

/Anders

--=-xJYY6flrGFMKqQNFjRgR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+w3EiLYywqksgYBoRAgjuAKCwRKEgtW9hal+VzlCfBRs2Gny2iACgqX2X
778VOO3vJKy/37+bee8E368=
=0vC0
-----END PGP SIGNATURE-----

--=-xJYY6flrGFMKqQNFjRgR--

