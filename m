Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTKEKtQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTKEKtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:49:16 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:23562 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262789AbTKEKtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:49:08 -0500
Date: Wed, 5 Nov 2003 21:48:53 +1100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [MOUSE] Alias for /dev/psaux
Message-ID: <20031105104853.GA1966@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch creates an alias for /dev/psaux so that mousedev is loaded
automatically.

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/input/mousedev.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/input/mousedev.c,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 mousedev.c
--- kernel-source-2.5/drivers/input/mousedev.c	28 Sep 2003 04:44:12 -0000	1.1.1.8
+++ kernel-source-2.5/drivers/input/mousedev.c	5 Nov 2003 10:40:30 -0000
@@ -571,3 +571,6 @@
 MODULE_PARM_DESC(xres, "Horizontal screen resolution");
 MODULE_PARM(yres, "i");
 MODULE_PARM_DESC(yres, "Vertical screen resolution");
+#ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
+MODULE_ALIAS_CHARDEV(MISC_MAJOR, PSMOUSE_MINOR);
+#endif

--UlVJffcvxoiEqYs2--
