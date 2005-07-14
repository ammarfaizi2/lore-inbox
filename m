Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVGNOlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVGNOlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVGNOlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 10:41:10 -0400
Received: from webapps.arcom.com ([194.200.159.168]:35077 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261182AbVGNOkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 10:40:23 -0400
Message-ID: <42D67954.70101@arcom.com>
Date: Thu, 14 Jul 2005 15:40:20 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serial: 8250 fails to detect Exar XR16L2551 correctly
References: <42CA96FC.9000708@arcom.com>	 <20050706195740.A28758@flint.arm.linux.org.uk> <42CD2C16.1070308@arcom.com>	 <1121108408.28557.71.camel@tdi>	 <20050711204646.D1540@flint.arm.linux.org.uk>	 <1121112057.28557.91.camel@tdi>	 <20050711211706.E1540@flint.arm.linux.org.uk>	 <1121116677.28557.104.camel@tdi>  <1121274296.4334.58.camel@tdi> <1121277829.4334.76.camel@tdi>
In-Reply-To: <1121277829.4334.76.camel@tdi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jul 2005 14:51:11.0156 (UTC) FILETIME=[7990E740:01C58883]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson wrote:
> 
> David, would you mind
> trying this on the XR16L255x part? (ie. don't use console=ttyS, use
> console=uart,...)  Thanks,

I wasn't even aware you could do this...

These are the serial ports I have:

ttyS0 at MMIO 0xc8000000 (irq = 15) is a XScale   IXP425 internal
ttyS1 at MMIO 0xc8001000 (irq = 13) is a XScale     "       "
ttyS2 at MMIO 0x53000000 (irq = 21) is a XR16550  XR16L2551
ttyS3 at MMIO 0x53000008 (irq = 21) is a XR16550      "

I tried console=uart,mmio,0x53000000,115200 and my board didn't print
anything to the console and the boot failed somewhere before starting
network (I don't know exactly where or why since I couldn't see any
messages).  Using console=ttyS2,115200 works fine.

What's 8250_early.c for anyway?  console=ttyS... has always worked fine
for me.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
