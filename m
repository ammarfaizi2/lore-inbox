Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVJaVOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVJaVOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVJaVOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:14:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47313 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932499AbVJaVOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:14:40 -0500
Date: Mon, 31 Oct 2005 22:14:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd64 bitops fix for -Os
Message-ID: <20051031211431.GA14877@elf.ucw.cz>
References: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br> <20051030192323.GF657@openzaurus.ucw.cz> <or8xw9v47o.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <or8xw9v47o.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> --- arch/x86_64/lib/bitops.c~	2005-10-27 22:02:08.000000000 -0200
> >> +++ arch/x86_64/lib/bitops.c	2005-10-29 18:24:27.000000000 -0200
> >> @@ -1,5 +1,11 @@
> >> #include <linux/bitops.h>
> >> 
> >> +#define BITOPS_CHECK_UNDERFLOW_RANGE 0
> >> +
> >> +#if BITOPS_CHECK_UNDERFLOW_RANGE
> >> +# include <linux/kernel.h>
> >> +#endif
> 
> > Could you drop the ifdefs? Nice for debugging but we don't
> > want them in mainline.
> 
> Are you absolutely sure we don't?  I'd almost left them in, enabled
> unconditionally.  Note that the ifdef will make no difference
> whatsoever for the case I've just fixed, but it would help catch any
> other (ab)uses(?) elsewhere that may have gone unnoticed until now.

Well, ifdefs need to be gone. Maybe you should unconditionally check
it (I do not think so, but...) but ifdefs are certainly wrong.

> > Plus you want to add signed-off-by: header and send it to ak@suse.de.
> 
> Err...  The header was right there.  Or do you mean as an e-mail
> header, as opposed to a regular line in the e-mail body?

Okay, so I'm blind. Sorry. (Yes, it should be in body).

> I'll forward the patch to ak.

Thanks.
								Pavel
-- 
Thanks, Sharp!
