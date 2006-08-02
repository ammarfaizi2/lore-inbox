Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWHBUzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWHBUzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWHBUzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:55:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:4834 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751008AbWHBUzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:55:36 -0400
Subject: [RFC][PATCH] enable VMSPLIT for highmem kernels
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 02 Aug 2006 13:55:33 -0700
Message-Id: <20060802205533.CBD06E21@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---

 lxc-dave/arch/i386/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/Kconfig~split-for-pae arch/i386/Kconfig
--- lxc/arch/i386/Kconfig~split-for-pae	2006-08-02 12:58:55.000000000 -0700
+++ lxc-dave/arch/i386/Kconfig	2006-08-02 13:02:55.000000000 -0700
@@ -497,7 +497,7 @@ config HIGHMEM64G
 endchoice
 
 choice
-	depends on EXPERIMENTAL && !X86_PAE
+	depends on EXPERIMENTAL
 	prompt "Memory split" if EMBEDDED
 	default VMSPLIT_3G
 	help
@@ -519,6 +519,7 @@ choice
 	config VMSPLIT_3G
 		bool "3G/1G user/kernel split"
 	config VMSPLIT_3G_OPT
+		depends on !HIGHMEM
 		bool "3G/1G user/kernel split (for full 1G low memory)"
 	config VMSPLIT_2G
 		bool "2G/2G user/kernel split"
_
