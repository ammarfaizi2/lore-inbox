Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161409AbWBUGYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161409AbWBUGYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWBUGWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:22:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:17066 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161444AbWBUGWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:22:01 -0500
Date: Mon, 20 Feb 2006 23:21:59 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Message-Id: <20060221062158.13304.96257.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 9/11] Time: i386 conversion part 3 - backout pmtmr changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backout pmtmr_ioport changes to avoid conflicting w/ x86-64

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/kernel/acpi/boot.c |    2 +-
 arch/i386/kernel/time.c      |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: mm-merge/arch/i386/kernel/acpi/boot.c
===================================================================
--- mm-merge.orig/arch/i386/kernel/acpi/boot.c
+++ mm-merge/arch/i386/kernel/acpi/boot.c
@@ -616,7 +616,7 @@ static int __init acpi_parse_hpet(unsign
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-u32 pmtmr_ioport;
+extern u32 pmtmr_ioport;
 #endif
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
