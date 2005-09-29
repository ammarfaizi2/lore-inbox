Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVI2BGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVI2BGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVI2BGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:06:00 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:60366 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751295AbVI2BF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:05:59 -0400
Date: Wed, 28 Sep 2005 18:07:01 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: rmk@arm.linux.org.uk, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [ARM] Fix thinko in previous ARM 2917/1 patch
Message-ID: <20050929010701.GA24279@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Previous patch accidently add IXDP425 mach entry when IXDP465 is configured.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -123,7 +123,7 @@ static void __init ixdp425_init(void)
 	platform_add_devices(ixdp425_devices, ARRAY_SIZE(ixdp425_devices));
 }
 
-#ifdef CONFIG_ARCH_IXDP465
+#ifdef CONFIG_ARCH_IXDP425
 MACHINE_START(IXDP425, "Intel IXDP425 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
 	.phys_ram	= PHYS_OFFSET,

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
