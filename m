Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUBWDSG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 22:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUBWDSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 22:18:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:34992 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261777AbUBWDSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 22:18:03 -0500
Subject: [PATCH] Disable debugging verbosity in macio_asic.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077505858.5942.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 14:10:58 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch undef's DEBUG by default in macio_asic, this is now
working fairly well, and the actual output isn't really useful
anyway.

===== drivers/macintosh/macio_asic.c 1.16 vs edited =====
--- 1.16/drivers/macintosh/macio_asic.c	Fri Feb 13 10:18:00 2004
+++ edited/drivers/macintosh/macio_asic.c	Mon Feb 23 14:09:16 2004
@@ -23,7 +23,7 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 
-#define DEBUG
+#undef DEBUG
 
 #define MAX_NODE_NAME_SIZE (BUS_ID_SIZE - 12)
 


