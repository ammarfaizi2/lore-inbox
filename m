Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVKSVMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVKSVMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVKSVMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:12:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:32499 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750829AbVKSVMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:12:24 -0500
Date: Sat, 19 Nov 2005 22:12:12 +0100 (CET)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: isdn4linux@listserv.isdn4linux.de, kkeil@suse.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] drivers/isdn/: add missing #include's
In-Reply-To: <20051119075943.GD16060@stusta.de>
Message-ID: <Pine.LNX.4.61.0511192208310.21536@phoenix.one.melware.de>
References: <20051119075943.GD16060@stusta.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2005, Adrian Bunk wrote:
> Every file should #include the headers containing the prototypes for 
> it's global functions.

Agreed. 
 
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

