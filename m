Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968829AbWLGJ2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968829AbWLGJ2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968832AbWLGJ2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:28:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45426 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968829AbWLGJ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:28:38 -0500
Date: Thu, 7 Dec 2006 10:27:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] lockdep: clean up VERY_VERBOSE define
Message-ID: <20061207092745.GA1042@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00,UPPERCASE_25_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
	0.0 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: clean up VERY_VERBOSE define
From: Ingo Molnar <mingo@elte.hu>

cleanup: the VERY_VERBOSE define was unnecessarily dependent
on #ifdef VERBOSE - while the VERBOSE switch is 0 or 1 (always
defined).

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -152,9 +152,7 @@ EXPORT_SYMBOL(lockdep_internal);
  */
 
 #define VERBOSE			0
-#ifdef VERBOSE
-# define VERY_VERBOSE		0
-#endif
+#define VERY_VERBOSE		0
 
 #if VERBOSE
 # define HARDIRQ_VERBOSE	1
