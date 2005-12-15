Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbVLONow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbVLONow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbVLONow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:44:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20242 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422727AbVLONov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:44:51 -0500
Date: Thu, 15 Dec 2005 13:44:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>,
       Anderson Lizardo <anderson.lizardo@gmail.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Message-ID: <20051215134436.GB6211@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Anderson Lizardo <anderson.lizardo@gmail.com>,
	Anderson Briglia <anderson.briglia@indt.org.br>,
	Anderson Lizardo <anderson.lizardo@indt.org.br>,
	linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
	Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	David Brownell <david-b@pacbell.net>
References: <20051213213208.303580000@localhost.localdomain> <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx> <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com> <43A11204.2070403@drzeus.cx> <20051215091220.GA29620@flint.arm.linux.org.uk> <43A136F1.3040700@drzeus.cx> <20051215100657.GC32490@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215100657.GC32490@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 10:06:57AM +0000, Russell King wrote:
> On Thu, Dec 15, 2005 at 10:27:13AM +0100, Pierre Ossman wrote:
> > The spec I have says that this is a single block command. So such
> > trickery would not work. It isn't explicit about padding so it might be
> > possible to pad the data (since password length is specified in the
> > data). If not, then we either ignore this function or have a system
> > where we can detect limited hosts and print warnings.
> 
> What we need is someone with the real MMC spec to tell us about the
> requirements here.

Reading through the specs I have here, block sizes seem to be all over
the place.  The MMC card specs seem to imply that any block size can
be set, from 0 bytes to 2^32-1 bytes.

The PXA MMC interface specification allows the block size to be anything
from 1 to 1023 bytes, excluding CRC.  It is unclear whether a value of 0
means 1024.

The MMCI specification allows the block size to be specified as a power
of two, from 1 to 2048 bytes, excluding CRC.

Pierre - can you comment on wbsd's capabilities please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
