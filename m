Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319033AbSIJMkm>; Tue, 10 Sep 2002 08:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319066AbSIJMkm>; Tue, 10 Sep 2002 08:40:42 -0400
Received: from h-66-166-207-97.SNVACAID.covad.net ([66.166.207.97]:12008 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S319033AbSIJMkl>; Tue, 10 Sep 2002 08:40:41 -0400
Date: Tue, 10 Sep 2002 05:45:20 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mj@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: Trivial patch: linux-2.5.33/arch/i386/pci/irq.c - pcibios_fixup_irqs should be static
Message-ID: <20020910054520.A13716@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	pcibios_fixup_irqs declared in linux-2.5.33/arch/i386/pci/irq.c
is only called from within that file.  So, it should be declared static
(as it already is in the linux-2.5.33/arch/i386/pci/visws.c version).
The following patch makes that change.  Do you want to integrate this
and forward it to Linus the next time you submit some changes, or is
there some other course of action that you'd prefer?

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="irq.static"

--- linux-2.5.33/arch/i386/pci/irq.c	2002-08-31 15:05:37.000000000 -0700
+++ linux/arch/i386/pci/irq.c	2002-09-10 05:29:09.000000000 -0700
@@ -719,7 +724,7 @@
 
 subsys_initcall(pcibios_irq_init);
 
-void __init pcibios_fixup_irqs(void)
+static void __init pcibios_fixup_irqs(void)
 {
 	struct pci_dev *dev;
 	u8 pin;

--k+w/mQv8wyuph6w0--
