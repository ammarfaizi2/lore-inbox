Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbUCJFSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUCJFSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:18:30 -0500
Received: from smtp1.cwidc.net ([154.33.63.111]:8160 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S262057AbUCJFSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:18:24 -0500
Message-ID: <404EA513.5060703@tequila.co.jp>
Date: Wed, 10 Mar 2004 14:18:11 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix occasional crash at boot in OF interface
References: <1078890877.9750.52.camel@gaston>
In-Reply-To: <1078890877.9750.52.camel@gaston>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin Herrenschmidt wrote:

is there a reason why you dropped all the comments ?

eg:

- -	REST_GPR(2, r1)			/* Restore the TOC */
- -	REST_GPR(13, r1)		/* Restore paca */
- -	REST_8GPRS(14, r1)		/* Restore the non-volatiles */
- -	REST_10GPRS(22, r1)		/* ditto */
- -
+	/* Restore other registers */
+	REST_GPR(2, r1)
+	REST_GPR(13, r1)
+	REST_8GPRS(14, r1)
+	REST_10GPRS(22, r1)

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFATqUSjBz/yQjBxz8RAqJyAJ9hRRsZleuPlZJ/LOqOtGVZDqkR/ACg7EjY
P88/EX+cR3/OkcH980/pC2M=
=TDWR
-----END PGP SIGNATURE-----
