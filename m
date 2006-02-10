Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWBJVpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWBJVpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWBJVpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:45:23 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:56016 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750882AbWBJVpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:45:23 -0500
Date: Fri, 10 Feb 2006 16:42:28 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] kbuild: add -fverbose-asm to i386 Makefile
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Der Herr Hofrat <der.herr@hofr.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200602101645_MC3-1-B818-6DA8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add -fverbose-asm to i386 Makefile rule for building .s files.
This makes the assembler output much more readable for humans.

Suggested by Der Herr Hofrat <der.herr@hofr.at>

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc2-mm1-32s.orig/scripts/Makefile.build
+++ 2.6.16-rc2-mm1-32s/scripts/Makefile.build
@@ -129,7 +129,7 @@ $(multi-objs-y:.o=.s)   : modname = $(mo
 $(multi-objs-y:.o=.lst) : modname = $(modname-multi)
 
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
+cmd_cc_s_c       = $(CC) $(c_flags) -fverbose-asm -S -o $@ $< 
 
 %.s: %.c FORCE
 	$(call if_changed_dep,cc_s_c)
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
