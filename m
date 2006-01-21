Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWAUToS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWAUToS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWAUToS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:44:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57353 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932294AbWAUToR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:44:17 -0500
Date: Sat, 21 Jan 2006 20:44:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: sju@lsil.com, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: drivers/scsi/megaraid.c: add a dummy mega_create_proc_entry() for PROC_FS=y
Message-ID: <20060121194416.GV31803@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a dummy mega_create_proc_entry() for CONFIG_PROC_FS=n.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jan 2006

--- linux-2.6.15-mm2-full/drivers/scsi/megaraid.c.old	2006-01-08 11:31:28.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/scsi/megaraid.c	2006-01-08 11:33:43.000000000 +0100
@@ -3179,6 +3179,10 @@
 
 	return len;
 }
+#else  /*  CONFIG_PROC_FS  */
+
+static inline void
+mega_create_proc_entry(int index, struct proc_dir_entry *parent) {}
 
 #endif
 

