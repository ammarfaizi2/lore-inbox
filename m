Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967493AbWK2SiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967493AbWK2SiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 13:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967531AbWK2SiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 13:38:24 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:63720 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S967493AbWK2SiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 13:38:23 -0500
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20061129134311.GA14566@elte.hu>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
	 <20061128200927.GA26934@elte.hu>
	 <1164746224.15887.40.camel@cmn3.stanford.edu>
	 <1164747854.15887.48.camel@cmn3.stanford.edu>
	 <20061129134311.GA14566@elte.hu>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 10:38:18 -0800
Message-Id: <1164825498.18954.5.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 14:43 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > > > > (            japa-4096 |#0): new 17 us maximum-latency wakeup.
> > > > > (         beagled-3412 |#1): new 19 us maximum-latency wakeup.
> > > > > (          IRQ 18-1081 |#1): new 26 us maximum-latency wakeup.
> > > > > (             snd-4040 |#1): new 1107 us maximum-latency wakeup.
> > > > > (            japa-4096 |#0): new 1445 us maximum-latency wakeup.
> > > > > (            japa-4096 |#0): new 2110 us maximum-latency wakeup.
> > > > > (        qjackctl-4038 |#1): new 2328 us maximum-latency wakeup.
> > > > > (            japa-4096 |#0): new 2548 us maximum-latency wakeup.
> > > > > (          IRQ 18-1081 |#0): new 10291 us maximum-latency wakeup.
> 
> ok, i reproduced something similar on one of my boxes and it turned out 
> to be a tracer bug. I've uploaded -rt10, could you try it? (The xruns 
> will likely remain, but at least the tracer should be more usable now to 
> find out the reason for the xruns.)

I'm testing -rt10 right now (your binary rpm). Looks like the number and
length of the xruns went down, at least for now. All below 2mSec - jack
is running 128x2 @ 48000Hz. I'll let it run for a while and report the
traces (I have a script that collects all traces above 60us, but not all
xruns trigger a trace). 

-- Fernando


