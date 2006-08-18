Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWHRI2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWHRI2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWHRI2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:28:08 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:58633 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751132AbWHRI2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:28:06 -0400
Date: Fri, 18 Aug 2006 09:27:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean-Paul Saman <jean-paul.saman@philips.com>
Cc: linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       Vitaly Wool <vitalywool@gmail.com>
Subject: Re: ip3106_uart oddity
Message-ID: <20060818082756.GB6901@flint.arm.linux.org.uk>
Mail-Followup-To: Jean-Paul Saman <jean-paul.saman@philips.com>,
	linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
	Vitaly Wool <vitalywool@gmail.com>
References: <20060817202954.GC28474@flint.arm.linux.org.uk> <OF21337E37.31820A4F-ONC12571CE.002682FD-C12571CE.002AB6EB@philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF21337E37.31820A4F-ONC12571CE.002682FD-C12571CE.002AB6EB@philips.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 09:46:01AM +0200, Jean-Paul Saman wrote:
> linux-kernel-owner@vger.kernel.org wrote on 17-08-2006 22:29:54:
> > On Thu, Aug 17, 2006 at 06:29:48PM +0400, Vitaly Wool wrote:
> > > I'd like to take the burden of restoring the UART functionality for
> > > PNX8550 boards in the mainline. This very UART HW is very weird and
> > > doesn't fit well into 8250 model, even with fixups like those that
> > > were introduced for Alchemy. It also differs from the IP_3106-based
> > > UARTs used on Philips ARM targets in registers layout so I'm not
> > > sure it's correct to call it ip3106_uart.
> > > So, given the above, does it make sense to try make it fir into
> > > standard 8250 driver model or restore/rework the custom driver?
> > 
> > No real clue.  Is it similar to any other drivers?
> 
> The ip3106_uart.c file that was used in the PNX8550 boards is wrongly 
> named. The uart just isn't an ip3106, because those are used in philips 
> ARM based devices.
> 
> If you restore the ip3106T_uart.c, then please rename it pnx8550_uart.c 
> (or pnx8xxxx_uart.c).

There are no plans what so ever to "restore" what was never even there.
Searching around, there was a pnx0105 driver submitted but needed some
additional work which was never done.

The same situation seems to apply to this driver.  Ralf submitted a
driver called ip3106_uart.c which claimed to be a rewrite of
pnx8550_uart.c.  Comments were given at that time, no real feedback
came of that.

I would suggest you read the "Serial driver for the Philips PNX8550
SOC." thread, but it was a private one between Ralf, me and an
embeddedalley.com employee (who allegedly was the author of the driver
and who volunteered to do the work to fix the comments, but seemingly
never actually did anything.)

I suggest you ask embeddedalley.com...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
