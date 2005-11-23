Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVKWQAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVKWQAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVKWQAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:00:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28431 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750837AbVKWQAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:00:49 -0500
Date: Wed, 23 Nov 2005 15:29:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jon Smirl <jonsmirl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
Message-ID: <20051123152950.GC15449@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jon Smirl <jonsmirl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
	Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk> <438488A0.8050104@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438488A0.8050104@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 04:20:00PM +0100, Pierre Ossman wrote:
> But if no hardware is connected to those devices, then where does the 
> driver route the setserial stuff?

setserial /dev/ttyS2 port 0x200 irq 5 autoconfig

and you might then end up with another serial port detected.  If
/dev/ttyS2 and above do not exist, you can't do that.  That would
in turn effectively prevent folk with some serial cards using them
with Linux without editing and rebuilding their kernel.

As for the rest of the "setserial stuff" it gets recorded against
the port and remembered for when the hardware turns up, which it
may do if it's your PCMCIA modem card.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
