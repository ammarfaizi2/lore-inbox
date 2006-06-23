Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932914AbWFWHbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbWFWHbz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932917AbWFWHby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:31:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46055 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932914AbWFWHbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:31:52 -0400
Date: Fri, 23 Jun 2006 09:26:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: kernel/lockdep.c: write-only variables
Message-ID: <20060623072656.GC29321@elte.hu>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622155230.GG9111@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622155230.GG9111@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5008]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> The following variables in kernel/lockdep.c are write-only:
>   nr_hardirq_read_safe_locks
>   nr_hardirq_read_unsafe_locks
>   nr_hardirq_safe_locks
>   nr_hardirq_unsafe_locks
>   nr_softirq_read_safe_locks
>   nr_softirq_read_unsafe_locks
>   nr_softirq_safe_locks
>   nr_softirq_unsafe_locks
> 
> Is a usage pending or should they be removed?

they are stale - i'll remove them. (there's a new calculation method for 
them)

	Ingo
