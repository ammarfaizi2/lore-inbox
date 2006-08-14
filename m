Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWHNPvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWHNPvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWHNPvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:51:04 -0400
Received: from outmx014.isp.belgacom.be ([195.238.4.69]:25045 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751462AbWHNPvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:51:03 -0400
Date: Mon, 14 Aug 2006 17:50:45 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814155045.GA4068@infomag.infomag.iguana.be>
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608120149.23380.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> >  > +#include <linux/config.h>
> >
> > not needed.
> 
> It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.

We'll fix this in the watchdog.h include file.

> >  > +static int nowayout =
> >  > +#if defined(CONFIG_WATCHDOG_NOWAYOUT)
> >  > +	1;
> >  > +#else
> >  > +	0;
> >  > +#endif
> >
> > static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
> >
> > should work.
> 
> Does not work. If the option is not selected, CONFIG_WATCHDOG_NOWAYOUT
> is undefined, not zero.

This should be:
static int nowayout = WATCHDOG_NOWAYOUT;

Can you resent me your latest diff?

Thanks,
Wim.

