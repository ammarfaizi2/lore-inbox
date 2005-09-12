Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVILUPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVILUPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVILUP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:15:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:26821 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932205AbVILUPY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:15:24 -0400
Cc: clucas@rotomalug.org
Subject: [PATCH] printk : Documentation/firmware_class/firmware_sample_driver.c
In-Reply-To: <11265558652786@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 12 Sep 2005 13:11:05 -0700
Message-Id: <112655586576@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] printk : Documentation/firmware_class/firmware_sample_driver.c

printk() calls should include appropriate KERN_* constant.

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 20dd026d7f5a6972dc78b4928a99620001fa547d
tree b2676a15c732f908bf85539d74fd36ee6cacf019
parent 49a1fd60d2a8e671222515cf6055e91781278517
author Christophe Lucas <clucas@rotomalug.org> Thu, 08 Sep 2005 08:55:53 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 09 Sep 2005 14:23:29 -0700

 .../firmware_class/firmware_sample_driver.c        |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware_class/firmware_sample_driver.c b/Documentation/firmware_class/firmware_sample_driver.c
--- a/Documentation/firmware_class/firmware_sample_driver.c
+++ b/Documentation/firmware_class/firmware_sample_driver.c
@@ -32,14 +32,14 @@ static void sample_firmware_load(char *f
 	u8 buf[size+1];
 	memcpy(buf, firmware, size);
 	buf[size] = '\0';
-	printk("firmware_sample_driver: firmware: %s\n", buf);
+	printk(KERN_INFO "firmware_sample_driver: firmware: %s\n", buf);
 }
 
 static void sample_probe_default(void)
 {
 	/* uses the default method to get the firmware */
         const struct firmware *fw_entry;
-	printk("firmware_sample_driver: a ghost device got inserted :)\n");
+	printk(KERN_INFO "firmware_sample_driver: a ghost device got inserted :)\n");
 
         if(request_firmware(&fw_entry, "sample_driver_fw", &ghost_device)!=0)
 	{
@@ -61,7 +61,7 @@ static void sample_probe_specific(void)
 
 	/* NOTE: This currently doesn't work */
 
-	printk("firmware_sample_driver: a ghost device got inserted :)\n");
+	printk(KERN_INFO "firmware_sample_driver: a ghost device got inserted :)\n");
 
         if(request_firmware(NULL, "sample_driver_fw", &ghost_device)!=0)
 	{
@@ -83,7 +83,7 @@ static void sample_probe_async_cont(cons
 		return;
 	}
 
-	printk("firmware_sample_driver: device pointer \"%s\"\n",
+	printk(KERN_INFO "firmware_sample_driver: device pointer \"%s\"\n",
 	       (char *)context);
 	sample_firmware_load(fw->data, fw->size);
 }

