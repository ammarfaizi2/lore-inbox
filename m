Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWGYSnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWGYSnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWGYSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:43:48 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:40199 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750842AbWGYSnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:43:47 -0400
Date: Tue, 25 Jul 2006 14:43:28 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Message-ID: <20060725184328.GF4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <1153850139.8932.40.camel@laptopd505.fenrus.org> <20060725182208.GD4608@hmsreliant.homelinux.net> <1153852375.8932.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153852375.8932.41.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 08:32:55PM +0200, Arjan van de Ven wrote:
> 
> > > 3) this will negate the power gain you get for tickless kernels, since
> > > now they need to start ticking again ;( )
> > > 
> > That is true, but only in the case where someone opens up /dev/rtc, and if they
> > open that driver and send it a UIE or PIE ioctl, it will start ticking
> > regardless of this patch (or that is at least my impression).
> 
> but.. if that's X like you said.. then it's basically "always"...
> 
Well, not always (considering the number of non-X embedded systems out there),
but I take your point.  So it really boils down to not having a tickless kernel,
or an X server that calls gettimeofday 1 million times per second (I think thats
the number that Dave threw out there).  Unless of course, you have a third
alternative, which, as I mentioned before I would be happy to take a crack at,
if you would elaborate on your idea a little more.

Thanks & Regards
Neil

> 
> -- 
> if you want to mail me at work (you don't), use arjan (at) linux.intel.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
