Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbULBTep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbULBTep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbULBTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:34:45 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:37801 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261735AbULBTem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:34:42 -0500
Date: Thu, 2 Dec 2004 12:34:36 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Anonymous via the Cypherpunks Tonga Remailer 
	<nobody@cypherpunks.to>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 on encrypted device mapper
Message-ID: <20041202193436.GS22547@schnapps.adilger.int>
Mail-Followup-To: Anonymous via the Cypherpunks Tonga Remailer <nobody@cypherpunks.to>,
	linux-kernel@vger.kernel.org
References: <20041202181727.5B50011643@mail.cypherpunks.to>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oN4OvwWIcd1E23D1"
Content-Disposition: inline
In-Reply-To: <20041202181727.5B50011643@mail.cypherpunks.to>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oN4OvwWIcd1E23D1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Dec 02, 2004  19:17 +0100, Anonymous via the Cypherpunks Tonga Remailer =
wrote:
> Filesystem is encrypted using dmcrypt, the encryption framework working o=
n top of the device mapper.
>=20
> I deleted a file and immediatelly i attempted to recover it using debugfs.
>=20
> Linux aaa 2.6.10-rc2 #1 Wed Dec 1 09:52:37 CET 2004 i686 GNU/Linux
>=20
> aaa:~# df -k .
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/mapper/rootfs     8676440   5278584   2957108  65% /
>=20
> aaa:~# debugfs /dev/mapper/rootfs
> debugfs 1.35 (28-Feb-2004)
> debugfs:  lsdel

Ext3 doesn't allow file undeleting (though the data on disk is not
overwritten in any way, just the metadata).  You should be happy, this
is more secure (seems you are worried about that).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--oN4OvwWIcd1E23D1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBr25LpIg59Q01vtYRAqmmAKC26VC35MulTTdFvgjh5pj/ryFVdQCbB2oG
YChOTfVRgDj8N0rciRdK0d0=
=oTO0
-----END PGP SIGNATURE-----

--oN4OvwWIcd1E23D1--
