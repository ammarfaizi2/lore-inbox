Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWB1Aan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWB1Aan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWB1Aan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:30:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:62848 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751838AbWB1Aam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:30:42 -0500
X-Authenticated: #2308221
Date: Tue, 28 Feb 2006 01:30:39 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata PATA patch for 2.6.16-rc5
Message-ID: <20060228003039.GA13335@zeus.uziel.local>
References: <1141054370.3089.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <1141054370.3089.0.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2006 at 03:32:50PM +0000, Alan Cox wrote:
> This is at
> 	http://zeniv.linux.org.uk/~alan/IDE
>=20

Got this working like a charm, although I had to add the promise 20269's
PCI IDs to ata_generic.c to make it tick. I only regard this as an
interim solution, but wanted to try out getting rid of IDE altogether.
So far it "feels" alright, using pata_via and ata_generic. Thanks a
bunch!


Regards,
Chris


Btw, here's the diff for convenience, in case of "interest":

--- a/drivers/scsi/ata_generic.c	2006-02-27 22:15:31.000000000 +0100
+++ b/drivers/scsi/ata_generic.c	2006-02-28 00:16:17.447430304 +0100
@@ -207,6 +207,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2),  },
+	{ PCI_DEVICE(PCI_VENDOR_ID_PROMISE,PCI_DEVICE_ID_PROMISE_20269),  },
 	/* Must come last. If you add entries adjust this table appropriately */
 	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE=
_IDE << 8, 0xFFFFFF00UL, 1},
 	{ 0, },

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iQIVAwUBRAOZr12m8MprmeOlAQJqQRAAlVFv/Q/f36X9zKaZw4W2Py+FiSeDaFjW
Uz/0BDa3CPkksgBsYI7s50z972QpvCsnRPKyjBZ/hfJC+hlTVReH2YPikVnxWiwf
GChTCvtF2bH7MmzJfpFbDOFc/iUj6tYI8SivLRpH+/OdBle3gSRLMzb2kUeTgOmX
U/7SUgG44ZnfgY9hv2zzbBKDzAxeuZ8Z2NU0PloDvcflxDrPxDz9NTmg4odXuWKr
3TkLSHVYZwRwpGRLfcZXILSik12hNVkt4CdNm7S/XIh5cBJmYv0a07Yock/+8XDl
5imXJRlVJiWfAJ3tMv8tK+xQUz2bf+G4G1mBwA91qwqFWqbfGx8vdeZ9fYLCsT0g
CppQF5FnmQOU7UO0WK9Kel0M5xOxoNc+otxsQw4BFLuFDaB3DoCG6D4lp4jn25Bx
SVzFHeLsdgfjSKTUfi9imHSpOPRQqXMnc0Hw/u3n7unY/pXUGAnM6Gwq92Z0uFYU
rhCJBR9ki0lAGbPYzCMOmaHsmR35NVsA83qES5p2MAsdWcFfZozN8N60hHC0vMj+
o+882TzX8amxHcvWynKP9n6nMrStok0Mg580b6FSG34L82Yki1ZakvxjARgp/CMR
Q0Q2hx6aRb+OjXds+TXadXFbL4simcqCvWvBVBGgbh+hWBE4kz8rSYqa/yc6jJ9n
b+8A7xs6POY=
=nvpX
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

