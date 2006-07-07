Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWGGAeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWGGAeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWGGAdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:33:45 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:47043 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751109AbWGGAdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:42 -0400
Message-Id: <200607070033.k670XbdL008687@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/19] UML - Remove useless declaration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wall_to_monotonic isn't used in this file, so we can remove the declaration.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-rc-mm/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.16-rc-mm.orig/arch/um/os-Linux/time.c	2006-06-26 17:51:36.000000000 -0400
+++ linux-2.6.16-rc-mm/arch/um/os-Linux/time.c	2006-06-28 13:07:09.000000000 -0400
@@ -17,11 +17,6 @@
 #include "kern_constants.h"
 #include "os.h"
 
-/* XXX This really needs to be declared and initialized in a kernel file since
- * it's in <linux/time.h>
- */
-extern struct timespec wall_to_monotonic;
-
 static void set_interval(int timer_type)
 {
 	int usec = 1000000/hz();

