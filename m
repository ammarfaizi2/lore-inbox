Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269133AbUIRG5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbUIRG5i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 02:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269134AbUIRG5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 02:57:38 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:48314 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269133AbUIRG5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 02:57:35 -0400
Date: Fri, 17 Sep 2004 23:57:33 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] scripts: Support output of new ld
Message-ID: <20040918065733.GA4549@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040818i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

This is one in a handful of small patches that I'll be sending along in
the near future. This patch allows scripts/ver_linux to find out the ld
version for versions of ld that have different output on 'ld -v' (new
ones have "GNU" at the beginning.)

Marcelo, please apply.=20

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--=20
Joshua Kwan

--- a/scripts/ver_linux	2004-09-05 01:31:23.000000000 -0700
+++ b/scripts/ver_linux	2004-09-05 01:31:47.000000000 -0700
@@ -22,7 +22,8 @@
       '/GNU Make/{print "Gnu make              ",$NF}'
=20
 ld -v 2>&1 | awk -F\) '{print $1}' | awk \
-      '/BFD/{print "binutils              ",$NF}'
+      '/BFD/{print "binutils              ",$NF}
+       /^GNU/{print "binutils              ",$4}'
=20
 fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
=20

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUvcXaOILr94RG8mAQK8kQ//WkoVdsjDnNPi5VCO/eZu5Cm6fpFdOoa7
f1XzsdctjWqjKvlMdCHTEM55wCn4tul2ILnTQHeB0uj5gfvmnMsttbMHegojy3V/
H36hSuav9faI57XXks0IE0JRxQwEIE5pQgnNy8hLLpsVZ3pWm53tJhu1s4Zhvziz
16x2QkmWEUBo7zxDWWC66T2g2VUE5yR7zQHSq13aX5NEZ9Ee90rswRZtbfXsNjO3
Nh+lDGWetdUn7jcieBFXO2fuL6OuR3ATzBhKzyOQ9eo0TKMKpNYusEbJbPwdOZDR
BcBt5umTzLFLCxgFOjZyRlc36/rNhpm20rdnGoqQzkBGlHzqw2Pa85F+hyn9+Dq/
Vq9rVyGFg8gttJM6vfaVmaINpELNS3atV6u22mUYwlECtp9biU4GdPj1Kquz/+yt
/VksvVQI3MHroyNOj7zUQ7UyARrw33uyh7bFsALJdL650lad+PuZD1gkn9Uv0QGD
Vy0dry2ESwyOreumoP6oTqcIQdHf/80XMP4UIla9kgetINVORbMJN9F+QBEM2QJf
dmbcyBDTdXyGEFjxhDcscUC4Rwdi/e3zmzuv+f3EDDrD+5IG8KgPaaog/32EkrNk
4OAZK5LlXz6QDzYVN0ml3FlwZPng5n+aJZx04T/ApAbAdrEmf3ch6xOLhd3IAJTD
z4l/KUH1oWc=
=1Tce
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
