Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWCZGK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWCZGK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 01:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWCZGK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 01:10:58 -0500
Received: from mail.gmx.de ([213.165.64.20]:14250 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750784AbWCZGK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 01:10:57 -0500
X-Authenticated: #2308221
Date: Sun, 26 Mar 2006 08:12:20 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: snd-nm256: hard lockup on every second module load after powerup
Message-ID: <20060326061124.GA9501@hermes.uziel.local>
References: <20060326054542.GA11961@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20060326054542.GA11961@hermes.uziel.local>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Sun, Mar 26, 2006 at 07:45:42AM +0200, Christian Trefzer wrote:
> ... currently experimenting with pcidump.

First of all, that is pcitweak. Reading all the register space
sequentially 32bit word-wise revealed the following:

If word #7 (counting from 0) is 0x22a0c0c0 the driver locks up while
loading, while with 0xa2a0c0c0 it will load. I'll try and reproduce the
case where I get the lockup-prone value, and then try to write the
working value there...


Later,

Chris

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRCYwwF2m8MprmeOlAQIeuRAAtph7D7yZC9YjlKlSGGbAtp073L++J5Bu
4mh2qQueBFmg4myUH4isWmhbGsO4tp1jZYqi8dJFUs85DjzRr/E6FIolfRHBLeBT
RzL853S78ca2bTlsf16O5qJ511MOVGbHoNsEJKp3EoVFtbf17L/UhmNKTaoagTP/
Pzc02Li+mL1RafazwlzDQvOpNzUjrrU9fgGziu+W7MXYXjfPu9tYatFE2fP9ytx9
2qSUKd1g5rBWL1fbPIeV1kMgl+DhuXqXxyojcgDyauXyOJat+5oQehepyIDPbG9k
s3r2d8+Ac1mMq6E2j9GXB7h5ALswa4sz0YGsAGmyfYJz03g2GSElsTpuHCaIQPed
ut+gXNPl/+ut4T1p7wv62IZRmt66BkpgIHMbGb/CdATMpwaN045QzvGZByu9DiWo
qBcCyC4vWOExAhOLTaOlNFhZBbs99IqphFx4i2mYYdtqOMrQ/5wsMoLGlWme4o02
ucEEwDwVS6vDUoUIAGdNyMPmjEkm0RGQl8I+0yQJXFQ2e6XTj3tZqmU+hQv4/gyu
qr8l7igthb4lsPdIeYEQl0ed0/Ex15vVbljC8dgmBXLBGOza1yLn6Pb6+AH2raSk
tZ8PNcFHxhCbF8s04GMH5+DlGG+Z5xzf7NpBUH8Qz7Gj0+niwf0quLVHE4I4fHYK
8TrqbU7yECQ=
=E/LG
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

