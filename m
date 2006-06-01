Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWFAXIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWFAXIC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWFAXIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:08:01 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:32973 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750866AbWFAXIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:08:00 -0400
Date: Thu, 1 Jun 2006 16:10:10 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: dwalker@mvista.com, James Perkins <james.perkins@windriver.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH-rt]: Add missing headers to clocksource.h
Message-ID: <20060601231010.GA21704@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rt26 won't compile w/o this if GENERIC_TIME is set.

Index: linux-2.6-rt/kernel/time/clockevents.c
===================================================================
--- linux-2.6-rt.orig/kernel/time/clockevents.c
+++ linux-2.6-rt/kernel/time/clockevents.c
@@ -23,10 +23,12 @@
 
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
+#include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/notifier.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/profile.h>
 #include <linux/sysdev.h>
 #include <linux/hrtimer.h>
 
-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
