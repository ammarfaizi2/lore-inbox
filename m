Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUKHOc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUKHOc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUKHOc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:32:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261837AbUKHOcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:32:51 -0500
Date: Mon, 8 Nov 2004 14:32:40 GMT
Message-Id: <200411081432.iA8EWeDY023392@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] Make /proc/kcore conditional on CONFIG_MMU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes the presence of /proc/kcore conditional on CONFIG_MMU
being configured on.

Signed-Off-By: dhowells@redhat.com
---
diffstat kcore-2610rc1mm3.diff
 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/fs/Kconfig linux-2.6.10-rc1-mm3-frv/fs/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-mm3/fs/Kconfig	2004-11-05 13:15:42.000000000 +0000
+++ linux-2.6.10-rc1-mm3-frv/fs/Kconfig	2004-11-05 14:17:06.124046375 +0000
@@ -856,7 +856,7 @@ config PROC_FS
 
 config PROC_KCORE
 	bool "/proc/kcore support" if !ARM
-	depends on PROC_FS
+	depends on PROC_FS && MMU
 
 config SYSFS
 	bool "sysfs file system support" if EMBEDDED
