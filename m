Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVBOTFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVBOTFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVBOTFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:05:31 -0500
Received: from ns1.hostitnow.com ([209.152.181.224]:11754 "EHLO
	sls-ce5p311.hostitnow.com") by vger.kernel.org with ESMTP
	id S261827AbVBOTFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:05:22 -0500
Subject: Kernel Driver Automation
From: Chris White <chriswhite@gentoo.org>
Reply-To: chriswhite@gentoo.org
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uxT8Lq2Ed8WTXzFnVt2Q"
Organization: Gentoo Linux
Date: Wed, 16 Feb 2005 04:05:47 +0900
Message-Id: <1108494347.7811.9.camel@secures>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sls-ce5p311.hostitnow.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gentoo.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uxT8Lq2Ed8WTXzFnVt2Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, My question was regarding automation of the driver compile process
in the kernel.

Basically, as it is, I have seen lots of people scared half to death of
linux because of one of its most powerful features: the kernel.  Windows
users are so used to "Insert device, windows sees device, windows finds
driver, windows installs driver, reboot and pray driver works ;)".  The
kernel, however (not in all cases mind you), is full of lots of
searching around for the right driver, making sure the right SCSI/IDE
controller is selected for DMA, and getting the network setup.
Ironically, if the network card driver is not working, there's no way to
google around for information on what modules to compile in for various
drivers.

Now then.. on to the real stuff.  Basically it comes down to the
question of what the kernel does so far as to have capabilities in
interfacing with a userspace application that would analyze the hardware
and attribute the proper driver for it.  I've seen techinques such as
compiling all modules and loading until one finally works.  This is
somewhat effective.. but in the long run leaves a lot of kernel bloat.
There are also wizards out there during distro install phase that help
with the process.  Is there any other technique as far as attributing
hardware to driver?  Something like the way USB can attribute a driver
to a product by the id and vendor?

The basic idea would be to have a userspace program that would be run
before the kernel compile process and check the device identification
string (using /proc?) and match it up against the correct module.  This
would, I'm guessing, require that modules would have an array containing
the appropriate device string that it works with, enabling the userspace
application to match the two up and generate the proper configure
option.  Though another propblem I ran into is "You need this module
compiled for this module to work".  Maybe there's some sort of module
dependancy information I'm not aware of.

Let me know if any of this makes sense or if I need to redirect my ideas
to something more realistic.  Thanks ahead of time for the
responses/criticism/flames.

--=20
Chris White <chriswhite@gentoo.org>
------------------------
Sound   | Video   | PPC
ChrisWhite @ irc.freenode.net

--=-uxT8Lq2Ed8WTXzFnVt2Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: 	=?UTF-8?Q?=E3=81=93=E3=81=AE=E3=83=A1=E3=83=83=E3=82=BB=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B8=E3=81=AB=E3=81=AF=E3=83=87=E3=82=B8=E3=82=BF?=
	=?UTF-8?Q?=E3=83=AB=E7=BD=B2=E5=90=8D=E3=81=95=E3=82=8C=E3=81=9F?=
	=?UTF-8?Q?=E9=83=A8=E5=88=86=E3=81=8C=E3=81=82=E3=82=8A=E3=81=BE?=
	=?UTF-8?Q?=E3=81=99?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCEkgLFdQwWVoAgN4RArR7AJ9Uh4G1s5QmrYmEhgZ7V9qEXLPNUwCg9241
DZ5FPHdbVJekdPeFZF8ZpS8=
=7ncz
-----END PGP SIGNATURE-----

--=-uxT8Lq2Ed8WTXzFnVt2Q--

