Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932950AbWFZTbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950AbWFZTbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWFZTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:31:24 -0400
Received: from palrel10.hp.com ([156.153.255.245]:43476 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932946AbWFZTbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:31:23 -0400
Date: Mon, 26 Jun 2006 12:32:56 -0700
From: Grant Grundler <iod00d@hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Stephane Eranian <eranian@hpl.hp.com>,
       oprofile-list <oprofile-list@lists.sourceforge.net>,
       perfmon <perfmon@napali.hpl.hp.com>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       perfctr-devel <perfctr-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17.1 new perfmon code base, libpfm, pfmon available
Message-ID: <20060626193256.GE14684@esmail.cup.hp.com>
References: <200606261336_MC3-1-C384-7981@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606261336_MC3-1-C384-7981@compuserve.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 01:33:03PM -0400, Chuck Ebbert wrote:
> 32-bit works great.  Unfortunately, pfmon is far too limited for serious
> kernel monitoring AFAICT.

I think "far too limited for serious kernel monitoring" is not a fair
statement. One can do some very interesting things as I presented
two years ago at OLS:
	http://iou.parisc-linux.org/ols_2004/pfmon_for_iodorks.pdf

It's just a _very_ complex subsystem and has a steep learning curve
to do some of the more complex things that one might like.

> E.g. you can't select edge counting instead
> of cycle counting.  So you can count how many clock cycles were spent
> with interrupts disabled but you can't count how many times they were
> disabled.

At first glance, this example sounds more like a limitation of the HW
and not the SW.

> And is someone working on kernel profiling tools that use the perfmon2
> infrastructure on i386?  I'd like to see kernel-based profiling that lets
> you use something like the existing 'readprofile' to retrieve results.  This
> would be a lot better than the current timer-based profiling.

Both are useful. I wouldn't say one of necessarily better.
FWIW, the "CPU_CYCLES" counts from pfmon aren't timer based on ia64.
AFAIK, the HW counters are sampled to gather those counts.

thanks,
grant
