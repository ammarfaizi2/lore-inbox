Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbULUAYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbULUAYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 19:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbULUAYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 19:24:38 -0500
Received: from waste.org ([216.27.176.166]:36803 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261709AbULUAY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 19:24:26 -0500
Date: Mon, 20 Dec 2004 16:24:16 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kai@germaschewski.name, sam@ravnborg.org
Subject: [PATCH] make depmod
Message-ID: <20041221002416.GC28322@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exposes the modules_install depmod functionality as a
convenience to external modules

Index: l/Makefile
===================================================================
--- l.orig/Makefile	2004-11-04 10:52:49.499525000 -0800
+++ l/Makefile	2004-12-20 16:19:01.195688000 -0800
@@ -867,7 +867,9 @@
 depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
 endif
 .PHONY: _modinst_post
-_modinst_post: _modinst_
+_modinst_post: _modinst_ depmod
+
+depmod:
 	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
 else # CONFIG_MODULES


-- 
Mathematics is the supreme nostalgia of our time.
