Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVGKUEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVGKUEC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVGKUCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:02:15 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:64666 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262508AbVGKUAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:00:38 -0400
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050711204646.D1540@flint.arm.linux.org.uk>
References: <42CA96FC.9000708@arcom.com>
	 <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com>
	 <1121108408.28557.71.camel@tdi>
	 <20050711204646.D1540@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 11 Jul 2005 14:00:57 -0600
Message-Id: <1121112057.28557.91.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 20:46 +0100, Russell King wrote:
> On Mon, Jul 11, 2005 at 01:00:08PM -0600, Alex Williamson wrote:
> > On Thu, 2005-07-07 at 14:20 +0100, David Vrabel wrote:
> > 
> > > I've redid the patch and added a check for this.  Alex, could you test
> > > this version, please.
> > 
> >    This detects the A2 ST16C255x as an XR16550, so apparently the sleep
> > check doesn't work.  I contacted Exar about these two seemingly
> > identical UARTs, and they say that the A2 ST16C255x should be compatible
> > with the XR16550 so perhaps we don't need to special case the A2 UART at
> > all.  Unfortunately, when I use the UART for a console, I get garbled
> > output from the time the UART is detected until we hit userspace.
> 
> There was a bug in this area - does it happen with latest and greatest
> kernels?

   Yes, I'm using a git pull from ~5hrs ago.  How recent was the bug
fix?  It worked fine before I applied David's patch, the A2 UART was
detected as a 16550A.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

