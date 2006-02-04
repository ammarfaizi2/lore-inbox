Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWBDXyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWBDXyz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWBDXyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:54:55 -0500
Received: from khc.piap.pl ([195.187.100.11]:53765 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030199AbWBDXyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:54:54 -0500
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org>
	<1138844838.5557.17.camel@localhost.localdomain>
	<43E2B8D6.1070707@aarnet.edu.au>
	<20060203094042.GB30738@flint.arm.linux.org.uk>
	<43E36850.5030900@aarnet.edu.au>
	<20060203160218.GA27452@flint.arm.linux.org.uk>
	<43E38E00.301@aarnet.edu.au>
	<20060203222340.GB10700@flint.arm.linux.org.uk>
	<m3irrvdrnm.fsf@defiant.localdomain>
	<20060204231637.GB24887@flint.arm.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 05 Feb 2006 00:54:51 +0100
In-Reply-To: <20060204231637.GB24887@flint.arm.linux.org.uk> (Russell King's message of "Sat, 4 Feb 2006 23:16:37 +0000")
Message-ID: <m3irrud6ic.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> CRTSCTS is to enable RTS/CTS hardware handshaking for the tty, which
> is what the modem wants if it is doing hardware handshaking.

Yes. But a Hayes modem wants a bit more than just RTS/CTS handshaking.

> Why
> should we invent a non-standard option to enable RTS/CTS hardware
> handshaking when CRTSCTS is already defined to do this?

That's not my idea.

If we want to support modems (Hayes-compatible) we need to make sure,
in addition to CRTSCTS, that we don't send anything when DCD (or DSR)
is down - and then we probably need another option.

BTW I think you know all of this very well for years.
-- 
Krzysztof Halasa
