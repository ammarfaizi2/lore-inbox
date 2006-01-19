Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWASNbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWASNbN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 08:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWASNbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 08:31:13 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:25053 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161180AbWASNbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 08:31:12 -0500
Date: Thu, 19 Jan 2006 14:31:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BUILD_LOCK_OPS: cleanup preempt_disable() usage
Message-ID: <20060119133135.GA10230@elte.hu>
References: <43CFA5FD.BE1B2978@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CFA5FD.BE1B2978@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> This patch changes the code from:
> 
> 	preempt_disable();
> 	for (;;) {
> 		...
> 		preempt_disable();
> 	}
> to:
> 	for (;;) {
> 		preempt_disable();
> 		...
> 	}
> 
> which seems more clean to me and saves a couple of bytes for
> each function.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

good one!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
