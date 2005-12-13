Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVLMOI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVLMOI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVLMOI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:08:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59403 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932322AbVLMOI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:08:26 -0500
Date: Tue, 13 Dec 2005 15:08:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Tolentino <matthew.e.tolentino@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/base/memory.c: unexport the static (sic) memory_sysdev_class
Message-ID: <20051213140826.GH23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We can't export a static struct to modules.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm2-full/drivers/base/memory.c.old	2005-12-13 15:00:17.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/drivers/base/memory.c	2005-12-13 15:00:28.000000000 +0100
@@ -28,7 +28,6 @@
 static struct sysdev_class memory_sysdev_class = {
 	set_kset_name(MEMORY_CLASS_NAME),
 };
-EXPORT_SYMBOL(memory_sysdev_class);
 
 static const char *memory_uevent_name(struct kset *kset, struct kobject *kobj)
 {

