Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbUJZBZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbUJZBZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUJZBUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:20:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261908AbUJZBR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:17:57 -0400
Date: Mon, 25 Oct 2004 16:38:39 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sivanich@sgi.com, mingo@elte.hu
Subject: [PATCH] scheduler: remove redundant #ifdef [trivial]
Message-ID: <20041025233839.GA1524@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes a redundant #ifdef CONFIG_SMP that is nested within an enclosing
#ifdef CONFIG_SMP.

Signed-off-by: <paulmck@us.ibm.com>

----

 sched.c |    2 --
 1 files changed, 2 deletions(-)

diff -urpN -X ../dontdiff linux-2.5-2004.10.23/kernel/sched.c linux-2.5-2004.10.23-LBinf/kernel/sched.c
--- linux-2.5-2004.10.23/kernel/sched.c	Sat Oct 23 13:23:31 2004
+++ linux-2.5-2004.10.23-LBinf/kernel/sched.c	Sun Oct 24 10:50:12 2004
@@ -4437,14 +4437,12 @@ static void sched_domain_debug(void)
 #define sched_domain_debug() {}
 #endif
 
-#ifdef CONFIG_SMP
 /*
  * Initial dummy domain for early boot and for hotplug cpu. Being static,
  * it is initialized to zero, so all balancing flags are cleared which is
  * what we want.
  */
 static struct sched_domain sched_domain_dummy;
-#endif
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*

