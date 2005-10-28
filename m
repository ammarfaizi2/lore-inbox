Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVJ1JAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVJ1JAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbVJ1JAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:00:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6325 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965184AbVJ1JAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:00:20 -0400
Date: Fri, 28 Oct 2005 11:00:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Bowler <jbowler@acm.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.14-rc5-mm1 net/ipv4/route.c: spin_unlock call fails to compile
Message-ID: <20051028090042.GC14842@elte.hu>
References: <001401c5db8e$650bd380$1001a8c0@kalmiopsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401c5db8e$650bd380$1001a8c0@kalmiopsis>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Bowler <jbowler@acm.org> wrote:

>  #else
> -# define rt_hash_lock_addr(slot) NULL
> +# define rt_hash_lock_addr(slot) ((spinlock_t*)NULL)
>  # define rt_hash_lock_init()

looks good to me - it gives (slightly) more type safety too.

	Ingo
