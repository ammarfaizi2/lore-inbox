Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266491AbSLWPEv>; Mon, 23 Dec 2002 10:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbSLWPEv>; Mon, 23 Dec 2002 10:04:51 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:37033
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S266491AbSLWPEu>; Mon, 23 Dec 2002 10:04:50 -0500
Subject: [PATCH]: Re: NMI: IOCK error (debug interrupt?) - nope
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1040293420.12106.13.camel@lemsip>
References: <1040293420.12106.13.camel@lemsip>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+mR9kVEwj6TgbGhf3Q1L"
Organization: 
Message-Id: <1040656341.23373.18.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 23 Dec 2002 15:12:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+mR9kVEwj6TgbGhf3Q1L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-12-19 at 10:23, Gianni Tedesco wrote:
> Hello,
>=20
> A firewall of ours recently went tits up (2.4.19). It was still routing
> traffic but when I connected to SSH for example the SSH banner would not
> appear, it looked like all userspace was dead.
>=20
> When we looked in the logs there was this. Presumably the hardware is
> broken. But I wonder if anyone can confirm this? Thanks!
>=20
> NMI: IOCK error (debug interrupt?)

Turns out to be a 2bit ECC error. The machine is a dell power-edge 350.

--- linux-2.4.19.orig/arch/i386/kernel/traps.c	Mon Dec 23 13:28:32 2002
+++ linux-2.4.19/arch/i386/kernel/traps.c	Mon Dec 23 15:11:24 2002
@@ -613,7 +613,7 @@
 {
 	unsigned long i;
=20
-	printk("NMI: IOCK error (debug interrupt?)\n");
+	printk("NMI: IOCK error (debug interrupt / ECC RAM error?)\n");
 	show_registers(regs);
=20
 	/* Re-enable the IOCK line, wait for a few seconds */


--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-+mR9kVEwj6TgbGhf3Q1L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+ByfVkbV2aYZGvn0RAr8ZAJ4zYZYCd+JtxCruUWgjpRf6uiz4XgCfSOAi
AzrdKsaP4vlddbj1brZQGQs=
=NV64
-----END PGP SIGNATURE-----

--=-+mR9kVEwj6TgbGhf3Q1L--

