Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWHPXKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWHPXKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWHPXKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:10:44 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:8720 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751219AbWHPXKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:10:43 -0400
Date: Thu, 17 Aug 2006 00:10:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060816231033.GB12407@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	Lee Revell <rlrevell@joe-job.com>,
	Raphael Hertzog <hertzog@debian.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060816104559.GF4325@ouaza.com> <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com> <1155762739.7338.18.camel@mindpipe> <1155767066.2600.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155767066.2600.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 05:24:26PM -0500, Paul Fulghum wrote:
> Does the MIDI device using the standard N_TTY line discipline?
> Are you using the low_latency flag on the serial device?
> What type of UART has been tested (16550? other?)
> Are you seeing overruns or just lost data?

MIDI uses its own driver - sound/drivers/serial-u16550.c.  My guess
is there's something in the system starving interrupt servicing.
Serial is very sensitive to that, and increases in other system
latencies tends to have an adverse impact on serial.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
