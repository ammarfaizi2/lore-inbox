Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161663AbWAMDWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161663AbWAMDWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161666AbWAMDWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:22:14 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10627 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161663AbWAMDWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:22:01 -0500
Message-Id: <20060113032249.457900000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:55 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Bunk <bunk@stusta.de>, davem@davemloft.net
Subject: [PATCH 17/17] [PATCH] arch/sparc64/Kconfig: fix HUGETLB_PAGE_SIZE_64K dependencies
Content-Disposition: inline; filename=sparc64-fix-HUGETLB_PAGE_SIZE_64K-dependencies.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This patch fixes a typo in the dependencies of HUGETLB_PAGE_SIZE_64K.

This bug was reported by Jean-Luc Leger <reiga@dspnet.fr.eu.org>.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/sparc64/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.y.orig/arch/sparc64/Kconfig
+++ linux-2.6.15.y/arch/sparc64/Kconfig
@@ -179,7 +179,7 @@ config HUGETLB_PAGE_SIZE_512K
 	bool "512K"
 
 config HUGETLB_PAGE_SIZE_64K
-	depends on !SPARC64_PAGE_SIZE_4MB && !SPARC64_PAGE_SIZE_512K
+	depends on !SPARC64_PAGE_SIZE_4MB && !SPARC64_PAGE_SIZE_512KB
 	bool "64K"
 
 endchoice

--
