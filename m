Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWEPRoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWEPRoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWEPRoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:44:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3592 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932251AbWEPRoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:44:12 -0400
Date: Tue, 16 May 2006 19:44:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] kernel/sys.c: remove unused exports
Message-ID: <20060516174411.GH10077@stusta.de>
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

