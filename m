Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319098AbSIJLj1>; Tue, 10 Sep 2002 07:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319099AbSIJLj1>; Tue, 10 Sep 2002 07:39:27 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:34950 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S319098AbSIJLj1>; Tue, 10 Sep 2002 07:39:27 -0400
Date: Tue, 10 Sep 2002 13:12:43 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       george anzinger <george@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC][PATCH] linux-2.5.34_timer-change_A2
Message-ID: <20020910131242.C960@linux-m68k.org>
References: <1031604509.24775.206.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1031604509.24775.206.camel@cog>; from johnstul@us.ibm.com on Mon, Sep 09, 2002 at 01:48:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 01:48:29PM -0700, john stultz wrote:
> Just a resync/resend:
> 
> Hi all,
>         Here is my timer-change patch resynced with 2.5.34. As I said
> before, this patch breaks up arch/i386/kernel/time.c into various
> timer_pit, timer_tsc chunks. The hope is to cleanup the existing code so
> it doesn't care what type of clock is providing the high-resolution
> offset for gettimeofday. This will also simplify adding support for my
> cyclone-timer patch as well as ACPI pm timer or any other high res
> counter. 

while at it, could we also finaly drop the broken CMOS clock 
update "feature" from arch/*/kenrel/time.c?

It was already mentioned a few times on this list and iirc there 
was never any argument against removing it.
In short the code does nothing that couldn't be done much better 
from userspace, it implements policy that belongs into userspace
and wastes time in an interrupt handler.

At least one architecture has it already completely disabled.

Richard
