Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTEGKNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbTEGKNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:13:14 -0400
Received: from cs-ats40.donpac.ru ([217.107.128.161]:30218 "EHLO pazke")
	by vger.kernel.org with ESMTP id S262963AbTEGKNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:13:13 -0400
Date: Wed, 7 May 2003 14:25:45 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: fix penguin with sgi logo
Message-ID: <20030507102545.GC2152@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
X-Uname: Linux 2.5.68 i686 unknown
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

attached patch fixes penguin with sgi framebuffer logo for 
visws subarch. It was broken in 2.5.68 IIRC.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sgi-logo

diff -urN -X /usr/share/dontdiff linux-2.5.68.vanilla/drivers/video/logo/logo.c linux-2.5.68/drivers/video/logo/logo.c
--- linux-2.5.68.vanilla/drivers/video/logo/logo.c	Mon Apr 28 22:25:39 2003
+++ linux-2.5.68/drivers/video/logo/logo.c	Mon Apr 28 22:34:57 2003
@@ -79,8 +79,10 @@
 		logo = &logo_parisc_clut224;
 #endif
 #ifdef CONFIG_LOGO_SGI_CLUT224
-		/* SGI Linux logo on MIPS/MIPS64 */
+		/* SGI Linux logo on MIPS/MIPS64 and VISWS */
+#ifndef CONFIG_X86_VISWS
 		if (mips_machgroup == MACH_GROUP_SGI)
+#endif
 			logo = &logo_sgi_clut224;
 #endif
 #ifdef CONFIG_LOGO_SUN_CLUT224

--6c2NcOVqGQ03X4Wi--
