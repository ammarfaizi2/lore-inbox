Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWEKByj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWEKByj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 21:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWEKByj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 21:54:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:39590 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965117AbWEKByi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 21:54:38 -0400
Subject: Re: [PATCHSET] Time: Generic Timekeeping Subsystem (v C2)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Tim Mann <mann@vmware.com>,
       Jim Cromie <jim.cromie@gmail.com>
In-Reply-To: <1147305476.12500.3.camel@localhost.localdomain>
References: <1147305476.12500.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 May 2006 18:54:36 -0700
Message-Id: <1147312476.12500.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 16:57 -0700, john stultz wrote:
> All,
> 	Here is an updated version of the smaller, reworked and improved
> patchset, most of which is currently in -mm. 

Tim pointed out I had a typo in apm.c that kept it from building. The
following fix is need (I'll be making a silent update of the release on
the web site).

thanks
-john

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index 25d5ef4..5811438 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1154,7 +1154,7 @@ static void set_time(void)
 	if (got_clock_diff) {	/* Must know time zone in order to set clock */
 		ts.tv_sec = get_cmos_time() + clock_cmos_diff;
 		ts.tv_nsec = 0;
-		do_settimeofday(&ts)
+		do_settimeofday(&ts);
 	} 
 }
 


