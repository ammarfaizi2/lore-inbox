Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUGQSwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUGQSwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 14:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUGQSwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 14:52:49 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23773 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261378AbUGQSwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 14:52:47 -0400
Date: Sat, 17 Jul 2004 20:52:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Move cache_reap out of timer context
Message-ID: <20040717185256.GA5815@elte.hu>
References: <20040714180942.GA18425@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714180942.GA18425@sgi.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dimitri Sivanich <sivanich@sgi.com> wrote:

> I'm submitting two patches associated with moving cache_reap
> functionality out of timer context.  Note that these patches do not
> make any further optimizations to cache_reap at this time.
> 
> The first patch adds a function similiar to schedule_delayed_work to
> allow work to be scheduled on another cpu.
> 
> The second patch makes use of schedule_delayed_work_on to schedule
> cache_reap to run from keventd.
> 
> These patches apply to 2.6.8-rc1.
> 
> Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

looks good to me and i agree with moving this unbound execution-time
function out of irq context. I suspect this should see some -mm testing
first/too?

	Ingo
