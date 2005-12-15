Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbVLOJMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbVLOJMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbVLOJMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:12:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33550 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161141AbVLOJMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:12:41 -0500
Date: Thu, 15 Dec 2005 09:12:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Anderson Lizardo <anderson.lizardo@gmail.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Message-ID: <20051215091220.GA29620@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Anderson Lizardo <anderson.lizardo@gmail.com>,
	Anderson Briglia <anderson.briglia@indt.org.br>,
	Anderson Lizardo <anderson.lizardo@indt.org.br>,
	linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
	Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	David Brownell <david-b@pacbell.net>
References: <20051213213208.303580000@localhost.localdomain> <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx> <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com> <43A11204.2070403@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A11204.2070403@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 07:49:40AM +0100, Pierre Ossman wrote:
> Sounds like a much better solution. Hacking around problems instead of
> solving them usually lead to even more problems.

No, that's not possible.

> I haven't studied all drivers in detail, but I believe all of them
> should be able to handle the transistion.

You seem to have ignored my message on why this is required.  The MMCI
driver requires that all transfers be a multiple of 1 << blksz_bits.
So, if you want to transfer (eg) 9 bytes, it must be transferred as 9
one byte blocks.  So set blksz_bits to 0 and blocks to 9.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
