Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263358AbVBENzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbVBENzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 08:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264978AbVBENzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 08:55:43 -0500
Received: from scrat.cs.umu.se ([130.239.40.18]:54709 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S263358AbVBENzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 08:55:24 -0500
Date: Sat, 5 Feb 2005 14:55:10 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [PATCH] arch/i386/kernel/pci-dma.c Remove some sparse warnings
Message-ID: <20050205135510.GA20631@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this is the correct way of fixing this, but at least it
compiles cleanly and seems to work for me.


--- linux-bk/arch/i386/kernel/pci-dma.c	2005-02-03 18:11:54.000000000 +0100
+++ linux/arch/i386/kernel/pci-dma.c	2005-02-05 12:47:05.000000000 +0100
@@ -14,7 +14,7 @@
 #include <asm/io.h>
 
 struct dma_coherent_mem {
-	void		*virt_base;
+	void __iomem	*virt_base;
 	u32		device_base;
 	int		size;
 	int		flags;


-- 
Peter Hagervall <hager@cs.umu.se>
