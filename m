Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUKDHNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUKDHNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUKDHNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:13:50 -0500
Received: from [211.58.254.17] ([211.58.254.17]:36254 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262109AbUKDGtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:49:16 -0500
Date: Thu, 4 Nov 2004 15:49:14 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 8/15] driver-model: MODULE_PARAM_PREFIX is changed to empty string from nothing
Message-ID: <20041104064913.GH24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_08_module_param_empty_prefix.patch

 This is the 8th patch of 15 patches for devparam.

 MODULE_PARAM_PREFIX is changed to be "" instead of being empty for
kernel proper.  The end result is the same for moduleparam, but it
helps devparam macros.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/moduleparam.h
===================================================================
--- linux-export.orig/include/linux/moduleparam.h	2004-11-04 11:04:09.000000000 +0900
+++ linux-export/include/linux/moduleparam.h	2004-11-04 11:04:09.000000000 +0900
@@ -8,7 +8,7 @@
 /* You can override this manually, but generally this should match the
    module name. */
 #ifdef MODULE
-#define MODULE_PARAM_PREFIX /* empty */
+#define MODULE_PARAM_PREFIX ""
 #else
 #define MODULE_PARAM_PREFIX __stringify(KBUILD_MODNAME) "."
 #endif
