Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWDDOCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWDDOCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 10:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWDDOCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 10:02:18 -0400
Received: from mail1.utc.com ([192.249.46.190]:39127 "EHLO mail1.utc.com")
	by vger.kernel.org with ESMTP id S932202AbWDDOCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 10:02:18 -0400
Message-ID: <44327C48.80200@cybsft.com>
Date: Tue, 04 Apr 2006 09:01:44 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RT] 2.6.16-rt12 hrtimer compile error
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------000400060900060803090901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000400060900060803090901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The attached patch is necessary to build 2.6.16-rt12 with
CONFIG_HIGH_RES_TIMERS disabled.

-- 
   kr


--------------000400060900060803090901
Content-Type: text/x-patch;
 name="hrtdef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtdef.patch"

--- linux-2.6.16/kernel/hrtimer.h.orig	2006-04-04 08:50:14.000000000 -0500
+++ linux-2.6.16/kernel/hrtimer.h	2006-04-04 08:50:18.000000000 -0500
@@ -207,6 +207,7 @@
 # define hrtimer_init_hres(c)		do { } while (0)
 # define hrtimer_init_timer_hres(t)	do { } while (0)
 # define hrtimer_update_timer_prio(t)	do { } while (0)
+# define hrtimer_adjust_softirq_prio(b)	do { } while (0)
 
 static inline void hrtimer_init_base(struct hrtimer_base *base)
 {

--------------000400060900060803090901--
