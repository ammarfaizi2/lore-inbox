Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSIKMwr>; Wed, 11 Sep 2002 08:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318756AbSIKMwJ>; Wed, 11 Sep 2002 08:52:09 -0400
Received: from dp.samba.org ([66.70.73.150]:41701 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318760AbSIKMwC>;
	Wed, 11 Sep 2002 08:52:02 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15743.15160.944416.838635@argo.ozlabs.ibm.com>
Date: Wed, 11 Sep 2002 22:46:48 +1000 (EST)
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PPC fix in drivers/pci/Makefile
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

On PPC these days we need drivers/pci/setup-irq.c (on all ppc32
platforms) and we don't use drivers/pci/setup-bus.c any more.  This
patch adjusts drivers/pci/Makefile to reflect this.

Please apply this to your tree.

Thanks,
Paul.

diff -urN linux-2.4/drivers/pci/Makefile linuxppc-2.4/drivers/pci/Makefile
--- linux-2.4/drivers/pci/Makefile	Wed Aug  7 18:09:34 2002
+++ linuxppc-2.4/drivers/pci/Makefile	Sun Aug 18 19:19:47 2002
@@ -27,7 +27,7 @@
 obj-$(CONFIG_ARM) += setup-bus.o setup-irq.o
 obj-$(CONFIG_PARISC) += setup-bus.o
 obj-$(CONFIG_SUPERH) += setup-bus.o setup-irq.o
-obj-$(CONFIG_ALL_PPC) += setup-bus.o
+obj-$(CONFIG_PPC32) += setup-irq.o
 obj-$(CONFIG_SGI_IP27) += setup-irq.o
 obj-$(CONFIG_SGI_IP32) += setup-irq.o
 
