Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVAJGDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVAJGDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVAJFps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:45:48 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:34820
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262112AbVAJFO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:58 -0500
Message-Id: <200501100736.j0A7aFPW005865@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, cw@foof.org
Subject: [PATCH 27/28] UML - define CONFIG_INPUT better
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:36:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Chris Wright - define CONFIG_INPUT to shut up a config warning.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/Kconfig
===================================================================
--- 2.6.10.orig/arch/um/Kconfig	2005-01-09 19:09:20.000000000 -0500
+++ 2.6.10/arch/um/Kconfig	2005-01-09 21:57:29.000000000 -0500
@@ -285,7 +285,10 @@
 endif
 
 config INPUT
-	bool
+	bool "Dummy option"
+	depends BROKEN
 	default n
+	help
+	This is a dummy option to get rid of warnings.
 
 source "arch/um/Kconfig.debug"

