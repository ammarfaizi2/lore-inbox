Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbUKZUHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUKZUHY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbUKZUGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:06:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262592AbUKZTfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:17 -0500
Date: Thu, 25 Nov 2004 20:19:35 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [PATCH] fix unnecessary increment in firmware_class_hotplug()
To: linux-kernel@vger.kernel.org
Cc: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Message-id: <20041125201935.213944c9.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch is to fix unnecessary increment of 'i' used to
specify an element of an arry 'envp[]' in firmware_class_hotplug().
The 'i' is already incremented in add_hotplug_env_var(), actually.

Thanks,
Keiichiro Tokunaga

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Status: Compiled on 2.6.10-rc2-mm3
---

 linux-2.6.10-rc2-mm3-kei/drivers/base/firmware_class.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/base/firmware_class.c~fix_firmware_class_hotplug drivers/base/firmware_class.c
--- linux-2.6.10-rc2-mm3/drivers/base/firmware_class.c~fix_firmware_class_hotplug	2004-11-25 18:31:19.278701104 +0900
+++ linux-2.6.10-rc2-mm3-kei/drivers/base/firmware_class.c	2004-11-25 18:31:37.555922544 +0900
@@ -103,7 +103,7 @@ firmware_class_hotplug(struct class_devi
 			"FIRMWARE=%s", fw_priv->fw_id))
 		return -ENOMEM;
 
-	envp[i++] = NULL;
+	envp[i] = NULL;
 
 	return 0;
 }

_

