Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293679AbSCATyc>; Fri, 1 Mar 2002 14:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293695AbSCATy0>; Fri, 1 Mar 2002 14:54:26 -0500
Received: from users.ccur.com ([208.248.32.211]:34438 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S293681AbSCATwz>;
	Fri, 1 Mar 2002 14:52:55 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200203011951.TAA12018@rudolph.ccur.com>
Subject: Re: [RFC][PATCH] irq0 affinity broke on some i386 boxes
To: macro@ds2.pg.gda.pl
Date: Fri, 1 Mar 2002 14:51:49 -0500 (EST)
Cc: joe.korty@ccur.com (Joe Korty), mingo@chiara.elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <Pine.GSO.3.96.1020301181736.3130F-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Mar 01, 2002 06:41:41 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 25 Feb 2002, Joe Korty wrote:
>
>>   The following patch fixes a bug that prevents a write to
>> /proc/irq/0/smp_affinity from actually changing the cpu affinity
>> of IRQ #0, on all the (Dell server) SMP machines I have access to.
> 
>  A nice spotting.  However what you describe is only a side effect of the
> bug, which is the IRQ is kept registered at the wrong pin.  It's only
> because the timer is special and it's edge-triggered it remained unnoticed
> for so long.
> 
>  I propose the following patch.  [...]
>
>  I don't know if the changes are relevant to your system as you haven't
> sent the relevant fragment of a bootstrap log from your system.  They
> affect all systems that have a bogus IRQ 0 entry in the MP table.  For
> other systems the patch is equivalent to yours.  Please test it if it
> works for you as I don't have a suitable system with IRQ 0 unconnected
> (I've been able to verify it builds only).  Everyone with such a system is
> invited to test the patch as well.


Thanks.  Your proposed patch works fine on the two of my five SMP systems
I have been able to get my hands on this afternoon.

Joe

PS: My original dmesg logs may now be found at
http://www.mindspring.com/~jakorty/irq0.bugreport.orig.
