Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWAQWtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWAQWtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWAQWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:49:15 -0500
Received: from 213-140-2-68.ip.fastwebnet.it ([213.140.2.68]:2704 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932474AbWAQWtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:49:15 -0500
Date: Tue, 17 Jan 2006 23:49:52 +0100
From: Mattia Dongili <malattia@linux.it>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)]
Message-ID: <20060117224951.GA3320@inferi.kami.home>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060110170037.4a614245.akpm@osdl.org> <20060111184027.GB4735@inferi.kami.home> <20060112220825.GA3490@inferi.kami.home> <1137108362.2890.141.camel@cog.beaverton.ibm.com> <20060114120816.GA3554@inferi.kami.home> <1137442582.27699.12.camel@cog.beaverton.ibm.com> <20060116204057.GC3639@inferi.kami.home> <1137458964.27699.65.camel@cog.beaverton.ibm.com> <20060117174953.GA3529@inferi.kami.home> <1137525090.27699.92.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137525090.27699.92.camel@cog.beaverton.ibm.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-mm4-4 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 11:11:30AM -0800, john stultz wrote:
> On Tue, 2006-01-17 at 18:49 +0100, Mattia Dongili wrote:
> > On Mon, Jan 16, 2006 at 04:49:18PM -0800, john stultz wrote:
> > > On Mon, 2006-01-16 at 21:40 +0100, Mattia Dongili wrote:
> > > > On Mon, Jan 16, 2006 at 12:16:21PM -0800, john stultz wrote:
> > > > > I'll try to narrow that window down a bit and see if that doesn't
> > > > > resolve the issue.
> > > > 
> > > > I'll be happy to test new patches if necessary (I'm running -mm4)
> > > 
> > > See if this patch doesn't resolve the issue. Its a bit hackish, but
> > > basically I'm just holding off installing any clocksources until later
> > > on at boot. This avoids some of the clocksource churn.
> > 
> > With the patch applied the boot went smooth.
> 
> Great. Thanks for the testing. I'll send that one off to Andrew.

I'm sorry, my very bad... it seems I somewhat forgot to remove
clocksource=jiffies from the command line and that fooled me.

the stall is still there, tomorrow I'll reapply your debug-patch and
report the full dmesg (with the finished_booting-hack enabled).

Sorry again.
-- 
mattia
:wq!
