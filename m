Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272610AbTHPE0c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 00:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272611AbTHPE0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 00:26:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17187 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S272610AbTHPE0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 00:26:30 -0400
Date: Sat, 16 Aug 2003 00:26:27 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH][TRIVIAL][RESEND]  Remove warning in drivers/ide/ide.c for
 non-PCI systems
To: andre@linux-ide.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3F3DB273.5080003@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_AthbaxSdFmzqT5lPUQmFwA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_AthbaxSdFmzqT5lPUQmFwA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Andre,

   the following patches remove a warning if CONFIG_BLK_DEV_IDEPCI is 
not defined.

   Included patches are for 2.4.22-rc1-ac1 and 2.6.0-test2.

Stephane Ouellette


--Boundary_(ID_AthbaxSdFmzqT5lPUQmFwA)
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

--Boundary_(ID_AthbaxSdFmzqT5lPUQmFwA)
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

--Boundary_(ID_AthbaxSdFmzqT5lPUQmFwA)--
