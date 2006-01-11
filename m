Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030702AbWAKAHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030702AbWAKAHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030703AbWAKAHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:07:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56568 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S1030702AbWAKAHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:07:34 -0500
Date: Tue, 10 Jan 2006 16:07:31 -0800
Message-Id: <200601110007.k0B07VOR018915@dhcp153.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the kick_off_hrtimer macro
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This macro doesn't currently have the two options when 
CONFIG_HIGH_RES_TIMERS is off. So I added them.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>


Index: linux-2.6.15/kernel/hrtimer.c
===================================================================
--- linux-2.6.15.orig/kernel/hrtimer.c
+++ linux-2.6.15/kernel/hrtimer.c
@@ -404,7 +404,7 @@ kick_off_hrtimer(struct hrtimer *timer, 
 # define hrtimer_hres_active		0
 # define hres_enqueue_expired(t,b,n)	0
 # define hrtimer_check_clocks()		do { } while (0)
-# define kick_off_hrtimer		do { } while (0)
+# define kick_off_hrtimer(a,b)		do { } while (0)
 
 #endif /* !CONFIG_HIGH_RES_TIMERS */
 
