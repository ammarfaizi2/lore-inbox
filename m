Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUJLSvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUJLSvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUJLSvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:51:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25842 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267561AbUJLSvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:51:05 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, sdietrich@mvista.com,
       linux-kernel@vger.kernel.org, abatyrshin@ru.mvista.com,
       amakarov@ru.mvista.com, emints@ru.mvista.com, ext-rt-dev@mvista.com,
       hzhang@ch.mvista.com, yyang@ch.mvista.com
In-Reply-To: <20041011204959.GB16366@elte.hu>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu>
	 <1097437314.17309.136.camel@dhcp153.mvista.com>
	 <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu>
	 <1097517191.28173.1.camel@dhcp153.mvista.com>
	 <20041011204959.GB16366@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097607049.9548.108.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Oct 2004 11:50:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 13:49, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> what do you think about the PREEMPT_REALTIME stuff in -T4? Ideally, if
> you agree with the generic approach, the next step would be to add your
> priority inheritance handling code to Linux semaphores and
> rw-semaphores. The sched.c bits for that looked pretty straightforward.
> The list walking is a bit ugly but probably unavoidable - the only other
> option would be 100 priority queues per semaphore -> yuck.


I think patch size is an issue, but I also think that , eventually, we
should change all spin_lock calls that actually lock a mutex to be more
distinct so it's obvious what is going on. Sven and I both agree that
this should be addressed. Is this a non-issue for you? What does the
community want? I don't find your code or ours acceptable in it's
current form , due to this issue.

With the addition of PREEMPT_REALTIME it looks like you more than
doubled the size of voluntary preempt. I really feel that it should
remain as two distinct patches. They are dependent , but the scope of
the changes are too vast to lump it all together. 

Daniel Walker

