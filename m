Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWEaVPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWEaVPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbWEaVPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:15:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1000 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965066AbWEaVPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:15:13 -0400
Date: Wed, 31 May 2006 23:15:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@google.com>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531211530.GA2716@elte.hu>
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531140823.580dbece.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > EIP is at check_deadlock+0x15/0xe0

> >   <c012b77b> check_deadlock+0xa5/0xe0  <c012b922> 
> > debug_mutex_add_waiter+0x46/0x55
> >   <c02d50de> __mutex_lock_slowpath+0x9e/0x1c0  <c0160061> 
> > lookup_create+0x19/0x5b
> >   <c016043a> sys_mkdirat+0x4c/0xc3  <c01604c0> sys_mkdir+0xf/0x13
> >   <c02d6217> syscall_call+0x7/0xb
> 
> Looks like the lock validator came unstuck.  But there's so much other 
> crap happening in there it's hard to tell.  Did you try it without all 
> the lockdep stuff enabled?

AFAICS this isnt the lock validator but the normal mutex debugging code 
(CONFIG_DEBUG_MUTEXES). The log does not indicate that lockdep was 
enabled.

	Ingo
