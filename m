Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbUKEEDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbUKEEDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUKEEDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:03:49 -0500
Received: from [12.177.129.25] ([12.177.129.25]:56515 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262588AbUKEEDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:03:46 -0500
Message-Id: <200411050615.iA56FjDZ007890@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, blaisorblade_spam@yahoo.it
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - update atomic.h so UML builds cleanly
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Nov 2004 01:15:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comment should be self-explanatory.  This works around a pile of 
nasty-looking build output.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9/include/asm-um/atomic.h
===================================================================
--- linux-2.6.9.orig/include/asm-um/atomic.h	2004-06-16 01:19:29.000000000 -0400
+++ linux-2.6.9/include/asm-um/atomic.h	2004-11-02 18:36:48.000000000 -0500
@@ -1,6 +1,11 @@
 #ifndef __UM_ATOMIC_H
 #define __UM_ATOMIC_H
 
+/* The i386 atomic.h calls printk, but doesn't include kernel.h, so we
+ * include it here.
+ */
+#include "linux/kernel.h"
+
 #include "asm/arch/atomic.h"
 
 #endif

