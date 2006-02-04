Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWBDXQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWBDXQq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWBDXQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:16:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11020 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964873AbWBDXQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:16:45 -0500
Date: Sat, 4 Feb 2006 23:16:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Glen Turner <glen.turner@aarnet.edu.au>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
Message-ID: <20060204231637.GB24887@flint.arm.linux.org.uk>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	Glen Turner <glen.turner@aarnet.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au> <20060203160218.GA27452@flint.arm.linux.org.uk> <43E38E00.301@aarnet.edu.au> <20060203222340.GB10700@flint.arm.linux.org.uk> <m3irrvdrnm.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3irrvdrnm.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2006 at 05:18:05PM +0100, Krzysztof Halasa wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> 
> > What about those who have incomplete null modem cables which might
> > not connect DCD or DSR, but who want to use hardware flow control?
> 
> BTW: Obviously CRTSCTS is a different thing than a modem with
> hardware handshaking. Basically CRTSCTS is a fixed, transparent
> line. So if we do Hayes modem console, it would better be another
> option.

I'm sorry, I don't understand what you're saying.

CRTSCTS is to enable RTS/CTS hardware handshaking for the tty, which
is what the modem wants if it is doing hardware handshaking.  Why
should we invent a non-standard option to enable RTS/CTS hardware
handshaking when CRTSCTS is already defined to do this?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
