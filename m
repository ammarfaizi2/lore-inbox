Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVJQRKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVJQRKZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVJQRKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:10:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20683 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751000AbVJQRJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:09:57 -0400
Date: Mon, 17 Oct 2005 12:09:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] swsusp: remove unneccessary includes
Message-ID: <20051017100914.GA5405@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup comments and remove unneccessary includes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1,8 +1,7 @@
 /*
- * linux/kernel/power/swsusp.c
+ * linux/kernel/power/snapshot.c
  *
- * This file is to realize architecture-independent
- * machine suspend feature using pretty near only high-level routines
+ * This file provide system snapshot/restore functionality.
  *
  * Copyright (C) 1998-2005 Pavel Machek <pavel@suse.cz>
  *
@@ -15,30 +14,16 @@
 #include <linux/mm.h>
 #include <linux/suspend.h>
 #include <linux/smp_lock.h>
-#include <linux/file.h>
-#include <linux/utsname.h>
-#include <linux/version.h>
 #include <linux/delay.h>
-#include <linux/reboot.h>
 #include <linux/bitops.h>
-#include <linux/vt_kern.h>
-#include <linux/kbd_kern.h>
-#include <linux/keyboard.h>
 #include <linux/spinlock.h>
-#include <linux/genhd.h>
 #include <linux/kernel.h>
-#include <linux/major.h>
-#include <linux/swap.h>
 #include <linux/pm.h>
 #include <linux/device.h>
-#include <linux/buffer_head.h>
-#include <linux/swapops.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/console.h>
 #include <linux/highmem.h>
-#include <linux/bio.h>
-#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -46,15 +31,9 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 
-#include <linux/random.h>
-#include <linux/crypto.h>
-#include <asm/scatterlist.h>
-
 #include "power.h"
 
 
-
-
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -1,8 +1,7 @@
 /*
  * linux/kernel/power/swsusp.c
  *
- * This file is to realize architecture-independent
- * machine suspend feature using pretty near only high-level routines
+ * This file provides code to write suspend image to swap and read it back.
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
  * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@suse.cz>
@@ -47,11 +46,7 @@
 #include <linux/utsname.h>
 #include <linux/version.h>
 #include <linux/delay.h>
-#include <linux/reboot.h>
 #include <linux/bitops.h>
-#include <linux/vt_kern.h>
-#include <linux/kbd_kern.h>
-#include <linux/keyboard.h>
 #include <linux/spinlock.h>
 #include <linux/genhd.h>
 #include <linux/kernel.h>
@@ -63,10 +58,8 @@
 #include <linux/swapops.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
-#include <linux/console.h>
 #include <linux/highmem.h>
 #include <linux/bio.h>
-#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>

-- 
Thanks, Sharp!
