Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVAOGlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVAOGlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 01:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVAOGlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 01:41:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28677 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262223AbVAOGjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 01:39:37 -0500
Date: Sat, 15 Jan 2005 07:39:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arm: NR_CPUS: use range
Message-ID: <20050115063934.GI4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below uses range for NR_CPUS on arm (the same is already 
done on all other architectures).


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/arch/arm/Kconfig.old	2005-01-15 07:34:47.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/arm/Kconfig	2005-01-15 07:38:24.000000000 +0100
@@ -286,6 +286,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "4"
 
