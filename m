Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVBLBNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVBLBNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVBLBNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:13:24 -0500
Received: from smtp07.auna.com ([62.81.186.17]:59612 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261726AbVBLBNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:13:17 -0500
Date: Sat, 12 Feb 2005 01:13:16 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: udev::cdsymlinks does not consider a 'cdrw' as a 'cdrom'
To: linux-kernel@vger.kernel.org
References: <1108170212l.5587l.0l@werewolf.able.es>
In-Reply-To: <1108170212l.5587l.0l@werewolf.able.es> (from
	jamagallon@able.es on Sat Feb 12 02:03:32 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1108170796l.5587l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-7uSSfyOhBXG2ZlkdA/P8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-7uSSfyOhBXG2ZlkdA/P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.02.12, J.A. Magallon wrote:
> Hi...
>=20
> I have a little problem with udev. I have udev-051, but have tried
> cdsymlinks.c from 053 and is the same.
>=20
> It does not give 'cdrom' or 'dvd' for DVD writers.
> In one box, hdb is a DVD, and hdc is a DVDRW:
>=20

Opps, and cdsymlinks.c and .sh behave different:

werewolf:~# /sbin/cdsymlinks hdc -d
Devices: hdb hdc
DVDRAM : 0 1 hdc
DVDRW  : 0 1 hdc
DVD    : 1 1 hdb hdc
CDRW   : 0 1 hdc
CDR    : 0 1 hdc
CDWMRW :
CDMRW  :
CDROM  : (all) hdb hdc
 cdrw dvdrw dvdram

werewolf:~# /etc/udev/scripts/cdsymlinks.sh hdc -d
Devices: hdb hdc
DVDRAM : 0 1 hdc
DVDRW  : 0 1 hdc
DVD    : 1 1 hdb hdc
CDRW   : 0 1 hdc
CD-R   : 0 1 hdc
CDMRW  : 1 1 hdb hdc
CDM    : 1 1 hdb hdc
CDROM  : (all) hdb hdc
 cdrom1 cdrw dvd1 dvdrw dvdram

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam9 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


--=-7uSSfyOhBXG2ZlkdA/P8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCDVgsRlIHNEGnKMMRArPzAJ0QgZPEx91x3wejIcZusMQS5+UjXgCeP261
NmoMw8eI5INzpY1xQJH/4sI=
=hgKd
-----END PGP SIGNATURE-----

--=-7uSSfyOhBXG2ZlkdA/P8--

