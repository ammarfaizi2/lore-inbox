Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVAPIAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVAPIAf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 03:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVAPIAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 03:00:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12303 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262451AbVAPIAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 03:00:15 -0500
Date: Sun, 16 Jan 2005 09:00:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ak@suse.de
Cc: discuss@x86-64.or, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386/x86_64 early_printk.c: make two variables static
Message-ID: <20050116080009.GB4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes two needlessly global variables static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/early_printk.c.old	2005-01-16 04:30:18.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/early_printk.c	2005-01-16 04:31:01.000000000 +0100
@@ -60,7 +60,7 @@
 
 /* Serial functions loosely based on a similar package from Klaus P. Gerlicher */ 
 
-int early_serial_base = 0x3f8;  /* ttyS0 */ 
+static int early_serial_base = 0x3f8;  /* ttyS0 */ 
 
 #define XMTRDY          0x20
 
@@ -155,7 +155,7 @@
 };
 
 /* Direct interface for emergencies */
-struct console *early_console = &early_vga_console;
+static struct console *early_console = &early_vga_console;
 static int early_console_initialized = 0;
 
 void early_printk(const char *fmt, ...)

