Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163054AbWLBRyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163054AbWLBRyr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163074AbWLBRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:54:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53765 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1163054AbWLBRyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:54:46 -0500
Date: Sat, 2 Dec 2006 18:54:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/wd33c93.c: cleanups
Message-ID: <20061202175451.GR11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- #include <asm/irq.h> for getting the prototypes of
  {dis,en}able_irq()
- make the needlessly global wd33c93_setup() static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Sep 2006

--- linux-2.6.18-rc5-mm1/drivers/scsi/wd33c93.c.old	2006-09-04 01:45:57.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/scsi/wd33c93.c	2006-09-04 01:46:26.000000000 +0200
@@ -85,6 +85,8 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 
+#include <asm/irq.h>
+
 #include "wd33c93.h"
 
 
@@ -1710,7 +1712,7 @@
 static char setup_used[MAX_SETUP_ARGS];
 static int done_setup = 0;
 
-int
+static int
 wd33c93_setup(char *str)
 {
 	int i;


