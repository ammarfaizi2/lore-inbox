Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVGTUox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVGTUox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 16:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGTUox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 16:44:53 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:30870 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261494AbVGTUow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 16:44:52 -0400
Subject: Re: [RFC][PATCH - 1/12] NTP cleanup: Move NTP code into ntp.c
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050718114226.GC1869@elf.ucw.cz>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <20050718114226.GC1869@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 13:44:46 -0700
Message-Id: <1121892287.2931.1.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-18 at 13:42 +0200, Pavel Machek wrote:
> Hi!
> > Any comments or feedback would be greatly appreciated.
> > +#ifdef CONFIG_TIME_INTERPOLATION
> > +void time_interpolator_update(long delta_nsec);
> > +#else
> > +#define time_interpolator_update(x)
> 
> do {} while (0) is safer...

Applied. 

> > +	result = time_state;       /* mostly `TIME_OK' */
> > +
> > +	/* Save for later - semantics of adjtime is to return old value */
> > +	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
> > +
> > +#if 0	/* STA_CLOCKERR is never set yet */
> > +	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
> > +#endif
> 
> Please remove deleted code completely.

Done in a later patch, but good point, I'll kill it in the first one. 


Thanks for the review and feedback! 
-john


