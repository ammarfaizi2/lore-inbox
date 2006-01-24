Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWAXXES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWAXXES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWAXXES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:04:18 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:65484 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750817AbWAXXER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:04:17 -0500
Date: Wed, 25 Jan 2006 00:04:54 +0100
From: Mattia Dongili <malattia@linux.it>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
Message-ID: <20060124230453.GA6174@inferi.kami.home>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1137108362.2890.141.camel@cog.beaverton.ibm.com> <20060114120816.GA3554@inferi.kami.home> <1137442582.27699.12.camel@cog.beaverton.ibm.com> <20060116204057.GC3639@inferi.kami.home> <1137458964.27699.65.camel@cog.beaverton.ibm.com> <20060117174953.GA3529@inferi.kami.home> <1137525090.27699.92.camel@cog.beaverton.ibm.com> <20060117224951.GA3320@inferi.kami.home> <16839.83.103.117.254.1137581235.squirrel@picard.linux.it> <1138141635.15682.92.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138141635.15682.92.camel@cog.beaverton.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.16-rc1-mm2-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 02:27:14PM -0800, john stultz wrote:
> On Wed, 2006-01-18 at 11:47 +0100, Mattia Dongili wrote:
> > On Tue, January 17, 2006 11:49 pm, Mattia Dongili said:
> > [...]
> > > the stall is still there, tomorrow I'll reapply your debug-patch and
> > > report the full dmesg (with the finished_booting-hack enabled).
> > 
> > Full dmesg attached.
> > Stalls happened between in the 16.39-16.55 interval, in 16.70-16.96 and
> > 17.89-18.64. They were all much longer than stated in the log timestamp
> > (I'd say ~10:1 ratio).	
> > 
> > Sorry again for my previous false notice about the bug being solved...
> 
> Hey Mattia, 
> 	Sorry I've been so quiet recently, I'm still working on this one.  The

No problem.

> difficult spot is that if the cpufreq notification driver is a module,
> then there will always be a window between the point at which we start
> using the TSC to the point where we find out that the TSC is changing
> frequency. Not sure what to do here just yet.

I was wondering if you could force an do_gettimeofday call quite early
in order to lower tsc priority as soon as possible, but maybe I'm not
entirely into that code :)

> Although I'm curious: Did the recent changes in 2.6.16-rc1-mm2 had any
> effect on this issue?

no, I'm currently running it and the same behaviour still applies.

ciao
-- 
mattia
:wq!
