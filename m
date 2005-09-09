Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbVIIUmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbVIIUmf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbVIIUme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:42:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:1255 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030504AbVIIUm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:42:28 -0400
Date: Fri, 9 Sep 2005 21:42:25 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] trivial iomem annotations in qla2xxx/qla_dbg.c
Message-ID: <20050909204225.GD9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/drivers/scsi/qla2xxx/qla_dbg.c current/drivers/scsi/qla2xxx/qla_dbg.c
--- RC13-git8-base/drivers/scsi/qla2xxx/qla_dbg.c	2005-08-28 23:09:45.000000000 -0400
+++ current/drivers/scsi/qla2xxx/qla_dbg.c	2005-09-08 23:53:33.000000000 -0400
@@ -1334,7 +1334,7 @@
 
 		dmp_reg = (uint32_t __iomem *)((uint8_t __iomem *)reg + 0xF0);
 		WRT_REG_DWORD(dmp_reg, 0xB0200000);
-		dmp_reg = (uint32_t *)((uint8_t *)reg + 0xFC);
+		dmp_reg = (uint32_t __iomem *)((uint8_t __iomem *)reg + 0xFC);
 		fw->shadow_reg[2] = RD_REG_DWORD(dmp_reg);
 
 		dmp_reg = (uint32_t __iomem *)((uint8_t __iomem *)reg + 0xF0);
