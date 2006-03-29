Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWC2AdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWC2AdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWC2AdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:33:12 -0500
Received: from tim.rpsys.net ([194.106.48.114]:11938 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750703AbWC2AdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:33:11 -0500
Subject: Re: [PATCH -mm 0/4] LED Updates
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060328162300.5bf4f4fc.akpm@osdl.org>
References: <1143591415.14682.55.camel@localhost.localdomain>
	 <20060328162300.5bf4f4fc.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 01:33:05 +0100
Message-Id: <1143592385.14682.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 16:23 -0800, Andrew Morton wrote:
> Richard Purdie <rpurdie@rpsys.net> wrote:
> >
> > ...
> >
> > Also add some missing externs.
> >
> > ... 
> >  
> >  /* Registration functions for complex triggers */
> > -int led_trigger_register(struct led_trigger *trigger);
> > -void led_trigger_unregister(struct led_trigger *trigger);
> > +extern int led_trigger_register(struct led_trigger *trigger);
> > +extern void led_trigger_unregister(struct led_trigger *trigger);
> 
> Well.  The externs weren't "missing".  They were "unnecessary".  I don't
> know why we do this really - it doesn't communicate any information.  Oh
> well.

Half of the leds header had them, half of it didn't. I looked at some
other kernel headers and saw the were present so presumed they were
needed for some reason. Looks like I changed the wrong half... :-/

Richard

