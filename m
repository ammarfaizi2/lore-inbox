Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933018AbWFWKz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933018AbWFWKz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWFWKzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:55:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3084 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933012AbWFWKzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:55:35 -0400
Date: Fri, 23 Jun 2006 12:55:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/sys.c: remove unused exports
Message-ID: <20060623105535.GL9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the following unused exports:
- EXPORT_SYMBOL:
  - in_egroup_p
- EXPORT_SYMBOL_GPL's:
  - kernel_restart
  - kernel_halt

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 May 2006

 kernel/sys.c |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2.6.17-rc4-mm1-full/kernel/sys.c.old	2006-05-16 14:20:27.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/kernel/sys.c	2006-05-16 14:20:47.000000000 +0200
@@ -615,7 +615,6 @@
 	printk(".\n");
 	machine_restart(cmd);
 }
-EXPORT_SYMBOL_GPL(kernel_restart);
 
 /**
  *	kernel_kexec - reboot the system
@@ -657,8 +656,6 @@
 	machine_halt();
 }
 
-EXPORT_SYMBOL_GPL(kernel_halt);
-
 /**
  *	kernel_power_off - power_off the system
  *
@@ -1665,8 +1662,6 @@
 	return retval;
 }
 
-EXPORT_SYMBOL(in_egroup_p);
-
 DECLARE_RWSEM(uts_sem);
 
 EXPORT_SYMBOL(uts_sem);

