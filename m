Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbUBZKa0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 05:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbUBZKa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 05:30:26 -0500
Received: from smtp.irisa.fr ([131.254.130.26]:39092 "EHLO smtp.irisa.fr")
	by vger.kernel.org with ESMTP id S262757AbUBZKaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 05:30:23 -0500
Message-ID: <403DCABD.8010205@irisa.fr>
Date: Thu, 26 Feb 2004 11:30:21 +0100
From: Romain Dolbeau <dolbeau@irisa.fr>
Organization: IRISA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] Smaill fix to pm3fb & MAINTAINERS
Content-Type: multipart/mixed;
 boundary="------------020102080609070205090200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102080609070205090200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The attached patch update my Permedia3 driver
to my latest version, and fix my MAINTAINERS
entry. It was created against 2.4.26-pre1.

TIA,

-- 
Romain Dolbeau

--------------020102080609070205090200
Content-Type: text/plain;
 name="patch.pm3fb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.pm3fb"

diff -ur linux-2.4.26-pre1/drivers/video/pm3fb.c linux-2.4.26-pre1-pm3/drivers/video/pm3fb.c
--- linux-2.4.26-pre1/drivers/video/pm3fb.c	2002-08-03 02:39:45.000000000 +0200
+++ linux-2.4.26-pre1-pm3/drivers/video/pm3fb.c	2004-02-26 11:19:23.000000000 +0100
@@ -19,6 +19,7 @@
  *  $Header: /cvsroot/linux/drivers/video/pm3fb.c,v 1.1 2002/02/25 19:11:06 marcelo Exp $
  *
  *  CHANGELOG:
+ *  Wed Nov 13 11:19:34 MET 2002, v 1.4.11C: option flatpanel: wasn't available in module, fixed.
  *  Mon Feb 11 10:35:48 MET 2002, v 1.4.11B: Cosmetic update.
  *  Wed Jan 23 14:16:59 MET 2002, v 1.4.11: Preliminary 2.5.x support, patch for 2.5.2.
  *  Wed Nov 28 11:08:29 MET 2001, v 1.4.10: potential bug fix for SDRAM-based board, patch for 2.4.16.
@@ -3756,6 +3757,8 @@
 MODULE_PARM_DESC(printtimings, "print the memory timings of the card(s)");
 MODULE_PARM(forcesize, PM3_MAX_BOARD_MODULE_ARRAY_SHORT);
 MODULE_PARM_DESC(forcesize, "force specified memory size");
+MODULE_PARM(flatpanel, PM3_MAX_BOARD_MODULE_ARRAY_SHORT);
+MODULE_PARM_DESC(flatpanel, "flatpanel (LCD) support (preliminary)");
 /*
 MODULE_SUPPORTED_DEVICE("Permedia3 PCI boards")
 MODULE_GENERIC_TABLE(gtype,name)
@@ -3800,6 +3803,11 @@
 			sprintf(ts, ",depth:%d:%d", i, depth[i]);
 			strncat(g_options, ts, PM3_OPTIONS_SIZE - strlen(g_options));
 		}
+                if (flatpanel[i])
+		{
+			sprintf(ts, ",flatpanel:%d:", i);
+			strncat(g_options, ts, PM3_OPTIONS_SIZE - strlen(g_options));
+		}
 	}
 	g_options[PM3_OPTIONS_SIZE - 1] = '\0';
 	DPRINTK(1, "pm3fb use options: %s\n", g_options);
diff -ur linux-2.4.26-pre1/MAINTAINERS linux-2.4.26-pre1-pm3/MAINTAINERS
--- linux-2.4.26-pre1/MAINTAINERS	2004-02-26 11:06:21.000000000 +0100
+++ linux-2.4.26-pre1-pm3/MAINTAINERS	2004-02-26 11:20:03.000000000 +0100
@@ -1456,9 +1456,9 @@
 
 PERMEDIA 3 FRAMEBUFFER DRIVER
 P:	Romain Dolbeau
-M:	dolbeau@irisa.fr
+M:	dolbeau@caps-entreprise.com
 L:	linux-fbdev-devel@lists.sourceforge.net
-W:	http://www.irisa.fr/prive/dolbeau/pm3fb/pm3fb.html
+W:	http://www.caps-entreprise.com/private/dolbeau/pm3fb/pm3fb.html
 S:	Maintained
 
 PHILIPS NINO PALM PC

--------------020102080609070205090200--
