Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTFQAdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTFQAdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:33:05 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:55564 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264479AbTFQAcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:32:32 -0400
Date: Mon, 16 Jun 2003 19:46:18 -0500
From: Art Haas <ahaas@airmail.net>
To: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for asm-ia64/include/xor.h
Message-ID: <20030617004618.GC21500@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to use C99 initializers. The patch is
against the current BK and is untested as I don't have access to the
hardware.

Art Haas

===== include/asm-ia64/xor.h 1.1 vs edited =====
--- 1.1/include/asm-ia64/xor.h	Tue Feb  5 11:39:54 2002
+++ edited/include/asm-ia64/xor.h	Mon Jun 16 18:11:19 2003
@@ -273,11 +273,11 @@
 ");
 
 static struct xor_block_template xor_block_ia64 = {
-	name: "ia64",
-	do_2: xor_ia64_2,
-	do_3: xor_ia64_3,
-	do_4: xor_ia64_4,
-	do_5: xor_ia64_5,
+	.name	= "ia64",
+	.do_2	= xor_ia64_2,
+	.do_3	= xor_ia64_3,
+	.do_4	= xor_ia64_4,
+	.do_5	= xor_ia64_5,
 };
 
 #define XOR_TRY_TEMPLATES	xor_speed(&xor_block_ia64)
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
