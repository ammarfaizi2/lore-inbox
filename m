Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTFCVrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTFCVrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 17:47:10 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:43137 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S261279AbTFCVrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 17:47:09 -0400
Date: Tue, 3 Jun 2003 15:00:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove extra #includes
Message-ID: <20030603220034.GB803@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes two extra #includes of <linux/spinlock.h>.
Nothing in either of these files require <linux/spinlock.h>.


===== arch/i386/kernel/i387.c 1.16 vs edited =====
--- 1.16/arch/i386/kernel/i387.c	Tue Apr  8 22:45:37 2003
+++ edited/arch/i386/kernel/i387.c	Tue Jun  3 13:10:08 2003
@@ -10,7 +10,6 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
-#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
===== include/asm-i386/i387.h 1.12 vs edited =====
--- 1.12/include/asm-i386/i387.h	Fri May  9 14:22:55 2003
+++ edited/include/asm-i386/i387.h	Tue Jun  3 13:23:18 2003
@@ -12,7 +12,6 @@
 #define __ASM_I386_I387_H
 
 #include <linux/sched.h>
-#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
 #include <asm/user.h>

-- 
Tom Rini
http://gate.crashing.org/~trini/
