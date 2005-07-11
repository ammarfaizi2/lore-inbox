Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVGKTt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVGKTt6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVGKTsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:48:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58632 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262466AbVGKTqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:46:51 -0400
Date: Mon, 11 Jul 2005 20:46:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alex Williamson <alex.williamson@hp.com>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
Message-ID: <20050711204646.D1540@flint.arm.linux.org.uk>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	David Vrabel <dvrabel@arcom.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <42CA96FC.9000708@arcom.com> <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com> <1121108408.28557.71.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1121108408.28557.71.camel@tdi>; from alex.williamson@hp.com on Mon, Jul 11, 2005 at 01:00:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 01:00:08PM -0600, Alex Williamson wrote:
> On Thu, 2005-07-07 at 14:20 +0100, David Vrabel wrote:
> 
> > I've redid the patch and added a check for this.  Alex, could you test
> > this version, please.
> 
>    This detects the A2 ST16C255x as an XR16550, so apparently the sleep
> check doesn't work.  I contacted Exar about these two seemingly
> identical UARTs, and they say that the A2 ST16C255x should be compatible
> with the XR16550 so perhaps we don't need to special case the A2 UART at
> all.  Unfortunately, when I use the UART for a console, I get garbled
> output from the time the UART is detected until we hit userspace.

There was a bug in this area - does it happen with latest and greatest
kernels?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
