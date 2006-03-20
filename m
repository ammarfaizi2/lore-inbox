Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030566AbWCTWMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030566AbWCTWMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWCTWBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030549AbWCTWBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:20 -0500
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/23] Mark empty release functions as broken
In-Reply-To: <11428920371527-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:37 -0800
Message-Id: <11428920373568-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Come on people, this is just wrong...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/video/epson1355fb.c |    1 +
 drivers/video/vfb.c         |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

972de6c8bfd8b36618563be454df1e95a36dc379
diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
index 3b0e713..0827594 100644
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -607,6 +607,7 @@ static void clearfb16(struct fb_info *in
 
 static void epson1355fb_platform_release(struct device *device)
 {
+	dev_err(device, "This driver is broken, please bug the authors so they will fix it.\n");
 }
 
 static int epson1355fb_remove(struct platform_device *dev)
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 53208cb..77eed1f 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -401,6 +401,7 @@ static int __init vfb_setup(char *option
 static void vfb_platform_release(struct device *device)
 {
 	// This is called when the reference count goes to zero.
+	dev_err(device, "This driver is broken, please bug the authors so they will fix it.\n");
 }
 
 static int __init vfb_probe(struct platform_device *dev)
-- 
1.2.4


