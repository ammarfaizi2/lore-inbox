Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVACO1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVACO1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVACO1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:27:55 -0500
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:59617 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261461AbVACO1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:27:40 -0500
From: Radoslaw Szkodzinski <astralstorm@gmail.com>
Reply-To: astralstorm@gmail.com
To: "prem.de.ms" <prem.de.ms@gmx.de>
Subject: Re: 2.6.10 compile error - blackbird_load_firmware
Date: Mon, 3 Jan 2005 15:27:30 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
References: <41D08611.9000004@gmx.de>
In-Reply-To: <41D08611.9000004@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3532757.hvRCf8s6b2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501031527.37315.astralstorm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3532757.hvRCf8s6b2
Content-Type: multipart/mixed;
  boundary="Boundary-01=_SZV2BYeEr/uwoZr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_SZV2BYeEr/uwoZr
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 27 of December 2004 23:00, prem.de.ms wrote:
> Hello,
>
> I get the following error message when I try to compile the new
> 2.6.10-kernel:
>
> <snip>
> Seems like the Conexant drivers are broken because the kernel compiles
> when I uncheck them.
>
It seems Conexant uses the firmware loader as well as I2C w/o requiring them.
Patch attached.

--Boundary-01=_SZV2BYeEr/uwoZr
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="conexant-deps.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="conexant-deps.patch"

=2D-- linux/drivers/media/video/Kconfig~	2005-01-03 15:24:46.669675320 +0100
+++ linux/drivers/media/video/Kconfig	2005-01-03 15:24:46.680673445 +0100
@@ -303,8 +303,9 @@
=20
 config VIDEO_CX88
 	tristate "Conexant 2388x (bt878 successor) support"
=2D	depends on VIDEO_DEV && PCI && EXPERIMENTAL
+	depends on VIDEO_DEV && PCI && I2C && EXPERIMENTAL
 	select I2C_ALGOBIT
+	select FW_LOADER
 	select VIDEO_BTCX
 	select VIDEO_BUF
 	select VIDEO_TUNER

--Boundary-01=_SZV2BYeEr/uwoZr--

--nextPart3532757.hvRCf8s6b2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBB2VZZsEwEy6zlhe0RAsZcAJsEwLNC9Wvgjhs/aZe+iJwzCLVTMgCeK6mf
hasmoJEVD6CHYNKxDR8HXG4=
=1SQF
-----END PGP SIGNATURE-----

--nextPart3532757.hvRCf8s6b2--
