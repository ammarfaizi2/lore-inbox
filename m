Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUIKMQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUIKMQv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 08:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUIKMQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 08:16:51 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:30593 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S268129AbUIKMPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 08:15:52 -0400
Message-ID: <4142EC76.3090803@g-house.de>
Date: Sat, 11 Sep 2004 14:15:50 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: regit@inl.fr
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 : typo in include/linux/hardirq.h ?
References: <1094898290.4533.5.camel@porky>
In-Reply-To: <1094898290.4533.5.camel@porky>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090102000502050001080608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090102000502050001080608
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric Leblond wrote:
> Hi,
>
> On my i386 computer, at line 5 of include/linux/hardirq.h we can read :
> #ifdef CONFIG_PREEPT
> It seems it should be
> #ifdef CONFIG_PREEMPT
>
> With this change, compilation of external driver like ndiswrapper works
> again.

you can fix it by yourself or apply the attached diff (last mail was
scrambled by my MUA)

Christian.
- --
BOFH excuse #262:

Our POP server was kidnapped by a weasel.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBQux2+A7rjkF8z0wRAvGLAKC7OkQu1X7Lt7qsuQAG4Zn9Gs672gCgwKBM
4YjYQL/SpRSiHQS13GBjdc0=
=vz7P
-----END PGP SIGNATURE-----

--------------090102000502050001080608
Content-Type: text/plain;
 name="hardirq.h_typo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hardirq.h_typo.diff"

--- include/linux/hardirq.h	2004-09-11 13:32:53.000000000 +0200
+++ include/linux/hardirq.h.edited	2004-09-11 14:07:28.000000000 +0200
@@ -2,7 +2,7 @@
 #define LINUX_HARDIRQ_H
 
 #include <linux/config.h>
-#ifdef CONFIG_PREEPT
+#ifdef CONFIG_PREEMPT
 #include <linux/smp_lock.h>
 #endif
 #include <asm/hardirq.h>

--------------090102000502050001080608--
