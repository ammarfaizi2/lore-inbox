Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWJXQ2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWJXQ2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWJXQ2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:28:01 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:34774 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932438AbWJXQ1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:27:50 -0400
Message-Id: <200610241827.31835.arnd@arndb.de>
References: <20061024160140.452484000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:27:30 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org,
       Dwayne Grant Mcconnell <decimal@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 1/3] spufs: fix signal2 file to report signal2
Content-Disposition: inline
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dwayne Grant Mcconnell <decimal@us.ibm.com>

Here is a simple patch that fixes the /signal2 file to actually give
signal2 data.

Signed-off-by: Dwayne Grant Mcconnell <decimal@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/hw_ops.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/hw_ops.c
@@ -147,7 +147,7 @@ static void spu_hw_signal1_write(struct 
 
 static u32 spu_hw_signal2_read(struct spu_context *ctx)
 {
-	return in_be32(&ctx->spu->problem->signal_notify1);
+	return in_be32(&ctx->spu->problem->signal_notify2);
 }
 
 static void spu_hw_signal2_write(struct spu_context *ctx, u32 data)

--

