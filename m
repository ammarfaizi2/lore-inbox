Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVHLRav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVHLRav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVHLRav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:30:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53427 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750745AbVHLRav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:30:51 -0400
Subject: Re: [PATCH] Add removal schedule of
	register_serial/unregister_serial to appropriate file
From: Max Asbock <masbock@us.ibm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, vernux@us.ibm.com
In-Reply-To: <20050714203321.E10410@flint.arm.linux.org.uk>
References: <20050623142335.A5564@flint.arm.linux.org.uk>
	 <20050714203321.E10410@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1123867834.17335.73.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 12 Aug 2005 10:30:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 12:33, Russell King wrote:
> On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
> > +
> > +---------------------------
> > +
> > +What:	register_serial/unregister_serial
> > +When:	December 2005
> > +Why:	This interface does not allow serial ports to be registered against
> > +	a struct device, and as such does not allow correct power management
> > +	of such ports.  8250-based ports should use serial8250_register_port
> > +	and serial8250_unregister_port instead.
> > +Who:	Russell King <rmk@arm.linux.org.uk>
> 
> I think it's about time to make the build a little more vocal about the
> expiry of these functions.  Due to recent discussions with problems in
> the console initialisation vs power manglement, I'd like to move the
> date forward to September.
> 

I am converting the ibmasm driver that uses (un)register_serial to use
serial_8250_(un)register_port. However I find function prototypes for
the new interfaces only in linux/drivers/char/8250.h. Is there a reason
there aren't any extern declarations for these functions in
linux/include/serial.h or linux/include/serial_8250.h?

thanks,
max


