Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWHIBC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWHIBC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWHIBCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:02:52 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:58542 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030387AbWHIBCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:02:36 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>, ak@suse.de
Message-Id: <20060809010410.25458.59204.sendpatchset@cherry.local>
In-Reply-To: <20060809010345.25458.86096.sendpatchset@cherry.local>
References: <20060809010345.25458.86096.sendpatchset@cherry.local>
Subject: [PATCH 06/06] x86_64: mark init_amd() as __cpuinit
Date: Wed,  9 Aug 2006 10:03:23 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64: mark init_amd() as __cpuinit

The init_amd() function is only called from identify_cpu() which is already
marked as __cpuinit. So let's mark it as __cpuinit.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 setup.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/x86_64/kernel/setup.c
+++ work/arch/x86_64/kernel/setup.c	2006-08-09 08:17:41.000000000 +0900
@@ -833,7 +833,7 @@ static void __init amd_detect_cmp(struct
 #endif
 }
 
-static void __init init_amd(struct cpuinfo_x86 *c)
+static void __cpuinit init_amd(struct cpuinfo_x86 *c)
 {
 	unsigned level;
 
