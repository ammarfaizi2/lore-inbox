Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRGDMGD>; Wed, 4 Jul 2001 08:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264356AbRGDMFx>; Wed, 4 Jul 2001 08:05:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:36370 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S263416AbRGDMFm>;
	Wed, 4 Jul 2001 08:05:42 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15171.1586.201917.908949@tango.paulus.ozlabs.org>
Date: Wed, 4 Jul 2001 22:04:02 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix typo in 2.4.6 for PPC
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a typo in the PowerPC code in 2.4.6.  Without
this change, people attempting to compile up a kernel for a powermac
will get a compile error.

Paul.

diff -urN linux/arch/ppc/kernel/pmac_pci.c linuxppc_2_4/arch/ppc/kernel/pmac_pci.c
--- linux/arch/ppc/kernel/pmac_pci.c	Tue Jul  3 13:38:19 2001
+++ linuxppc_2_4/arch/ppc/kernel/pmac_pci.c	Tue Jul  3 15:00:40 2001
@@ -249,7 +249,7 @@
 	out_le32(bp->cfg_addr, (1UL << BANDIT_DEVNUM) + PCI_VENDOR_ID);
 	udelay(2);
 	vendev = in_le32((volatile unsigned int *)bp->cfg_data);
-	if (vendev == (PCI_VENDOR_ID_APPLE_BANDIT << 16) + 
+	if (vendev == (PCI_DEVICE_ID_APPLE_BANDIT << 16) + 
 			PCI_VENDOR_ID_APPLE) {
 		/* read the revision id */
 		out_le32(bp->cfg_addr,
