Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVCWDA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVCWDA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 22:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVCWDA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 22:00:59 -0500
Received: from aun.it.uu.se ([130.238.12.36]:39416 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262740AbVCWDAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 22:00:09 -0500
Date: Wed, 23 Mar 2005 04:00:03 +0100 (MET)
Message-Id: <200503230300.j2N303Qo023641@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm1 3/3] perfctr: 64-bit values in register descriptors
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- <linux/perfctr.h>: Change value fields in register descriptors
  to 64 bits. This will be needed for ppc64, and ppc32 user-space
  on ppc64 kernels, and may eventually also be needed on x86.
  We could have different descriptor types for 32 and 64-bit
  registers, but that just complicates things for no real benefit.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 include/linux/perfctr.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -rupN linux-2.6.12-rc1-mm1/include/linux/perfctr.h linux-2.6.12-rc1-mm1.perfctr-update-common/include/linux/perfctr.h
--- linux-2.6.12-rc1-mm1/include/linux/perfctr.h	2005-03-22 21:59:08.000000000 +0100
+++ linux-2.6.12-rc1-mm1.perfctr-update-common/include/linux/perfctr.h	2005-03-23 02:19:45.000000000 +0100
@@ -27,10 +27,10 @@ struct vperfctr_control {
 #define VPERFCTR_CONTROL_RESUME		0x03
 #define VPERFCTR_CONTROL_CLEAR		0x04
 
-/* common description of an arch-specific 32-bit control register */
+/* common description of an arch-specific control register */
 struct perfctr_cpu_reg {
 	__u32 nr;
-	__u32 value;
+	__u64 value;
 };
 
 /* state and control domain numbers
