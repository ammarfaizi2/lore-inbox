Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266523AbUAWGsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUAWGpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:45:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266525AbUAWGgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:46 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: OOSTORE needs MTRR.
Message-Id: <E1Ajuub-0000y6-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The centaur CPU init code get linking errors without it.

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/Kconfig linux-2.5/arch/i386/Kconfig
--- bk-linus/arch/i386/Kconfig	2004-01-23 05:23:44.000000000 +0000
+++ linux-2.5/arch/i386/Kconfig	2004-01-23 05:43:37.000000000 +0000
@@ -399,7 +399,7 @@ config X86_USE_3DNOW
 
 config X86_OOSTORE
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6
+	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
 	default y
 
 config HPET_TIMER
