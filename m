Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbVHYVyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVHYVyG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVHYVyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:54:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12483 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964867AbVHYVyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:54:05 -0400
Date: Thu, 25 Aug 2005 23:54:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc7-rt1
Message-ID: <20050825215451.GA7479@elte.hu>
References: <20050825062651.GA26781@elte.hu> <1125006373.10901.11.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125006373.10901.11.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> @@ -257,6 +257,7 @@ void check_preempt_wakeup(struct task_st
>  	 * hangs and race conditions.
>  	 */
>  	if (!preempt_count() &&
> +		!__raw_irqs_disabled() &&
>  		p->prio < current->prio &&
>  		rt_task(p) &&
>  		(current->rcu_read_lock_nesting != 0 ||

did you get a false positive? If yes, in what code/driver?

	Ingo
