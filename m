Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUKVO6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUKVO6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUKVO5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:57:12 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:6793 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261463AbUKVOze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:55:34 -0500
Date: Mon, 22 Nov 2004 15:52:37 +0100
From: Martin Waitz <tali@admingilde.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Stelian Pop <stelian@popies.net>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
Message-ID: <20041122145237.GM19738@admingilde.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
	Stelian Pop <stelian@popies.net>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com
References: <20041119193350.GE2700@deep-space-9.dsnet> <20041119195736.GA8466@infradead.org> <20041119213942.GG2700@deep-space-9.dsnet> <20041119230820.GB32455@one-eyed-alien.net> <419FD192.1040604@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Content-Disposition: inline
In-Reply-To: <419FD192.1040604@osdl.org>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Nov 20, 2004 at 03:21:54PM -0800, Randy.Dunlap wrote:
> Until 'suggests' is available, does this help any?
> It's tough getting people to read Help messages though.

perhaps the following is enough?
SCSI is auto-enabled by USB_STORAGE. We should enable BLK_DEV_SD
by default in this case but we should leave the option to turn it off.


Index: drivers/scsi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/inf3/mnwaitz/src/linux-cvs/linux-2.5/drivers/scsi/Kconfig,v
retrieving revision 1.69
diff -u -p -r1.69 Kconfig
--- drivers/scsi/Kconfig	14 Nov 2004 04:33:58 -0000	1.69
+++ drivers/scsi/Kconfig	22 Nov 2004 14:48:22 -0000
@@ -38,6 +38,7 @@ comment "SCSI support type (disk, tape,=20
 config BLK_DEV_SD
 	tristate "SCSI disk support"
 	depends on SCSI
+	default m
 	---help---
 	  If you want to use SCSI hard disks, Fibre Channel disks,
 	  USB storage or the SCSI or parallel port version of


--=20
Martin Waitz

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBof0zj/Eaxd/oD7IRAmelAJwLPG3YuvZO7aoW6bVYM6LdF7qE7gCfYOFI
y1qm+CoMtipEj4i3/H6XBJk=
=yC+L
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
