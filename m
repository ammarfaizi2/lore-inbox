Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269193AbUJWEbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269193AbUJWEbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUJWEbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:31:11 -0400
Received: from [211.58.254.17] ([211.58.254.17]:14993 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S269200AbUJWE3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:29:34 -0400
Date: Sat, 23 Oct 2004 13:29:30 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (9/16)
Message-ID: <20041023042930.GJ3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_09_module_param_empty_prefix.diff

 This is the 9th patch of 16 patches for devparam.

 MODULE_PARAM_PREFIX is changed to be "" instead of being empty for
kernel proper.  The end result is the same for moduleparam, but it
helps devparam macros.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
@@ -8,7 +8,7 @@
 /* You can override this manually, but generally this should match the
    module name. */
 #ifdef MODULE
-#define MODULE_PARAM_PREFIX /* empty */
+#define MODULE_PARAM_PREFIX ""
 #else
 #define MODULE_PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
 #endif
