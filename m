Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWGGRwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWGGRwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWGGRwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:52:47 -0400
Received: from nsm.pl ([195.34.211.229]:39693 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S932237AbWGGRwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:52:47 -0400
Date: Fri, 7 Jul 2006 19:52:39 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: lost cpufreq (Re: Linux v2.6.18-rc1)
Message-ID: <20060707175239.GB7648@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2006 at 09:26:35PM -0700, Linus Torvalds wrote:
>=20
> Ok,
>  the merge window for 2.6.18 is closed, and -rc1 is out there

  ... and cpufreq-nforce2.ko fails to work. Module can't be loaded:
FATAL: Error inserting cpufreq_nforce2
(/lib/modules/2.6.18-rc1/kernel/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce=
2.ko):
Device or resource busy

  Here's relevant difference between dmesg of 2.6.17 and 2.6.18-rc1:

@@ -244,7 +240,6 @@
 lp: driver loaded but no devices found
 cpufreq: Detected nForce2 chipset revision C1
 cpufreq: FSB changing is maybe unstable and can lead to crashes and data l=
oss.
-cpufreq: FSB currently at 165 MHz, FID 10.5
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub

 Motherboard is Abit, NF7,NF7-V (nVidia-nForce2), Version: 2.X,1.0,
 (according to dmidecode).


  Also alsactl restore didn't restore PCM volume and mute state. Some
mixer elements changed name? Module is snd_intel8x0, chip is integrated
in above mentioned motherboard.

--=20
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox


--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFErp9nThhlKowQALQRAspTAJ9xo4VpYAYgWABNrYSmVYAh1eUGHQCbB+8j
jla4fTu1GkUO0Gu0ajGjnm4=
=e2yI
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
