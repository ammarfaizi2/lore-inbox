Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUFVR5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUFVR5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbUFVRy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:54:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:51125 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265087AbUFVRnk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:40 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261093697@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:49 -0700
Message-Id: <10879261092064@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.47, 2004/06/03 11:40:44-07:00, greg@kroah.com

Driver Model: More cleanup of silly scsi use of the *ATTR macros...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/scsi/scsi_debug.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
--- a/drivers/scsi/scsi_debug.c	Tue Jun 22 09:48:55 2004
+++ b/drivers/scsi/scsi_debug.c	Tue Jun 22 09:48:55 2004
@@ -1326,7 +1326,7 @@
 	return -EINVAL;
 }
 DRIVER_ATTR(delay, S_IRUGO | S_IWUSR, sdebug_delay_show, 
-	    sdebug_delay_store)
+	    sdebug_delay_store);
 
 static ssize_t sdebug_opts_show(struct device_driver * ddp, char * buf) 
 {
@@ -1355,7 +1355,7 @@
 	return count;
 }
 DRIVER_ATTR(opts, S_IRUGO | S_IWUSR, sdebug_opts_show, 
-	    sdebug_opts_store)
+	    sdebug_opts_store);
 
 static ssize_t sdebug_num_tgts_show(struct device_driver * ddp, char * buf) 
 {
@@ -1373,13 +1373,13 @@
 	return -EINVAL;
 }
 DRIVER_ATTR(num_tgts, S_IRUGO | S_IWUSR, sdebug_num_tgts_show, 
-	    sdebug_num_tgts_store) 
+	    sdebug_num_tgts_store);
 
 static ssize_t sdebug_dev_size_mb_show(struct device_driver * ddp, char * buf) 
 {
         return scnprintf(buf, PAGE_SIZE, "%d\n", scsi_debug_dev_size_mb);
 }
-DRIVER_ATTR(dev_size_mb, S_IRUGO, sdebug_dev_size_mb_show, NULL) 
+DRIVER_ATTR(dev_size_mb, S_IRUGO, sdebug_dev_size_mb_show, NULL);
 
 static ssize_t sdebug_every_nth_show(struct device_driver * ddp, char * buf) 
 {
@@ -1398,7 +1398,7 @@
 	return -EINVAL;
 }
 DRIVER_ATTR(every_nth, S_IRUGO | S_IWUSR, sdebug_every_nth_show,
-	    sdebug_every_nth_store) 
+	    sdebug_every_nth_store);
 
 static ssize_t sdebug_max_luns_show(struct device_driver * ddp, char * buf) 
 {
@@ -1416,13 +1416,13 @@
 	return -EINVAL;
 }
 DRIVER_ATTR(max_luns, S_IRUGO | S_IWUSR, sdebug_max_luns_show, 
-	    sdebug_max_luns_store) 
+	    sdebug_max_luns_store);
 
 static ssize_t sdebug_scsi_level_show(struct device_driver * ddp, char * buf) 
 {
         return scnprintf(buf, PAGE_SIZE, "%d\n", scsi_debug_scsi_level);
 }
-DRIVER_ATTR(scsi_level, S_IRUGO, sdebug_scsi_level_show, NULL) 
+DRIVER_ATTR(scsi_level, S_IRUGO, sdebug_scsi_level_show, NULL);
 
 static ssize_t sdebug_add_host_show(struct device_driver * ddp, char * buf) 
 {
@@ -1459,7 +1459,7 @@
 	return count;
 }
 DRIVER_ATTR(add_host, S_IRUGO | S_IWUSR, sdebug_add_host_show, 
-	    sdebug_add_host_store)
+	    sdebug_add_host_store);
 
 static void do_create_driverfs_files()
 {

