Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTERWJA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbTERWJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:09:00 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:27404 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S262223AbTERWI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:08:57 -0400
Date: Sun, 18 May 2003 18:21:50 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: And yet another it87 patch.
Message-ID: <20030518222150.GA24805@babylon.d2dc.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Trivial, but important.

Somehow in the patching the bk tree somehow got two memset's to clear
new_client in it87_detect, normally while this would be bad, it would
not be critical.

However one of the two happens BEFORE the variable is set, and thus
things go badly.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

>OK, fine. You're arguing semantics, though.

"arguing semantics" is not the same as "arguing nomenclature".  My DI
was very good at arguing semantics.  He had this funny idea that an
"unloaded" weapon was one that you had personally inspected and that
the semantic difference mattered.  Something about not wanting to do
the paperwork of one of us killed someone with an unloaded weapon.
Most technical debates are ultimately about semantics, but that
doesn't mean that they are unimportant.
  -- Shmuel Metz and Steve Sobol on ASR.


--- linux-2.5.69-mm6/drivers/i2c/chips/it87.c.orig	2003-05-17 03:37:19.0000=
00000 -0400
+++ linux-2.5.69-mm6/drivers/i2c/chips/it87.c	2003-05-17 03:37:28.000000000=
 -0400
@@ -630,7 +630,6 @@
 			}
 		}
 	}
-	memset (new_client, 0x00, sizeof(struct i2c_client) + sizeof(struct it87_=
data));
=20
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+yAd+RFMAi+ZaeAERAv42AJwIZNrHvaNFYz+4KX/aGJlptfH4zwCfSHX4
c/AvGaWTw4oDvEaR4rWwsyw=
=ETx9
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
