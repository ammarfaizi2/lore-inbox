Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSGOSun>; Mon, 15 Jul 2002 14:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSGOSum>; Mon, 15 Jul 2002 14:50:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54022 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317593AbSGOSuj>; Mon, 15 Jul 2002 14:50:39 -0400
Date: Mon, 15 Jul 2002 19:53:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020715195332.C15136@flint.arm.linux.org.uk>
References: <20020715180646.B15136@flint.arm.linux.org.uk> <200207151843.g6FIh0r217981@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207151843.g6FIh0r217981@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, Jul 15, 2002 at 02:43:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 02:43:00PM -0400, Albert D. Cahalan wrote:
> Russell King writes:
> > $ grep hz_to_std arch-*/param.h
> > arch-l7200/param.h:#define hz_to_std(a) ((a * HZ)/100)
> > arch-shark/param.h:#define hz_to_std(a) ((a * HZ)/100)
> 
> Won't that overflow in 3 or 4 days?

Probably.  Someone else's problem though (who wrote those)

> > And hz_to_std gets used (fs/proc/array.c):
> >
> >                 hz_to_std(task->times.tms_utime),
> >                 hz_to_std(task->times.tms_stime),
> >                 hz_to_std(task->times.tms_cutime),
> >                 hz_to_std(task->times.tms_cstime),
> 
> Now look in the 2.4.xx kernel source.

Firstly, you can't base any assumptions about ARM from what's in the
main kernels.

It's not in the Marcelo source, but in the -rmk patch, which you need
to have a working kernel on ARM for _any_ kernel what so ever (because
I haven't yet managed to get Linus to take some trivial bits needed,
neither have I had any response why he won't take them.)

Yes, ARM has always been broken in every kernel there ever has been
from Linus/Marcelo/Alan.

The situation is improving with BK, but it's less than optimal; the
generic changes can't go through BK, therefore I can't really have a
BK tree that builds for ARM (because then the merging of csets gets
horrible.)

This all said, it looks like libproc automatically detects whatever
the kernel uses, so this is all irrelevant in the end.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

