Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284899AbRL3Uid>; Sun, 30 Dec 2001 15:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbRL3UiX>; Sun, 30 Dec 2001 15:38:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15635 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284899AbRL3UiM>; Sun, 30 Dec 2001 15:38:12 -0500
Date: Sun, 30 Dec 2001 20:38:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fbmem.c build failure in pre4
Message-ID: <20011230203805.F9625@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fbmem.c requires VM_IO definitions to build, which are located in
linux/mm.h.

This patch adds the necessary include.

--- orig/drivers/video/fbmem.c	Sun Dec 30 20:35:49 2001
+++ linux/drivers/video/fbmem.c	Sun Dec 30 20:19:30 2001
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/tty.h>
 #include <linux/console.h>

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

