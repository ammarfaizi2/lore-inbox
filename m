Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTI1KHG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTI1KGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:06:23 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:60939 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262356AbTI1KGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:06:16 -0400
Date: Sun, 28 Sep 2003 20:06:05 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ISDN] Add missing label in isdn_common.c
Message-ID: <20030928100605.GA10992@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The last change to isdn_common.c removed a label that is used when
ISDN_PPP is defined.  This patch puts it back.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=q

Index: kernel-source-2.5/drivers/isdn/i4l/isdn_common.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/isdn/i4l/isdn_common.c,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 isdn_common.c
--- kernel-source-2.5/drivers/isdn/i4l/isdn_common.c	28 Sep 2003 04:44:13 -0000	1.1.1.7
+++ kernel-source-2.5/drivers/isdn/i4l/isdn_common.c	28 Sep 2003 10:05:01 -0000
@@ -2229,8 +2229,10 @@
 	isdn_info_update();
 	return 0;
 
-/* err_tty_modem:*/
+#ifdef CONFIG_ISDN_PPP
+ err_tty_modem:
 	isdn_tty_exit();
+#endif
  err_cleanup_devfs:
 	isdn_cleanup_devfs();
 	unregister_chrdev(ISDN_MAJOR, "isdn");

--CE+1k2dSO48ffgeK--
