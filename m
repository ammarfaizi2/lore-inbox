Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932783AbWCQVIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbWCQVIV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbWCQVIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:08:21 -0500
Received: from ns1.siteground.net ([207.218.208.2]:57554 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932783AbWCQVIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:08:20 -0500
Date: Fri, 17 Mar 2006 13:08:58 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Mark cyc2ns_scale readmostly
Message-ID: <20060317210858.GA3666@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is rarely written to.  Mark the variable accordingly

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc6mm1/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6.16-rc6mm1.orig/arch/i386/kernel/tsc.c	2006-03-17 11:18:53.000000000 -0800
+++ linux-2.6.16-rc6mm1/arch/i386/kernel/tsc.c	2006-03-17 11:26:35.000000000 -0800
@@ -87,7 +87,7 @@ EXPORT_SYMBOL_GPL(mark_tsc_unstable);
  *
  *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
-static unsigned long cyc2ns_scale;
+static unsigned long cyc2ns_scale __read_mostly;
 
 #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 
Index: linux-2.6.16-rc6mm1/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.16-rc6mm1.orig/arch/x86_64/kernel/time.c	2006-03-17 11:18:53.000000000 -0800
+++ linux-2.6.16-rc6mm1/arch/x86_64/kernel/time.c	2006-03-17 11:23:07.000000000 -0800
@@ -467,7 +467,7 @@ static irqreturn_t timer_interrupt(int i
 	return IRQ_HANDLED;
 }
 
-static unsigned int cyc2ns_scale;
+static unsigned int cyc2ns_scale __read_mostly;
 #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 
 static inline void set_cyc2ns_scale(unsigned long cpu_khz)
