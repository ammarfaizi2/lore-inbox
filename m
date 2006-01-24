Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWAXW1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWAXW1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWAXW1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:27:19 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:64487 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750784AbWAXW1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:27:18 -0500
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 
	oops on suspend and more (bonus oops shot!)]
From: john stultz <johnstul@us.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <16839.83.103.117.254.1137581235.squirrel@picard.linux.it>
References: <20060110170037.4a614245.akpm@osdl.org>
	 <20060111184027.GB4735@inferi.kami.home>
	 <20060112220825.GA3490@inferi.kami.home>
	 <1137108362.2890.141.camel@cog.beaverton.ibm.com>
	 <20060114120816.GA3554@inferi.kami.home>
	 <1137442582.27699.12.camel@cog.beaverton.ibm.com>
	 <20060116204057.GC3639@inferi.kami.home>
	 <1137458964.27699.65.camel@cog.beaverton.ibm.com>
	 <20060117174953.GA3529@inferi.kami.home>
	 <1137525090.27699.92.camel@cog.beaverton.ibm.com>
	 <20060117224951.GA3320@inferi.kami.home>
	 <16839.83.103.117.254.1137581235.squirrel@picard.linux.it>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 14:27:14 -0800
Message-Id: <1138141635.15682.92.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 11:47 +0100, Mattia Dongili wrote:
> On Tue, January 17, 2006 11:49 pm, Mattia Dongili said:
> [...]
> > the stall is still there, tomorrow I'll reapply your debug-patch and
> > report the full dmesg (with the finished_booting-hack enabled).
> 
> Full dmesg attached.
> Stalls happened between in the 16.39-16.55 interval, in 16.70-16.96 and
> 17.89-18.64. They were all much longer than stated in the log timestamp
> (I'd say ~10:1 ratio).	
> 
> Sorry again for my previous false notice about the bug being solved...

Hey Mattia, 
	Sorry I've been so quiet recently, I'm still working on this one.  The
difficult spot is that if the cpufreq notification driver is a module,
then there will always be a window between the point at which we start
using the TSC to the point where we find out that the TSC is changing
frequency. Not sure what to do here just yet.

Although I'm curious: Did the recent changes in 2.6.16-rc1-mm2 had any
effect on this issue?

thanks
-john

