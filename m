Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWGFTwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWGFTwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWGFTwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:52:41 -0400
Received: from server6.greatnet.de ([83.133.96.26]:11400 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750787AbWGFTwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:52:40 -0400
Message-ID: <44AD6A5A.5060403@nachtwindheim.de>
Date: Thu, 06 Jul 2006 21:54:02 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Neela.Kolli@engenio.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: [PATCH] fix legacy megaraid-driver to compile without CONFIG_PROC_FS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Create an empty inline function to make the legacy megaraid-driver compile
without PROC_FS.
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

--- linux-2.6.18-rc1/drivers/scsi/megaraid.h    2006-06-18 03:49:35.000000000 +0200
+++ linux/drivers/scsi/megaraid.h       2006-07-06 21:39:59.000000000 +0200
@@ -1039,6 +1039,9 @@
 static int proc_rdrv_30(char *, char **, off_t, int, int *, void *);
 static int proc_rdrv_40(char *, char **, off_t, int, int *, void *);
 static int proc_rdrv(adapter_t *, char *, int, int);
+#else
+static inline void
+mega_create_proc_entry(int index, struct proc_dir_entry *parent) {}
 #endif

 static int mega_adapinq(adapter_t *, dma_addr_t);
