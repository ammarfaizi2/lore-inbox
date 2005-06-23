Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVFWBSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVFWBSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVFWBSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:18:34 -0400
Received: from fmr18.intel.com ([134.134.136.17]:27618 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261955AbVFWBSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:18:31 -0400
Date: Wed, 22 Jun 2005 18:18:23 -0700
Message-Id: <200506230118.j5N1INsc016585@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [ia64][patch] Fix 2.6.12-mm1 default tiger config
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of the CONFIG_FUSION_FC and CONFIG_FUSION_SPI
config entries, the ia64 default tiger configuration is broken
(because system fails to mount root device.)  This patch fixes
the default for tiger systems.

    --rusty

signed-off-by: Rusty Lynch <rusty.lynch@intel.com>

 arch/ia64/configs/tiger_defconfig |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.12-mm1/arch/ia64/configs/tiger_defconfig
===================================================================
--- linux-2.6.12-mm1.orig/arch/ia64/configs/tiger_defconfig
+++ linux-2.6.12-mm1/arch/ia64/configs/tiger_defconfig
@@ -366,6 +366,8 @@ CONFIG_DM_ZERO=m
 # Fusion MPT device support
 #
 CONFIG_FUSION=y
+CONFIG_FUSION_SPI=y
+# CONFIG_FUSION_FC is not set
 CONFIG_FUSION_MAX_SGE=40
 # CONFIG_FUSION_CTL is not set
 
