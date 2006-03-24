Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWCXXWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWCXXWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWCXXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:22:41 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:56580 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932239AbWCXXWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:22:40 -0500
Subject: Re: [PATCH]
From: Daniel Walker <dwalker@mvista.com>
To: john stultz <johnstul@us.ibm.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <1143242372.26994.13.camel@cog.beaverton.ibm.com>
References: <200603242307.k2ON7TK0007932@dhcp153.mvista.com>
	 <1143242372.26994.13.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 15:22:32 -0800
Message-Id: <1143242553.24010.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 15:19 -0800, john stultz wrote:
> On Fri, 2006-03-24 at 15:07 -0800, Daniel Walker wrote:
> > Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> > 
> > Index: linux-2.6.16/kernel/time/timeofday.c
> > ===================================================================
> > --- linux-2.6.16.orig/kernel/time/timeofday.c
> > +++ linux-2.6.16/kernel/time/timeofday.c
> > @@ -644,7 +644,7 @@ static void timeofday_periodic_hook(unsi
> >  
> >  	int something_changed = 0;
> >   	int clocksource_changed = 0;
> > -	struct clocksource old_clock;
> > +	struct clocksource old_clock = { .mult = 1, .shift = 0 };
> >  	static s64 second_check;
> >  
> >  	write_seqlock_irqsave(&system_time_lock, flags);
> 
> I assume this is a fix for the GCC "may be used uninitialized" warning?

Yeah, Sorry ,I accidentally pressed enter before I described it ..

Daniel

