Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTERB56 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 21:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbTERB56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 21:57:58 -0400
Received: from c16812.rivrw3.nsw.optusnet.com.au ([211.28.63.178]:59410 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261919AbTERB54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 21:57:56 -0400
Date: Sun, 18 May 2003 12:10:34 +1000
To: davem@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Added missing dependencies on CRYPTO_HMAC
Message-ID: <20030518021034.GA4667@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Trivial patch which makes INET?_{AH,ESP} depend on CRYPTO_HMAC.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: net/ipv4/Kconfig
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/net/ipv4/Kconfig,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 Kconfig
--- net/ipv4/Kconfig	4 May 2003 23:53:36 -0000	1.1.1.4
+++ net/ipv4/Kconfig	18 May 2003 02:04:06 -0000
@@ -350,6 +350,7 @@
 
 config INET_AH
 	tristate "IP: AH transformation"
+	depends on INET && CRYPTO_HMAC
 	---help---
 	  Support for IPsec AH.
 
@@ -357,6 +358,7 @@
 
 config INET_ESP
 	tristate "IP: ESP transformation"
+	depends on INET && CRYPTO_HMAC
 	---help---
 	  Support for IPsec ESP.
 
@@ -364,6 +366,7 @@
 
 config INET_IPCOMP
 	tristate "IP: IPComp transformation"
+	depends on INET
 	---help---
 	  Support for IP Paylod Compression (RFC3173), typically needed
 	  for IPsec.
Index: net/ipv6/Kconfig
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/net/ipv6/Kconfig,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 Kconfig
--- net/ipv6/Kconfig	24 Mar 2003 22:00:39 -0000	1.1.1.3
+++ net/ipv6/Kconfig	18 May 2003 02:04:26 -0000
@@ -19,7 +19,7 @@
 
 config INET6_AH
 	tristate "IPv6: AH transformation"
-	depends on IPV6
+	depends on IPV6 && CRYPTO_HMAC
 	---help---
 	  Support for IPsec AH.
 
@@ -27,7 +27,7 @@
 
 config INET6_ESP
 	tristate "IPv6: ESP transformation"
-	depends on IPV6
+	depends on IPV6 && CRYPTO_HMAC
 	---help---
 	  Support for IPsec ESP.
 

--7AUc2qLy4jB3hD7Z--
