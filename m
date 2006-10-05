Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWJEHaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWJEHaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWJEHaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:30:20 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:35291 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750700AbWJEHaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:30:19 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.6.19-rc1: PATA long delay with AMD driver on init
Date: Thu, 5 Oct 2006 09:30:06 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3695816.rU4yFfBUmT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610050930.10231.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3695816.rU4yFfBUmT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I tried the PATA driver for my onboard IDE with one DVD+RW drive connected =
as=20
master. The driver hangs a long time on probing (and causing major havoc on=
=20
the rest of my devices). Using the old IDE driver I don't have this problem.

I deactivated one SATA and secondary IDE controller. Enabled the situation=
=20
gets worse.


The kernel is patched with reiser4 and acpi_skip_timer_override quirk is=20
deactivated (see last link why).

I tried different combinations (dmesg + .config). Differences are mostly pc=
i=20
mt init, irqpoll, nforce eth napi, pata/ide amd driver

http://www.prakash.gmxhome.de/linux/2.6.19-rc1-1.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-2.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-3.txt.bz2
http://www.prakash.gmxhome.de/linux/2.6.19-rc1-4.txt.bz2

cat /proc/interrupts for 2.6.18 resp .19-rc1
http://www.prakash.gmxhome.de/linux/irqs18.txt
http://www.prakash.gmxhome.de/linux/irqs19.txt

lspci can be found here:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D115545986619977&w=3D2

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart3695816.rU4yFfBUmT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJLSCxU2n/+9+t5gRAtebAKDrVWmF2wmOmVgqWy48dX/jjS1BaACgmgOI
fLHE7UpJmzb0TL6toJNmdzo=
=GrgL
-----END PGP SIGNATURE-----

--nextPart3695816.rU4yFfBUmT--
