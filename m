Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161382AbWHDT2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161382AbWHDT2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161379AbWHDT2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:28:43 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:60311 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161382AbWHDT2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:28:43 -0400
Subject: Re: [PATCH 04/10] -mm  clocksource: add some new API calls
From: Daniel Walker <dwalker@mvista.com>
To: john stultz <johnstul@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1154718400.5327.23.camel@localhost.localdomain>
References: <20060804032414.304636000@mvista.com>
	 <20060804032521.464282000@mvista.com>
	 <1154718400.5327.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 12:28:39 -0700
Message-Id: <1154719720.12936.50.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +/*
> > + * Internally used to invert the rating, so lower is better.
> > + */
> > +#define CLOCKSOURCE_RATING(x)	(INT_MAX-x)
> 
> Since this is used for the plist bits, could it get a more explicit
> name?


Sure, like CLOCKSOURCE_INVERT_RATING() 



> >  int clocksource_register(struct clocksource *c)
> >  {
> >  	int ret = 0;
> >  	unsigned long flags;
> >  
> > +	if (unlikely(!c))
> > +		return -EINVAL;
> > +
> 
> I'm not sure I understand the need for this. Is it really likely someone
> would pass NULL to clocksource_register()?

Not likely, I was just covering all possibilities.. It might be better
as a BUG_ON() actually.


Daniel

