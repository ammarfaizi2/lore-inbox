Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbUKOGsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbUKOGsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKOGqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:46:05 -0500
Received: from havoc.gtf.org ([69.28.190.101]:41945 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261521AbUKOGpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:45:20 -0500
Date: Mon, 15 Nov 2004 01:45:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x misc updates (OSS drvr module_param stuff)
Message-ID: <20041115064515.GA14512@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK users:

	bk pull bk://gkernel.bkbits.net/misc-2.6

This will update the following files:

 sound/oss/i810_audio.c |   12 ++++++------
 sound/oss/soundcard.c  |    4 ++--
 sound/oss/uart401.c    |    8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/11/14 1.2162)
   [sound/oss] use module_param() in soundcard.c and uart401.c

<jgarzik@pobox.com> (04/11/14 1.2161)
   [sound/oss i810_audio] use module_param()
   
   Also, set MODULE_AUTHOR and correct module name in a macro.

diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	2004-11-14 22:53:09 -05:00
+++ b/sound/oss/i810_audio.c	2004-11-14 22:53:09 -05:00
@@ -3460,15 +3460,15 @@
 }	
 #endif /* CONFIG_PM */
 
-MODULE_AUTHOR("");
+MODULE_AUTHOR("The Linux kernel team");
 MODULE_DESCRIPTION("Intel 810 audio support");
 MODULE_LICENSE("GPL");
-MODULE_PARM(ftsodell, "i");
-MODULE_PARM(clocking, "i");
-MODULE_PARM(strict_clocking, "i");
-MODULE_PARM(spdif_locked, "i");
+module_param(ftsodell, int, 0444);
+module_param(clocking, uint, 0444);
+module_param(strict_clocking, int, 0444);
+module_param(spdif_locked, int, 0444);
 
-#define I810_MODULE_NAME "intel810_audio"
+#define I810_MODULE_NAME "i810_audio"
 
 static struct pci_driver i810_pci_driver = {
 	.name		= I810_MODULE_NAME,
diff -Nru a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c	2004-11-14 22:53:09 -05:00
+++ b/sound/oss/soundcard.c	2004-11-14 22:53:09 -05:00
@@ -535,8 +535,8 @@
 static int dmabuf;
 static int dmabug;
 
-MODULE_PARM(dmabuf, "i");
-MODULE_PARM(dmabug, "i");
+module_param(dmabuf, int, 0444);
+module_param(dmabug, int, 0444);
 
 static int __init oss_init(void)
 {
diff -Nru a/sound/oss/uart401.c b/sound/oss/uart401.c
--- a/sound/oss/uart401.c	2004-11-14 22:53:09 -05:00
+++ b/sound/oss/uart401.c	2004-11-14 22:53:09 -05:00
@@ -430,11 +430,11 @@
 
 static struct address_info cfg_mpu;
 
-static int __initdata io = -1;
-static int __initdata irq = -1;
+static int io = -1;
+static int irq = -1;
 
-MODULE_PARM(io, "i");
-MODULE_PARM(irq, "i");
+module_param(io, int, 0444);
+module_param(irq, int, 0444);
 
 
 static int __init init_uart401(void)
