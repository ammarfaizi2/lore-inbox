Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTLNJk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 04:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTLNJk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 04:40:58 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:38569 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263573AbTLNJk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 04:40:56 -0500
Message-ID: <3FDC3023.9030708@cyberone.com.au>
Date: Sun, 14 Dec 2003 20:40:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][RFC] HT scheduler
References: <20031213022038.300B22C2C1@lists.samba.org> <3FDAB517.4000309@cyberone.com.au> <brgeo7$huv$1@gatekeeper.tmr.com> <3FDBC876.3020603@cyberone.com.au> <20031214043245.GC21241@mail.shareable.org>
In-Reply-To: <20031214043245.GC21241@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamie Lokier wrote:

>Nick Piggin wrote:
>
>>>Shared runqueues sound like a simplification to describe execution units
>>>which have shared resourses and null cost of changing units. You can do
>>>that by having a domain which behaved like that, but a shared runqueue
>>>sounds better because it would eliminate the cost of even considering
>>>moving a process from one sibling to another.
>>>
>>You are correct, however it would be a miniscule cost advantage,
>>possibly outweighed by the shared lock, and overhead of more
>>changing of CPUs (I'm sure there would be some cost).
>>
>
>Regarding the overhead of the shared runqueue lock:
>
>Is the "lock" prefix actually required for locking between x86
>siblings which share the same L1 cache?
>

That lock is still taken by other CPUs as well for eg. wakeups, balancing,
and so forth. I guess it could be a very specific optimisation for
spinlocks in general if there was only one HT core. Don't know if it
would be worthwhile though.


