Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVDUWlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVDUWlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVDUWlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:41:10 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:53971 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261514AbVDUWlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:41:03 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: [PATCH] x86_64: i8259.c trivial iso99 structure initialization
From: Alexander Nyberg <alexn@telia.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 22 Apr 2005 00:40:56 +0200
Message-Id: <1114123256.890.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial iso99 structure initialization


Index: test/arch/x86_64/kernel/i8259.c
===================================================================
--- test.orig/arch/x86_64/kernel/i8259.c	2005-04-20 22:29:02.000000000 +0200
+++ test/arch/x86_64/kernel/i8259.c	2005-04-22 00:16:22.000000000 +0200
@@ -158,14 +158,13 @@
 }
 
 static struct hw_interrupt_type i8259A_irq_type = {
-	"XT-PIC",
-	startup_8259A_irq,
-	shutdown_8259A_irq,
-	enable_8259A_irq,
-	disable_8259A_irq,
-	mask_and_ack_8259A,
-	end_8259A_irq,
-	NULL
+	.typename = "XT-PIC",
+	.startup = startup_8259A_irq,
+	.shutdown = shutdown_8259A_irq,
+	.enable = enable_8259A_irq,
+	.disable = disable_8259A_irq,
+	.ack = mask_and_ack_8259A,
+	.end = end_8259A_irq,
 };
 
 /*


