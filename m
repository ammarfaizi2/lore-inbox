Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266070AbUBJRuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUBJR3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:29:33 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:48770 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266028AbUBJR2h (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:28:37 -0500
Message-Id: <200402101728.i1AHS354008665@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Daniel Jacobowitz <dan@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Chua <jchua@fedex.com>, jeffchua@silk.corp.fedex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warning: `__attribute_used__' redefined 
In-Reply-To: Your message of "Tue, 10 Feb 2004 12:10:55 EST."
             <20040210171055.GA32612@nevyn.them.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com> <20040209225336.1f9bc8a8.akpm@osdl.org> <Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com> <20040210082514.04afde4a.akpm@osdl.org> <Pine.LNX.4.58.0402100827100.2128@home.osdl.org>
            <20040210171055.GA32612@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1102005358P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Feb 2004 12:28:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1102005358P
Content-Type: text/plain; charset=us-ascii

On Tue, 10 Feb 2004 12:10:55 EST, Daniel Jacobowitz said:

> This is what Debian has been using.  I believe the other folks with a
> glibc-kernel-headers package based on 2.6 do something similar.  I
> don't know how you'll feel about adding this sort of crap to the

I found this in the Fedora linux-2.6.0-compile.patch included in their
kernel-2.6.1-1.65.src.rpm.  A bit more hard-line. :)

Anybody want to push it for the Linus or -mm trees? ;)

--- linux-2.6.0-test11/include/linux/config.h~  2003-12-11 09:29:14.090625985 +0100
+++ linux-2.6.0-test11/include/linux/config.h   2003-12-11 09:29:14.090625985 +0100
@@ -2,5 +2,7 @@
 #define _LINUX_CONFIG_H
 
 #include <linux/autoconf.h>
-
+#ifndef __KERNEL__
+#error including kernel header in userspace; use the glibc headers instead!
+#endif
 #endif


--==_Exmh_-1102005358P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAKRSjcC3lWbTT17ARAo8ZAKDI1AarM5viEFKTEOEbPWyxPREdAgCgs9tn
edPXH7HVzYNer8m71lw/Up4=
=izfA
-----END PGP SIGNATURE-----

--==_Exmh_-1102005358P--
