Return-Path: <linux-kernel-owner+w=401wt.eu-S1755202AbXAAOTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbXAAOTk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 09:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbXAAOTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 09:19:40 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:33059 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755202AbXAAOTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 09:19:39 -0500
X-Sasl-enc: YooqEIXS1Q7yWNw7O1C411XmUdj38W7P03+PU5I/ZSmV 1167661057
Message-ID: <45991971.90605@imap.cc>
Date: Mon, 01 Jan 2007 15:23:45 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Sparse 0.2 warnings from {asm,net}/checksum.h
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBC09B142662263704879AEE5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC09B142662263704879AEE5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

With sparse 0.2, my previously sparse-clean driver generates the
following warnings:

include/asm/checksum.h:182:6: warning: symbol 'sum' shadows an earlier on=
e
include/asm/checksum.h:178:28: originally declared here
include/net/checksum.h:33:6: warning: symbol 'sum' shadows an earlier one=

include/net/checksum.h:31:27: originally declared here

Architecture is i386. The lines referred to are in the functions
csum_and_copy_to_user() and csum_and_copy_from_user(), but I
don't see why sparse would emit such a warning for that code.

Any chance of getting rid of these?

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigBC09B142662263704879AEE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFmRlxMdB4Whm86/kRArkNAJ9OSmyI4gM8pUa0xpNAzn3mj4ofWACffsob
eZy7kP+VyDU8LVNK4HSWBs0=
=j0sf
-----END PGP SIGNATURE-----

--------------enigBC09B142662263704879AEE5--
