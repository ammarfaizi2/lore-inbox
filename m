Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTFBMYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTFBMYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:24:54 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56326 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262259AbTFBMYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:24:52 -0400
Date: Mon, 2 Jun 2003 22:34:38 +1000
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Include missing headers
Message-ID: <20030602123438.GA13415@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds two missing headers:

linux/timer.h: include linux/stddef.h for NULL
linux/in.h: include linux/socket.h for sa_family_t
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: include/linux/timer.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/include/linux/timer.h,v
retrieving revision 1.1.1.7
diff -u -r1.1.1.7 timer.h
--- include/linux/timer.h	5 Nov 2001 20:42:13 -0000	1.1.1.7
+++ include/linux/timer.h	2 Jun 2003 12:31:23 -0000
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/list.h>
+#include <linux/stddef.h>
 
 /*
  * In Linux 2.4, static timers have been removed from the kernel.
Index: include/linux/in.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/include/linux/in.h,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 in.h
--- include/linux/in.h	1 Jun 2003 07:27:00 -0000	1.1.1.3
+++ include/linux/in.h	2 Jun 2003 12:32:37 -0000
@@ -18,6 +18,7 @@
 #ifndef _LINUX_IN_H
 #define _LINUX_IN_H
 
+#include <linux/socket.h>
 #include <linux/types.h>
 
 /* Standard well-defined IP protocols.  */

--dDRMvlgZJXvWKvBx--
