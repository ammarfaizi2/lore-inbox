Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVCRLRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVCRLRP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 06:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVCRLRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 06:17:15 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:49640 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261575AbVCRLRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 06:17:07 -0500
Date: Fri, 18 Mar 2005 12:16:58 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docbook: fix escaping of kernel-doc
Message-ID: <20050318111658.GM8617@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <200503112034.j2BKYMli008385@shell0.pdx.osdl.net> <20050314081319.GD8617@admingilde.org> <20050314004712.4746f2cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kZxC0s2ORSstvtHP"
Content-Disposition: inline
In-Reply-To: <20050314004712.4746f2cf.akpm@osdl.org>
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
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kZxC0s2ORSstvtHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

the following patch fixes a bug I introduced with the last patches
of the DocBook generation.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---
Please apply.

=2E.. and I really have to redo my bitkeeper repository as it
is full of merge artifacts as BK did not note the fact that
the patches were applied using normal patches.

I guess I have to use one complete tree per patch and recreate
the public repo as a combination of the individual ones.
Alternatives?

diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	2005-03-18 11:51:17 +01:00
+++ b/scripts/kernel-doc	2005-03-18 11:51:17 +01:00
@@ -1626,11 +1655,11 @@
=20
 # replace <, >, and &
 sub xml_escape($) {
-	shift;
-	s/\&/\\\\\\amp;/g;
-	s/\</\\\\\\lt;/g;
-	s/\>/\\\\\\gt;/g;
-	return $_;
+	my $text =3D shift;
+	$text =3D~ s/\&/\\\\\\amp;/g;
+	$text =3D~ s/\</\\\\\\lt;/g;
+	$text =3D~ s/\>/\\\\\\gt;/g;
+	return $text;
 }
=20
 sub process_file($) {


--=20
Martin Waitz

--kZxC0s2ORSstvtHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCOriqj/Eaxd/oD7IRAtgvAJ9XnTA+qbDynp+NGShPvoedD8EqFwCghN8t
I6+wU/3A/7IzXjUxeBaQpe4=
=2lor
-----END PGP SIGNATURE-----

--kZxC0s2ORSstvtHP--
