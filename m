Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWHRHqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWHRHqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWHRHqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:46:36 -0400
Received: from gw-eur4.philips.com ([161.85.125.10]:42472 "EHLO
	gw-eur4.philips.com") by vger.kernel.org with ESMTP
	id S1751028AbWHRHqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:46:36 -0400
In-Reply-To: <20060817202954.GC28474@flint.arm.linux.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       Vitaly Wool <vitalywool@gmail.com>
Subject: Re: ip3106_uart oddity
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.0.3 September 26, 2003
Message-ID: <OF21337E37.31820A4F-ONC12571CE.002682FD-C12571CE.002AB6EB@philips.com>
From: Jean-Paul Saman <jean-paul.saman@philips.com>
Date: Fri, 18 Aug 2006 09:46:01 +0200
X-MIMETrack: Serialize by Router on ehvrmh02/H/SERVER/PHILIPS(Release 6.5.5HF561 | June
 9, 2006) at 18/08/2006 09:46:03,
	Serialize complete at 18/08/2006 09:46:03
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel-owner@vger.kernel.org wrote on 17-08-2006 22:29:54:

> On Thu, Aug 17, 2006 at 06:29:48PM +0400, Vitaly Wool wrote:
> > it looks like drivers/serial/ip3106_uart.c was dropped from the
> > mainline at some point I couldn't identify. Can you please confirm
> > that?
> 
Looks like someone wanted to rename it, but forgot to include the new 
file.

> I am not aware of its addition nor removal of this file.  There was
> au1x00_uart.c at one time.
> 
> > I'd like to take the burden of restoring the UART functionality for
> > PNX8550 boards in the mainline. This very UART HW is very weird and
> > doesn't fit well into 8250 model, even with fixups like those that
> > were introduced for Alchemy. It also differs from the IP_3106-based
> > UARTs used on Philips ARM targets in registers layout so I'm not
> > sure it's correct to call it ip3106_uart.
> > So, given the above, does it make sense to try make it fir into
> > standard 8250 driver model or restore/rework the custom driver?
> 
> No real clue.  Is it similar to any other drivers?

The ip3106_uart.c file that was used in the PNX8550 boards is wrongly 
named. The uart just isn't an ip3106, because those are used in philips 
ARM based devices.

If you restore the ip3106T_uart.c, then please rename it pnx8550_uart.c 
(or pnx8xxxx_uart.c).

Kind greetings,

Jean-Paul Saman

Philips Semiconductors
