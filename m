Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbULGPCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbULGPCV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbULGPBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:01:16 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:45805 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261824AbULGPA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:00:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Dec 2004 15:35:41 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uml devel <user-mode-linux-devel@lists.sourceforge.net>,
       Jeff Dike <jdike@addtoit.com>,
       Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [patch] uml: ramdisk config fix
Message-ID: <20041207143541.GA23555@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ObviouslyCorrect[tm] buildfix ;)
Should go into 2.6.10.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/Kconfig_block |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux-2.6.10-rc3/arch/um/Kconfig_block
===================================================================
--- linux-2.6.10-rc3.orig/arch/um/Kconfig_block	2004-12-07 12:12:09.000000000 +0100
+++ linux-2.6.10-rc3/arch/um/Kconfig_block	2004-12-07 13:41:38.692103167 +0100
@@ -43,6 +43,10 @@ config BLK_DEV_NBD
 config BLK_DEV_RAM
 	tristate "RAM disk support"
 
+config BLK_DEV_RAM_COUNT
+	int "Default number of RAM disks" if BLK_DEV_RAM
+	default "16"
+
 config BLK_DEV_RAM_SIZE
 	int "Default RAM disk size"
 	depends on BLK_DEV_RAM

-- 
#define printk(args...) fprintf(stderr, ## args)
