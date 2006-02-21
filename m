Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161434AbWBUGWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161434AbWBUGWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161437AbWBUGWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:22:17 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:64989 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161438AbWBUGVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:55 -0500
Date: Mon, 20 Feb 2006 23:21:53 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20060221062152.13304.89116.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 8/11] Time: i386 conversion part 3 - remove nsec_t
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes nsec_t usage as suggested by Roman Zippel

Signed-off-by: John Stultz <johnstul@us.ibm.com>


 arch/i386/kernel/time.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: mm-merge/arch/i386/kernel/time.c
===================================================================
--- mm-merge.orig/arch/i386/kernel/time.c
+++ mm-merge/arch/i386/kernel/time.c
@@ -223,9 +223,9 @@ unsigned long get_cmos_time(void)
 EXPORT_SYMBOL(get_cmos_time);
 
 /* arch specific timeofday hooks */
-nsec_t read_persistent_clock(void)
+s64 read_persistent_clock(void)
 {
-	return (nsec_t)get_cmos_time() * NSEC_PER_SEC;
+	return (s64)get_cmos_time() * NSEC_PER_SEC;
 }
 
 void sync_persistent_clock(struct timespec ts)
