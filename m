Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279264AbRKIFL4>; Fri, 9 Nov 2001 00:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRKIFLq>; Fri, 9 Nov 2001 00:11:46 -0500
Received: from [202.135.142.195] ([202.135.142.195]:1803 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S279277AbRKIFLg>; Fri, 9 Nov 2001 00:11:36 -0500
Date: Fri, 9 Nov 2001 14:12:15 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-Id: <20011109141215.08d33c96.rusty@rustcorp.com.au>
In-Reply-To: <p731yj8kgvw.fsf@amdsim2.suse.de>
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0111081836080.15975-100000@localhost.localdomain.suse.lists.linux.kernel>
	<p731yj8kgvw.fsf@amdsim2.suse.de>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Nov 2001 00:00:19 +0100
Andi Kleen <ak@suse.de> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> > 
> > we should fix this by trying to allocate continuous physical memory if
> > possible, and fall back to vmalloc() only if this allocation fails.
> 
> Check -aa. A patch to do that has been in there for some time now.
> 
> -Andi
> 
> P.S.: It makes a measurable difference with some Oracle benchmarks with
> the Qlogic driver.

Modules have lots of little disadvantages that add up.  The speed penalty
on various platforms is one, the load/unload race complexity is another.

There's a widespread "modules are free!" mentality: they're not, and we
can add complexity trying to make them "free", but it might be wiser to
realize that dynamic adding and deleting from a running kernel is a
problem on par with a pagagble kernel, and may not be the greatest thing
since sliced bread.

Rusty.
