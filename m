Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVGEVsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVGEVsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVGEVrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:47:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19345 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261978AbVGEVkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:40:19 -0400
Date: Tue, 5 Jul 2005 23:40:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix printk format vs argument warning
Message-ID: <20050705214004.GA11695@elte.hu>
References: <1284.1120593819@warthog.cambridge.redhat.com> <20050705143348.29348633.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705143348.29348633.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> calibrate_migration_costs() causes a storm of boot-time output and I 
> think all those printks should be removed before this code goes up to 
> Linus.  Maybe split out into a separate -mm-only patch?

it was only a debugging measure. Patch below turns off.

------
turn off migration debugging.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-sched-curr/kernel/sched.c
===================================================================
--- linux-sched-curr.orig/kernel/sched.c
+++ linux-sched-curr/kernel/sched.c
@@ -5043,7 +5043,7 @@ __init static unsigned long domain_dista
 	return distance;
 }
 
-static __initdata unsigned int migration_debug = 1;
+static __initdata unsigned int migration_debug = 0;
 
 static int __init setup_migration_debug(char *str)
 {
