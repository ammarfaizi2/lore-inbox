Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287484AbRLaKfK>; Mon, 31 Dec 2001 05:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287483AbRLaKfA>; Mon, 31 Dec 2001 05:35:00 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:27401 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S287481AbRLaKeq>;
	Mon, 31 Dec 2001 05:34:46 -0500
Date: Mon, 31 Dec 2001 11:32:39 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Phil Oester <kernel@theoesters.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 still croaks under heavy load
Message-ID: <20011231103239.GA18933@paradigm.rfc822.org>
In-Reply-To: <001101c18f6e$38b40160$6400a8c0@philxp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <001101c18f6e$38b40160$6400a8c0@philxp>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Thu, Dec 27, 2001 at 11:06:50PM -0800, Phil Oester wrote:
> Have a webserver running Zope (specifically the ZEO db) which dies every
> few days with no messages in syslog.  Locks up so tight a powercycle is
> required to recover.  System has 1gb RAM, 2xSMP, kernel configured with
> 4gb highmem. =20
>=20
> Since the kernel doesn't provide any info in syslog when it dies, I just
> ran a vmstat 30 to a file and waited for the next untimely demise.
> Here's what happened when it died last time.  Note the sudden surge in
> disk activity (bi)=20

I am seeing the same kind of deaths on multiple very different SMP boxes
since 2.2 days. They do not die in the "high load" case but only the
high load boxes are unstable. I am having on "testcase" where the box
crashes at least every 24 hours (mutella). Boxes i have seen this
happening on are

Box1:
Dual Celeron 400
IDE Raid=20
SCSI System disk
1GB Ram (No Highmem) (Used to have 512M)
EEPro 100

Box2:
Dual PIII 1Ghz
Serverworks Board
1GB Ram (No Highmem)
ICP Vortex Raid
EEPro 100

I have 3 machines of the exakt same type of the latter type. All are
unstable and tend to crash depending on application every 24 hours to
every 2-3 Weeks.

No notice in the syslog, nothing on the serial console. There are
completly dead without any sign before. I have tried to capture
informations about processes, swap, memory etc - Within 1 minute
prior to crash the boxes are basically idle.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8MD7HUaz2rXW+gJcRAr7qAJ4og2Sw7XxgfJIItt6Q1Qk8fRJL8wCgvTGi
12yShgNgYeau2NfutfKo+vs=
=GG1N
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
