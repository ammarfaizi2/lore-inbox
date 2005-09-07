Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVIGHPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVIGHPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 03:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVIGHPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 03:15:41 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:15260 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751097AbVIGHPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 03:15:40 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20050907071440.3015.76396.sendpatchset@cherry.local>
Subject: [PATCH] i386: CONFIG_ACPI_SRAT typo fix
Date: Wed,  7 Sep 2005 16:15:39 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.6.13-git6 fixes a typo involving CONFIG_ACPI_SRAT.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
----

--- from-0005/include/asm-i386/mmzone.h
+++ to-0008/include/asm-i386/mmzone.h	2005-09-07 15:06:52.000000000 +0900
@@ -29,7 +29,7 @@ static inline void get_memcfg_numa(void)
 #ifdef CONFIG_X86_NUMAQ
 	if (get_memcfg_numaq())
 		return;
-#elif CONFIG_ACPI_SRAT
+#elif defined(CONFIG_ACPI_SRAT)
 	if (get_memcfg_from_srat())
 		return;
 #endif
