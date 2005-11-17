Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVKQXHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVKQXHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVKQXHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:07:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:60838 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965042AbVKQXHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:07:37 -0500
Date: Thu, 17 Nov 2005 17:05:02 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, <linuxppc-embedded@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, <dave@cray.com>
Subject: [PATCH] ppc: Fix MPC83xx device table
Message-ID: <Pine.LNX.4.44.0511171704240.15752-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SVRs for MPC8343/E where incorrect and really the SVRs
for MPC8347/E.

Signed-off-by: David Updegraff <dave@cray.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 6eba85c696e0a0fef59435bd641110a759b308ab
tree 0f2393d85f4f225793508a321460c74579c9d834
parent 5b45c04aa9d209ba1a71ff8061fda9ae3979ddd6
author Kumar Gala <galak@kernel.crashing.org> Thu, 17 Nov 2005 17:06:02 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 17 Nov 2005 17:06:02 -0600

 arch/ppc/syslib/mpc83xx_sys.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/ppc/syslib/mpc83xx_sys.c b/arch/ppc/syslib/mpc83xx_sys.c
index a152398..82cf3ab 100644
--- a/arch/ppc/syslib/mpc83xx_sys.c
+++ b/arch/ppc/syslib/mpc83xx_sys.c
@@ -69,9 +69,33 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		},
 	},
 	{
-		.ppc_sys_name	= "8343E",
+		.ppc_sys_name	= "8347E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80540000,
+		.num_devices	= 9,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+		},
+	},
+	{
+		.ppc_sys_name	= "8347",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80550000,
+		.num_devices	= 8,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
+			MPC83xx_IIC2, MPC83xx_DUART,
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
+		},
+	},
+	{
+		.ppc_sys_name	= "8343E",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x80560000,
 		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
@@ -83,7 +107,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 	{
 		.ppc_sys_name	= "8343",
 		.mask 		= 0xFFFF0000,
-		.value 		= 0x80550000,
+		.value 		= 0x80570000,
 		.num_devices	= 7,
 		.device_list	= (enum ppc_sys_devices[])
 		{

