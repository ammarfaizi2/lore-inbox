Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWCaPtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWCaPtc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWCaPtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:49:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54539 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751386AbWCaPtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:49:31 -0500
Date: Fri, 31 Mar 2006 17:49:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jordan Crouse <jordan.crouse@amd.com>
Subject: [2.6 patch] Enable TSC for AMD Geode GX/LX
Message-ID: <20060331154929.GI3893@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jordan.crouse@amd.com>

Geode GX/LX should enable X86_TSC.   Pointed out by Adrian Bunk.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Jordan Crouse on:
- 19 Mar 2006

--- a/arch/i386/Kconfig.cpu
+++ b/arch/i386/Kconfig.cpu
@@ -311,5 +311,5 @@ config X86_OOSTORE
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MGEODEGX1) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MGEODEGX1 || MGEODE_LX) && !X86_NUMAQ
 	default y

