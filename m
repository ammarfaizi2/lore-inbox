Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbTFRUcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265519AbTFRUct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:32:49 -0400
Received: from palrel10.hp.com ([156.153.255.245]:40863 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265491AbTFRUcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:32:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.53170.851207.542028@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 13:46:42 -0700
To: groudier@free.fr
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: small patch for sym53c8xx_2
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought we had an agreement for a long time already that the use of
dma64_addr_t in the sym53c8xx_2 driver was wrong, but it's still
there.

Thanks,

	--david

diff -Nru a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c	Wed Jun 18 13:32:51 2003
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c	Wed Jun 18 13:32:51 2003
@@ -295,11 +295,7 @@
 #ifndef SYM_LINUX_DYNAMIC_DMA_MAPPING
 typedef u_long		bus_addr_t;
 #else
-#if	SYM_CONF_DMA_ADDRESSING_MODE > 0
-typedef dma64_addr_t	bus_addr_t;
-#else
 typedef dma_addr_t	bus_addr_t;
-#endif
 #endif
 
 /*
