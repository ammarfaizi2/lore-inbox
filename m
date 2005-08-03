Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVHCGTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVHCGTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVHCGTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:19:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54924 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262077AbVHCGRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:17:31 -0400
Date: Wed, 3 Aug 2005 08:17:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Andrey Volkov <avolkov@varma-el.com>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: Where is place of arch independed companion chips?
Message-ID: <20050803061719.GE1399@elf.ucw.cz>
References: <42EB6A12.70100@varma-el.com> <42EE15AF.5050902@hp.com> <20050801181357.GA31144@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801181357.GA31144@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >While I write driver for SM501 CC (which have graphics controller, USB
> > >MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
> > >I bumped with next ambiguity:
> > >Where is a place of this chip's Kconfig/drivers in
> > >kernel config/drivers tree? May be create new node in drivers subtree?
> > >Or put it under graphics node (since it's main function of this CC)?
> > >
> > >AFAIK, this is not one such multifunctional monster in the world, so
> > >somebody bumped with this problem again in future.
> > >
> > > 
> > >
> > Good question.  I was about to submit a patch that created 
> > drivers/platform because the toplevel driver for MQ11xx is a 
> > platform_device driver.  Any thoughts on this?
> 
> drivers/platform sounds good to me.

We have some problems with ucb1x00 chip on some small systems;
originally we wanted it to go into drivers/misc, but that sounded
wrong. Latest idea was drivers/mfd (multi functional devices)...

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
