Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTICO2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbTICO2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:28:05 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:20026 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262364AbTICO2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:28:00 -0400
Subject: Re: Scaling noise
From: Steven Cole <elenstev@mesatop.com>
To: Larry McVoy <lm@bitmover.com>
Cc: CaT <cat@zip.com.au>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030903050859.GD10257@work.bitmover.com>
References: <20030903040327.GA10257@work.bitmover.com>
	 <20030903041850.GA2978@krispykreme>
	 <20030903042953.GC10257@work.bitmover.com>
	 <20030903043355.GC2019@zip.com.au>
	 <20030903050859.GD10257@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1062599136.1724.84.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 03 Sep 2003 08:25:36 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-02 at 23:08, Larry McVoy wrote:
> On Wed, Sep 03, 2003 at 02:33:56PM +1000, CaT wrote:
> > I think Anton is referring to the fact that on a 4-way cpu machine with
> > HT enabled you basically have an 8-way smp box (with special conditions)
> > and so if 4-way machines are becoming more popular, making sure that 8-way
> > smp works well is a good idea.
> 
> Maybe this is a better way to get my point across.  Think about more CPUs
> on the same memory subsystem.  I've been trying to make this scaling point
> ever since I discovered how much cache misses hurt.  That was about 1995
> or so.  At that point, memory latency was about 200 ns and processor speeds
> were at about 200Mhz or 5 ns.  Today, memory latency is about 130 ns and
> processor speeds are about .3 ns.  Processor speeds are 15 times faster and
> memory is less than 2 times faster.  SMP makes that ratio worse.
> 
> It's called asymptotic behavior.  After a while you can look at the graph
> and see that more CPUs on the same memory doesn't make sense.  It hasn't
> made sense for a decade, what makes anyone think that is changing?

You're right about the asymptotic behavior and you'll just get more
right as time goes on, but other forces are at work.

What is changing is the number of cores per 'processor' is increasing. 
The Intel Montecito will increase this to two, and rumor has it that the
Intel Tanglewood may have as many as sixteen.  The IBM Power6 will
likely be similarly capable.

The Tanglewood is not some far off flight of fancy; it may be available
as soon as the 2.8.x stable series, so planning to accommodate it should
be happening now.  

With companies like SGI building Altix systems with 64 and 128 CPUs
using the current single-core Madison, just think of what will be
possible using the future hardware. 

In four years, Michael Dell will still be saying the same thing, but
he'll just fudge his answer by a factor of four. 

The question which will continue to be important in the next kernel
series is: How to best accommodate the future many-CPU machines without
sacrificing performance on the low-end?  The change is that the 'many'
in the above may start to double every few years.

Some candidate answers to this have been discussed before, such as
cache-coherent clusters.  I just hope this gets worked out before the
hardware ships.

Steven

