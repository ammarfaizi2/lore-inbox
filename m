Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVF0Ahp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVF0Ahp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 20:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVF0Aho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 20:37:44 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:21714 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S261682AbVF0AhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 20:37:04 -0400
Date: Mon, 27 Jun 2005 10:36:55 +1000
From: David McCullough <davidm@snapgear.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerass <paulus@au.ibm.com>,
       Mikael Starvik <starvik@axis.com>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050627003655.GD27196@beast>
References: <20050623142335.A5564@flint.arm.linux.org.uk> <20050625104725.A16381@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050625104725.A16381@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Russell King lays it down ...
> On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
> > +What:	register_serial/unregister_serial
> > +When:	December 2005
> > +Why:	This interface does not allow serial ports to be registered against
> > +	a struct device, and as such does not allow correct power management
> > +	of such ports.  8250-based ports should use serial8250_register_port
> > +	and serial8250_unregister_port instead.
> > +Who:	Russell King <rmk@arm.linux.org.uk>
> 
> Ok, now that this is in, I guess I should arrange for register_serial &
> co to throw a compiler warning.  However, this is non-trivial because
> several other drivers declare this function:

...

> drivers/serial/68328serial.c:int register_serial(struct serial_struct *req)
> drivers/serial/68328serial.c:void unregister_serial(int line)

These can go.  AFAICT they were never used and I have no idea why they
are there.

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
