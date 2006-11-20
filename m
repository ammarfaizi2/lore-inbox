Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966333AbWKTSNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966333AbWKTSNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966313AbWKTSHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:02 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:42999 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934275AbWKTSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:06:59 -0500
Message-Id: <20061120180523.217159000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:02 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 08/22] spufs: replace spu.nid with spu.node
Content-Disposition: inline; filename=cell-replace-spu-nid-with-spu-node.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geoff Levand <geoffrey.levand@am.sony.com>
Replace the use of the platform specific variable spu.nid with the
platform independednt variable spu.node.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -835,14 +835,14 @@ static int spu_create_sysdev(struct spu 
 		return ret;
 	}
 
-	sysfs_add_device_to_node(&spu->sysdev, spu->nid);
+	sysfs_add_device_to_node(&spu->sysdev, spu->node);
 
 	return 0;
 }
 
 static void spu_destroy_sysdev(struct spu *spu)
 {
-	sysfs_remove_device_from_node(&spu->sysdev, spu->nid);
+	sysfs_remove_device_from_node(&spu->sysdev, spu->node);
 	sysdev_unregister(&spu->sysdev);
 }
 

--

