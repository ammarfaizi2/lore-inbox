Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131528AbRCXBT1>; Fri, 23 Mar 2001 20:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131530AbRCXBTR>; Fri, 23 Mar 2001 20:19:17 -0500
Received: from monza.monza.org ([209.102.105.34]:55812 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131528AbRCXBTL>;
	Fri, 23 Mar 2001 20:19:11 -0500
Date: Fri, 23 Mar 2001 17:18:04 -0800
From: Tim Wright <timw@splhi.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: fix comments in <linux/timer.h>
Message-ID: <20010323171804.F2534@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micro patchlet :-)
In wandering around the kernel recently, I found that <linux/timer.h>
contains stale comments at the head of the file relating to the old static
timers which were deleted for 2.4.
So, here's a trivial patch to try to bring things back in sync.

Regards,

Tim


--- timer.h.2.4.2	Fri Mar 23 13:57:51 2001
+++ timer.h	Fri Mar 23 14:07:00 2001
@@ -5,17 +5,13 @@
 #include <linux/list.h>
 
 /*
- * This is completely separate from the above, and is the
- * "new and improved" way of handling timers more dynamically.
- * Hopefully efficient and general enough for most things.
+ * In Linux 2.4, static timers have been removed from the kernel.
+ * Timers may be dynamically created and destroyed, and should be initialized
+ * by a call to init_timer() upon creation.
  *
- * The "hardcoded" timers above are still useful for well-
- * defined problems, but the timer-list is probably better
- * when you need multiple outstanding timers or similar.
- *
- * The "data" field is in case you want to use the same
- * timeout function for several timeouts. You can use this
- * to distinguish between the different invocations.
+ * The "data" field enables use of a common timeout function for several
+ * timeouts. You can use this field to distinguish between the different
+ * invocations.
  */
 struct timer_list {
 	struct list_head list;


-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
