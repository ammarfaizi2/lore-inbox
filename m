Return-Path: <linux-kernel-owner+willy=40w.ods.org-S378709AbUKAWqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S378709AbUKAWqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S378441AbUKAWp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:45:27 -0500
Received: from peabody.ximian.com ([130.57.169.10]:34462 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266063AbUKAU4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:56:12 -0500
Subject: [patch] inotify: change default number of queued events
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1099330316.12182.2.camel@vertex>
References: <1099330316.12182.2.camel@vertex>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 15:53:52 -0500
Message-Id: <1099342432.31022.54.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hola, John.

The default of 16384 maximum queued events is way too high.  That is a
lot of physical memory that the user can pin.

Attached patch takes it to 512.

	Robert Love


change the default number of queued events down from 16384 to 512

Signed-Off-By: Robert Love <rml@novell.com>

 drivers/char/inotify.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.6.10-rc1-inotify/drivers/char/inotify.c linux/drivers/char/inotify.c
--- linux-2.6.10-rc1-inotify/drivers/char/inotify.c	2004-11-01 15:50:36.163496688 -0500
+++ linux/drivers/char/inotify.c	2004-11-01 15:48:15.380898896 -0500
@@ -921,7 +921,7 @@
 	if (ret)
 		return ret;
 
-	sysfs_attrib_max_queued_events = 16384;
+	sysfs_attrib_max_queued_events = 512;
 
 	for (i = 0;inotify_device_attrs[i];i++)
 		device_create_file(inotify_device.dev, inotify_device_attrs[i]);


