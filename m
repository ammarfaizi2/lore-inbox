Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVEPTvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVEPTvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVEPTvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:51:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:32153 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261836AbVEPTvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:51:02 -0400
Subject: Re: IA64 implementation of timesource for new time of day subsystem
From: john stultz <johnstul@us.ibm.com>
To: David Mosberger <davidm@hpl.hp.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
In-Reply-To: <17032.62615.750699.18847@napali.hpl.hp.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
	 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
	 <1116264858.26990.39.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com>
	 <1116269136.26990.67.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com>
	 <17032.62615.750699.18847@napali.hpl.hp.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 12:50:55 -0700
Message-Id: <1116273055.13867.5.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 12:29 -0700, David Mosberger wrote: 
> >>>>> On Mon, 16 May 2005 12:24:08 -0700 (PDT), Christoph Lameter <clameter@engr.sgi.com> said:
> 
>   Christoph> Other IA64 vendors will see that their timer performance
>   Christoph> drops significantly after the new timer subsystem is
>   Christoph> in. IBM no longer has IA64 systems that rely on ITC?
> 
> Would that somehow make it ok to break existing and working code?

No. I intend to preserve the existing functionality (and performance) of
the current code. The current timeofday core should allow for this (as I
described in my last mail), so really its just a matter of either me or
someone else getting around to properly converting that arch with the
help of the arch maintainer. Until the arch is really ready to use the
new timeofday core, no changes are necessary.

Christoph's patch is just a step in the right direction. That is, a much
appreciated step, I haven't yet had the time to implement or test the
ia64 timesources. Any notable regressions introduced will need to be
resolved before the arch specific patch is finally submitted.

What I'm trying to shake out, with Christoph's help, is any major
limitations in the core timeofday code that would keep an arch from
being able to use it.  I feel Christoph's concerns have been addressed,
but please let me know if you disagree.

thanks
-john

