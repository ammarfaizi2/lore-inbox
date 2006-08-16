Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWHPX1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWHPX1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWHPX1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:27:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49090 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751232AbWHPX1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:27:43 -0400
Subject: Re: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>, Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060816231926.GC12407@flint.arm.linux.org.uk>
References: <20060816104559.GF4325@ouaza.com>
	 <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com>
	 <1155762739.7338.18.camel@mindpipe>
	 <1155767066.2600.19.camel@localhost.localdomain>
	 <20060816231033.GB12407@flint.arm.linux.org.uk>
	 <1155770107.8796.14.camel@mindpipe>
	 <20060816231926.GC12407@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 19:28:19 -0400
Message-Id: <1155770899.8796.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 00:19 +0100, Russell King wrote:
> On Wed, Aug 16, 2006 at 07:15:06PM -0400, Lee Revell wrote:
> > On Thu, 2006-08-17 at 00:10 +0100, Russell King wrote:
> > > MIDI uses its own driver - sound/drivers/serial-u16550.c.  My guess
> > > is there's something in the system starving interrupt servicing.
> > > Serial is very sensitive to that, and increases in other system
> > > latencies tends to have an adverse impact on serial.
> > 
> > Have you seen many other reports of serial working reliably in 2.4 but
> > not in 2.6?  Right now this is the only clue I have to go on...
> 
> There have been one or two, but the above is basically as far as I've
> got.  Unfortunately, I don't have any machines slow enough (or maybe
> with the right hardware) to exhibit the problem.
> 

OK, thanks.  FWIW here is the serial board we are using:

http://www.moschip.com/html/MCS9845.html

The hardware guy says "The mn9845cv, have in default 2 serial ports and
one ISA bus, where we have connected the tl16c554, quad serial port."

Hopefully Ingo's latency tracer can tell me what is holding off
interrupts.

Lee


