Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264642AbRFPSTP>; Sat, 16 Jun 2001 14:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbRFPSTF>; Sat, 16 Jun 2001 14:19:05 -0400
Received: from [209.250.53.83] ([209.250.53.83]:2308 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S264642AbRFPSS7>; Sat, 16 Jun 2001 14:18:59 -0400
Date: Sat, 16 Jun 2001 13:12:37 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix warning in tdfxfb.c
Message-ID: <20010616131237.A4378@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 1:11pm  up 19:39,  3 users,  load average: 3.16, 3.06, 2.74
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is obviously correct.  It doesn't appear that tdfxfb has a
maintainer, so I'm sending this patch to the list.  Nothing
earth-shattering, it just removes a warning during build.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

--- tdfxfb.c~	Sat Jun 16 13:09:08 2001
+++ tdfxfb.c	Sat Jun 16 13:09:21 2001
@@ -1892,7 +1892,7 @@
        ((pdev->device == PCI_DEVICE_ID_3DFX_BANSHEE) ||
 	(pdev->device == PCI_DEVICE_ID_3DFX_VOODOO3) ||
 	(pdev->device == PCI_DEVICE_ID_3DFX_VOODOO5))) {
-      char *name;
+      char *name = NULL;
 
       fb_info.dev   = pdev->device;
       switch (pdev->device) {
