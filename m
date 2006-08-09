Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWHIBDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWHIBDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWHIBCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:02:50 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:60846 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030389AbWHIBCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:02:41 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Magnus Damm <magnus@valinux.co.jp>, ak@suse.de
Message-Id: <20060809010415.25458.9899.sendpatchset@cherry.local>
In-Reply-To: <20060809010345.25458.86096.sendpatchset@cherry.local>
References: <20060809010345.25458.86096.sendpatchset@cherry.local>
Subject: [PATCH] i386: mark tsc_init() as __init
Date: Wed,  9 Aug 2006 10:03:28 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: mark tsc_init() as __init

tsc_init() is only called from setup_arch() which is marked as __init.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 tsc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/i386/kernel/tsc.c
+++ work/arch/i386/kernel/tsc.c	2006-08-09 08:59:47.000000000 +0900
@@ -192,7 +192,7 @@ int recalibrate_cpu_khz(void)
 
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
-void tsc_init(void)
+void __init tsc_init(void)
 {
 	if (!cpu_has_tsc || tsc_disable)
 		return;
