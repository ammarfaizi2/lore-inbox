Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVBFPSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVBFPSp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 10:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVBFPSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 10:18:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27411 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261156AbVBFPSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 10:18:44 -0500
Date: Sun, 6 Feb 2005 16:18:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: rmk@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] arm: NR_CPUS: use range
Message-ID: <20050206151840.GQ3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses range for NR_CPUS on arm (the same is already done on 
all other architectures).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- 

This patch was already sent on:
- 15 Jan 2005

--- linux-2.6.11-rc1-mm1-full/arch/arm/Kconfig.old	2005-01-15 07:34:47.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/arm/Kconfig	2005-01-15 07:38:24.000000000 +0100
@@ -286,6 +286,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "4"
 
