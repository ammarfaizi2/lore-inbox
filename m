Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbTDDRPf (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTDDROQ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:14:16 -0500
Received: from palrel12.hp.com ([156.153.255.237]:39397 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263874AbTDDRMt (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 12:12:49 -0500
Date: Fri, 4 Apr 2003 09:24:17 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: uart_ioctl OOPS with irtty-sir
Message-ID: <20030404172417.GA24719@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030404013405.GA19446@bougret.hpl.hp.com> <20030404102535.A29313@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404102535.A29313@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 10:25:35AM +0100, Russell King wrote:
> On Thu, Apr 03, 2003 at 05:34:05PM -0800, Jean Tourrilhes wrote:
> > 	Unfortunately, the irtty-sir driver, which is a TTY line
> > discipline and a network driver, need to be able to change the RTS and
> > DTR line from a kernel thread.
> 
> I'd prefer if we added an tty API to allow line disciplines to read/set
> the modem control lines to the tty later, rather than having line
> disciplines play games with IOCTLs.

	Yes, that would look much cleaner, and it would avoid this
kind of confusion to come back again in the long term. And it would
also be slightly more efficient.

> Russell King

	Thanks for the quick answer !

	Jean
