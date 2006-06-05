Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751402AbWFEUIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWFEUIg (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWFEUIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:08:36 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:6026 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751402AbWFEUIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:08:35 -0400
Date: Mon, 5 Jun 2006 22:08:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
        mbligh@google.com, akpm@osdl.org, apw@shadowen.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605200800.GA15762@elte.hu>
References: <44845C27.3000006@google.com> <20060605194422.GB14709@elte.hu> <20060605130039.db1ac80c.rdunlap@xenotime.net> <20060605200554.GB6143@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605200554.GB6143@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5332]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Jones <davej@redhat.com> wrote:

>  > kernel/mutex-debug.c:
>  > void debug_mutex_free_waiter(struct mutex_waiter *waiter)
>  > {
>  > 	DEBUG_WARN_ON(!list_empty(&waiter->list));
>  > 	memset(waiter, 0x22, sizeof(*waiter));
>  > }
> 
> Documentation/magic-number.txt sounds so promising, but we scatter 
> definitions of numbers all over the place. (No mention of the slab 
> poison values, or similar numbers there for eg, and various pointers 
> to _other_ lists of magic numbers).

we've also got include/linux/poison.h - i'll move this value there.

	Ingo
