Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315447AbSELW4u>; Sun, 12 May 2002 18:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315448AbSELW4u>; Sun, 12 May 2002 18:56:50 -0400
Received: from pool-151-201-36-168.pitt.east.verizon.net ([151.201.36.168]:50816
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id <S315447AbSELW4s>; Sun, 12 May 2002 18:56:48 -0400
Date: Sun, 12 May 2002 18:57:09 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Jennifer Huang <carrothh@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about cpu time accuracy.
Message-ID: <20020512185709.C623@marta>
Mail-Followup-To: Kurt Wall <kwall>, Jennifer Huang <carrothh@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020512223710.41173.qmail@web20109.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scribbling feverishly on May 12, Jennifer Huang managed to emit:
> Hi all,
> 
> I have a question about cpu time accuracy.
> 
> I am using kernel 2.4.18. But, when I tried "utime"
> and "nanosleep" to get a process suspended, it only
> worked in 10ms granularity, and it's no way to sleep
> for 1 microsecond.

The standard kernel timer has a resolution of 1/HZ, which is 10ms on 
an x86. You could try a scheduling policy of SCHED_FIFO or SCHED_RR,
but this only gets you 2ms resolution. 

> Anyone can help me out of this?

There are patches available for high resolution timers:

http://sourceforge.net/projects/high-res-timers/
http://www.cs.wisc.edu/paradyn/libhrtime/

Kurt
-- 
Anarchy may not be the best form of government, but it's better than no
government at all.
