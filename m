Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263757AbUCXP7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbUCXP7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:59:40 -0500
Received: from ltgp.iram.es ([150.214.224.138]:13696 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S263757AbUCXP7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:59:32 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 24 Mar 2004 16:50:40 +0100
To: Jamie Lokier <jamie@shareable.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Hans-Peter Jansen <hpj@urpla.net>, Robert_Hentosh@Dell.com,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: spurious 8259A interrupt
Message-ID: <20040324155040.GA3822@iram.es>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com> <20040319130609.GE2650@mail.shareable.org> <Pine.LNX.4.53.0403190825070.929@chaos> <200403211858.07445.hpj@urpla.net> <Pine.LNX.4.53.0403220713160.13879@chaos> <20040324152800.GA5758@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324152800.GA5758@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 03:28:00PM +0000, Jamie Lokier wrote:
> Richard B. Johnson wrote:
> > It isn't CPU-specific. It's motherboard glitch specific. If there
> > is ground-bounce on the motherboard or excessive induced
> > coupling, the CPU may occasionally get hit with a logic-level
> > that it "thinks" is an interrupt, even though no controller
> > actually generated it.
> 
> That doesn't seem plausible on an otherwise reliable computer.
> 
> Why would interrupt lines suffer ground-bounce logic glitches yet all
> the data, address and control lines be fine?

Two reasons at least:
- the data/address lines are always driven by a buffer when there
a transfer is taking place, while the interrupt lines are permanently
monitored but most of the time only held by passive pull-ups of a
much higher impedance.

- board designers know that the timing of data and addresses are
critical and take care during the layout. Interrupt lines come last
and are routed where there is room left, after all these are low
frequency signals...

	Regards,
	Gabriel
