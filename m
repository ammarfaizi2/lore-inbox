Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWHNOLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWHNOLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHNOLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:11:49 -0400
Received: from ms-smtp-04.ohiordc.rr.com ([65.24.5.138]:3573 "EHLO
	ms-smtp-04.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S1751337AbWHNOLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:11:48 -0400
Date: Mon, 14 Aug 2006 10:14:45 -0400
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: Dave Jones <davej@redhat.com>, wim@iguana.be, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
       sam@ravnborg.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814141445.GA10763@nineveh.rivenstone.net>
Mail-Followup-To: Thomas Koeller <thomas@koeller.dyndns.org>,
	Dave Jones <davej@redhat.com>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, sam@ravnborg.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608120149.23380.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.5.11
From: jhf@columbus.rr.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
> On Friday 11 August 2006 22:56, Dave Jones wrote:
> > On Thu, Aug 10, 2006 at 11:19:13PM +0200, thomas@koeller.dyndns.org wrote:
> >  > +
> >  > +#include <linux/config.h>
> >
> > not needed.
>
> It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.

    It shouldn't be necessary, so it's probably a bug.  I could not
begin to tell you where.

    I've CC'd the Kbuild maintainer -- apologies if I'm way off base
here.

    Still, if this #include is to stay, you'd probably better comment
it, or it's likely someone will rip it out in a cleanup:

http://www.gossamer-threads.com/lists/linux/kernel/663918

>
> >
> >  > +static int locked = 0;
> >
> > unneeded initialisation.
>
> Not strictly needed, that's true, but does not do any harm either
> and expresses the intention clearly.

    My meager understanding is that it makes the kernel image bigger.

> >
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


    Possibly related?


--
Joseph Fannin
jhf@columbus.rr.com || jfannin@gmail.com


