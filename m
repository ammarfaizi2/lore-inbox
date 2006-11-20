Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966358AbWKTSOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966358AbWKTSOB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966338AbWKTSNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:13:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:49651 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934279AbWKTSHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:03 -0500
Message-Id: <20061120180525.031590000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:45:07 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Masato Noguchi <Masato.Noguchi@jp.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 13/22] spufs: fix return value of spufs_mfc_write
Content-Disposition: inline; filename=spufs-fix-return-value-of-spufs_mfc_write.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>
This patch changes spufs_mfc_write() to return
correct size instead of 0.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
 arch/powerpc/platforms/cell/spufs/file.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.19-rc6-arnd1/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.19-rc6-arnd1.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6.19-rc6-arnd1/arch/powerpc/platforms/cell/spufs/file.c
@@ -1325,6 +1325,7 @@ static ssize_t spufs_mfc_write(struct fi
 		goto out;
 
 	ctx->tagwait |= 1 << cmd.tag;
+	ret = size;
 
 out:
 	return ret;

_______________________________________________
cbe-oss-dev mailing list
cbe-oss-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/cbe-oss-dev

--

