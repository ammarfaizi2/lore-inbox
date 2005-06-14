Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFNLDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFNLDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 07:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFNLDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 07:03:13 -0400
Received: from [213.69.232.60] ([213.69.232.60]:34572 "HELO ei.schottelius.org")
	by vger.kernel.org with SMTP id S261184AbVFNLDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 07:03:05 -0400
Date: Tue, 14 Jun 2005 13:03:03 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Bart Hartgers <bart@etpmod.phys.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gzip zombie / spawned from init
Message-ID: <20050614110303.GG1467@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Bart Hartgers <bart@etpmod.phys.tue.nl>,
	linux-kernel@vger.kernel.org
References: <20050614085436.GA1467@schottelius.org> <42AEB756.2030809@etpmod.phys.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Content-Disposition: inline
In-Reply-To: <42AEB756.2030809@etpmod.phys.tue.nl>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the fast answer, Bart.

Bart Hartgers [Tue, Jun 14, 2005 at 12:54:14PM +0200]:
> Nico Schottelius wrote:
> > [zombie in your head...]
>=20
> Yes and no. If a parent exits before its child, the child is reparented=
=20
> to init. loadkeys probably doesn't wait properly for gzip to finish.

Ok, so I'll try to contact the loadkeys developer.

> >cinit forks() loadkeys and does waitpid() for it. There is no
> > loadkeys zombie, only gzip.
>=20
> Use waitpid(-1,...) or wait(...) to wait on all childeren in your init.=
=20
> gzip will become a child of cinit.

Well, wait waitpid(-1, ...) cannot be used, as there are many other
children (the system is booting up at the time the gzip process
becomes a zombie).

Still you cleared this issue for me.

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQq65ZrOTBMvCUbrlAQLQBg/8DV7Ebm5EWzpaHz/lfxaKDso9ACtW1Luh
QGbqNmATRFgCTi3QQCmu9mExdryPZjiKW0f2LfMABK8gT3NAo7VCM45xPTbn7lx+
NpZh9RvJn37qfF7DlpYSSJc1npGvlxt48O7N9WJwUOwAf2OiZB91V9Cf0HcTDIWt
Rd95WQJdEl6G4fQtmkC16h4BGE5g8VTup8xR1+dNsgdkoBxGh/eKQjFW59ze93FE
yBT7pHll4sWJhzhYM2FLTL353WVobUQKtWCt45LKXGn3yjX9Nte0uxA0wT207tG6
qmzETYtdhd2ImW29HiRPsJk6/4ivXdKNtPzYt4DvkJ9uYafumJsL8ZefhbFqrJAu
BPhSuzK3LFPqjyk+yLoiXOO6IqCI+dB9aTokTIF8+gimn7xLrDivrcdqxBQ2Xaa9
F2NQQYNwmBbBDv9ztcIaunKFWSXNfDxrsitUm7dzqibL49Jg6Ih1BFhnhTUiexoe
sAlTDwWWl0G7kbSt57QsoX0PO78ldfGwdUd1bnF/iVeLo29adwqXkZ2VONSALNW8
As+F7BSMreTfqHk1KvAW3GLM3ThhbFIsFGQ4/GjM1rWBpzztGhfprK5VJYIn+UYv
ZC4DYo+RqK64LV2n4vtFQ0myQ1uUbw8YNgZNJOZMO6LoqDkQdvSJHUaBsscaoxEm
JAiBjMOAbp4=
=RjXI
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
