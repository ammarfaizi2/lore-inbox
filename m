Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbTC0Wj7>; Thu, 27 Mar 2003 17:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbTC0Wj7>; Thu, 27 Mar 2003 17:39:59 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:3169 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261424AbTC0Wj5>;
	Thu, 27 Mar 2003 17:39:57 -0500
Message-ID: <3E83805B.7040002@acm.org>
Date: Thu, 27 Mar 2003 16:51:07 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Yet another IPMI fix
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig439F0876C66DB2E98C455462"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig439F0876C66DB2E98C455462
Content-Type: multipart/mixed;
 boundary="------------000208020708000201000808"

This is a multi-part message in MIME format.
--------------000208020708000201000808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,

Wouldn't you know I would find another bug right after I sent you a 
patch.  This patch fixes a problem with the state machine getting stuck 
in a certain error condition.

Please apply.

Thanks,

-Corey

--------------000208020708000201000808
Content-Type: text/plain;
 name="linix-ipmi-kcs-sm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linix-ipmi-kcs-sm.diff"

--- linux.orig/drivers/char/ipmi/ipmi_kcs_sm.c	Tue Jan 14 11:16:10 2003
+++ linux-main/drivers/char/ipmi/ipmi_kcs_sm.c	Thu Mar 27 16:46:03 2003
@@ -468,7 +468,7 @@
 		break;
 			
 	case KCS_HOSED:
-		return KCS_SM_HOSED;
+		break;
 	}
 
 	if (kcs->state == KCS_HOSED) {

--------------000208020708000201000808--

--------------enig439F0876C66DB2E98C455462
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+g4BfIXnXXONXERcRAqaXAJwM9EogGfBUr2IKA9MsuHSyo5wUXQCdHd81
brB52411AEo5GHVU0l86ZuQ=
=jRz2
-----END PGP SIGNATURE-----

--------------enig439F0876C66DB2E98C455462--

