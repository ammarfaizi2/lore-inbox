Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWAXPWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWAXPWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWAXPWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:22:49 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:24813 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030355AbWAXPWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:22:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=dYAhbWMOIrHUcDv2OjiUOu4O6e0wfEhuDWN6UTjFw1S9tKdOhaWA0lGZ0/AN4jIUWrTviVxL6pnbMtMtp32c612FeslO82tE6ae5jrGrhc6EQ1Ui61m8UXWqlOFZh9h83pzMaktOjHUVZ+i5CQXtLbKdwktXOOryZjpvM6C3dRc=
Date: Tue, 24 Jan 2006 18:40:29 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: dma-mapping.h: add "struct scatterlist;"
Message-ID: <20060124154029.GA9472@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On alpha-jensen:

  CC      drivers/base/platform.o
In file included from include/linux/dma-mapping.h:24,
                 from drivers/base/platform.c:16:
include/asm/dma-mapping.h:36: warning: "struct scatterlist" declared inside parameter list
include/asm/dma-mapping.h:36: warning: its scope is only this definition or declaration, which is probably not what you want

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-alpha/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/asm-alpha/dma-mapping.h
+++ b/include/asm-alpha/dma-mapping.h
@@ -30,6 +30,7 @@
 
 #else	/* no PCI - no IOMMU. */
 
+struct scatterlist;
 void *dma_alloc_coherent(struct device *dev, size_t size,
 			 dma_addr_t *dma_handle, gfp_t gfp);
 int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,


