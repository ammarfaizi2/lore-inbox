Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287334AbRL3ELm>; Sat, 29 Dec 2001 23:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287336AbRL3ELd>; Sat, 29 Dec 2001 23:11:33 -0500
Received: from wantadilla.lemis.com ([192.109.197.80]:24837 "HELO
	wantadilla.lemis.com") by vger.kernel.org with SMTP
	id <S287334AbRL3ELQ>; Sat, 29 Dec 2001 23:11:16 -0500
Date: Thu, 27 Dec 2001 17:50:33 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New per-cpu patch v2.5.1
Message-Id: <20011227175033.13e1fcd0.rusty@rustcorp.com.au>
In-Reply-To: <20011220174335.A10791@in.ibm.com>
In-Reply-To: <20011220174335.A10791@in.ibm.com>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001 17:43:35 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> Hi Rusty,
> 
> I appreciate the noble gesture of allowing NUMA people to
> locate the per-cpu areas in different places in memory ;-)
> 
> That said, memcpy of static per-cpu areas doesn't seem right.
> Why copy the same area to all the dynamically allocated per-cpu
> areas ?

Initialization.  Sure, we can't do it with the current macros...

> Also, shouldn't the size be &__per_cpu_end - &__per_cpu_start ?

Oops...  Yes.  (I wrote this just before my Xmas break, and didn't have time
to test it).

> And how do we use this with per-cpu data used right
> from smp boot, say apic_timer_irqs[] ?

No.  You can't have everthing (without going into the arch-specific code).

Cheers,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
