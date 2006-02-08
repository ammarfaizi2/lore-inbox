Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWBHDSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWBHDSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWBHDSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:18:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55168 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751137AbWBHDSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:02 -0500
To: torvalds@osdl.org
Subject: [PATCH 02/29] bogus asm/delay.h includes
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fqD-0006BK-VN@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1133412425 -0500

asm/delay.h is non-portable; linux/delay.h should be used in generic code.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/net/wan/pci200syn.c    |    2 +-
 drivers/net/wan/wanxl.c        |    2 +-
 drivers/scsi/aacraid/commsup.c |    2 +-
 sound/oss/emu10k1/recmgr.c     |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

164006da316a22eaaa9fbe36f835a01606436c66
diff --git a/drivers/net/wan/pci200syn.c b/drivers/net/wan/pci200syn.c
index 8dea07b..eba8e5c 100644
--- a/drivers/net/wan/pci200syn.c
+++ b/drivers/net/wan/pci200syn.c
@@ -29,7 +29,7 @@
 #include <linux/netdevice.h>
 #include <linux/hdlc.h>
 #include <linux/pci.h>
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 
 #include "hd64572.h"
diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index 9c1e106..9d3b51c 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -27,8 +27,8 @@
 #include <linux/hdlc.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
+#include <linux/delay.h>
 #include <asm/io.h>
-#include <asm/delay.h>
 
 #include "wanxl.h"
 
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 38d6d00..014cc8d 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -38,10 +38,10 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/blkdev.h>
+#include <linux/delay.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <asm/semaphore.h>
-#include <asm/delay.h>
 
 #include "aacraid.h"
 
diff --git a/sound/oss/emu10k1/recmgr.c b/sound/oss/emu10k1/recmgr.c
index 67c3fd0..2ce5618 100644
--- a/sound/oss/emu10k1/recmgr.c
+++ b/sound/oss/emu10k1/recmgr.c
@@ -29,7 +29,7 @@
  **********************************************************************
  */
 
-#include <asm/delay.h>
+#include <linux/delay.h>
 #include "8010.h"
 #include "recmgr.h"
 
-- 
0.99.9.GIT

