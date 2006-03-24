Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWCXXIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWCXXIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWCXXIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:08:10 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:24052 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S964809AbWCXXIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:08:06 -0500
Date: Fri, 24 Mar 2006 15:07:29 -0800
Message-Id: <200603242307.k2ON7TK0007932@dhcp153.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/kernel/time/timeofday.c
===================================================================
--- linux-2.6.16.orig/kernel/time/timeofday.c
+++ linux-2.6.16/kernel/time/timeofday.c
@@ -644,7 +644,7 @@ static void timeofday_periodic_hook(unsi
 
 	int something_changed = 0;
  	int clocksource_changed = 0;
-	struct clocksource old_clock;
+	struct clocksource old_clock = { .mult = 1, .shift = 0 };
 	static s64 second_check;
 
 	write_seqlock_irqsave(&system_time_lock, flags);
