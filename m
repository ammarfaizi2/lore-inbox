Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVDCSB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVDCSB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 14:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVDCSB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 14:01:57 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:50826 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261843AbVDCSBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 14:01:55 -0400
Subject: Re: kernel stack size
From: Steven Rostedt <rostedt@goodmis.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <424F96DD.2070307@colorfullife.com>
References: <424EFD2A.6060305@colorfullife.com>
	 <1112480132.27149.55.camel@localhost.localdomain>
	 <424F96DD.2070307@colorfullife.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 03 Apr 2005 14:01:44 -0400
Message-Id: <1112551304.27149.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-03 at 09:10 +0200, Manfred Spraul wrote:

> Yes - sem or spin locks are quicker as long as no cache line transfers 
> are necessary. If the semaphore is accessed by multiple cpus, then 
> kmalloc would be faster: slab tries hard to avoid taking global locks. 
> I'm not speaking about contention, just the cache line ping pong for 
> acquiring a free semaphore.

Without contention, is there still a problem with cache line ping pong
of acquiring a free semaphore?

I mean, say only one task is using a given semaphore. Is there still
going to be cache line transfers for acquiring it? Even if the task in
question stays on a CPU. Is the "LOCK" on an instruction that expensive
even if the other CPUs haven't accessed that location of memory.

Sorry for my ignorance, I don't know all the interworkings of the Cache
on SMP systems.  Is there any good references on the Internet? I
definitely want to know so that my coding practices for SMP improve. 

Thanks,

-- Steve


