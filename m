Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752628AbWAHOOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbWAHOOg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 09:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbWAHOOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 09:14:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26379 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752629AbWAHOOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 09:14:35 -0500
Date: Sun, 8 Jan 2006 15:14:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sju@lsil.com
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: drivers/scsi/megaraid.c: add a dummy mega_create_proc_entry() for PROC_FS=y
Message-ID: <20060108141434.GK3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a dummy mega_create_proc_entry() for CONFIG_PROC_FS=n.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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
 

