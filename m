Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbULGPCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbULGPCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbULGPBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:01:51 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:47853 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261827AbULGPA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:00:29 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Dec 2004 15:37:39 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uml devel <user-mode-linux-devel@lists.sourceforge.net>,
       Jeff Dike <jdike@addtoit.com>,
       Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [patch] uml: raise tty limit
Message-ID: <20041207143739.GA23627@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$subject says all ;)

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/drivers/stdio_console.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: uml-2.6.9-rc2/arch/um/drivers/stdio_console.c
===================================================================
--- uml-2.6.9-rc2.orig/arch/um/drivers/stdio_console.c	2004-09-16 16:34:54.467184040 +0200
+++ uml-2.6.9-rc2/arch/um/drivers/stdio_console.c	2004-09-16 16:58:26.640111896 +0200
@@ -30,7 +30,7 @@
 #include "init.h"
 #include "2_5compat.h"
 
-#define MAX_TTYS (8)
+#define MAX_TTYS (16)
 
 /* Referenced only by tty_driver below - presumably it's locked correctly
  * by the tty driver.

-- 
#define printk(args...) fprintf(stderr, ## args)
