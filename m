Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263363AbVGOUkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbVGOUkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVGOUkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:40:35 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:34215 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262023AbVGOUjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:39:01 -0400
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050714144604.A7314@flint.arm.linux.org.uk>
References: <42CA96FC.9000708@arcom.com>
	 <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com>
	 <1121108408.28557.71.camel@tdi>
	 <20050711204646.D1540@flint.arm.linux.org.uk>
	 <1121112057.28557.91.camel@tdi>
	 <20050711211706.E1540@flint.arm.linux.org.uk>
	 <1121116677.28557.104.camel@tdi> <1121274296.4334.58.camel@tdi>
	 <20050714144604.A7314@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: LOSL
Date: Fri, 15 Jul 2005 14:39:21 -0600
Message-Id: <1121459961.12944.52.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 14:46 +0100, Russell King wrote:

> Then we try to register the console, which may result in this UART
> becoming a console.  So now we have a console which is in low power
> mode.  Bad bad bad.  No cookie for the serial layer today.

   I don't know if this is a possible short term option, but the code
David proposes would work fine on the A2 rev ST16C255x parts as long as
UART_CAP_SLEEP in not included in the list of capabilities.  The check
for the A2 part would not be needed (esp. since it doesn't work).  When
the console detection code is fixed up, this flag could be included, and
I'd be happy to test it.  This would at least give us both usable UARTs
until we can work out the other kinks.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

