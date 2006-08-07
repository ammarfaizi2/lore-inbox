Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWHGQEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWHGQEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWHGQEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:04:46 -0400
Received: from styx.suse.cz ([82.119.242.94]:61092 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750786AbWHGQEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:04:45 -0400
Date: Mon, 7 Aug 2006 18:04:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Dmitry Torokhov <dtor@insightbb.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807160432.GA16695@suse.cz>
References: <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com> <20060807084850.GA67713@muc.de> <20060807110931.GM27757@suse.cz> <20060807122845.GA85602@muc.de> <20060807124855.GB21003@suse.cz> <20060807125639.GA88155@muc.de> <20060807151957.GA9911@rhlx01.fht-esslingen.de> <20060807155714.GA3075@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807155714.GA3075@muc.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 05:57:14PM +0200, Andi Kleen wrote:
> > That way a driver could use
> > 
> > 	if (gtod_cpu_cycles_needed <= 500)
> > 		gettimeofday();
> > 	else
> > 		funky_fast_workaround();
> 
> Sounds like overengineering to me. I prefer something simple.

I could as well benchmark gettimeofday() in the gameport init.

> > OK, in total we have at least four ways of doing this:
> 
> Please don't get carried away with this. I'm really not interested
> in any complex solutions here.


-- 
Vojtech Pavlik
Director SuSE Labs
