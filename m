Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268890AbUIQQ04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268890AbUIQQ04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 12:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUIQQYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 12:24:35 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:30147 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S269023AbUIQQUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 12:20:18 -0400
Date: Sat, 18 Sep 2004 01:20:10 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fixed vr41xx serial
Message-Id: <20040918012010.10a3c4bc.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UPF_RESOURCES isn't used now.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/common/serial.c a/arch/mips/vr41xx/common/serial.c
--- a-orig/arch/mips/vr41xx/common/serial.c	Mon Sep 13 14:32:26 2004
+++ a/arch/mips/vr41xx/common/serial.c	Sat Sep 18 01:10:23 2004
@@ -115,7 +115,7 @@
 	port.line = vr41xx_serial_ports;
 	port.uartclk = SIU_BASE_BAUD * 16;
 	port.irq = SIU_IRQ;
-	port.flags = UPF_RESOURCES | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
 	switch (current_cpu_data.cputype) {
 	case CPU_VR4111:
 	case CPU_VR4121:
@@ -160,7 +160,7 @@
 	port.line = vr41xx_serial_ports;
 	port.uartclk = DSIU_BASE_BAUD * 16;
 	port.irq = DSIU_IRQ;
-	port.flags = UPF_RESOURCES | UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
+	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
 	port.mapbase = DSIU_BASE;
 	port.regshift = 0;
 	port.iotype = UPIO_MEM;
