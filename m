Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVFARm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVFARm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVFARjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:39:31 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:7389 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261486AbVFARgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:36:21 -0400
Date: Wed, 1 Jun 2005 12:36:11 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Removed dependency on CONFIG_CPM2 for building
 mpc85xx_device.c
Message-ID: <Pine.LNX.4.61.0506011235330.1682@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we needed CONFIG_CPM2 enabled to get the proper IRQ
ifdef's for CPM interrupts.  Recent changes have caused that to
be no longer necessary.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 22774efc1bef9f9a0fd9b34d44bf10da787e3d91
tree 115c991f9030418e78a7aa0f23d678d0141e0746
parent 6e7c21f278abb17a9bbdc6fd1f1b1b96e6677fdb
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 01 Jun 2005 12:34:30 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 01 Jun 2005 12:34:30 -0500

 arch/ppc/syslib/mpc85xx_devices.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
--- a/arch/ppc/syslib/mpc85xx_devices.c
+++ b/arch/ppc/syslib/mpc85xx_devices.c
@@ -321,7 +321,6 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
-#ifdef CONFIG_CPM2
 	[MPC85xx_CPM_FCC1] = {
 		.name = "fsl-cpm-fcc",
 		.id	= 1,
@@ -575,7 +574,6 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
-#endif /* CONFIG_CPM2 */
 	[MPC85xx_eTSEC1] = {
 		.name = "fsl-gianfar",
 		.id	= 1,
