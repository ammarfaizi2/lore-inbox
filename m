Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUCAI6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUCAI4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:56:35 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:5350 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S262289AbUCAIwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:52:12 -0500
Date: Mon, 1 Mar 2004 09:52:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/5): xpram driver.
Message-ID: <20040301085203.GF675@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xpram fix: Replace old style module parameter definition with new style.

diffstat:
 drivers/s390/block/xpram.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urN linux-2.6/drivers/s390/block/xpram.c linux-2.6-s390/drivers/s390/block/xpram.c
--- linux-2.6/drivers/s390/block/xpram.c	Wed Feb 18 04:58:53 2004
+++ linux-2.6-s390/drivers/s390/block/xpram.c	Fri Feb 27 20:05:05 2004
@@ -74,9 +74,10 @@
  */
 static int devs = XPRAM_DEVS;
 static unsigned int sizes[XPRAM_MAX_DEVS];
+static unsigned int sizes_count;
 
 module_param(devs, int, 0);
-MODULE_PARM(sizes,"1-" __MODULE_STRING(XPRAM_MAX_DEVS) "i"); 
+module_param_array(sizes, int, sizes_count, 0);
 
 MODULE_PARM_DESC(devs, "number of devices (\"partitions\"), " \
 		 "the default is " __MODULE_STRING(XPRAM_DEVS) "\n");
