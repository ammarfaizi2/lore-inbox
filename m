Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbULXR3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbULXR3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 12:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbULXR3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 12:29:40 -0500
Received: from 8f.7b.d1c4.cidr.airmail.net ([209.196.123.143]:36360 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261418AbULXR3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 12:29:38 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 24 Dec 2004 11:29:37 -0600
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial Makefile patch
Message-ID: <20041224172937.GG19022@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The comment doesn't match the function name.

Art Haas

===== Makefile 1.550 vs edited =====
--- 1.550/Makefile	2004-12-03 14:56:59 -06:00
+++ edited/Makefile	2004-12-24 11:24:28 -06:00
 # See documentation in Documentation/kbuild/makefiles.txt
 
 # cc-option
-# Usage: cflags-y += $(call gcc-option, -march=winchip-c6, -march=i586)
+# Usage: cflags-y += $(call cc-option, -march=winchip-c6, -march=i586)
 
 cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
              > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
@@ -291,7 +291,7 @@
             $(call cc-option, $(1),$(2))
 
 # cc-option-yn
-# Usage: flag := $(call gcc-option-yn, -march=winchip-c6)
+# Usage: flag := $(call cc-option-yn, -march=winchip-c6)
 cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
                 > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
 
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
