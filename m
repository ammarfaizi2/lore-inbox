Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUKNBUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUKNBUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 20:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbUKNBUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 20:20:19 -0500
Received: from hera.cwi.nl ([192.16.191.8]:53979 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261224AbUKNBUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 20:20:14 -0500
Date: Sun, 14 Nov 2004 02:20:08 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __init in scsi/scsi_devinfo.c
Message-ID: <20041114012005.GA22032@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
--- a/drivers/scsi/scsi_devinfo.c	2004-08-26 22:05:29.000000000 +0200
+++ b/drivers/scsi/scsi_devinfo.c	2004-11-13 22:40:51.000000000 +0100
@@ -510,7 +510,7 @@ void scsi_exit_devinfo(void)
  * 	Add command line @dev_list entries, then add
  * 	scsi_static_device_list entries to the scsi device info list.
  **/
-int scsi_init_devinfo(void)
+int __init scsi_init_devinfo(void)
 {
 #ifdef CONFIG_SCSI_PROC_FS
 	struct proc_dir_entry *p;
diff -uprN -X /linux/dontdiff a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
--- a/drivers/scsi/scsi_priv.h	2004-08-26 22:05:29.000000000 +0200
+++ b/drivers/scsi/scsi_priv.h	2004-11-13 22:40:51.000000000 +0100
@@ -96,7 +96,7 @@ static inline void scsi_log_completion(s
 /* scsi_devinfo.c */
 extern int scsi_get_device_flags(struct scsi_device *sdev,
 				 unsigned char *vendor, unsigned char *model);
-extern int scsi_init_devinfo(void);
+extern int __init scsi_init_devinfo(void);
 extern void scsi_exit_devinfo(void);
 
 /* scsi_error.c */
