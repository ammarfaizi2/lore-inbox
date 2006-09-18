Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWIRBio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWIRBio (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWIRBiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:38:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:8442 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965215AbWIRBiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:38:19 -0400
Message-Id: <200609180337.25347.arnd@arndb.de>
References: <20060918012740.407846000@klappe.arndb.de>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Date: Mon, 18 Sep 2006 03:37:24 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 7/8] annotate if_* header for make headers_check
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stop headers_check from warning about include/linux/if_*.h

Signed-off-by: Arnd Bermann <arnd@arndb.de>

diff --git a/include/linux/if_fc.h b/include/linux/if_fc.h
index 376a34e..6ed7f1b 100644
Index: linux-cg/include/linux/if_fc.h
===================================================================
--- linux-cg.orig/include/linux/if_fc.h	2006-09-18 03:16:11.000000000 +0200
+++ linux-cg/include/linux/if_fc.h	2006-09-18 03:16:27.000000000 +0200
@@ -20,6 +20,7 @@
 #ifndef _LINUX_IF_FC_H
 #define _LINUX_IF_FC_H
 
+/* @headercheck: -include linux/types.h @ */
 
 #define FC_ALEN	6		/* Octets in one ethernet addr	 */
 #define FC_HLEN   (sizeof(struct fch_hdr)+sizeof(struct fcllc))
Index: linux-cg/include/linux/if_fddi.h
===================================================================
--- linux-cg.orig/include/linux/if_fddi.h	2006-09-18 03:16:11.000000000 +0200
+++ linux-cg/include/linux/if_fddi.h	2006-09-18 03:16:27.000000000 +0200
@@ -24,6 +24,8 @@
 #ifndef _LINUX_IF_FDDI_H
 #define _LINUX_IF_FDDI_H
 
+/* @headercheck: -include linux/types.h @ */
+
 /*
  *  Define max and min legal sizes.  The frame sizes do not include
  *  4 byte FCS/CRC (frame check sequence).
Index: linux-cg/include/linux/if_ppp.h
===================================================================
--- linux-cg.orig/include/linux/if_ppp.h	2006-09-18 03:16:11.000000000 +0200
+++ linux-cg/include/linux/if_ppp.h	2006-09-18 03:16:27.000000000 +0200
@@ -35,6 +35,8 @@
 #ifndef _IF_PPP_H_
 #define _IF_PPP_H_
 
+/* @headercheck: -include linux/ppp_defs.h @ */
+/* @headercheck: -include linux/if.h @ */
 #include <linux/compiler.h>
 
 /*
Index: linux-cg/include/linux/if_pppox.h
===================================================================
--- linux-cg.orig/include/linux/if_pppox.h	2006-09-18 03:16:11.000000000 +0200
+++ linux-cg/include/linux/if_pppox.h	2006-09-18 03:16:27.000000000 +0200
@@ -20,6 +20,9 @@
 #include <asm/types.h>
 #include <asm/byteorder.h>
 
+/* @headercheck: -include linux/if_ether.h @ */
+/* @headercheck: -include linux/if.h @ */
+
 #ifdef  __KERNEL__
 #include <linux/if_ether.h>
 #include <linux/if.h>
Index: linux-cg/include/linux/if_shaper.h
===================================================================
--- linux-cg.orig/include/linux/if_shaper.h	2006-09-18 03:16:11.000000000 +0200
+++ linux-cg/include/linux/if_shaper.h	2006-09-18 03:16:27.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __LINUX_SHAPER_H
 #define __LINUX_SHAPER_H
 
+/* @headercheck: -include linux/types.h @ */
+
 #ifdef __KERNEL__
 
 #define SHAPER_QLEN	10
Index: linux-cg/include/linux/if_strip.h
===================================================================
--- linux-cg.orig/include/linux/if_strip.h	2006-09-18 03:16:11.000000000 +0200
+++ linux-cg/include/linux/if_strip.h	2006-09-18 03:16:27.000000000 +0200
@@ -18,6 +18,8 @@
 #ifndef __LINUX_STRIP_H
 #define __LINUX_STRIP_H
 
+/* @headercheck: -include linux/types.h @ */
+
 typedef struct {
     __u8 c[6];
 } MetricomAddress;
Index: linux-cg/include/linux/if_tunnel.h
===================================================================
--- linux-cg.orig/include/linux/if_tunnel.h	2006-09-18 03:16:11.000000000 +0200
+++ linux-cg/include/linux/if_tunnel.h	2006-09-18 03:16:27.000000000 +0200
@@ -1,6 +1,9 @@
 #ifndef _IF_TUNNEL_H_
 #define _IF_TUNNEL_H_
 
+/* @headercheck: -include linux/if.h @ */
+/* @headercheck: -include linux/ip.h @ */
+
 #define SIOCGETTUNNEL   (SIOCDEVPRIVATE + 0)
 #define SIOCADDTUNNEL   (SIOCDEVPRIVATE + 1)
 #define SIOCDELTUNNEL   (SIOCDEVPRIVATE + 2)

--

