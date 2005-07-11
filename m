Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVGKVT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVGKVT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVGKVTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:19:25 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:3980 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262764AbVGKVRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:17:39 -0400
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050711211706.E1540@flint.arm.linux.org.uk>
References: <42CA96FC.9000708@arcom.com>
	 <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com>
	 <1121108408.28557.71.camel@tdi>
	 <20050711204646.D1540@flint.arm.linux.org.uk>
	 <1121112057.28557.91.camel@tdi>
	 <20050711211706.E1540@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 11 Jul 2005 15:17:57 -0600
Message-Id: <1121116677.28557.104.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 21:17 +0100, Russell King wrote:
> On Mon, Jul 11, 2005 at 02:00:57PM -0600, Alex Williamson wrote:
> > On Mon, 2005-07-11 at 20:46 +0100, Russell King wrote:
> > > There was a bug in this area - does it happen with latest and greatest
> > > kernels?
> > 
> >    Yes, I'm using a git pull from ~5hrs ago.  How recent was the bug
> > fix?  It worked fine before I applied David's patch, the A2 UART was
> > detected as a 16550A.  Thanks,
> 
> The fix for this went in on 21st May 2005, so obviously it's not
> actually fixed.

   No, I think this is a problem with the broken A2 UARTs getting
confused in serial8250_set_sleep().  If I remove either UART_CAP_SLEEP
or UART_CAP_EFR from the capabilities list for this UART, it behaves
normally.  Also, just commenting out the UART_CAP_EFR chunks of
set_sleep make it behave.  I'll ping Exar for more data.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

