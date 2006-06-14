Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWFNQ2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWFNQ2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWFNQ2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:28:15 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:26100 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S964906AbWFNQ2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:28:15 -0400
Message-Id: <20060614162638.570305000@mvista.com>
User-Agent: quilt/0.45-1
Date: Wed, 14 Jun 2006 09:26:38 -0700
From: dwalker@mvista.com
To: tglx@linutronix.de
Cc: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] white space damage in clockevents.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing some tabs ..

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/time/clockevents.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.16/kernel/time/clockevents.c
===================================================================
--- linux-2.6.16.orig/kernel/time/clockevents.c
+++ linux-2.6.16/kernel/time/clockevents.c
@@ -473,7 +473,7 @@ int __init setup_global_clockevent(struc
 int clockevents_next_event_available(void)
 {
 	struct local_events *sources = &__get_cpu_var(local_eventsources);
-        int i;
+	int i;
 
 	if (!sources->nextevt)
 		return 0;
@@ -489,13 +489,13 @@ int clockevents_next_event_available(voi
 	 * have switched off one of the capability flags.
 	 */
 	for (i = 0; i < sources->installed; i++) {
-                if (sources->nextevt != sources->events[i].event)
-                        continue;
+		if (sources->nextevt != sources->events[i].event)
+			continue;
 
-	        if (sources->events[i].real_caps & ~CLOCK_CAP_NEXTEVT)
-        		return CLOCK_EVT_SCHEDTICK;
+		if (sources->events[i].real_caps & ~CLOCK_CAP_NEXTEVT)
+			return CLOCK_EVT_SCHEDTICK;
 		return CLOCK_EVT_NOTICK;
-        }
+	}
 	return CLOCK_EVT_NOTICK;
 }
 
@@ -527,7 +527,7 @@ int clockevents_set_next_event(ktime_t e
 		delta = sources->nextevt->min_delta_ns;
 
 #ifndef CONFIG_IA64
- 	clc = mpy_sc32((unsigned long) delta, sources->nextevt->mult);
+	clc = mpy_sc32((unsigned long) delta, sources->nextevt->mult);
 #else
 	clc = (unsigned long) delta * (unsigned long) sources->nextevt->mult;
 	clc = clc >> sources->nextevt->shift;
--
