Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVCFXtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVCFXtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVCFXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:48:48 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:18678 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261554AbVCFXbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 18:31:11 -0500
Date: Mon, 7 Mar 2005 08:30:52 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-mm1] mips: fix section type conflict about mpc30x
Message-Id: <20050307083052.3366678c.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes section type conflict about mpc30x

  CC      arch/mips/pci/fixup-mpc30x.o
arch/mips/pci/fixup-mpc30x.c:26: error: internal_func_irqs causes a section type conflict
make[1]: *** [arch/mips/pci/fixup-mpc30x.o] Error 1
make: *** [arch/mips/pci] Error 2

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-mpc30x.c a/arch/mips/pci/fixup-mpc30x.c
--- a-orig/arch/mips/pci/fixup-mpc30x.c	Fri Nov  5 00:42:26 2004
+++ a/arch/mips/pci/fixup-mpc30x.c	Mon Jan 10 23:54:09 2005
@@ -29,7 +29,7 @@
 	VRC4173_USB_IRQ,
 };
 
-static char irq_tab_mpc30x[] __initdata = {
+static const int irq_tab_mpc30x[] __initdata = {
  [12] = VRC4173_PCMCIA1_IRQ,
  [13] = VRC4173_PCMCIA2_IRQ,
  [29] = MQ200_IRQ,

