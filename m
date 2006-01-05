Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWAESSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWAESSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWAESSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:18:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48914 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751354AbWAESSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:18:31 -0500
Date: Thu, 5 Jan 2006 19:18:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Armin Schindler <armin@melware.de>, isdn4linux@listserv.isdn4linux.de,
       kkeil@suse.de, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] drivers/isdn/: add missing #include's (fwd)
Message-ID: <20060105181830.GE12313@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for 
it's global functions.

 
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Armin Schindler <armin@melware.de>

---

 drivers/isdn/capi/capifs.c           |    2 ++
 drivers/isdn/hardware/eicon/os_bri.c |    1 +
 drivers/isdn/hardware/eicon/os_pri.c |    1 +
 3 files changed, 4 insertions(+)

--- linux-2.6.15-rc1-mm2-full/drivers/isdn/capi/capifs.c.old	2005-11-19 03:41:08.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/isdn/capi/capifs.c	2005-11-19 03:41:21.000000000 +0100
@@ -17,6 +17,8 @@
 #include <linux/ctype.h>
 #include <linux/sched.h>	/* current */
 
+#include "capifs.h"
+
 MODULE_DESCRIPTION("CAPI4Linux: /dev/capi/ filesystem");
 MODULE_AUTHOR("Carsten Paeth");
 MODULE_LICENSE("GPL");
--- linux-2.6.15-rc1-mm2-full/drivers/isdn/hardware/eicon/os_bri.c.old	2005-11-19 03:47:24.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/isdn/hardware/eicon/os_bri.c	2005-11-19 03:47:38.000000000 +0100
@@ -16,6 +16,7 @@
 #include "diva_pci.h"
 #include "mi_pc.h"
 #include "pc_maint.h"
+#include "dsrv_bri.h"
 
 /*
 **  IMPORTS
--- linux-2.6.15-rc1-mm2-full/drivers/isdn/hardware/eicon/os_pri.c.old	2005-11-19 03:49:19.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/isdn/hardware/eicon/os_pri.c	2005-11-19 03:49:32.000000000 +0100
@@ -18,6 +18,7 @@
 #include "pc_maint.h"
 #include "dsp_tst.h"
 #include "diva_dma.h"
+#include "dsrv_pri.h"
 
 /* --------------------------------------------------------------------------
    OS Dependent part of XDI driver for DIVA PRI Adapter

