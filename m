Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTFQAae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTFQAae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:30:34 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:24844 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264477AbTFQAa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:30:27 -0400
Date: Mon, 16 Jun 2003 19:44:15 -0500
From: Art Haas <ahaas@airmail.net>
To: Russell King <rmk@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for asm-arm/include/xor.h
Message-ID: <20030617004415.GB21500@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

These patches convert the xor.h files to use C99 initializers. The
patches are against the current BK. Both patches are untested as I don't
have the hardware.

Art Haas

===== include/asm-arm/xor.h 1.4 vs edited =====
--- 1.4/include/asm-arm/xor.h	Tue Feb  5 01:41:12 2002
+++ edited/include/asm-arm/xor.h	Mon Jun 16 18:19:17 2003
@@ -125,11 +125,11 @@
 }
 
 static struct xor_block_template xor_block_arm4regs = {
-	name:	"arm4regs",
-	do_2:	xor_arm4regs_2,
-	do_3:	xor_arm4regs_3,
-	do_4:	xor_arm4regs_4,
-	do_5:	xor_arm4regs_5,
+	.name	= "arm4regs",
+	.do_2	= xor_arm4regs_2,
+	.do_3	= xor_arm4regs_3,
+	.do_4	= xor_arm4regs_4,
+	.do_5	= xor_arm4regs_5,
 };
 
 #undef XOR_TRY_TEMPLATES
===== include/asm-arm26/xor.h 1.1 vs edited =====
--- 1.1/include/asm-arm26/xor.h	Wed Jun  4 06:14:11 2003
+++ edited/include/asm-arm26/xor.h	Mon Jun 16 18:19:50 2003
@@ -125,11 +125,11 @@
 }
 
 static struct xor_block_template xor_block_arm4regs = {
-	name:	"arm4regs",
-	do_2:	xor_arm4regs_2,
-	do_3:	xor_arm4regs_3,
-	do_4:	xor_arm4regs_4,
-	do_5:	xor_arm4regs_5,
+	.name	= "arm4regs",
+	.do_2	= xor_arm4regs_2,
+	.do_3	= xor_arm4regs_3,
+	.do_4	= xor_arm4regs_4,
+	.do_5	= xor_arm4regs_5,
 };
 
 #undef XOR_TRY_TEMPLATES
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
