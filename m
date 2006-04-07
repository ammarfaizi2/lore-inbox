Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWDGVJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWDGVJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWDGVJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:09:05 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:14290 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964958AbWDGVJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:09:04 -0400
Subject: Re: [PATCH 1/5] generic clocksource updates
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604072239110.32445@scrub.home>
References: <Pine.LNX.4.64.0604032155070.4707@scrub.home>
	 <1144317972.5344.681.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0604062048130.17704@scrub.home>
	 <1144351944.5925.23.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0604072239110.32445@scrub.home>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 14:08:45 -0700
Message-Id: <1144444126.2745.125.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 22:43 +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 6 Apr 2006, Thomas Gleixner wrote:
> 
> > > Currently this field isn't needed and as soon we have a need for it, we 
> > > can add proper capability information.
> > 
> > Is there a reason, why requirements which are known from existing
> > experience must be discarded to be reintroduced later ?
> 
> Then please explain these requirements.
> This field shouldn't have been added in first place, I guess I managed to 
> confuse John when I talked about handling of continuous vs. tick based 
> clocks. Currently no user should even care about this, it's an 
> implementation detail of the clock.

I don't think you confused me on this issue (although, I admit I'm prone
to confusion). 

The is_continuous flag on the clocksource is used so other systems can
query if timekeeping is able to function without regular timer ticks.
This would be necessary for the HRT patchset, as well as the dynamic
tick patches, as they both reprograms the tick frequency, and need to
know if that will affect time.

I can reasonably drop this bit from the current patches, but it is very
small and and will be needed shortly, so I'm not sure its that big of a
deal.

thanks
-john

