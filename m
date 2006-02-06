Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWBFU1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWBFU1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbWBFU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:27:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48913 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964780AbWBFU1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:27:07 -0500
Date: Mon, 6 Feb 2006 20:26:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Glen Turner <glen.turner@aarnet.edu.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kumar Gala <galak@kernel.crashing.org>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060206202654.GC2470@ucw.cz>
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203094042.GB30738@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The serial console driver has a host of issues
> > 
> > [...]
> > 
> >  - [SECURITY] 'r' should require DCD to be asserted
> >    before outputing characters. Otherwise we talk to
> >    Hayes modem command mode.  This allows a non-root
> >    user to re-program the modem and is a major security
> >    issue is people configure calling line identification
> >    or encryption to restrict use of the serial console.
> 
> How is this possible?  A normal user can't produce arbitarily formatted
> kernel messages, and if they have access to /dev/ttyS they can do what
> ever they like with the port anyway.

Maybe not *arbitrary* messages, but any user probably can fake enough
to
confuse modem. Name your process \nATD609123456\n and cause it to eat
all memory, or something like that. OOM killer will print name...


						Pavel
-- 
Thanks, Sharp!
