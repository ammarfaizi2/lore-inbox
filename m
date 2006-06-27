Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161193AbWF0Qtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbWF0Qtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbWF0Qtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:49:52 -0400
Received: from palrel10.hp.com ([156.153.255.245]:23972 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1161193AbWF0Qtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:49:50 -0400
Date: Tue, 27 Jun 2006 09:51:25 -0700
From: Grant Grundler <iod00d@hp.com>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       perfctr-devel <perfctr-devel@lists.sourceforge.net>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       perfmon <perfmon@napali.hpl.hp.com>,
       oprofile-list <oprofile-list@lists.sourceforge.net>
Subject: Re: 2.6.17.1 new perfmon code base, libpfm, pfmon available
Message-ID: <20060627165125.GA19132@esmail.cup.hp.com>
References: <200606270159_MC3-1-C391-1A2A@compuserve.com> <20060627143204.GC16417@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627143204.GC16417@frankl.hpl.hp.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 07:32:04AM -0700, Stephane Eranian wrote:
...
> > 5006 hardware interrupts in 10 seconds, 16359 interrupt-disable events ==>
> > the kernel disabled interrupts 11353 times for critical sections.  To get
> > useful results it looks like booting with idle=poll and disabling cpufreq
> > is needed, though, since interrupts_masked_cycles (non-edge mode) counts
> > even when the CPU is halted:
> 
> Yes, I think you need to be careful with the idle thread, some events may or
> may not count when going low-power. I think it is best to avoid going
> low-power for measurements.

Any benchmarking that involves IA64 idle thread is strongly reccomended
to use "nohalt" option. It's about a 15-20% performance difference
on some interrupt intensive benchmarks (e.g. netperf TCP_RR).

If someone has measured the delta for other architectures that
go into a "low power" state in idle thread, I'd be grateful if
they posted the results or mailed them to me.

thanks,
grant
