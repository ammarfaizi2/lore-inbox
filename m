Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbULUA2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbULUA2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbULUA2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:28:42 -0500
Received: from waste.org ([216.27.176.166]:63427 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261709AbULUA2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:28:19 -0500
Date: Mon, 20 Dec 2004 16:28:15 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kai@germaschewski.name, sam@ravnborg.org
Subject: [PATCH] make kernelrelease
Message-ID: <20041221002815.GD28322@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it easy to programmatically get at the kernel
makefile's idea of the kernel version from external scripts and
makefiles with something like V=`make kernelrelease`.

Alternatives include parsing Makefile (errorprone and broken by things
like localversion) and running the C preprocessor on version.h (which
requires a) building version.h somewhere and b) is really ugly).

Index: l/Makefile
===================================================================
--- l.orig/Makefile	2004-12-20 16:08:11.746716000 -0800
+++ l/Makefile	2004-12-20 16:18:25.036696000 -0800
@@ -1187,6 +1187,9 @@
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
 
+kernelrelease:
+	@echo $(KERNELRELEASE)
+
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 


-- 
Mathematics is the supreme nostalgia of our time.
