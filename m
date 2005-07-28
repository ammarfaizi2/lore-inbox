Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVG1Qjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVG1Qjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVG1Qhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:37:33 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:47117 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261673AbVG1Qep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:34:45 -0400
Message-Id: <200507281626.j6SGQgsI009471@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/7] UML - -mm3 compile fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jul 2005 12:26:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-mm3 adds an include of asm/vm86.h in include/asm-i386/ptrace.h.  Since UML
includes the underlying arch's ptrace.h, it needs an asm/vm86.h in order
to build.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm2/include/asm-um/vm86.h
===================================================================
--- linux-2.6.12-rc3-mm2.orig/include/asm-um/vm86.h	2005-07-28 05:04:34.593890552 -0400
+++ linux-2.6.12-rc3-mm2/include/asm-um/vm86.h	2005-07-28 11:13:32.000000000 -0400
@@ -0,0 +1,6 @@
+#ifndef __UM_VM86_H
+#define __UM_VM86_H
+
+#include "asm/arch/vm86.h"
+
+#endif

