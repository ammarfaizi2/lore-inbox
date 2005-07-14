Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbVGNTA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbVGNTA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVGNS6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:58:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2831 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263104AbVGNS5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:57:23 -0400
Date: Thu, 14 Jul 2005 19:57:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9: serial_core: uart_open
Message-ID: <20050714195717.B10410@flint.arm.linux.org.uk>
Mail-Followup-To: karl malbrain <karl@petzent.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20050714092648.C26322@flint.arm.linux.org.uk> <NDBBKFNEMLJBNHKPPFILIEAICEAA.karl@petzent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NDBBKFNEMLJBNHKPPFILIEAICEAA.karl@petzent.com>; from karl@petzent.com on Thu, Jul 14, 2005 at 10:16:23AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 10:16:23AM -0700, karl malbrain wrote:
> I'd love to do a ps listing for you, but, except for the mouse, the system
> is completely unresponsive after issuing the blocking open("/dev/ttyS1",
> O_RDRW).
> 
> Telnet is dead; the console will respond to the mouse, but the only thing I
> can do is close the xterm window and thereby kill the process. I can launch
> a new xterm window from the menu using the mouse, but the new window is dead
> and has no cursor nor bash prompt.
> 
> The clock on the display is being updated.  After several hours the system
> reboots on its own.
> 
> I recall from my DOS days that 8250/16550 programming requires that the
> specific IIR source be responded to, or the chip will immediately
> turn-around with another interrupt.  It doesn't look like 8250.c is
> organized to respond directly to the modem-status-change value in IIR which
> requires reading MSR to reset.

Well, at this point interrupts are enabled, and _are_ handled.  The
only thing we use the IIR for is to answer the question "did this
device say it had an interrupt?"

If it did, we unconditionally read the MSR without fail.

So, I've no idea what so ever about what's going on here.  I don't
understand why your system is behaving the way it is.  Therefore,
I don't think we can progress this any further, sorry.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
