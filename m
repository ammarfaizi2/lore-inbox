Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272253AbTHIDZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 23:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272259AbTHIDZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 23:25:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8101 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S272253AbTHIDZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 23:25:23 -0400
Date: Fri, 08 Aug 2003 23:25:14 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]  Compile warning in ide.c if CONFIG_BLK_DEV_IDEPCI is not
 defined
To: linux-kernel@vger.kernel.org
Message-id: <3F34699A.9060806@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_cutj0SFsYsgiJIw6NUEX2Q)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_cutj0SFsYsgiJIw6NUEX2Q)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folks,

    the following patches fixe a compile warning complaining about an 
unused variable in ide.c if CONFIG_BLK_DEV_IDEPCI is not defined.

    These patches apply against 2.4.22-rc1-ac1 and 2.6.0-test2.

Stephane Ouellette.


--Boundary_(ID_cutj0SFsYsgiJIw6NUEX2Q)
Content-type: text/plain; name=ide.c-2.4.22-rc1-ac1.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=ide.c-2.4.22-rc1-ac1.diff

--- linux-2.4.22-rc1-ac1-orig/drivers/ide/ide.c	Fri Aug  8 22:34:38 2003
+++ linux-2.4.22-rc1-ac1-fixed/drivers/ide/ide.c	Fri Aug  8 23:10:57 2003
@@ -172,7 +172,9 @@
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
 static int initializing;	/* set while initializing built-in drivers */
 
+#ifdef CONFIG_BLK_DEV_IDEPCI
 static int ide_scan_direction;	/* THIS was formerly 2.2.x pci=reverse */
+#endif
 
 #ifdef CONFIG_IDEDMA_AUTO
 int noautodma = 0;

--Boundary_(ID_cutj0SFsYsgiJIw6NUEX2Q)
Content-type: text/plain; name=ide.c-2.6.0-test2.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=ide.c-2.6.0-test2.diff

--- linux-2.6.0-test2-orig/drivers/ide/ide.c	2003-07-27 12:59:39.000000000 -0400
+++ linux-2.6.0-test2-fixed/drivers/ide/ide.c	2003-08-08 23:19:44.000000000 -0400
@@ -180,7 +180,9 @@
 DECLARE_MUTEX(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
+#ifdef CONFIG_BLK_DEV_IDEPCI
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
+#endif
 
 #ifdef CONFIG_IDEDMA_AUTO
 int noautodma = 0;

--Boundary_(ID_cutj0SFsYsgiJIw6NUEX2Q)--
