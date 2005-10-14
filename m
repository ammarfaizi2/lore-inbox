Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVJNFet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVJNFet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 01:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJNFet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 01:34:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4008 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751312AbVJNFes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 01:34:48 -0400
Date: Fri, 14 Oct 2005 07:35:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Singleton <dsingleton@mvista.com>
Cc: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Robust Futex update
Message-ID: <20051014053516.GA21579@elte.hu>
References: <434DA382.1050100@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434DA382.1050100@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Singleton <dsingleton@mvista.com> wrote:

> Ingo,
>    here 's a patch for 2.6.14-rc4-rt1 that fixes two things:
> 
> 1) Deregister futex returns -EBUSY instead of -EINVAL if a thread 
> tries to deregister a pthread_mutex that another thread has locked.
> 
> 2) Make the fast path robust.  If a pthread_mutex is only locked in 
> user space we need to clear the owner when the thread dies.  This 
> makes both the 'rt_mutex is locked in the kernel' and the 
> 'pthread_mutex is only locked in user space' paths robust.

thanks, applied.

	Ingo
