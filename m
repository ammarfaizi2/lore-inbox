Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbTAUUVF>; Tue, 21 Jan 2003 15:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267212AbTAUUVF>; Tue, 21 Jan 2003 15:21:05 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:26593 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267209AbTAUUVE>; Tue, 21 Jan 2003 15:21:04 -0500
Date: Tue, 21 Jan 2003 12:30:03 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121203002.GH20972@ca-server1.us.oracle.com>
References: <200301210135.h0L1ZFa06867@eng2.beaverton.ibm.com> <1043113336.32478.97.camel@w-jstultz2.beaverton.ibm.com> <20030121020015.GQ20972@ca-server1.us.oracle.com> <1043117157.32472.116.camel@w-jstultz2.beaverton.ibm.com> <20030121172941.GT20972@ca-server1.us.oracle.com> <1043179438.15689.36.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043179438.15689.36.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 12:03:58PM -0800, john stultz wrote:
> boxes), might you consider continuing using get_cycles() for now,
> however place it behind a my_gettimeofday() function. That way, once
> this issue is fixed, we can just do a simple
> s/my_gettimeofday/do_gettimeofday on your code and be done with it?

	I'll look at that.  It's not as convenient an interface as one
long long, though.  :-)

> Oh yea, one more thing: I gave the earlier released 2.4 module a whirl,
> and the printk() before machine_restart() never gets flushed out to the
> logs. Makes it a bit confusing if you are trying to determine if the
> hangcheck module or something else bounced the box. 

	What kernel were you running?  I've seen printk()s get lost on a
couple Red Hat kernels, but not on vanilla.  That's not to say it can't
happen, of course.

Joel

-- 

Life's Little Instruction Book #274

	"Leave everything a little better than you found it."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
