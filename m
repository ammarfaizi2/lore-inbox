Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315613AbSEIEwT>; Thu, 9 May 2002 00:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315616AbSEIEwS>; Thu, 9 May 2002 00:52:18 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:10889 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315613AbSEIEwR>;
	Thu, 9 May 2002 00:52:17 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15577.65459.100216.857895@argo.ozlabs.ibm.com>
Date: Thu, 9 May 2002 14:48:51 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix drivers/pci/Makefile for PPC
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

On 32-bit PPC we don't need setup-bus.o but we do need setup-irq.o.
This patch changes drivers/pci/Makefile to reflect that.

The patch is against 2.5.15.  Please apply it to your tree.

Thanks,

Paul.

diff -urN linux-2.5/drivers/pci/Makefile pmac-2.5/drivers/pci/Makefile
--- linux-2.5/drivers/pci/Makefile	Thu May  9 12:07:43 2002
+++ pmac-2.5/drivers/pci/Makefile	Thu May  9 12:40:15 2002
@@ -29,7 +29,7 @@
 obj-$(CONFIG_ARM) += setup-bus.o setup-irq.o
 obj-$(CONFIG_PARISC) += setup-bus.o
 obj-$(CONFIG_SUPERH) += setup-bus.o setup-irq.o
-obj-$(CONFIG_ALL_PPC) += setup-bus.o
+obj-$(CONFIG_PPC32) += setup-irq.o
 obj-$(CONFIG_DDB5476) += setup-bus.o
 obj-$(CONFIG_SGI_IP27) += setup-irq.o
 
