Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWHAOpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWHAOpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWHAOpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:45:46 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:60593 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161011AbWHAOpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:45:45 -0400
From: David Brownell <david-b@pacbell.net>
To: hans@rubico.se
Subject: Re: Block request processing for MMC/SD over SPI bus
Date: Tue, 1 Aug 2006 07:45:39 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
References: <200608011208.27143.hans@rubico.se>
In-Reply-To: <200608011208.27143.hans@rubico.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010745.40245.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 3:08 am, Hans Eklund wrote:

> As you can see om my LKML post, my driver covers (at first stage) everything 
> from low level SPI commands and block device insertion to the request 
> processing(since i at first could not connect to the MMC subsystem). Now, 
> Russel King believes that you may have written a SPI to MMC subsytem driver. 
> Correct? If so, whats the status on your driver?

Not entirely "my" driver, I just updated it and got it to partially enumerate
on some hardware that's a bit too weak for "real work":

http://sourceforge.net/mailarchive/forum.php?thread_id=13335072&forum_id=45866

... and there's the separate issue of the spi_claim()/spi_release() API
to take over an entire bus.  Such an API could be used by other SPI based
interfaces; some in-system-programmers (including JTAG) need that same kind
of protocol tweaking hook for SPI.

- Dave

