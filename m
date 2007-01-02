Return-Path: <linux-kernel-owner+w=401wt.eu-S965125AbXABXkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbXABXkK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbXABXkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:40:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46083 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965125AbXABXkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:40:09 -0500
Date: Wed, 3 Jan 2007 00:36:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch] profiling: fix sched profiling typo
Message-ID: <20070102233642.GA16490@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] profiling: fix sched profiling typo
From: Ingo Molnar <mingo@elte.hu>

fix sched profiling typo, introduced by the sleep profiling patch. This 
bug caused profile=sched to not work.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/profile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/profile.c
===================================================================
--- linux.orig/kernel/profile.c
+++ linux/kernel/profile.c
@@ -64,7 +64,7 @@ static int __init profile_setup(char * s
 		printk(KERN_INFO
 			"kernel sleep profiling enabled (shift: %ld)\n",
 			prof_shift);
-	} else if (!strncmp(str, sleepstr, strlen(sleepstr))) {
+	} else if (!strncmp(str, schedstr, strlen(schedstr))) {
 		prof_on = SCHED_PROFILING;
 		if (str[strlen(schedstr)] == ',')
 			str += strlen(schedstr) + 1;
