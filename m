Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTDDJyi (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 04:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbTDDJyi (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 04:54:38 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:18436 "EHLO pazke")
	by vger.kernel.org with ESMTP id S263482AbTDDJyR (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 04:54:17 -0500
Date: Fri, 4 Apr 2003 14:05:43 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>, jsimmons@infradead.org
Subject: [PATCH] allow penguin with SGI logo for visws
Message-ID: <20030404100543.GC964@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>, jsimmons@infradead.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Visual Workstations 320/540 are SGI products, so IMHO they
can use penguin with SGI logo as mips does :))

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-logo

diff -urN -X /usr/share/dontdiff linux-2.5.66.vanilla/drivers/video/logo/Kconfig linux-2.5.66/drivers/video/logo/Kconfig
--- linux-2.5.66.vanilla/drivers/video/logo/Kconfig	Mon Mar 31 13:40:58 2003
+++ linux-2.5.66/drivers/video/logo/Kconfig	Mon Mar 31 13:59:23 2003
@@ -40,7 +40,7 @@
 
 config LOGO_SGI_CLUT224
 	bool "224-color SGI Linux logo"
-	depends on LOGO && (SGI_IP22 || SGI_IP27 || SGI_IP32)
+	depends on LOGO && (SGI_IP22 || SGI_IP27 || SGI_IP32 || X86_VISWS)
 	default y
 
 config LOGO_SUN_CLUT224
diff -urN -X /usr/share/dontdiff linux-2.5.66.vanilla/drivers/video/logo/logo.c linux-2.5.66/drivers/video/logo/logo.c
--- linux-2.5.66.vanilla/drivers/video/logo/logo.c	Mon Mar 31 13:40:58 2003
+++ linux-2.5.66/drivers/video/logo/logo.c	Mon Mar 31 14:52:54 2003
@@ -80,8 +81,10 @@
 			logo = &logo_parisc_clut224;
 #endif
 #ifdef CONFIG_LOGO_SGI_CLUT224
-			/* SGI Linux logo on MIPS/MIPS64 */
+			/* SGI Linux logo on MIPS/MIPS64 ans VisWs 320/540 */
+#ifndef CONFIG_X86_VISWS
 			if (mips_machgroup == MACH_GROUP_SGI)
+#endif
 				logo = &logo_sgi_clut224;
 #endif
 #ifdef CONFIG_LOGO_SUN_CLUT224

--L6iaP+gRLNZHKoI4--
