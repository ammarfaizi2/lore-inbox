Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966624AbWKOHva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966624AbWKOHva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966598AbWKOHvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:51:13 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:12495 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966392AbWKOHuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:35 -0500
Message-ID: <363577029.15756@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075032.945192537@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:33 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 26/28] readahead: turn on by default
Content-Disposition: inline; filename=readahead-turn-on-by-default.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the adaptive readahead logic by default.

It helps collect more early testers, and is meant to be a -mm only patch.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm1.orig/mm/Kconfig
+++ linux-2.6.19-rc5-mm1/mm/Kconfig
@@ -168,7 +168,7 @@ config ZONE_DMA_FLAG
 #
 config ADAPTIVE_READAHEAD
 	bool "Adaptive file readahead (EXPERIMENTAL)"
-	default n
+	default y
 	depends on EXPERIMENTAL
 	help
 	  Readahead is a technique employed by the kernel in an attempt

--
