Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965285AbWFIQhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbWFIQhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWFIQhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:37:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:2224 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965283AbWFIQhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:37:47 -0400
Date: Fri, 9 Jun 2006 18:37:37 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Paul Fulghum <paulkf@microgate.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, khc@pm.waw.pl
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
In-Reply-To: <44899EE2.2080303@microgate.com>
Message-ID: <Pine.LNX.4.64.0606091836340.17704@scrub.home>
References: <1149694978.12920.14.camel@amdx2.microgate.com> 
 <20060607143138.62855633.rdunlap@xenotime.net> <1149868042.20097.5.camel@amdx2.microgate.com>
 <Pine.LNX.4.64.0606091757260.17704@scrub.home> <44899EE2.2080303@microgate.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 9 Jun 2006, Paul Fulghum wrote:

> Roman Zippel wrote:
> > > +config SYNCLINK_HDLC
> > > +	bool "Generic HDLC support for SyncLink driver"
> > > +	depends on SYNCLINK
> > > +	depends on HDLC=y || HDLC=SYNCLINK
> > 
> > 
> > If you replace now 'bool "..."' with 'def_bool y', it's enabled
> > automatically as soon as HDLC is enabled and the user doesn't has to confirm
> > it for every driver separately and it has the same effect as your #ifdef
> > hack.
> 
> You need to explain this more.

Just try it. :)

> The only #ifdef in the patch is that which conditionally
> compiles the generic HDLC support based on the
> kernel configuration option. If I remove those, then
> the synclink would require generic HDLC, which
> is not what we want.

I meant the old #ifdef hack, which your patch removed.

bye, Roman
