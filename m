Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbVEAVUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVEAVUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVEAVTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:19:42 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23571 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262685AbVEAVS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:29 -0400
Message-Id: <200505012112.j41LCslp016456@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/22] UML - Inclusion cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The completion cleanup got rid of some semaphores, but didn't remove the
inclusion of asm/semaphore.h from xterm_kern.c.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/xterm_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/xterm_kern.c	2005-03-12 18:59:48.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/xterm_kern.c	2005-03-12 22:30:06.000000000 -0500
@@ -7,7 +7,6 @@
 #include "linux/slab.h"
 #include "linux/signal.h"
 #include "linux/interrupt.h"
-#include "asm/semaphore.h"
 #include "asm/irq.h"
 #include "irq_user.h"
 #include "irq_kern.h"

