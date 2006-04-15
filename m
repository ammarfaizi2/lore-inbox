Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWDOWwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWDOWwx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWDOWwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:52:53 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:36356 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932153AbWDOWwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:52:53 -0400
Date: Sun, 16 Apr 2006 00:52:44 +0200
From: Jean-Luc =?iso-8859-1?Q?L=E9ger?= 
	<jean-luc.leger@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
Subject: [2.6 patch] fix dependencies of HUGETLB_PAGE_SIZE_64K
Message-ID: <20060415225244.GG47644@dspnet.fr.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes dependencies of HUGETLB_PAGE_SIZE_64K

Signed-off-by: Jean-Luc Léger <jean-luc.leger@dspnet.fr.eu.org>

Index: linux-2.6.17-rc1/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.17-rc1/arch/sparc64/Kconfig.old   2006-04-15 21:57:30.000000000 +0200
+++ linux-2.6.17-rc1/arch/sparc64/Kconfig       2006-04-15 21:58:38.000000000 +0200
@@ -187,7 +187,7 @@
 	bool "512K"
 
 config HUGETLB_PAGE_SIZE_64K
-	depends on !SPARC64_PAGE_SIZE_4MB && !SPARC64_PAGE_SIZE_512KB && !SPARC64_PAGE_SIZE_64K
+	depends on !SPARC64_PAGE_SIZE_4MB && !SPARC64_PAGE_SIZE_512KB && !SPARC64_PAGE_SIZE_64KB
 	bool "64K"
 
 endchoice

