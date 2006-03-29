Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWC2N6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWC2N6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWC2N6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:58:39 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:5780 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750740AbWC2N6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:58:38 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>, linux-kernel@vger.kernel.org,
       lm-sensors <lm-sensors@lm-sensors.org>
In-Reply-To: <20060329034510.GA8309@jupiter.solarsys.private>
References: <20060317042019.GC3446@jupiter.solarsys.private>
	 <20060320230037.29764.qmail@web26902.mail.ukl.yahoo.com>
	 <20060329034510.GA8309@jupiter.solarsys.private>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 15:00:07 +0100
Message-Id: <1143640808.22244.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 213.104.11.16
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: I2C_PCA_ISA causes boot delays (was re: sis96x compiled in by
	error: delay of one minute at boot)
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 22:45 -0500, Mark M. Hoffman wrote:
> 
> This alone is the cause of the delay.  (I have confirmed it by running
> some similar .configs here.)  You almost certainly don't own this
> specialized piece of hardware.  Worse still, that particular driver
> has no code to detect whether or not the hardware is present.  I cc'ed
> the listed driver author (Ian) just in case this might be corrected...
> but I guess there is no way to fix it.
> 
> So the delay is (1) an I2C bus driver that is not actually present,
> trying to probe for (2) seven different sensors chip drivers that
> certainly aren't present on the nonexistent bus.  Timeouts ensue.
> 
> So unless Ian knows a better way to detect that bus driver... the best
> I can advise is to *not* build in those drivers for hardware that you
> do not have. 

I don't work at Arcom anymore so I don't have access to the hardware,
but I don't know of a better way off the top of my head how to detect
the presence of the PCA chip.

You are unlikely to have the particular PC/104 card the driver was
written for. If I recall correctly PCA chip itself doesn't do ISA (it
has simple processor bus chip select type arrangement I think) but the
PC/104 card in question has a small CPLD which does the address decoding
for ISA. I guess you are unlikely to find another ISA card which has the
PCA chip on it.

It's possible that you might have an embedded board with the PCA chip
directly on it -- but if you don't then I don't know why you would
enable the driver.

Ian.
-- 
Ian Campbell

To save a single life is better than to build a seven story pagoda.

