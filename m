Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWHGQMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWHGQMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWHGQMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:12:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53377 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932203AbWHGQMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:12:09 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Dmitry Torokhov <dtor@insightbb.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
References: <1154832963.29151.21.camel@localhost.localdomain>
	<20060806031643.GA43490@muc.de>
	<200608062243.45129.dtor@insightbb.com>
	<20060807084850.GA67713@muc.de> <20060807110931.GM27757@suse.cz>
	<20060807122845.GA85602@muc.de> <20060807124855.GB21003@suse.cz>
	<20060807125639.GA88155@muc.de>
	<20060807151957.GA9911@rhlx01.fht-esslingen.de>
	<20060807155714.GA3075@muc.de> <20060807160432.GA16695@suse.cz>
From: Andi Kleen <ak@suse.de>
Date: 07 Aug 2006 18:12:03 +0200
In-Reply-To: <20060807160432.GA16695@suse.cz>
Message-ID: <p73k65kplt8.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Mon, Aug 07, 2006 at 05:57:14PM +0200, Andi Kleen wrote:
> > > That way a driver could use
> > > 
> > > 	if (gtod_cpu_cycles_needed <= 500)
> > > 		gettimeofday();
> > > 	else
> > > 		funky_fast_workaround();
> > 
> > Sounds like overengineering to me. I prefer something simple.
> 
> I could as well benchmark gettimeofday() in the gameport init.

Except you can't because the only way to benchmark it would
be to use gettimeofday already and then you don't know
how much is overhead and what is the real time.

-Andi
