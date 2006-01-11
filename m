Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWAKXqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWAKXqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWAKXqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:46:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18184 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964769AbWAKXqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:46:42 -0500
Date: Thu, 12 Jan 2006 00:46:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davem@davemloft.net
Cc: ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] arch/sparc64/Kconfig: fix HUGETLB_PAGE_SIZE_64K dependencies
Message-ID: <20060111234640.GJ29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo in the dependencies of HUGETLB_PAGE_SIZE_64K.

It might be more logical to rename the HUGETLB_PAGE_SIZE_*K dependencies 
to HUGETLB_PAGE_SIZE_*KB, but let's fix this bug first.

This bug was reported by Jean-Luc Leger <reiga@dspnet.fr.eu.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm3-full/arch/sparc64/Kconfig.old	2006-01-11 23:44:42.000000000 +0100
+++ linux-2.6.15-mm3-full/arch/sparc64/Kconfig	2006-01-11 23:44:58.000000000 +0100
@@ -179,7 +179,7 @@
 	bool "512K"
 
 config HUGETLB_PAGE_SIZE_64K
-	depends on !SPARC64_PAGE_SIZE_4MB && !SPARC64_PAGE_SIZE_512K
+	depends on !SPARC64_PAGE_SIZE_4MB && !SPARC64_PAGE_SIZE_512KB
 	bool "64K"
 
 endchoice
