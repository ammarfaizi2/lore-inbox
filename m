Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVFXCMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVFXCMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 22:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVFXCMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 22:12:52 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:64962 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S263003AbVFXCMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 22:12:33 -0400
Date: Thu, 23 Jun 2005 21:12:23 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Linus Torvalds <torvalds@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, tony.Li@freescale.com
Subject: [PATCH] ppc32: Fix MPC83xx IPIC external interrupt pending register
 offset
Message-ID: <Pine.LNX.4.61.0506232110360.6610@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The pending registers for IRQ1-IRQ7 were pointing to the interrupt pending
register instead of the external one.

Signed-off-by: Tony Li <Tony.Li@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 7ada9b1e61d5af4c75f32bfc1f7aabca435024ed
tree 44de45c386a0f22584344494bfe1eb453dffa16c
parent e3f1d172ca1cfd1ac2dd907c31fb2521bfe21689
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 23 Jun 2005 22:49:39 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 23 Jun 2005 22:49:39 -0500

 arch/ppc/syslib/ipic.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/ppc/syslib/ipic.c b/arch/ppc/syslib/ipic.c
--- a/arch/ppc/syslib/ipic.c
+++ b/arch/ppc/syslib/ipic.c
@@ -79,7 +79,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[17] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -87,7 +87,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[18] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -95,7 +95,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[19] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -103,7 +103,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[20] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -111,7 +111,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[21] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -119,7 +119,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[22] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -127,7 +127,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[23] = {
-		.pend	= IPIC_SIPNR_H,
+		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
