Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVEPWNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVEPWNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVEPWNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:13:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1033 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261944AbVEPWMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:12:20 -0400
Date: Tue, 17 May 2005 00:12:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/cpu/intel_cacheinfo.c: section fix
Message-ID: <20050516221215.GM5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

num_cache_leaves is used in __devexit cache_remove_dev() and can 
therefore not be __devinit.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc4-mm2/arch/i386/kernel/cpu/intel_cacheinfo.c.old	2005-05-17 00:05:28.000000000 +0200
+++ linux-2.6.12-rc4-mm2/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-05-17 00:05:49.000000000 +0200
@@ -118,7 +118,7 @@
 };
 
 #define MAX_CACHE_LEAVES		4
-static unsigned short __devinitdata	num_cache_leaves;
+static unsigned short			num_cache_leaves;
 
 static int __devinit cpuid4_cache_lookup(int index, struct _cpuid4_info *this_leaf)
 {

