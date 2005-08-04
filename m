Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVHDODS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVHDODS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVHDOBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:01:04 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:37046 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262540AbVHDOAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:00:13 -0400
Date: Thu, 4 Aug 2005 08:59:51 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, LeoLi@freescale.com,
       Tanya.jiang@freescale.com
Subject: [PATCH] ppc32: Fix MPC834x USB memory map offsets
Message-ID: <Pine.LNX.4.61.0508040858290.13245@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The memory mappings for MPC8349 USB MPH and DR modules were reversed.

Signed-off-by: Li Yang <LeoLi@freescale.com>
Signed-off-by: Jiang Bo <Tanya.jiang@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit a2227df6ac23000dff7d95411ae5bd8022437ad3
tree d22a59e837eb881b1292f70e51df561802b279df
parent 51904043565cdfb348f58ce99377427c5ffe25fd
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 04 Aug 2005 08:57:58 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 04 Aug 2005 08:57:58 -0500

 arch/ppc/syslib/mpc83xx_devices.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/syslib/mpc83xx_devices.c b/arch/ppc/syslib/mpc83xx_devices.c
--- a/arch/ppc/syslib/mpc83xx_devices.c
+++ b/arch/ppc/syslib/mpc83xx_devices.c
@@ -191,8 +191,8 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 2,
 		.resource = (struct resource[]) {
 			{
-				.start	= 0x22000,
-				.end	= 0x22fff,
+				.start	= 0x23000,
+				.end	= 0x23fff,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
@@ -208,8 +208,8 @@ struct platform_device ppc_sys_platform_
 		.num_resources	 = 2,
 		.resource = (struct resource[]) {
 			{
-				.start	= 0x23000,
-				.end	= 0x23fff,
+				.start	= 0x22000,
+				.end	= 0x22fff,
 				.flags	= IORESOURCE_MEM,
 			},
 			{
