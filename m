Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWE2WHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWE2WHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWE2WHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:07:10 -0400
Received: from terminus.zytor.com ([192.83.249.54]:61675 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751342AbWE2WHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:07:08 -0400
Date: Mon, 29 May 2006 15:07:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <200605292207.k4TM722M027624@terminus.zytor.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Make procfs obligatory except under CONFIG_EMBEDDED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Peter Anvin <hpa@zytor.com>

This patch makes procfs non-optional unless EMBEDDED is set, just like
sysfs.  procfs is already de facto required for a large subset of
Linux functionality.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

diff --git a/fs/Kconfig b/fs/Kconfig
index 71d6b30..2c3a733 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -764,7 +764,8 @@ endmenu
 menu "Pseudo filesystems"
 
 config PROC_FS
-	bool "/proc file system support"
+	bool "/proc file system support" if EMBEDDED
+	default y
 	help
 	  This is a virtual file system providing information about the status
 	  of the system. "Virtual" means that it doesn't take up any space on
