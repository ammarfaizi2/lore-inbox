Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTDFU25 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTDFU24 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:28:56 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:55622
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263076AbTDFU2z (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 16:28:55 -0400
Date: Sun, 6 Apr 2003 16:35:48 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] Grab SET_MODULE_OWNER from the clutches of the deprecated
Message-ID: <Pine.LNX.4.50.0304061633590.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This comment seems to want to include SET_MODULE_OWNER as one of the 
deprecated facilities.

Index: linux-2.5.66/include/linux/module.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/include/linux/module.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 module.h
--- linux-2.5.66/include/linux/module.h	24 Mar 2003 23:40:13 -0000	1.1.1.1
+++ linux-2.5.66/include/linux/module.h	6 Apr 2003 20:21:51 -0000
@@ -412,9 +412,9 @@ __attribute__((section(".gnu.linkonce.th
 #endif /* MODULE */
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
+#define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-#define SET_MODULE_OWNER(dev) ((dev)->owner = THIS_MODULE)
 
 struct obsolete_modparm {
 	char name[64];

-- 
function.linuxpower.ca
