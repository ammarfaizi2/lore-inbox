Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274387AbRITJ0w>; Thu, 20 Sep 2001 05:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274388AbRITJ0m>; Thu, 20 Sep 2001 05:26:42 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:3732 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S274387AbRITJ0a>;
	Thu, 20 Sep 2001 05:26:30 -0400
Date: Thu, 20 Sep 2001 14:58:54 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre12aa1 [PATCH]
Message-ID: <20010920145854.A10387@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010920094622.A729@athlon.random> Andrea Arcangeli wrote:

Hi Andrea,

Patch for 2.4.10pre12aa1 -

diff -uN sched.c.bad sched.c
--- sched.c.bad	Thu Sep 20 14:34:43 2001
+++ sched.c	Thu Sep 20 14:34:54 2001
@@ -1124,7 +1124,7 @@
 	int i;
 
 	// Subtract non-idle processes running on other CPUs.
-	for (i = 0; i < smp_num_cpus; i++)
+	for (i = 0; i < smp_num_cpus; i++) {
 		if (cpu_curr(i) != logical_idle_task(i))
 			nr_pending--;
 	}


Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
