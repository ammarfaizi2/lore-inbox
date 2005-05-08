Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVEHT7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVEHT7V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVEHT5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:57:46 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:5271 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262941AbVEHTKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:22 -0400
Message-Id: <20050508184345.305738000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:31 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-saa7146-init-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 02/37] saa7146: no need to initialize static/global variables to 0
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no need to initialize static/global variables to 0

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/common/saa7146_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/common/saa7146_core.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/common/saa7146_core.c	2005-05-08 18:23:20.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/common/saa7146_core.c	2005-05-08 20:24:42.000000000 +0200
@@ -23,9 +23,9 @@
 LIST_HEAD(saa7146_devices);
 DECLARE_MUTEX(saa7146_devices_lock);
 
-static int saa7146_num = 0;
+static int saa7146_num;
 
-unsigned int saa7146_debug = 0;
+unsigned int saa7146_debug;
 
 module_param(saa7146_debug, int, 0644);
 MODULE_PARM_DESC(saa7146_debug, "debug level (default: 0)");

--

