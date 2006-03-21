Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWCUXJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWCUXJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbWCUXJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:09:16 -0500
Received: from xenotime.net ([66.160.160.81]:12213 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751831AbWCUXJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:09:15 -0500
Date: Tue, 21 Mar 2006 15:11:24 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ranty@debian.org, akpm <akpm@osdl.org>
Subject: [PATCH] Doc: fix example firmware source code
Message-Id: <20060321151124.b68bbc45.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix Documentation/firmware_class/ examples so that they will build.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/firmware_class/firmware_sample_driver.c         |    3 +--
 Documentation/firmware_class/firmware_sample_firmware_class.c |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

--- linux-2616-work.orig/Documentation/firmware_class/firmware_sample_driver.c
+++ linux-2616-work/Documentation/firmware_class/firmware_sample_driver.c
@@ -23,7 +23,6 @@ char __init inkernel_firmware[] = "let's
 #endif
 
 static struct device ghost_device = {
-	.name      = "Ghost Device",
 	.bus_id    = "ghost0",
 };
 
@@ -92,7 +91,7 @@ static void sample_probe_async(void)
 {
 	/* Let's say that I can't sleep */
 	int error;
-	error = request_firmware_nowait (THIS_MODULE,
+	error = request_firmware_nowait (THIS_MODULE, FW_ACTION_NOHOTPLUG,
 					 "sample_driver_fw", &ghost_device,
 					 "my device pointer",
 					 sample_probe_async_cont);
--- linux-2616-work.orig/Documentation/firmware_class/firmware_sample_firmware_class.c
+++ linux-2616-work/Documentation/firmware_class/firmware_sample_firmware_class.c
@@ -172,7 +172,6 @@ static void fw_remove_class_device(struc
 static struct class_device *class_dev;
 
 static struct device my_device = {
-	.name      = "Sample Device",
 	.bus_id    = "my_dev0",
 };
 


---
