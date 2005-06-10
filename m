Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVFJPjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVFJPjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVFJPi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:38:56 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:30982 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262583AbVFJPep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:34:45 -0400
Message-Id: <200506101529.j5AFTRhV008271@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/4] UML - Remove duplicate includes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Jun 2005 11:29:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Andrew, these four patches are 2.6.12 material ]

A few files include the same header twice.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/main.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/main.c	2005-06-08 14:33:10.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/main.c	2005-06-08 14:33:36.000000000 -0400
@@ -24,8 +24,6 @@
 #include "mode.h"
 #include "choose-mode.h"
 #include "uml-config.h"
-#include "irq_user.h"
-#include "time_user.h"
 #include "os.h"
 
 /* Set in set_stklim, which is called from main and __wrap_malloc.
Index: linux-2.6.12-rc/arch/um/kernel/process.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/process.c	2005-06-08 14:31:54.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/process.c	2005-06-08 14:33:13.000000000 -0400
@@ -30,7 +30,6 @@
 #include "init.h"
 #include "os.h"
 #include "uml-config.h"
-#include "ptrace_user.h"
 #include "choose-mode.h"
 #include "mode.h"
 #ifdef UML_CONFIG_MODE_SKAS
Index: linux-2.6.12-rc/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/um_arch.c	2005-06-08 14:31:54.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/um_arch.c	2005-06-08 14:33:13.000000000 -0400
@@ -26,7 +26,6 @@
 #include "asm/setup.h"
 #include "ubd_user.h"
 #include "asm/current.h"
-#include "asm/setup.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "kern.h"

