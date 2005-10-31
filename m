Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVKAOSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKAOSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKAOSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:18:23 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:31242 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750809AbVKAOSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:18:22 -0500
Date: Mon, 31 Oct 2005 23:10:03 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Patrizio Bassi <patrizio.bassi@gmail.com>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
Message-ID: <20051031221003.GA26784@irc.pl>
References: <436638A8.3000604@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <436638A8.3000604@gmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2005 at 04:30:48PM +0100, Patrizio Bassi wrote:
> when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
> file)
> i hear noises, related to disk activity. more hd is used, more chicks
> and ZZZZ noises happen.
>=20
> linux 2.4.x and windows has no problems, perfect.

 I remeber similar problems with es1370 and OSS/ALSA driver. OSS were
fine, ALSA produced noise.
 It turned to be PCI latency timer issues. OSS driver changed it's value
to working good values. ALSA didn't touch latency timer, and during hard
disk activity sound stuttered.
 Got rid of problem by running setpci -d CARD:ID latency_timer=3D40
--=20
Tomasz Torcz                                                       72->|   =
80->|
zdzichu@irc.-nie.spam-.pl                                          72->|   =
80->|


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDZpY7ThhlKowQALQRAsNCAKC2rFbJZAj/SyB2LK06eooDagilGQCdH9ye
Sa9wSfwGSP963D17ahd2Yho=
=EFMJ
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
