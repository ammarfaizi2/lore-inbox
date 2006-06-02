Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWFBL5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWFBL5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 07:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWFBL5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 07:57:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:57229 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751204AbWFBL5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 07:57:53 -0400
Date: Fri, 2 Jun 2006 13:58:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fall back to old-style call trace if no unwinding is possible
Message-ID: <20060602115814.GA29453@elte.hu>
References: <448042C1.76E4.0078.0@novell.com> <20060602115709.GA29066@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602115709.GA29066@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5189]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> hm, could you please merge this ontop of the stacktrace-output 
> beautification patch below that Andrew already has in his post-mm2 
> tree? (or the other way around - whichever you prefer)

which also needs the following addon.

	Ingo

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -292,7 +292,6 @@ void show_trace(struct task_struct *tsk,
 			 * out the call path that was taken. \
 			 */ \
 			printk_address(addr); \
-			printk("\n"); \
 		} \
 	} while (0)
 
