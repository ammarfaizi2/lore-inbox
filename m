Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTFQAeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTFQAeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:34:50 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:24845 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264479AbTFQAeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:34:14 -0400
Date: Mon, 16 Jun 2003 19:48:00 -0500
From: Art Haas <ahaas@airmail.net>
To: sparclinux@vger.kernel.org, ultralinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for asm-sparc/include/xor.h
Message-ID: <20030617004800.GD21500@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

These two patches fix the xor.h files to use C99 initializers. The
patches are against the current BK, and both are untested as I don't
have access to the hardware.

Art Haas

===== include/asm-sparc/xor.h 1.2 vs edited =====
--- 1.2/include/asm-sparc/xor.h	Tue Feb  5 01:53:56 2002
+++ edited/include/asm-sparc/xor.h	Mon Jun 16 18:10:35 2003
@@ -250,11 +250,11 @@
 }
 
 static struct xor_block_template xor_block_SPARC = {
-	name: "SPARC",
-	do_2: sparc_2,
-	do_3: sparc_3,
-	do_4: sparc_4,
-	do_5: sparc_5,
+	.name	= "SPARC",
+	.do_2	= sparc_2,
+	.do_3	= sparc_3,
+	.do_4	= sparc_4,
+	.do_5	= sparc_5,
 };
 
 /* For grins, also test the generic routines.  */
===== include/asm-sparc64/xor.h 1.2 vs edited =====
--- 1.2/include/asm-sparc64/xor.h	Tue Feb  5 01:54:46 2002
+++ edited/include/asm-sparc64/xor.h	Mon Jun 16 18:22:58 2003
@@ -388,11 +388,11 @@
 ");
 
 static struct xor_block_template xor_block_VIS = {
-        name: "VIS",
-        do_2: xor_vis_2,
-        do_3: xor_vis_3,
-        do_4: xor_vis_4,
-        do_5: xor_vis_5,
+        .name	= "VIS",
+        .do_2	= xor_vis_2,
+        .do_3	= xor_vis_3,
+        .do_4	= xor_vis_4,
+        .do_5	= xor_vis_5,
 };
 
 #define XOR_TRY_TEMPLATES       xor_speed(&xor_block_VIS)
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
