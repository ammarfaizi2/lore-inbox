Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUJCIxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUJCIxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 04:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267766AbUJCIxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 04:53:12 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:8689 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S267765AbUJCIxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 04:53:08 -0400
Date: Sun, 3 Oct 2004 17:52:57 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: added missing definition and fixed typo
Message-Id: <20041003175257.465f6a34.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had added missing definition and had fixed typo for VRC4173.
 
Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/vrc4173.c a/arch/mips/vr41xx/common/vrc4173.c
--- a-orig/arch/mips/vr41xx/common/vrc4173.c	Sat Oct  2 22:03:21 2004
+++ a/arch/mips/vr41xx/common/vrc4173.c	Sun Oct  3 17:34:56 2004
@@ -56,6 +56,9 @@
 
 #define VRC4173_SYSINT1REG	0x060
 #define VRC4173_MSYSINT1REG	0x06c
+#define VRC4173_MPIUINTREG	0x06e
+#define VRC4173_MAIUINTREG	0x070
+#define VRC4173_MKIUINTREG	0x072
 
 #define VRC4173_SELECTREG	0x09e
  #define SEL3			0x0008
@@ -329,7 +332,7 @@
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
-EXPORT_SYMBOL(vrc4173_eanble_piuint);
+EXPORT_SYMBOL(vrc4173_enable_piuint);
 
 void vrc4173_disable_piuint(uint16_t mask)
 {
diff -urN -X dontdiff a-orig/include/linux/pci_ids.h a/include/linux/pci_ids.h
--- a-orig/include/linux/pci_ids.h	Sat Oct  2 22:03:53 2004
+++ a/include/linux/pci_ids.h	Sun Oct  3 17:29:15 2004
@@ -569,6 +569,7 @@
 #define PCI_DEVICE_ID_NEC_PCX2		0x0046 /* PowerVR */
 #define PCI_DEVICE_ID_NEC_NILE4		0x005a
 #define PCI_DEVICE_ID_NEC_VRC5476       0x009b
+#define PCI_DEVICE_ID_NEC_VRC4173	0x00a5
 #define PCI_DEVICE_ID_NEC_VRC5477_AC97  0x00a6
 #define PCI_DEVICE_ID_NEC_PC9821CS01    0x800c /* PC-9821-CS01 */
 #define PCI_DEVICE_ID_NEC_PC9821NRB06   0x800d /* PC-9821NR-B06 */
