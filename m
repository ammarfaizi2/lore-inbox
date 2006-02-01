Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422861AbWBASdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422861AbWBASdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWBASdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:33:10 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:30099 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422861AbWBASdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:33:09 -0500
Subject: Re: 2.6.15-rt16
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <williams@redhat.com>
Cc: linux-kernel@vger.kernel.org, chris perkins <cperkins@OCF.Berkeley.EDU>
In-Reply-To: <1138730835.5959.3.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
	 <1138730835.5959.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 13:32:50 -0500
Message-Id: <1138818770.6685.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 12:07 -0600, Clark Williams wrote:
> On Tue, 2006-01-31 at 09:52 -0800, chris perkins wrote:
> > > <snip>
> > >
> > >> CONFIG_LATENCY_TIMING=y
> > >
> > > I'm betting this is the same thing I'm seeing. Are you running on a
> > > uniprocessor x86_64? And if so are you seeing messages similar to the
> > > following?
> > >
> > > init[1]: segfault at ffffffff8010fadc rip ffffffff8010fadc rsp
> > > 00007fffffdacfc8
> > >
> > > If so, then I suspect that you're getting a segfault in ld.so (at least
> > > that's the furthest I've gotten so far). Something about how the kernel
> > > sets up the memory map is upsetting dynamically loaded executables. I
> > > can boot with init=/sbin/sash, but when I try and run a dynamically
> > > linked program, I get segfaults.
> > >
> > > You might try turning off LATENCY_TRACING and see if that allows you to
> > > boot and run (works for me).
> > >
> > > Meanwhile, I'm going to try and pin this down to something better than
> > > "somewhere in ld.so..."
> > >
> > > Clark
> > > -
> > > Clark Williams <williams@redhat.com>
> > 
> > hi,
> >    actually i'm running on a dual processor x86_64. with the problem i was 
> > having, i never got far enough to see the message you asked about. Steven 
> > Rostedt's suggestion to turn off NUMA worked and i am now able to boot. 
> > However, if I turn LATENCY_TRACING on, i get an immediate reboot after the 
> > kernel is uncompressed. this doesn't sound like the same problem you're 
> > having, though.
> 
> Man, I saw that LATENCY_TRACING and completely missed the NUMA
> parameter. Sorry about that...
> 
> I must be the only person running a uniprocessor x86_64 that's working
> with the -rt patches and trying to trace latencies. If I turn off
> LATENCY_TRACING, I boot just fine. 
> 
> Are you getting any output from the kernel before the reboot?

I'm still curious to what's happening with your kernel.  I'm currently
running my x86_64 (typing right now on it) with CONFIG_SMP=n and
CONFIG_LATENCY=y.  I know you probably sent a config before, but could
you send it to me again.  (probably best to send it to me off list)

Thanks,

-- Steve


