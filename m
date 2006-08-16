Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWHPXOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWHPXOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWHPXOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:14:30 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26560 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751222AbWHPXOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:14:30 -0400
Subject: Re: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>, Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060816231033.GB12407@flint.arm.linux.org.uk>
References: <20060816104559.GF4325@ouaza.com>
	 <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com>
	 <1155762739.7338.18.camel@mindpipe>
	 <1155767066.2600.19.camel@localhost.localdomain>
	 <20060816231033.GB12407@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 19:15:06 -0400
Message-Id: <1155770107.8796.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 00:10 +0100, Russell King wrote:
> On Wed, Aug 16, 2006 at 05:24:26PM -0500, Paul Fulghum wrote:
> > Does the MIDI device using the standard N_TTY line discipline?
> > Are you using the low_latency flag on the serial device?
> > What type of UART has been tested (16550? other?)
> > Are you seeing overruns or just lost data?
> 
> MIDI uses its own driver - sound/drivers/serial-u16550.c.  My guess
> is there's something in the system starving interrupt servicing.
> Serial is very sensitive to that, and increases in other system
> latencies tends to have an adverse impact on serial.
> 

Thanks.

Have you seen many other reports of serial working reliably in 2.4 but
not in 2.6?  Right now this is the only clue I have to go on...

Lee

