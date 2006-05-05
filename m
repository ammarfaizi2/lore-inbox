Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWEERJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWEERJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWEERJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 13:09:38 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:18638 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751174AbWEERJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 13:09:38 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <13.420169009@selenic.com>
Subject: [PATCH 12/14] random: Remove not very useful SA_SAMPLE_RANDOM from lubbock
Date: Fri, 05 May 2006 11:42:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove not very useful SA_SAMPLE_RANDOM from lubbock

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/arch/arm/mach-pxa/lubbock.c
===================================================================
--- 2.6.orig/arch/arm/mach-pxa/lubbock.c	2006-04-20 17:01:03.000000000 -0500
+++ 2.6/arch/arm/mach-pxa/lubbock.c	2006-05-02 18:35:47.000000000 -0500
@@ -342,7 +342,7 @@ static int lubbock_mci_init(struct devic
 	init_timer(&mmc_timer);
 	mmc_timer.data = (unsigned long) data;
 	return request_irq(LUBBOCK_SD_IRQ, lubbock_detect_int,
-			SA_SAMPLE_RANDOM, "lubbock-sd-detect", data);
+			0, "lubbock-sd-detect", data);
 }
 
 static int lubbock_mci_get_ro(struct device *dev)
