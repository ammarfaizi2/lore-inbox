Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267223AbUBMXBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267266AbUBMXBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:01:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:25498 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267223AbUBMXBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:01:35 -0500
Subject: [PATCH] ppc64: CONFIG_PPC_PMAC implies CONFIG_ADB_PMU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076713226.900.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 10:00:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch avoids a link error if PPC_PMAC is set and the user forgets
to set ADB_PMU. (The PMU driver is mandatory for pmac)

Ben.

diff -urN linux-2.5/arch/ppc64/Kconfig linuxppc-2.5-benh/arch/ppc64/Kconfig
--- linux-2.5/arch/ppc64/Kconfig	2004-02-13 08:05:06.000000000 +1100
+++ linuxppc-2.5-benh/arch/ppc64/Kconfig	2004-02-14 09:58:11.913734520 +1100
@@ -87,6 +87,7 @@
 config PPC_PMAC
 	depends on PPC_PSERIES
 	bool "Apple PowerMac G5 support"
+	select ADB_PMU
 
 config PPC_PMAC64
 	bool


