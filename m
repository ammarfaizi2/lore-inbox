Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUE3Lxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUE3Lxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUE3Lxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:53:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55561 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263166AbUE3Lxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:53:39 -0400
Date: Sun, 30 May 2004 12:53:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040530125330.A25212@flint.arm.linux.org.uk>
Mail-Followup-To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>; from danlee@informatik.uni-freiburg.de on Sun, May 30, 2004 at 01:40:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 01:40:03PM +0200, Sau Dan Lee wrote:
> Now, what prevents people from  connecting terminals to a computer via
> the PS/2 mouse port?

Apart from electrically blowing the PS/2 port, the data format of PS/2
is well defined and fixed, whereas a UART (8250-based) port is more
flexible.  PS/2 also has the idea of acknowledgement from the peripheral
device for each byte transferred, and is synchronous, whereas UARTs
have no acknowledgement and are asyncrhonous.

So, any thought that the two ports are similar compatible with each other,
either from the electrical or protocol points of view is just a dead loss.

How do these mice work on both ports then?  They can detect which port
they're connected to and the electronics inside automatically configures
itself depending on which port they're connected to.

> Your  approach   in  the  input  system  completely   rules  out  this
> possibility.

As from above, its more than just the input system - its the protocol
and electrical characteristics which completely rules out the
possibility - which in turn makes it nonsensible to support such an
idea in software.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
