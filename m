Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVC3H3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVC3H3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVC3H3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:29:00 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:61123 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261806AbVC3H2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:28:40 -0500
Date: Wed, 30 Mar 2005 01:28:25 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix MPC8555 & MPC8555E device lists (updated)
Message-ID: <Pine.LNX.4.61.0503300126320.17828@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

(As I decide how long to keep the paper bag on this time, here is an 
updated patch.  This one actually reduces the number of devices as well as 
removes the device from the lists which makes things work better :)

Removed the FCC3 device from the lists of devices on MPC8555 & MPC8555E
since it does not exist on these processors.

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/syslib/mpc85xx_sys.c b/arch/ppc/syslib/mpc85xx_sys.c
--- a/arch/ppc/syslib/mpc85xx_sys.c	2005-03-30 01:23:14 -06:00
+++ b/arch/ppc/syslib/mpc85xx_sys.c	2005-03-30 01:23:14 -06:00
@@ -80,7 +80,7 @@
 		.ppc_sys_name	= "8555",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80710000,
-		.num_devices	= 20,
+		.num_devices	= 19,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
@@ -88,7 +88,7 @@
 			MPC85xx_PERFMON, MPC85xx_DUART,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
 			MPC85xx_CPM_USB,
 		},
@@ -97,7 +97,7 @@
 		.ppc_sys_name	= "8555E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80790000,
-		.num_devices	= 21,
+		.num_devices	= 20,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
@@ -105,7 +105,7 @@
 			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3,
-			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
+			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
 			MPC85xx_CPM_USB,
 		},


