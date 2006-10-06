Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422851AbWJFS6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851AbWJFS6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422854AbWJFS6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:58:36 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:32291 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1422851AbWJFS6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:58:03 -0400
Message-Id: <20061006185457.619680000@mvista.com>
References: <20061006185439.667702000@mvista.com>
User-Agent: quilt/0.45-1
Date: Fri, 06 Oct 2006 11:54:49 -0700
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 10/10] -mm: clocksource: update kernel parameters
Content-Disposition: inline; filename=add_some_new_clocksource_params.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documents two new kernel parameters,

timeofday_clocksource
sched_clocksource

Removed old ones,

clocksource
clock

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 Documentation/kernel-parameters.txt |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

Index: linux-2.6.18/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.18.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.18/Documentation/kernel-parameters.txt
@@ -351,13 +351,6 @@ and is between 256 and 4096 characters. 
 			Value can be changed at runtime via
 				/selinux/checkreqprot.
 
-	clock=		[BUGS=IA-32, HW] gettimeofday clocksource override.
-			[Deprecated]
-			Forces specified clocksource (if avaliable) to be used
-			when calculating gettimeofday(). If specified
-			clocksource is not avalible, it defaults to PIT.
-			Format: { pit | tsc | cyclone | pmtmr }
-
 	disable_8254_timer
 	enable_8254_timer
 			[IA32/X86_64] Disable/Enable interrupt 0 timer routing
@@ -1647,9 +1640,13 @@ and is between 256 and 4096 characters. 
 
 	time		Show timing data prefixed to each printk message line
 
-	clocksource=	[GENERIC_TIME] Override the default clocksource
-			Override the default clocksource and use the clocksource
-			with the name specified.
+	timeofday_clocksource=	[GENERIC_TIME]
+			Override the default time of day clocksource and use
+			the clocksource with the name specified.
+
+	sched_clocksource=	[GENERIC_TIME]
+			Override the default scheduler clocksource. Used for
+			timing only inside the scheduler.
 
 	tipar.timeout=	[HW,PPT]
 			Set communications timeout in tenths of a second

--

