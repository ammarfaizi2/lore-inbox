Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVFAMTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVFAMTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFAMTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:19:22 -0400
Received: from [195.23.16.24] ([195.23.16.24]:16778 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261360AbVFAMTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:19:16 -0400
Message-ID: <429DA7AE.5000304@grupopie.com>
Date: Wed, 01 Jun 2005 13:18:54 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Esben Nielsen <simlo@phys.au.dk>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random>
In-Reply-To: <20050531204544.GU5413@g5.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
>[...]
> Plus with RTAI we don't depend on scheduler to do the right thing etc...
> that suff can break when somebody tweak the scheduler for some smp
> scalability bit or something like that (just watch currently Linus and
> Ingo going after a scheduler bug that hangs the system, that would crash
> a system with preempt-RT but RTAI would keep going without noticing
> since it gets irq even when irqs are locally disabled), while it sounds
> harder to break the nanokernel thing that depends on hardware feature
> and unmaskable irqs.

It seems you didn't follow that thread too closely :)

The problem on that thread is that most of the processes running on the 
system have the same priority, and the way wine works is giving it an 
interactive priority bonus that makes it run preferentially over other 
processes with the "same" priority.

This wouldn't affect real-time tasks running over preempt-RT at all, 
since the interactive bonus would never be enough to go over real-time 
priority tasks.

I do understand the point you're trying to make about the simplicity of 
a nano-kernel that makes it much more reliable and verifiable.

However it seems that the range of applications that can use the 
nano-kernel approach is getting pretty thin between the applications 
that are so simple that they can run on a dedicated hardware/processor 
without any OS at all, and the applications that require more complex 
services than those that a nanokernel can provide by itself.

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
