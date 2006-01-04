Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWAGD0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWAGD0A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWAGDZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:25:59 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:29359 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030325AbWAGDZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:25:58 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [patch 2.6.14-rc6-git 2/6] SPI ads7846 protocol driver
Date: Tue, 3 Jan 2006 19:41:48 -0800
User-Agent: KMail/1.7.1
Cc: Komal Shah <komal_shah802003@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20060103112047.33558.qmail@web32902.mail.mud.yahoo.com>
In-Reply-To: <20060103112047.33558.qmail@web32902.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601031941.48787.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How do you test this driver on OSK? 

With disgusting hacks to the existing uwire driver.


> Don't we need controller driver / bitbanging interface atleast?

I was thinking of replacing the hacks with spi_bitbang stuff;
the txrx_bufs() method is appropriate for MicroWire since it
needs to know whether to read _or_ write, and txrx_word() calls
assume the full-service shift register is available.


> Also use input_allocate_device() instead of init_input_dev(). Thanx.

Got patch?  :)


> I have started writing OMAP2 SPI master controller driver for and
> tsc2101 driver based on ads7846 driver for H4 board.

Cool.  tsc2101 + uwire will handle H2 (and H3?) also.  The only
API change I know of (== necessariy affects your code) will be
the "spi_transfer.transfer_list" patch, which I'll get out soon.
 
- Dave


