Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVKZOyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVKZOyF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVKZOyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:54:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:22206 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964793AbVKZOyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:54:03 -0500
Date: Sat, 26 Nov 2005 15:54:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/13] Time: Generic Timekeeping Infrastructure
Message-ID: <20051126145406.GF12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013541.18537.9070.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013541.18537.9070.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up timeofday-core.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/asm-generic/timeofday.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux/include/asm-generic/timeofday.h
===================================================================
--- linux.orig/include/asm-generic/timeofday.h
+++ linux/include/asm-generic/timeofday.h
@@ -12,6 +12,7 @@
 #include <linux/clocksource.h>
 
 #include <asm/div64.h>
+
 #ifdef CONFIG_GENERIC_TIME
 /* Required externs */
 extern nsec_t read_persistent_clock(void);
@@ -22,7 +23,7 @@ extern void arch_update_vsyscall_gtod(st
 				cycle_t offset_base, struct clocksource* clock,
 				int ntp_adj);
 #else
-#define arch_update_vsyscall_gtod(x,y,z,w) {}
+# define arch_update_vsyscall_gtod(x,y,z,w) do { } while(0)
 #endif /* CONFIG_GENERIC_TIME_VSYSCALL */
 
 #endif /* CONFIG_GENERIC_TIME */
