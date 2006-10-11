Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030729AbWJKAgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030729AbWJKAgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 20:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030734AbWJKAgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 20:36:48 -0400
Received: from gw.goop.org ([64.81.55.164]:12713 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030729AbWJKAgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 20:36:47 -0400
Message-ID: <452C3CA6.2060403@goop.org>
Date: Tue, 10 Oct 2006 17:36:54 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Subject: [PATCH 2.6.19-rc1-mm1] Export jiffies_to_timespec()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export jiffies_to_timespec; previously modules used the inlined header version.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de
Cc: mingo@elte.hu
Cc: johnstul@us.ibm.com 

diff -r 821dbffe1ec5 kernel/time.c
--- a/kernel/time.c	Tue Oct 10 16:35:36 2006 -0700
+++ b/kernel/time.c	Tue Oct 10 16:35:55 2006 -0700
@@ -607,6 +607,7 @@ jiffies_to_timespec(const unsigned long 
 	u64 nsec = (u64)jiffies * TICK_NSEC;
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
 }
+EXPORT_SYMBOL(jiffies_to_timespec);
 
 /* Same for "timeval"
  *


