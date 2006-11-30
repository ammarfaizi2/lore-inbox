Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758395AbWK3G5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758395AbWK3G5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 01:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758394AbWK3G5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 01:57:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:9514 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1758255AbWK3G5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 01:57:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NrN19UQA6z5GlCwuzALBPTBuYoPi2iDUeQKv0QO4lR4LcEkz3kJ05sVLun7TPiasCer4s0Hmg2uV71AVk1GDe2k67L07RjgpKM8klq0i/fSWW6QQlcma4GAGIOIhQdbaJzkQc33jzYkBISBMy5fm0HXLstY3bJlGux4VtY/ity0=
Message-ID: <74d0deb30611292257n3f532abbyedef9b543b9d48ae@mail.gmail.com>
Date: Thu, 30 Nov 2006 07:57:52 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Cc: "Bill Gatliff" <bgat@billgatliff.com>, "Paul Mundt" <lethal@linux-sh.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Andrew Victor" <andrew@sanpeople.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
In-Reply-To: <200611221640.55574.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611111541.34699.david-b@pacbell.net>
	 <200611202135.39970.david-b@pacbell.net>
	 <456321E9.2030308@billgatliff.com>
	 <200611221640.55574.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/23/06, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 21 November 2006 7:57 am, Bill Gatliff wrote:
>
> > Once you're hiding the GPIO number behind an enumeration, you can create
> > a bitmap with more information than a single integer.  That extra
> > information could be used--- in my implementations, if any ever come
> > about--- to store routing information.
>
> But none of the existing GPIO users do that.  The goal wasn't to define
> a new notion of GPIO; it was collecting the existing ones under a single
> arch-neutral umbrella.
>
>
> > >It'd also be a big (and needless) disruption to code that's been working
> > >fine for several years now ...
> >
> > ... all of which is using the current GPIO API, you mean?  :)
>
> Effectively, yes.  I counted quite a few implementations in the current
> tree which can trivially (#defines) map to that API.

I tried to do that for pxa, the patch is attached.
So what is the state of this discussion, now that 2.6.19 is here?

I just submitted an input driver for GPIO buttons to linux-input that
we use in the handhelds.org kernel for sa1100, pxa and s3c2410 archs.
It needs some ugly
#ifdefs currently, but with common GPIO calls they all could go away.

regards
Philipp
