Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVCLX3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVCLX3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCLX0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:26:01 -0500
Received: from aun.it.uu.se ([130.238.12.36]:16330 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262426AbVCLXW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:22:28 -0500
Date: Sun, 13 Mar 2005 00:22:21 +0100 (MET)
Message-Id: <200503122322.j2CNMLTx028990@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 6/9: cpu_control access, common
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add declarations of common arch-specific domain numbers and
  corresponding data structures to <linux/perfctr.h>. This just
  factors out common code, it does not impose any requirements
  on arch-specific code.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 include/linux/perfctr.h |   11 +++++++++++
 1 files changed, 11 insertions(+)

diff -rupN linux-2.6.11-mm3.perfctr-cpu_control_header/include/linux/perfctr.h linux-2.6.11-mm3.perfctr-cpu_control-access/include/linux/perfctr.h
--- linux-2.6.11-mm3.perfctr-cpu_control_header/include/linux/perfctr.h	2005-03-12 19:26:26.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control-access/include/linux/perfctr.h	2005-03-12 20:01:39.000000000 +0100
@@ -60,6 +60,17 @@ struct vperfctr_control {
 #define VPERFCTR_CONTROL_RESUME		0x03
 #define VPERFCTR_CONTROL_CLEAR		0x04
 
+/* common description of an arch-specific 32-bit control register */
+struct perfctr_cpu_reg {
+	unsigned int nr;
+	unsigned int value;
+};
+
+/* domain numbers for common arch-specific control data */
+#define PERFCTR_DOMAIN_CPU_CONTROL	128	/* struct perfctr_cpu_control_header */
+#define PERFCTR_DOMAIN_CPU_MAP		129	/* unsigned int[] */
+#define PERFCTR_DOMAIN_CPU_REGS		130	/* struct perfctr_cpu_reg[] */
+
 /* commands for sys_vperfctr_read() */
 #define VPERFCTR_READ_SUM	0x01
 #define VPERFCTR_READ_CONTROL	0x02
