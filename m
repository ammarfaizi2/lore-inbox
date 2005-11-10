Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVKJPDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVKJPDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVKJPDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:03:32 -0500
Received: from tim.rpsys.net ([194.106.48.114]:11191 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750710AbVKJPDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:03:31 -0500
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
From: Richard Purdie <rpurdie@rpsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <43735FC8.2090101@rtr.ca>
References: <20051103220305.77620d8f.akpm@osdl.org>
	 <20051104071932.GA6362@kroah.com>
	 <1131117293.26925.46.camel@localhost.localdomain>
	 <20051104163755.GB13420@kroah.com>
	 <1131531428.8506.24.camel@localhost.localdomain>  <43735FC8.2090101@rtr.ca>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 15:03:01 +0000
Message-Id: <1131634982.8499.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 09:57 -0500, Mark Lord wrote: 
> Richard Purdie wrote:
> >
> > - *	FIXME: This treatment is probably applicable for *all* PCMCIA (PC CARD)
> > - *	devices, so in linux 2.3.x we should change this to just treat all
> > - *	PCMCIA  drives this way, and get rid of the model-name tests below
> > - *	(too big of an interface change for 2.4.x).
> > - *	At that time, we might also consider parameterizing the timeouts and
> > - *	retries, since these are MUCH faster than mechanical drives. -M.Lord
> > - */
> 
> I believe the latter half of those comments (timeouts) should
> be left in the IDE layer (somewhere), as a note to current/future
> maintainers about something that does need fixing eventually.
> 
> Something like this:
> 
> /*
>   * FIXME:  Someday we ought to parameterize IDE timeouts to use
>   * much smaller values when dealing with flash memory cards.
>   * For example, these devices never require more than a second
>   * (much less, actually) for "spin-up", compared with a limit
>   * of 31 seconds for mechanical ATA drives.  This would speed up
>   * error recovery for these popular devices, especially in embedded work
>   */

Does this still apply given the existence of devices like microdrives?
My microdrive certainly sounds like it could take a second or two to
spin up...

Richard

